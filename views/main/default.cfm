<h2>Welcome to InjectOne!</h2>
<cfset bf = getBeanFactory() />
<cfdump var="#bf.getBean('userbean')#" label="User Bean"/>
<cfdump var="#bf.getBean('userservice')#" label="User Service"/>
<cfdump var="#bf.getBean('product')#" label="Product Service"/>
<cfdump var="#bf.getBean('userbean').product.getUserService()#" label="bf.getBean('userbean').product.getUserService()"/>