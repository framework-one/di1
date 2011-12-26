// caution: requires FW/1 2.0 Alpha 5 or later!!
component extends="org.corfield.framework" {
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
        var bf = new ioc( '' );
        bf.addBean( 'config', '/some/xml/file.xml' );
        bf.declareBean( 'configObject', 'declared.things.myconfig' );
        ioc.addBean( 'myconfig', bf.injectProperties( 'configObject', { name = "MyConfig" } ) );
    }
}
