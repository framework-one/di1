component extends="mxunit.framework.TestCase" {

    function shouldDeclareSingleton() {
        var bf = new ioc( "" ).declareBean( "foo", "tests.extrabeans.sheep.item" );
        application.itemCount = 0;
        var item1 = bf.getBean( "foo" );
        assertEquals( 1, application.itemCount );
        var item2 = bf.getBean( "foo" );
        assertEquals( 1, application.itemCount );
        assertSame( item1, item2 );
    }

    function shouldDeclareTransient() {
        var bf = new ioc( "" ).declareBean( "foo", "tests.extrabeans.sheep.item", false );
        application.itemCount = 0;
        var item1 = bf.getBean( "foo" );
        assertEquals( 1, application.itemCount );
        var item2 = bf.getBean( "foo" );
        assertEquals( 2, application.itemCount );
        assertNotSame( item1, item2 );
    }

}
