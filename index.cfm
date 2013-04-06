<h1>Welcome to DI/1!</h1>
<p>DI/1 is a lightweight, convention-over-configuration dependency injection framework a.k.a. bean factory.</p>
<p>All you need is <tt>ioc.cfc</tt>. See <a href="https://github.com/framework-one/di1/wiki">the DI/1 wiki</a> for detailed documentation.</p>
<pre>var bf = new ioc( "/model" );      // DI/1 will find all CFCs under /model
svc = bf.getBean( "userService" ); // typical singleton: UserService.cfc or services/user.cfc
bean = bf.getBean( "item" );       // typical transient: beans/item.cfc</pre>
<p>DI/1 autowires by name and attempts to resolve constructor arguments, setters and property declarations (when implicit setters are used).</p>
<p>If you want to run the test suite, install <a href="http://mxunit.org">MXUnit</a> and run the Ant script.</p>
