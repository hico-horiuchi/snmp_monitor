# Monitor

[![Build Status](https://travis-ci.org/hico-horiuchi/snmp_monitor.svg?branch=master)](https://travis-ci.org/hico-horiuchi/snmp_monitor)

Monitor is visualization tool for SNMP.
<br>
You can see in the graph, such as CPU usage, memory usage and etc... on the server.

<a href="https://raw.githubusercontent.com/hico-horiuchi/snmp_monitor/master/screenshots/servers_list.jpg">
  <img src="/../master/screenshots/servers_list.jpg" width="320px" height="auto">
</a>
<a href="https://raw.githubusercontent.com/hico-horiuchi/snmp_monitor/master/screenshots/servers_show.jpg">
  <img src="/../master/screenshots/servers_show.jpg" width="320px" height="auto">
</a>

## Using

- Ruby on Rails 4
- Bootstrap & Bootswatch
- HighCharts

## SNMP Setting

/etc/snmp/snmpd.conf (on Ubuntu or Debian)

	#agentAddress udp:127.0.0.1:161
	agentAddress udp:161,udp6:[::1]:161

    # for CPU, disk and memory
    view systemonly included .1.3.6.1.4.1.2021

    rocommunity secret [Monitor Server IP Address]
