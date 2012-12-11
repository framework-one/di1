component extends="mxunit.framework.TestCase" {
	
	function setup() {
		transients = ['BarService','Beer','BeerFactory','Wine','CoffeeFoo','PizzaFoo'];
		singletons = ['Drinks','Tea','Burger','FoodFactory'];
		
		variables.factory = new ioc( "/tests/transientPattern", { transientPattern = ".+(Foo)$" } );
	}
		
	/**
	* @mxunit:dataprovider singletons
	**/
	function checkForSingletons( required beanname ) {
		assertTrue( variables.factory.containsBean( arguments.beanname ) );
		assertTrue( variables.factory.isSingleton( arguments.beanname ) );
		instanceA = variables.factory.getBean( arguments.beanname );
		instanceB = variables.factory.getBean( arguments.beanname );
		assertSame( instanceA, instanceB );
	}
		
	/**
	* @mxunit:dataprovider transients
	**/
	function checkForTransients( beanname ) {
		//assertTrue( variables.factory.containsBean( beanname ) );
		assertFalse( variables.factory.isSingleton( beanname ) );
		instanceA = variables.factory.getBean( arguments.beanname );
		instanceB = variables.factory.getBean( arguments.beanname );
		assertNotSame( instanceA, instanceB );
	}
}
