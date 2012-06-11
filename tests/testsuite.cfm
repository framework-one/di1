<cfscript>
	
testSuite = new mxunit.framework.TestSuite();

tests = directoryList( getDirectoryFromPath( getCurrentTemplatePath() ), false, "name", "*.cfc" );

for ( test in tests ){
	testSuite.addAll( "tests." & Replace( test, ".cfc", "" ) );
}

results = testSuite.run();

writeOutput( results.getResultsOutput() );
</cfscript>