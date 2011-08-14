component extends="org.corfield.framework" {
	function setupApplication() {
		var xbf = new ioc( '/extrabeans',
			{
				constants = { magicValue = 42 },
				singulars = { sheep = 'bean' }
			}
		);
		var bf = new ioc( '/model' );
		bf.setParent( xbf );
		setBeanFactory( bf );
		
		// used to track creation of transient beans for illustration purposes:
		structDelete( application, 'itemCount' );
	}
}