grammar config;

WS:( ' ' | '\r' | '\t' | '\n' | '!' ) -> skip;

AAA:'aaa';
ACCESS_GROUP:'access-group';
ACCESS_LIST:'access-list';
ALLOWED:'allowed';
ARCHIVE:'archive';
AREA:'area';
ADDRESS:'address';
DUPLEX_SETTING:'full'|'half';
VERSION_NUM:NUM'.'NUM;
IP_ADDRESS_NUM:NUM'.'NUM'.'NUM'.'NUM;
ADJUST_MSS:'adjust-mss';
ANY_WORD:'any';
AUTO:'auto';
BOOT_END:'boot-end-marker';
BOOT_START:'boot-start-marker';
BRI:'BRI';
CEF:'cef';
CONTROL_PLANE:'control-plane';
CRYPTO:'crypto';
DATETIME_SETTING:'msec'|'localtime'|'show-timezone';
DEFAULT:'default';
DUPLEX:'duplex';
ENCAPSULATION:'encapsulation';
ENCAPSULATION_SETTING:'hdlc'|'ppp';
END:'end';
ETHERNET:'FastEthernet'|'GigabitEthernet'|'TenGigabitEthernet';
FORWARD_PROTOCOL:'forward-protocol';
HOST:'host';
HOSTNAME:'hostname';
HTTP:'http server'|'http secure-server';
IN_OUT:'in'|'out';
INTERFASE:'interface';
INT_VLAN:'Vlan';
IPV6:'ipv6';
ISDN:'isdn';
LINE:'line';
LINE_SETTING:'logging synchronous'|'login'|'password';
LICENSE:'license';
LOG_ADJACENCY_CHANGES:'log-adjacency-changes';
LOG_CONFIG:'log config';
LOG_CONF:'hidekeys';
MGCP:'mgcp';
MODE:'mode';
SWITCHPORT_MODE:'access'|'trunk'|'dynamic auto'|'dynamic desirable';
STP_MODE:'pvst'|'rapid-pvst'|'mst';
MULTIDROP:'multidrop';
MULTILINK:'multilink bundle-name authenticated';
NAME:'name';
NAT:'nat';
INSIDE:'inside';
OUTSIDE:'outside';
NATIVE:'native';
NETWORK:'network';
NEW_MODEL:'new-model';
NO:'no';
OPERATOR:'eq'|'neq'|'gt'|'lt'|'range';
OSPF:'ospf';
PERMIT:'permit'|'deny';
PASSWORD:'password-encryption';
PKI:'pki';
PID:'pid';
PORT:'con'|'aux'|'vty';
PRIORITY:'priority';
PROTOCOL:'ip'|'tcp'|'udp'|'icmp';
PROFILE:'profile';
REMOVAL:'removal';
ROUTE:'route';
ROUTER:'router';
ROUTER_ID:'router-id';
SERVICE:'service';
SOURSE_ROUTE:'source-route';
SHUTDOWN:'shutdown';
SPANNING_TREE:'spanning-tree';
SPEED:'speed';
SWITCHPORT:'switchport';
SYS_LOG:'dot11 syslog';
SN:'sn';
TERMINATION:'termination';
TIME:'uptime'|'datetime';
TIMESTAMPS:'timestamps debug'|'timestamps log';
TIMEOUT:'timeout';
TOKEN:'token';
TRANK_ENCAPSULATION:'dot1q'|'isl';
UDI:'udi';
VERSION:'version';
VIRTUAL_LINK:'virtual-link';
VIRTUAL_REASSEMBLY:'virtual-reassembly';
VLAN:'vlan';
RIP:'rip';

WELL_KNOWN_PORT:'rje'|'echo'|'discard'|'users'|'daytime'|'netstat'|'quote'|'chargen'|'ftp-data'|'ftp'
               |'telnet'|'smtp'|'time'|'rlp'|'nameserver'|'nicname'|'login'|'domain'|'bootps'|'bootpc'|'tftp'
               |'finger'|'supdup'|'hostname'|'iso-tsap'|'x400'|'x400-snd'|'sunrpc'|'auth'|'uucp-path'|'nntp'|'ntp'
               |'netbios-ns'|'netbios-dgm'|'netbios-ss'|'snmp'|'snmptrap'|'rexec'|'rlogin'|'rwho'|'rsh'|'syslog'
               |'printer'|'rip'|'timed';

NUM:[0-9]+;
ANY:[a-zA-Z]+;

file:category+;

category:version
        |service
        |stp
        |hostname
        |aaa
        |crypto
        |source_route
        |boot
        |syslog
        |cef
        |multilink
        |license
        |archive
        |vlan_name
        |interface
        |ip_route
        |router
        |forword_protocol
        |http
        |access_list
        |control_plane
        |mgcp
        |line
        |any
        |end;

aaa:NO?AAA NEW_MODEL;
access_group:PROTOCOL ACCESS_GROUP (access_list_number|access_list_name) IN_OUT;
access_list:ACCESS_LIST NUM PERMIT PROTOCOL source_ip_address source_port? dest_ip_address dest_port?;
access_list_number:NUM;
access_list_name:any;
access_vlan:SWITCHPORT_MODE VLAN NUM;
source_ip_address:(HOST ip_address_or_any)|(ip_address_or_any wildcard?);
dest_ip_address:(HOST ip_address_or_any)|(ip_address_or_any wildcard?);
ip_address_and_subnet_mask:ip_address subnet_mask;
ip_address_or_any:IP_ADDRESS_NUM|ANY_WORD;
ip_address:IP_ADDRESS_NUM;
subnet_mask:IP_ADDRESS_NUM;
next_hop_address:IP_ADDRESS_NUM;
wildcard:IP_ADDRESS_NUM;
any:(ANY|NUM)+;
archive:ARCHIVE log_config;
boot:BOOT_START (ANY+)? BOOT_END;
bri:BRI NUM interface_setting;
crypto:CRYPTO PKI TOKEN DEFAULT REMOVAL TIMEOUT ANY;
cef:NO? (IPV6|PROTOCOL) CEF;
control_plane:CONTROL_PLANE;
duplex:DUPLEX duplex_type;
duplex_type:DUPLEX_SETTING|AUTO;
encapsulation:ENCAPSULATION ENCAPSULATION_SETTING;
end:END;
ethernet:ETHERNET ((stack'/')?slot'/')?port interface_setting;
forword_protocol:NO?PROTOCOL FORWARD_PROTOCOL ANY+;
hostname:HOSTNAME any;
http:NO?PROTOCOL HTTP;
if_vlan:INT_VLAN NUM interface_setting;
interface:INTERFASE interfacename;
interfacename:bri|ethernet|if_vlan;
interface_setting:(if_ip_address|access_group|switchport|encapsulation|duplex|speed|nat|mss|virtual_reassembly|isdn|SHUTDOWN|any)*;
if_ip_address:NO?PROTOCOL ADDRESS (ip_address subnet_mask)?;
ip_route:PROTOCOL ROUTE ip_address subnet_mask next_hop_address;
isdn:NO? ISDN TERMINATION MULTIDROP;
line:LINE PORT NUM+ LINE_SETTING* (ANY+)?;
license:LICENSE UDI PID any SN any;
log_config:LOG_CONFIG LOG_CONF;
mgcp:MGCP PROFILE DEFAULT;
mss:PROTOCOL PROTOCOL ADJUST_MSS NUM;
multilink:MULTILINK;
nat:PROTOCOL NAT (INSIDE|OUTSIDE);
network_area:NETWORK ip_address wildcard AREA NUM;
ospf:OSPF NUM(router_id|LOG_ADJACENCY_CHANGES|virtual_link|network_area|any)*;
rip:RIP;
port_mode:MODE SWITCHPORT_MODE;
source_port:OPERATOR access_list_port_info;
dest_port:OPERATOR access_list_port_info;
access_list_port_info:(NUM|WELL_KNOWN_PORT)+;
router_id:ROUTER_ID IP_ADDRESS_NUM;
router:ROUTER (ospf|rip);
service:NO?SERVICE(timestamps|PASSWORD);
source_route:PROTOCOL SOURSE_ROUTE;
speed:SPEED speed_type;
speed_type:NUM|AUTO;
stp:SPANNING_TREE (MODE STP_MODE|vlan PRIORITY NUM|any|SPANNING_TREE)*;
switchport:SWITCHPORT(port_mode|access_vlan|trunk);
syslog:NO?SYS_LOG;
timestamps:TIMESTAMPS TIME DATETIME_SETTING;
trunk:SWITCHPORT_MODE (native_vlan|allowed_vlan|trunk_encapsulation);
native_vlan:NATIVE VLAN NUM;
allowed_vlan:ALLOWED VLAN vlan_list;
trunk_encapsulation:ENCAPSULATION TRANK_ENCAPSULATION;
version:VERSION VERSION_NUM;
virtual_link:AREA NUM VIRTUAL_LINK IP_ADDRESS_NUM;
virtual_reassembly:PROTOCOL VIRTUAL_REASSEMBLY IN_OUT;
vlan:VLAN NUM;
port:NUM;
slot:NUM;
stack:NUM;
vlan_name:vlan NAME any;
vlan_num:any('-'any)?;
vlan_list:vlan_num(','vlan_num)*;