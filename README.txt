DI/1 is a simple convention-based dependency injection (inversion of control) 
framework.

Initialize it with a comma-separated list of folders to scan for CFCs.

CFCs found in a folder called beans are assumed to be transient. All other CFCs
are assumed to be singletons.

DI/1 supports constructor injection, setter injection and property-based injection.
All injection is done by name. If a bean name is unique, it can be used as-is. Else
the bean will have an alias which is the bean name followed by its immediate parent
folder name, e.g.,

	/model/beans/user.cfc will be "user" and "userBean"
	/model/services/product.cfc will be "product" and "productService"

Folder names may be singular or plural. DI/1 assumes that if a folder name ends in
"s" it can remove that to get the singular name.

See https://github.com/framework-one/di1/wiki for more detail.
