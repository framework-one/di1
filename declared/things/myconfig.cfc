component accessors=true {
    property string name;
    function init( any config ) {
        variables.config = config;
    }
    function explain() {
        writeDump( var = variables.config, label = "MyConfig.config" );
        writeDump( var = variables.name, label = "MyConfig.name" );
    }
}
