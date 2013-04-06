component extends="mxunit.framework.TestCase" {
	
    function checkDefaultInitArgWorks() {
		var factory = new ioc( "/tests/model", { constants = { dsn = "sample" } } );
        var user37 = factory.getBean( "user37" );
        assertEquals( "sample", user37.getDSN() );
        assertEquals( 0, user37.getID() );
    }

}
