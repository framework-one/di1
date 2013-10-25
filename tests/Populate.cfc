component extends="mxunit.framework.TestCase"{
	
	function setup(){
		VARIABLES.BF = new ioc("populate");
	}
	function hasPopulateMethod(){
		var BF = new ioc("");
		AssertTrue(StructKeyExists(bf, "populate"), "populate function doesnt exist in beanfactory");
	}

	public void function testPopulateFlatComponent() {
		request.context = getOneLevelRC();
		var user = BF.populate("userOneLevel", request.context);
		assertEquals( request.context.username,user.getUserName() );
		assertEquals( request.context.firstName,user.getFirstName() );
		assertEquals( request.context.lastName,user.getLastName() );
		assertEquals( request.context.isActive,user.getIsActive() );
	}


	/*
		DATA GENERATION
	*/

	private Struct function getOneLevelRC()
	output=false {
		return { username = "foobar", firstName="Homer", lastName="Simpson", isActive=true };
	}

// 	private Struct function getTwoLevelRC()
// 	output=false {
// 		return { username = "foobar", "contact.firstName" = "Homer", "contact.lastName" = "Simpson", isActive = true, "contact.dateCreated" = "02/29/2012" };
// 	}

// 	private Struct function getThreeLevelRC()
// 	output=false {
// 		return {
// 				username = "foobar", 
// 				"contact.firstName" = "Homer", 
// 				"contact.lastName" = "Simpson", 
// 				"contact.dateCreated" = "02/29/2012",
// 				isActive = true,
// 				"contact.address.line1" = "123 Fake Street",
// 				"contact.address.line2" = "Apt 12",
// 				"contact.address.zipCode" = "54232"
// 		};
// 	}
	/*

		FW/1 POPULATE TESTS
	*/

// 	component extends="mxunit.framework.TestCase" {

// 	public void function setUp() {
// 		variables.fw = new org.corfield.framework();
// 		clearFW1MetaData();
// 	}



// 	public void function testPopulateFlatComponentWithKeys() {
// 		var user = new stubs.userOneLevel();
// 		request.context = getOneLevelRC();

// 		variables.fw.populate( cfc=user, keys="username,firstname", deep=true );

// 		assertEquals( request.context.username, user.getUserName() );
// 		assertEquals( request.context.firstName, user.getFirstName() );
// 		assertEquals( "", user.getLastName() );
// 		assertEquals( false, user.getIsActive() );
// 	}

// 	public void function testPopulateChildComponentWithKeys() {
// 		var user = new stubs.userTwoLevel();
// 		request.context = getTwoLevelRC();

// 		variables.fw.populate( cfc=user, keys="contact.firstName,username", deep=true );

// 		assertEquals( request.context.username, user.getUserName() );
// 		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
// 		assertEquals( "", user.getContact().getLastName() );
// 	}

// 	public void function testPopulateChildComponentWithTrustKeys() {
// 		var user = new stubs.userTwoLevel();
// 		request.context = getTwoLevelRC();

// 		variables.fw.populate( cfc=user, trustKeys=true );

// 		assertEquals( request.context.username,user.getUserName() );
// 		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
// 		assertEquals( request.context[ "contact.lastName" ], user.getContact().getLastName() );
// 	}

// 	public void function testComponentWithSingleChild() {
// 		var user = new stubs.userTwoLevel();
// 		request.context = getTwoLevelRC();

// 		variables.fw.populate( cfc=user, deep=true );

// 		assertEquals( request.context.username,user.getUserName() );
// 		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
// 		assertEquals( request.context[ "contact.lastName" ], user.getContact().getLastName() );
// 		assertEquals( request.context[ "contact.dateCreated" ], user.getContact().getDateCreated() );
// 	}

// 	public void function testComponentWithSingleChildAndDeepFalse() {
// 		var user = new stubs.userTwoLevel();
// 		request.context = getTwoLevelRC();

// 		variables.fw.populate( cfc=user );

// 		assertEquals( request.context.username,user.getUserName() );
// 		assertEquals( "",user.getContact().getFirstName() );
// 		assertEquals( "",user.getContact().getLastName() );
// 		assertEquals( true,user.getIsActive() );
// 	}

// 	public void function testComponentWithManyChildren() {
// 		var user = new stubs.userThreeLevel();
// 		request.context = getThreeLevelRC();

// 		variables.fw.populate(cfc=user,deep=true);

// 		assertEquals( request.context.username, user.getUserName() );
// 		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
// 		assertEquals( request.context[ "contact.lastName" ], user.getContact().getLastName() );
// 		assertEquals( request.context.isActive, user.getIsActive() );
// 		assertEquals( request.context[ "contact.address.line1" ], user.getContact().getAddress().GetLine1() );
// 		assertEquals( request.context[ "contact.address.line2" ], user.getContact().getAddress().GetLine2() );
// 		assertEquals( request.context[ "contact.address.zipCode" ], user.getContact().getAddress().GetZipCode() );
// 	}

// 	public void function testComponentWithManyChildrenAndTrustKeys() {
// 		var user = new stubs.userThreeLevel();
// 		request.context = getThreeLevelRC();

// 		variables.fw.populate( cfc=user, deep=true, trustKeys=true );

// 		assertEquals( request.context.username, user.getUserName() );
// 		assertEquals( request.context[ "contact.firstName"], user.getContact().getFirstName() );
// 		assertEquals( request.context[ "contact.lastName"], user.getContact().getLastName() );
// 		assertEquals( request.context.isActive, user.getIsActive() );
// 		assertEquals( request.context[ "contact.address.line1"], user.getContact().getAddress().GetLine1() );
// 		assertEquals( request.context[ "contact.address.line2"], user.getContact().getAddress().GetLine2() );
// 		assertEquals( request.context[ "contact.address.zipCode"], user.getContact().getAddress().GetZipCode() );
// 	}

// 	public void function testComponentWithManyChildrenPassInKeys() {
// 		var user = new stubs.userThreeLevel();
// 		request.context = getThreeLevelRC();

// 		variables.fw.populate( cfc=user, deep=true, keys = "contact.firstName,contact.address.line1,username" );

// 		assertEquals( request.context.username, user.getUserName() );
// 		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
// 		assertEquals( "", user.getContact().getLastName() );
// 		assertEquals( false, user.getIsActive() );
// 		assertEquals( request.context[ "contact.address.line1" ], user.getContact().getAddress().GetLine1() );
// 		assertEquals( "", user.getContact().getAddress().GetLine2() );
// 		assertEquals( "", user.getContact().getAddress().GetZipCode() );
// 	}



// 	private void function clearFW1MetaData()
// 	output=false hint=""{
// 		var cfcs = {};

// 		cfcs[ "stubs.Address" ] =  getMetaData( new stubs.Address() );

// 		cfcs[ "stubs.Contact" ] =  getMetaData( new stubs.Contact() );
// 		cfcs[ "stubs.UserOneLevel" ] =  getMetaData( new stubs.UserOneLevel() );
// 		cfcs[ "stubs.UserTwoLevel" ] =  getMetaData( new stubs.UserTwoLevel() );
// 		cfcs[ "stubs.UserThreeLevel" ] =  getMetaData( new stubs.UserThreeLevel() );
		
// 		for(cfc in cfcs){
// 			if ( structKeyExists( cfcs[ cfc ], '__fw1_setters' ) ) {
// 				structDelete( cfcs[ cfc ], "__fw1_setters" );
// 			}
// 		}
// 	}
// }

	/*
		
		THIS IS THE ACTUAL POPULATE METHOD

	*/
	// public any function populate( any cfc, string keys = '', boolean trustKeys = false, boolean trim = false, deep = false ) {
	// 	if ( keys == '' ) {
	// 		if ( trustKeys ) {
	// 			// assume everything in the request context can be set into the CFC
	// 			for ( var property in request.context ) {
	// 				try {
	// 					var args = { };
	// 					args[ property ] = request.context[ property ];
	// 					if ( trim && isSimpleValue( args[ property ] ) ) args[ property ] = trim( args[ property ] );
	// 					// cfc[ 'set'&property ]( argumentCollection = args ); // ugh! no portable script version of this?!?!						
	// 					setProperty( cfc, property, args );
	// 				} catch ( any e ) {
	// 					onPopulateError( cfc, property, request.context );
	// 				}
	// 			}
	// 		} else {
	// 			var setters = findImplicitAndExplicitSetters( cfc );
	// 			for ( var property in setters ) {
	// 				if ( structKeyExists( request.context, property ) ) {
	// 					var args = { };
	// 					args[ property ] = request.context[ property ];
	// 					if ( trim && isSimpleValue( args[ property ] ) ) args[ property ] = trim( args[ property ] );
	// 					// cfc[ 'set'&property ]( argumentCollection = args ); // ugh! no portable script version of this?!?!
	// 					setProperty( cfc, property, args );
	// 				} else if ( deep && structKeyExists( cfc, 'get' & property ) ) {
	// 					//look for a context property that starts with the property
	// 					for ( var key in request.context ) {
	// 						if ( listFindNoCase( key, property, '.') ) {
	// 							try {
	// 								setProperty( cfc, key, { '#key#' = request.context[ key ] } );
	// 							} catch ( any e ) {
	// 								onPopulateError( cfc, key, request.context);
	// 							}
	// 						}
	// 					}
	// 				}
	// 			}
	// 		}
	// 	} else {
	// 		var setters = findImplicitAndExplicitSetters( cfc );
	// 		var keyArray = listToArray( keys );
	// 		for ( var property in keyArray ) {
	// 			var trimProperty = trim( property );
	// 			if ( structKeyExists( setters, trimProperty ) || trustKeys ) {
	// 				if ( structKeyExists( request.context, trimProperty ) ) {
	// 					var args = { };
	// 					args[ trimProperty ] = request.context[ trimProperty ];
	// 					if ( trim && isSimpleValue( args[ trimProperty ] ) ) args[ trimProperty ] = trim( args[ trimProperty ] );
	// 					// cfc[ 'set'&trimproperty ]( argumentCollection = args ); // ugh! no portable script version of this?!?!
	// 					setProperty( cfc, trimProperty, args );
	// 				}
	// 			} else if ( deep ) {
	// 				if ( listLen( trimProperty, '.' ) > 1 ) {
	// 					var prop = listFirst( trimProperty, '.' );
	// 					if ( structKeyExists( cfc, 'get' & prop ) ) {
 //                            setProperty( cfc, trimProperty, { '#trimProperty#' = request.context[ trimProperty ] } );
 //                        }
	// 				}
	// 			}
	// 		}
	// 	}
	// 	return cfc;
	// }
}