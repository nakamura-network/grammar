grammar version;

WS:( ' ' | '\r' | '\t' | '\n' ) -> skip;

ANY:.;


file:category+;

category:model_name
        |ios_version
        |rom_version
        |device_model
        |any
        |','
        |'('
        |')'
        |':'
        |'/'
        |','
        |'Cisco';

any:ANY+;
model:ANY+;
model_name:'Cisco IOS Software,' any 'Software' '(' any ')';
ios_version:'Version' any;
rom_version:'ROM:' any;
device_model:'Cisco' model '(' any ')' (any|'('|')'|'/')+ 'bytes of memory';

