component accessors="true" {
	property beanfactory;

    function init() {
	    param name="application.itemCount" default="0";
	    this.itemNumber = ++application.itemCount;
    }

	function getNewItem() {
		return variables.beanfactory.getBean( "item" );
	}

}
