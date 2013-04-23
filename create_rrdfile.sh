#!/bin/bash
#
# First arg is rrd file

/usr/bin/rrdtool create $1 \
--step 300 \
DS:pl:GAUGE:600:0:100 \
DS:rtt:GAUGE:600:0:10000000 \
RRA:AVERAGE:0.5:1:800 \
RRA:AVERAGE:0.5:6:800 \
RRA:AVERAGE:0.5:24:800 \
RRA:AVERAGE:0.5:288:800 \
RRA:MAX:0.5:1:800 \
RRA:MAX:0.5:6:800 \
RRA:MAX:0.5:24:800 \
RRA:MAX:0.5:288:800

