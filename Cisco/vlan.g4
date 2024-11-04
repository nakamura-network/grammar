grammar vlan;

WS:( ' ' | '\t' | '\n' | '\r' ) -> skip;

STATUS:'active'|'act/unsup'|'act/lshut';
INTERFACE:'Fa'|'Gi';
ANY:WORD|NUM|DASH;
WORD:[a-zA-Z]+;
NUM:[0-9]+;
DASH:'-';

file:vlan_brief_header
     ANY+
     vlan_brief*
     vlan_detail_header
     ANY+
     vlan_detail*;

any:ANY+;
vlan_brief_header:ANY+;
vlan_brief:ANY any STATUS vlan_port?;
vlan_port:INTERFACE ANY (','? INTERFACE ANY('/'ANY)*)*;
vlan_detail_header:ANY+;
vlan_detail:any any*;