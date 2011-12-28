component {
    this.name = "InjectOneTests";
    // used to test search via mapping:
    this.mappings[ "/goldfish/trumpets" ] = expandPath( "/tests/extrabeans" );
}

/*
	this.mappings[ '/goldfish/trumpets' ] = expandPath( '/extrabeans' );
	function setupApplication() {
		var xbf = new ioc( '/goldfish/trumpets',
			{
				constants = { magicValue = 42 },
				singulars = { sheep = 'bean' }
			}
		);
		// demonstrate passing expanded path under webroot:
		var svcPath = expandPath( 'services' );
		var bf = new ioc( '/model, #svcPath#', { transients = [ 'fish' ] } );
		bf.setParent( xbf );
        bf.onLoad( variables.loader );
		setBeanFactory( bf );
		
		// programmatically declare another bean:
		bf.declareBean( 'declaredBean', 'declared.things.example', false );
		
		// used to track creation of transient beans for illustration purposes:
		structDelete( application, 'itemCount' );
	}

    function loader( any ioc ) {
        ioc.addBean( 'myconfig1',
                     new ioc( '' )
                     .addBean( 'config', '/some/xml/file.xml' )
                     .declareBean( 'configObject', 'declared.things.myconfig' )
                     .injectProperties( 'configObject',
                                        { name = "MyConfig" } ) );
        ioc.addBean( 'myconfig2',
                     ioc.injectProperties(
                         new declared.things.myconfig( '/some/other/file.xml' ),
                         { name = "MyConfigBean" } ) );
    }
*/
