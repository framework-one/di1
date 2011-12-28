component extends="mxunit.framework.TestCase" {

    function setup() {
        variables.ioc = new ioc( "" );
    }

    function shouldInjectWithType() {
        var bean = ioc.injectProperties( "tests.declared.things.myconfig", { name = "ByType" } );
        assertEquals( "ByType", bean.getName() );
        try {
            var data = bean.getConfig();
            fail( "constructor should not have been called" );
        } catch ( any e ) {
            assertEquals( "expression", e.type );
        }
    }

    function shouldInjectWithObject() {
        var bean = ioc.injectProperties(
            new declared.things.myconfig( "object" ),
            { name = "ByObject" } );
        assertEquals( "ByObject", bean.getName() );
        assertEquals( "object", bean.getConfig() );
    }

    function shouldInjectWithName() {
        variables.ioc
            .addBean( "data", "data" )
            .declareBean( "configObject", "tests.declared.things.myconfig" );
        var bean = variables.ioc.injectProperties( "configObject", { name = "ByName" } );
        assertEquals( "ByName", bean.getName() );
        assertEquals( "data", bean.getConfig() );
    }

}
