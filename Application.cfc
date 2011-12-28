component {
    this.name = "InjectOneTests";
    // used to test search via mapping:
    this.mappings[ "/goldfish/trumpets" ] = expandPath( "/tests/extrabeans" );
}

/*
//	this.mappings[ '/goldfish/trumpets' ] = expandPath( '/extrabeans' );
//	function setupApplication() {
//		var xbf = new ioc( '/goldfish/trumpets',
//			{
//				constants = { magicValue = 42 },
//				singulars = { sheep = 'bean' }
//			}
//		);
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
//        ioc.addBean( 'myconfig1',
//                     new ioc( '' )
//                     .addBean( 'config', '/some/xml/file.xml' )
//                     .declareBean( 'configObject', 'declared.things.myconfig' )
//                     .injectProperties( 'configObject',
//                                        { name = "MyConfig" } ) );
//        ioc.addBean( 'myconfig2',
//                     ioc.injectProperties(
//                         new declared.things.myconfig( '/some/other/file.xml' ),
//                         { name = "MyConfigBean" } ) );
    }
<h2>Welcome to InjectOne!</h2>
<cfset bf = getBeanFactory() />
<cfset item = bf.getBean('item') />
<cfdump var="#item#" label="Item Bean"/>
<cfdump var="#item.getNewItem()#" label="New Item From Bean-Aware Item Bean"/>
<cfset user1 = bf.getBean('userfish') />
<cfdump var="#user1#" label="User 1 Bean"/>
<cfdump var="#user1.getItem()#" label="User 1's Item Bean - should be null, transient not injected"/>
<cfset user2 = bf.getBean('userfish') />
<cfdump var="#user2#" label="User 2 Bean"/>
<cfdump var="#user2.getItem()#" label="User 2's Item Bean - should be null, transient not injected"/>
<cfdump var="#bf.getBean('userservice')#" label="User Service"/>
<cfdump var="#bf.getBean('product')#" label="Product Service"/>
<cfdump var="#bf.getBean('userfish').product.getUserService()#" label="bf.getBean('userfish').product.getUserService()"/>
<cfdump var="#bf.getBean('magicvalue')#" label="bf.getBean('magicvalue')"/>
<cfdump var="#bf.getBean('item')#" label="bf.getBean('item') - transient"/>
<cfset bf.getBean('myconfig1').explain() />
<cfset bf.getBean('myconfig2').explain() />
<cfdump var="#bf.getBeanInfo()#"/>
*/
