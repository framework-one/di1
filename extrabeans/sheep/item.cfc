component accessors="true" {
	property beanfactory;
	param name="application.itemCount" default="0";
	this.itemNumber = ++application.itemCount;
	function init( any magicValue ) {
		this.magicValue = magicValue;
		return this;
	}
	function getNewItem() {
		return variables.beanfactory.getBean( "item" );
	}
}