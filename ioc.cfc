/*
	Copyright (c) 2010, Sean Corfield

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
	
	public any function init( string folders, struct config = structNew() ) { // TODO: ugh! use { } when CFB supports that
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
		var key = 0; // TODO: move into for() when CFB supports that
		for ( key in variables.beanInfo ) {
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
		var f = 0;
		for ( f in folderArray ) {
			f = directoryExists( f ) ? f : expandPath( f );
			discoverBeansInFolder( f );
		}
		writeDump( variables.beanInfo );
	}
	
	
	private void function discoverBeansInFolder( string folder ) {
		var cfcs = directoryList( folder, variables.config.recurse, 'path', '*.cfc' );
		var n = arrayLen( cfcs );
		for ( var i = 1; i <= n; ++i ) {
			var cfcPath = cfcs[ i ];
			var file = listLast( cfcPath, '\/' );
			var beanName = left( file, len( file ) - 4 );
			var dottedPath = deduceDottedPath( cfcPath );
			var metadata = { path = cfcPath, cfc = dottedPath, metadata = cleanMetadata( dottedPath ) };
			variables.beanInfo[ beanName ] = metadata;
		}
	}
	
	
	private any function resolveBean( string beanName ) {
		throw 'not implemented';
	}
	
	
	private void function setupFrameworkDefaults() {
		param name = "variables.config.recurse"		default = true;
		param name = "variables.config.version"		default = "0.0.1";
	}
	
}