component {
	param name="application.itemCount" default="0";
	this.itemNumber = ++application.itemCount;
	function init( any magicValue ) {
		this.magicValue = magicValue;
		return this;
	}
}