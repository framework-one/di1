component extends="mxunit.framework.TestCase" {

    function setup() {
        variables.factory = new ioc( "/tests/model, /tests/extrabeans",
                                     { transients = [ "fish" ], singulars = { sheep = "bean" } } );
    }

    function shouldNotInjectTransient() {
        assertTrue( variables.factory.containsBean( "item" ) );
        assertFalse( variables.factory.isSingleton( "item" ) );
        var user = variables.factory.getBean( "user" );
        var item = user.itemTest();
        assertTrue( isSimpleValue( item ) );
        assertEquals( "missing", item );
    }

}
