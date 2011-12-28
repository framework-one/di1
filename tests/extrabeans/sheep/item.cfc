component accessors="true" {
	property beanfactory;
	param name="application.itemCount" default="0";

    function init() {
	    this.itemNumber = ++application.itemCount;
    }

	function getNewItem() {
		return variables.beanfactory.getBean( "item" );
	}

}
