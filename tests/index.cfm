<h1>Running the tests</h1>
<cfscript>
	testSuite = createObject("component","mxunit.framework.TestSuite").TestSuite(); //TestSuite() is the constructor
	

	  testSuite.addAll("tests.AddBean");
      testSuite.addAll("tests.BeanInfo");
      testSuite.addAll("tests.Circular");
      testSuite.addAll("tests.Constant");
      testSuite.addAll("tests.DeclareBean");
      testSuite.addAll("tests.defaultarg");
      testSuite.addAll("tests.Empty");
      testSuite.addAll("tests.ExtraBeans");
      testSuite.addAll("tests.InjectProperties");
      testSuite.addAll("tests.Mapping");
      testSuite.addAll("tests.Model");
      testSuite.addAll("tests.ModelService");
      testSuite.addAll("tests.OnLoad");
      testSuite.addAll("tests.Parent");
      testSuite.addAll("tests.Populate");
      testSuite.addAll("tests.singletonPattern");
      testSuite.addAll("tests.Transient");
      testSuite.addAll("tests.transientPattern");
      results = testSuite.run();
      	echo("<html><head><title>Railo.io Unit Tests</title></head><body>");
 		echo(results.getHTMLResults());		
 		echo("</body></html>");

</cfscript>
