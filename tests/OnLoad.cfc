component extends="mxunit.framework.TestCase" {

    function setup() {
        application.loadCount = 0;
    }

    function shouldCallOnLoadListener() {
        var bf = new ioc( "" ).onLoad( variables.loader );
        assertEquals( 0, application.loadCount );
        var q = bf.containsBean( "foo" );
        assertEquals( 1, application.loadCount );
    }

    function shouldCallMultipleOnLoadListeners() {
        var bf = new ioc( "" ).onLoad( variables.loader ).onLoad( variables.loader );
        assertEquals( 0, application.loadCount );
        var q = bf.containsBean( "foo" );
        assertEquals( 2, application.loadCount );
    }

    private void function loader( any factory ) {
        ++application.loadCount;
    }

}
