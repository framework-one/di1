/*
	Copyright (c) 2010-2011, Sean Corfield

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/
component {

	// CONSTRUCTOR
	
	public any function init( string folders, struct config = { } ) {
		variables.beanInfo = { };
		variables.beanCache = { };
		variables.config = config;
		setupFrameworkDefaults();
		discoverBeans( folders );
		return this;
	}
	
	// PUBLIC METHODS
	
	public boolean function containsBean( string beanName ) {
		return structKeyExists( variables.beanInfo, beanName );
	}
	
	
	public any function getBean( string beanName ) {
		if ( structKeyExists( variables.beanCache, beanName ) ) {
			return variables.beanCache[ beanName ];
		} else {
			var bean = resolveBean( beanName );
			if ( variables.beanInfo[ beanName ].isSingleton ) {
				variables.beanCache[ beanName ] = bean;
			}
			return bean;
		}
	}
	
	
	public void function load() {
		variables.beanCache = { };
		for ( var key in variables.beanInfo ) {
			getBean( key );
		}
	}
	
	// PRIVATE METHODS
	
	private struct function cleanMetadata( string cfc ) {
		var baseMetadata = getComponentMetadata( cfc );
		var iocMeta = { setters = { } };
		var md = { extends = baseMetadata };
		do {
			md = md.extends;
			// gather up setters based on metadata:
			var implicitSetters = structKeyExists( md, 'accessors' ) && isBoolean( md.accessors ) && md.accessors;
			if ( structKeyExists( md, 'properties' ) ) {
				// due to a bug in ACF9.0.1, we cannot use var property in md.properties,
				// instead we must use an explicit loop index... ugh!
				var n = arrayLen( md.properties );
				for ( var i = 1; i <= n; ++i ) {
					var property = md.properties[ i ];
					if ( implicitSetters ||
							structKeyExists( property, 'setter' ) && isBoolean( property.setter ) && property.setter ) {
						iocMeta.setters[ property.name ] = 'implicit';
					}
				}
			}
			// still looking for a constructor?
			if ( !structKeyExists( iocMeta, 'constructor' ) ) {
				if ( structKeyExists( md, 'functions' ) ) {
					// due to a bug in ACF9.0.1, we cannot use var property in md.functions,
					// instead we must use an explicit loop index... ugh!
					var n = arrayLen( md.functions );
					for ( var i = 1; i <= n; ++i ) {
						var func = md.functions[ i ];
						if ( func.name == 'init' ) {
							iocMeta.constructor = { };
							if ( structKeyExists( func, 'parameters' ) ) {
								// due to a bug in ACF9.0.1, we cannot use var property in md.functions,
								// instead we must use an explicit loop index... ugh!
								var m = arrayLen( func.parameters );
								for ( var j = 1; j <= m; ++j ) {
									var arg = func.parameters[ j ];
									iocMeta.constructor[ arg.name ] = arg.type;
								}
							}
						}
					}
				}
			}
		} while ( structKeyExists( md, 'extends' ) );
		return iocMeta;
	}
	
	
	private string function deduceDottedPath( string path, string mapping, string truePath ) {
		// TODO: we know mapping => truePath and path will have a prefix of truePath
		// figure out dotted version of mapping and take it away from path / truePath
		// given a full file path, figure out the root-relative or mapped path
		// then convert that to a CFC dotted path
		var webroot = expandPath( '/' );
		if ( path.startsWith( webroot ) ) {
			var rootRelativePath = right( path, len( path ) - len( webroot ) );
			return replace( left( rootRelativePath, len( rootRelativePath ) - 4 ), '/', '.', 'all' );
		} else {
			// need to go off looking for mappings
			throw 'not implemented';
		}
	}
	
	
	private void function discoverBeans( string folders ) {
		var folderArray = listToArray( folders );
		variables.pathMapCache = { };
		for ( var f in folderArray ) {
			discoverBeansInFolder( f );
		}
	}
	
	
	private void function discoverBeansInFolder( string original ) {
		var folder = expandPath( original );
		var cfcs = directoryList( folder, variables.config.recurse, 'path', '*.cfc' );
		var n = arrayLen( cfcs );
		for ( var i = 1; i <= n; ++i ) {
			var cfcPath = cfcs[ i ];
			var dirPath = getDirectoryFromPath( cfcPath );
			var dir = singular( listLast( dirPath, '\/' ) );
			var file = listLast( cfcPath, '\/' );
			var beanName = left( file, len( file ) - 4 );
			var dottedPath = deduceDottedPath( cfcPath, folder, original );
			var metadata = { 
				name = beanName, qualifier = dir, isSingleton = ( dir != 'bean' ), 
				path = cfcPath, cfc = dottedPath, metadata = cleanMetadata( dottedPath )
			};
			if ( structKeyExists( variables.beanInfo, beanName ) ) {
				structDelete( variables.beanInfo, beanName );
				variables.beanInfo[ beanName & dir ] = metadata;
			} else {
				variables.beanInfo[ beanName ] = metadata;
				variables.beanInfo[ beanName & dir ] = metadata;
			}
		}
	}
	
	
	private struct function findSetters( any cfc, struct iocMeta ) {
		var liveMeta = { setters = iocMeta.setters };
		// gather up explicit setters:
		for ( var member in cfc ) {
			var method = cfc[ member ];
			var n = len( member );
			if ( isCustomFunction( method ) && left( member, 3 ) == 'set' && n > 3 ) {
				var property = right( member, n - 3 );
				liveMeta.setters[ property ] = 'explicit';
			}
		}
		return liveMeta;
	}
	
	
	private any function resolveBean( string beanName ) {
		// do enough resolution to create and initialization this bean
		// returns a struct of the bean and a struct of beans and setters still to run
		var partialBean = resolveBeanCreate( beanName, { injection = { } } );
		// now perform all of the injection:
		for ( var name in partialBean.injection ) {
			var injection = partialBean.injection[ name ];
			for ( var property in injection.setters ) {
				var args = { };
				args[ property ] = partialBean.injection[ property ].bean;
				evaluate( 'injection.bean.set#property#( argumentCollection = args )' );
			}
		}
		return partialBean.bean;
	}
	
	
	private struct function resolveBeanCreate( string beanName, struct accumulator ) {
		var info = variables.beanInfo[ beanName ];
		// use createObject so we have control over initialization:
		var bean = createObject( 'component', info.cfc );
		if ( structKeyExists( info.metadata, 'constructor' ) ) {
			var args = { };
			for ( var arg in info.metadata.constructor ) {
				var argBean = resolveBeanCreate( arg, accumulator );
				args[ arg ] = argBean.bean;
			}
			evaluate( 'bean.init( argumentCollection = args )' );
		}
		var setterMeta = findSetters( bean, info.metadata );
		setterMeta.bean = bean;
		accumulator.injection[ beanName ] = setterMeta; 
		for ( var property in setterMeta.setters ) {
			resolveBeanCreate( property, accumulator );
		}
		accumulator.bean = bean;
		return accumulator;
	}
	
	
	private void function setupFrameworkDefaults() {
		param name = "variables.config.recurse"		default = true;
		param name = "variables.config.version"		default = "0.0.1";
	}
	
	
	private string function singular( string plural ) {
		var single = plural;
		var n = len( plural );
		var last = right( plural, 1 );
		if ( last == 's' ) {
			single = left( plural, n - 1 );
		}
		return single;
	}
	
}