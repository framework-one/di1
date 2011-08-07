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
			if ( variables.beanInfo.isSingleton ) {
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
		var md = getComponentMetadata( cfc );
		return md;
	}
	
	
	private string function deduceDottedPath( string path ) {
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
			var folder = directoryExists( f ) ? f : expandPath( f );
			discoverBeansInFolder( folder );
		}
		writeDump( variables.beanInfo );
	}
	
	
	private void function discoverBeansInFolder( string folder ) {
		var cfcs = directoryList( folder, variables.config.recurse, 'path', '*.cfc' );
		var n = arrayLen( cfcs );
		for ( var i = 1; i <= n; ++i ) {
			var cfcPath = cfcs[ i ];
			var dirPath = getDirectoryFromPath( cfcPath );
			var dir = singular( listLast( dirPath, '\/' ) );
			var file = listLast( cfcPath, '\/' );
			var beanName = left( file, len( file ) - 4 );
			var dottedPath = deduceDottedPath( cfcPath );
			var metadata = { name = beanName, qualifier = dir, path = cfcPath, cfc = dottedPath, metadata = cleanMetadata( dottedPath ) };
			if ( structKeyExists( variables.beanInfo, beanName ) ) {
				structDelete( variables.beanInfo, beanName );
				variables.beanInfo[ beanName & dir ] = metadata;
			} else {
				variables.beanInfo[ beanName ] = metadata;
				variables.beanInfo[ beanName & dir ] = metadata;
			}
		}
	}
	
	
	private any function resolveBean( string beanName ) {
		throw 'not implemented';
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