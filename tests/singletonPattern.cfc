component extends="mxunit.framework.TestCase" {
	
	function setup() {
		/** 
		* Note that although 'BeanFactory' and 'BarService' match the singletonpattern
		* they are considered transients as in the beans folder
		**/		
		transients = ['BarService','Beer','BeerFactory','Wine','Coffee','Tea','Burger','Pizza'];
		singletons = ['DrinksService','FoodFactory'];
		
		variables.factory = new ioc( "/tests/singletonPattern", { singletonPattern = ".+(Service|Factory)$" } );
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