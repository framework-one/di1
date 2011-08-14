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
		var bf = new ioc( '/model', { transients = [ 'fish' ] } );
		bf.setParent( xbf );
		setBeanFactory( bf );
		
		// used to track creation of transient beans for illustration purposes:
		structDelete( application, 'itemCount' );
	}
}