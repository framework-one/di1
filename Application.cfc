component extends="org.corfield.framework" {
	function setupApplication() {
		var bf = new ioc( '/model' );
		setBeanFactory( bf );
	}
}