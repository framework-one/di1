<h2>Welcome to InjectOne!</h2>
<cfset bf = getBeanFactory() />
<cfdump var="#bf.getBean('item')#" label="Item Bean"/>
<cfset user1 = bf.getBean('userbean') />
<cfdump var="#user1#" label="User 1 Bean"/>
<cfdump var="#user1.getItem()#" label="User 1's Item Bean"/>
<cfset user2 = bf.getBean('userbean') />
<cfdump var="#user2#" label="User 2 Bean"/>
<cfdump var="#user2.getItem()#" label="User 2's Item Bean"/>
<cfdump var="#bf.getBean('userservice')#" label="User Service"/>
<cfdump var="#bf.getBean('product')#" label="Product Service"/>
<cfdump var="#bf.getBean('userbean').product.getUserService()#" label="bf.getBean('userbean').product.getUserService()"/>