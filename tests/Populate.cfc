component extends="mxunit.framework.TestCase"{
	
	function setup(){
		VARIABLES.BF = new ioc("populate");
	}
	function hasPopulateMethod(){
		AssertTrue(StructKeyExists(VARIABLES.BF, "populate"), "populate function doesnt exist in beanfactory");
	}

	public void function testPopulateFlatComponent() {
		request.context = getOneLevelRC();
		var user = VARIABLES.BF.populate("userOneLevel", request.context);

		

		assertEquals( request.context.username,user.getUserName() );
		assertEquals( request.context.firstName,user.getFirstName() );
		assertEquals( request.context.lastName,user.getLastName() );
		assertEquals( request.context.isActive,user.getIsActive() );
	}


	public void function testPopulateFlatComponentWithKeys() {
		
		request.context = getOneLevelRC();

		var user = VARIABLES.BF.populate( cfc="userOneLevel", data=request.context, keys="username,firstname", deep=true );

		assertEquals( request.context.username, user.getUserName() );
		assertEquals( request.context.firstName, user.getFirstName() );
		assertEquals( "", user.getLastName() );
		assertEquals( false, user.getIsActive() );
	}


	public void function testPopulateChildComponentWithKeys() {
		
		request.context = getTwoLevelRC();

		var user = VARIABLES.BF.populate( cfc="userTwoLevel", data=request.context, keys="contact.firstName,username", deep=true );

		assertEquals( request.context.username, user.getUserName() );
		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
		assertEquals( "", user.getContact().getLastName() );
	}

		public void function testPopulateChildComponentWithKeysExtraKeys() {
		
		request.context = getTwoLevelRC();
		request.context["contact.foo"] = "bar";

		//Should not error
		var user = VARIABLES.BF.populate( cfc="userTwoLevel", data=request.context, deep=true, trustKeys=false);

		
		assertEquals( request.context.username, user.getUserName() );
		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
		

		//Should error

		var failed = false;
		try{	
			var user = VARIABLES.BF.populate( cfc="userTwoLevel", data=request.context, deep=true, trustKeys=true);
		}
		catch(Any e){
			failed = true;
		}
		
		assertTrue(failed, "The populate function should have failed if we had extra sub keys");

	}
	
	public void function testPopulateChildComponentWithTrustKeys() {
		request.context = getTwoLevelRC();

		var user = VARIABLES.BF.populate( cfc="UserTwoLevel", data=request.context, trustKeys=true );

		assertEquals( request.context.username,user.getUserName() );
		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
		assertEquals( request.context[ "contact.lastName" ], user.getContact().getLastName() );

		//Now add 
	}



	public void function testComponentWithSingleChild() {
		request.context = getTwoLevelRC();

		var user =  VARIABLES.BF.populate( cfc="userTwoLevel", data=request.context, deep=true );

		assertEquals( request.context.username,user.getUserName() );
		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
		assertEquals( request.context[ "contact.lastName" ], user.getContact().getLastName() );
		assertEquals( request.context[ "contact.dateCreated" ], user.getContact().getDateCreated() );
	}


	public void function testComponentWithSingleChildAndDeepFalse() {
		request.context = getTwoLevelRC();
		

		var user = VARIABLES.BF.populate( cfc="userTwoLevel", data=request.context);

		assertEquals( request.context.username,user.getUserName() );
		assertEquals( "",user.getContact().getFirstName() );
		assertEquals( "",user.getContact().getLastName() );
		assertEquals( true,user.getIsActive() );
	}







	public void function testComponentWithManyChildren() {
		request.context = getThreeLevelRC();
		
		var user = VARIABLES.BF.populate(cfc="userThreeLevel", data=request.context ,deep=true);

		assertEquals( request.context.username, user.getUserName() );
		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
		assertEquals( request.context[ "contact.lastName" ], user.getContact().getLastName() );
		assertEquals( request.context.isActive, user.getIsActive() );
		assertEquals( request.context[ "contact.address.line1" ], user.getContact().getAddress().GetLine1() );
		assertEquals( request.context[ "contact.address.line2" ], user.getContact().getAddress().GetLine2() );
		assertEquals( request.context[ "contact.address.zipCode" ], user.getContact().getAddress().GetZipCode() );
	}

	public void function testComponentWithManyChildrenAndTrustKeys() {
		
		request.context = getThreeLevelRC();

		var user = VARIABLES.BF.populate( cfc="userThreeLevel", data=request.context, deep=true, trustKeys=true );

		assertEquals( request.context.username, user.getUserName() );
		assertEquals( request.context[ "contact.firstName"], user.getContact().getFirstName() );
		assertEquals( request.context[ "contact.lastName"], user.getContact().getLastName() );
		assertEquals( request.context.isActive, user.getIsActive() );
		assertEquals( request.context[ "contact.address.line1"], user.getContact().getAddress().GetLine1() );
		assertEquals( request.context[ "contact.address.line2"], user.getContact().getAddress().GetLine2() );
		assertEquals( request.context[ "contact.address.zipCode"], user.getContact().getAddress().GetZipCode() );
	}

	public void function testComponentWithManyChildrenPassInKeys() {
		
		request.context = getThreeLevelRC();

		var user = VARIABLES.BF.populate( cfc="userThreeLevel", data=request.context, deep=true, keys = "contact.firstName,contact.address.line1,username" );

		assertEquals( request.context.username, user.getUserName() );
		assertEquals( request.context[ "contact.firstName" ], user.getContact().getFirstName() );
		assertEquals( "", user.getContact().getLastName() );
		assertEquals( false, user.getIsActive() );
		assertEquals( request.context[ "contact.address.line1" ], user.getContact().getAddress().GetLine1() );
		assertEquals( "", user.getContact().getAddress().GetLine2() );
		assertEquals( "", user.getContact().getAddress().GetZipCode() );
	}

	public void function testStructureWithUnwantedKeys(){

		request.context = getOneLevelRC();
		request.context['unwantedKey'] = "Elvis";
		request.context['unwantedKey2'] = 2;

		var user = VARIABLES.BF.populate( cfc="UserOneLevel", data=request.context);

		assertEquals( request.context.username,user.getUserName() );
		assertEquals( request.context[ "firstName" ], user.getFirstName() );
		assertEquals( request.context[ "lastName" ], user.getLastName() );


		//Then these keys don't exist
		assertFalse(StructKeyExists(user, "unwantedKey"));
		assertFalse(StructKeyExists(user, "unwantedKey2"));

	}

	public void function testStructureWithUnwantedKeysAndTrustKeys(){

		request.context = getOneLevelRC();
		request.context['unwantedKey'] = "Elvis";
		request.context['unwantedKey2'] = 2;


		//This should thrown an error	
		var throwError = false;
		try{
			var user = VARIABLES.BF.populate( cfc="UserOneLevel", data=request.context, trustKeys=true);	
		}
		catch(Any e){
			throwError=true;
		}

		//Then these keys don't exist
		AssertTrue(throwError, "Trying to populate a bean AND trusting keys with extra keys should throw an error");
	}

	

	/*
		DATA GENERATION
	*/

	private Struct function getOneLevelRC()
	output=false {
		return { username = "foobar", firstName="Homer", lastName="Simpson", isActive=true };
	}



	private Struct function getTwoLevelRC()
	output=false {
		return { username = "foobar", "contact.firstName" = "Homer", "contact.lastName" = "Simpson", isActive = true, "contact.dateCreated" = "02/29/2012" };
		
	}



	private Struct function getThreeLevelRC()
	output=false {
		return {
				username = "foobar", 
				"contact.firstName" = "Homer", 
				"contact.lastName" = "Simpson", 
				"contact.dateCreated" = "02/29/2012",
				isActive = true,
				"contact.address.line1" = "123 Fake Street",
				"contact.address.line2" = "Apt 12",
				"contact.address.zipCode" = "54232"
		};
	}

}