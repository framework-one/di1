DI/1 is a simple convention-based dependency injection (inversion of control) 
framework. DI/1 is part of the [FW/1 family of components](https://github.com/framework-one/fw1).
All development work occurs in that repo. This repo is provided purely as a convenience for users
who want just DI/1 as a standalone component.

Usage
----
Initialize it with a comma-separated list of folders to scan for CFCs:

    var beanfactor = new ioc("/model,/shared/services");

CFCs found in a folder called `beans` are assumed to be transient. All other CFCs
are assumed to be singletons. This can be overridden via optional configuration.

DI/1 supports constructor injection, setter injection and property-based injection.
All injection is done by name. If a bean name is unique, it can be used as-is, else
the bean will have an alias which is the bean name followed by its immediate parent
folder name, e.g.,

	/model/beans/user.cfc will be "user" and "userBean"
	/model/services/product.cfc will be "product" and "productService"

Folder names may be singular or plural. DI/1 assumes that if a folder name ends in
"s" it can remove that to get the singular name.

See the [DI/1 documentation](https://framework-one.github.io/documentation/4.3/using-di-one/) for more details.
