component accessors="true" {
	property item;

	function init( product ) {
		variables.product = product;
	}

	function setFunny() { }

    function getProduct() {
        return variables.product;
    }

}
