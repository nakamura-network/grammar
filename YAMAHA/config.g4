grammar config;

WS:( ' ' | '#' | '\r' | '\t' | '\n' | '\r\n' ) -> skip;

IP_ADDRESS_NUM:NUM'.'NUM'.'NUM'.'NUM;
ANY_WORD:'any';
AREA:'area';
IEEE:'802.1q';
CONSOLE:'console';
ICMP:'icmp';
DIVIDE_NETWORK:'divide-network';
FILTER:'filter';
FILTER_SETTING:'pass'|'pass-log'|'pass-nolog'|'reject'|'reject-log'|'reject-nolog'|'restrict'|'restrict-log'|'restrict-nolog';
GATEWAY:'gateway';
LAN:'lan';
HOST:'host';
DHCP:'dhcp';
DHCP_SETTING:'broadcast-nak'|'none-domain-null'|'remain-silent'|'reply-ack'|'use-clientid';
NONE:'none';
BYTES:'bytes';
IP:'ip';
ID:'id';
IN_OUT:'in'|'out';
ROUTE:'route';
MAPPING:'mapping';
MAC:'MAC';
MAIN:'main';
NAME:'name';
ADDRESS:'Address'|'address';
VER:'ver';
VID:'vid';
VLAN:'vlan'|'VLAN';
VIRTUAL_LINK:'virtual-link';
SERIAL:'serial';
SECURE:'secure';
SERVICE:'service';
SERVER:'server';
TCP:'tcp';
UDP:'udp';
TELNETED:'telnetd';
TYPE:'type';
OSPF:'ospf';
PROMPT:'prompt';
PORT:'port';
PORT_BASED_OPTION:'port-based-option';
RFC:'rfc2131';
ROUTER:'router';
SCOPE:'scope';
COMPLIANT:'compliant';
EXCEPT:'except';
REVISION:'Rev.';
RELAY:'relay';
REPORTING_DATE:'Reporting Date';
DAY:'Mon'|'Tue'|'Wed'|'Thu'|'Fri'|'Sat'|'Sun';
MONTH:'Jan'|'Feb'|'Mar'|'Apr'|'May'|'Jun'|'Jul'|'Aug'|'Sep'|'Oct'|'Nov'|'Dec';
MEMORY:'Memory';
WELL_KNOWN_PORT:'tcpmux'|'rje'|'echo'|'discard'|'systat'|'daytime'|'chargen'|'ftpdata'|'ftp'|'telnet'|'smtp'|'time'|'nameserver'
               |'whois'|'auditd'|'domain'|'tacacs_ds'|'dhcps'|'dhcpc'|'tftp'|'gopher'|'finger'|'www'|'kerberos'|'pop2'
               |'pop3'|'sunrpc'|'ident'|'nntp'|'ntp'|'netbios_ns'|'netbios_dgm'|'netbios_ssn'|'imap2'|'snmp'|'snmptrap'
               |'bgp'|'irc'|'at_rtmp'|'at_nbp'|'at_3'|'at_echo'|'at_5'|'at_zis'|'at_7'|'at_8'|'imap3'|'ldap'|'netware_ip'
               |'timbuktu'|'mobileip_agent'|'mobilip_mn'|'https'|'biff'|'who'|'syslog'|'exec'|'login'|'printer'|'talk'
               |'uucp'|'submission'|'doom';

NUM:[0-9]+;
ANY:[a-zA-Z]+;

file:device_model
     device_mac_address
     memory_and_interface
     main
     reporting_date
     category+;

category:console
        |ip_route
        |ip_filter
        |secure_filter
        |lan_address
        |lan_type
        |vlan_address
        |vlan_mapping
        |vlan_tag
        |ospf_router
        |ospf_area
        |ospf_interface
        |ospf_virtual_link
        |telneted_host
        |dhcp_service
        |dhcp_scope
        |dchp_server
        |any;

any:(ANY|NUM)+;
device_model:any REVISION NUM('.'NUM)* '('DAY date')';
date:MONTH NUM NUM':'NUM':'NUM NUM;
device_mac_address:MAC ADDRESS ':' mac_address(','mac_address)*;
mac_address:any':'any':'any':'any':'any':'any;
memory_and_interface:MEMORY any ',' any(','any);
main:MAIN':'any VER'='any SERIAL'='any (MAC'-'ADDRESS'='mac_address)*;
lan_type:LAN TYPE lan PORT_BASED_OPTION'='DIVIDE_NETWORK;
reporting_date:REPORTING_DATE ':' date;
console:CONSOLE PROMPT any;
ip_address:IP_ADDRESS_NUM('/' NUM)? | '*';
ip_route:IP ROUTE ip_address GATEWAY next_hop_address;
next_hop_address:IP_ADDRESS_NUM;
ip_filter:IP FILTER NUM FILTER_SETTING ip_address(','ip_address)* ip_address(','ip_address)* protocol port port;
secure_filter:IP (lan|vlan) SECURE FILTER IN_OUT ANY+;
lan_address:IP lan('/'NUM)? ADDRESS ip_address;
vlan_address:IP vlan ADDRESS ip_address;
vlan_mapping:VLAN PORT MAPPING LAN NUM'.'NUM vlan;
vlan_tag:VLAN lan('/'NUM)? IEEE VID'='NUM (NAME'='(any|vlan))?;
lan:LAN NUM;
vlan:VLAN NUM;
ospf_router:OSPF ROUTER ID IP_ADDRESS_NUM;
ospf_area:OSPF AREA NUM;
ospf_interface:IP any OSPF AREA ANY;
ospf_virtual_link:OSPF VIRTUAL_LINK IP_ADDRESS_NUM ANY;
port:'*'|WELL_KNOWN_PORT(','WELL_KNOWN_PORT)*('-'WELL_KNOWN_PORT)?|ANY(','ANY)*('-'ANY)?;
telneted_host:TELNETED HOST ((IP_ADDRESS_NUM('-'IP_ADDRESS_NUM)?)*|ANY|NONE|LAN);
protocol:(UDP|TCP|ICMP)(','(UDP|TCP|ICMP))*|'*';
dhcp_service:DHCP SERVICE SERVER|RELAY;
dchp_server:DHCP SERVER RFC COMPLIANT EXCEPT DHCP_SETTING+;
dhcp_scope:DHCP SCOPE NUM IP_ADDRESS_NUM'-'IP_ADDRESS_NUM'/'NUM;
