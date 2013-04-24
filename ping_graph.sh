#!/bin/sh
# First argument is input RRD file
# Second is output directory
# Thirds is title - e.g. the host

# Go to the output directory
cd $2

# Then make the HTML-file
echo "
<HTML>
<HEAD>
<TITLE>Round-Trip and Packet Loss Stats</TITLE>
<meta http-equiv="refresh" content="300" >
</HEAD>
<BODY>
<h1>Monitoring of $3</h1>
<H3>Hourly Round-Trip & Packetloss Stats(1min average)</H3>
" > ping_{$3}.html

# Make the graph 
rrdtool graph ping_{$3}_hour.png -h 225 -w 600 -a PNG \
--imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
--start -3600 --end -60 --x-grid MINUTE:10:HOUR:1:MINUTE:30:0:%R \
-v "Round-Trip Time (ms)" \
--rigid \
--lower-limit 0 \
DEF:roundtrip=$1:rtt:AVERAGE \
DEF:packetloss=$1:pl:AVERAGE \
CDEF:PLNone=packetloss,0,2,LIMIT,UN,UNKN,INF,IF \
CDEF:PL2=packetloss,2,8,LIMIT,UN,UNKN,INF,IF \
CDEF:PL15=packetloss,8,15,LIMIT,UN,UNKN,INF,IF \
CDEF:PL25=packetloss,15,25,LIMIT,UN,UNKN,INF,IF \
CDEF:PL50=packetloss,25,50,LIMIT,UN,UNKN,INF,IF \
CDEF:PL75=packetloss,50,75,LIMIT,UN,UNKN,INF,IF \
CDEF:PL100=packetloss,75,100,LIMIT,UN,UNKN,INF,IF \
AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
GPRINT:roundtrip:MIN:"Min\: %5.2lf\n" \
AREA:PLNone#6c9bcd:"0-2%":STACK \
AREA:PL2#00ffae:"2-8%":STACK \
AREA:PL15#ccff00:"8-15%":STACK \
AREA:PL25#ffff00:"15-25%":STACK \
AREA:PL50#ffcc66:"25-50%":STACK \
AREA:PL75#ff9900:"50-75%":STACK \
AREA:PL100#ff0000:"75-100%":STACK \
COMMENT:"(Packet Loss Percentage)"

# Add hourly to HTML
echo "
<img src='ping_{$3}_hour.png'><br>
<br>
<H3>Daily Round-Trip & Packetloss Stats(1min average)</H3>
" >> ping_{$3}.html

# Make daily graph
rrdtool graph ping_{$3}_day.png -h 225 -w 600 -a PNG \
--imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
--lazy --start -86400 --end -60 --x-grid MINUTE:30:HOUR:1:HOUR:2:0:%H \
-v "Round-Trip Time (ms)" \
--rigid \
--lower-limit 0 \
DEF:roundtrip=$1:rtt:AVERAGE \
DEF:packetloss=$1:pl:AVERAGE \
CDEF:PLNone=packetloss,0,2,LIMIT,UN,UNKN,INF,IF \
CDEF:PL2=packetloss,2,8,LIMIT,UN,UNKN,INF,IF \
CDEF:PL15=packetloss,8,15,LIMIT,UN,UNKN,INF,IF \
CDEF:PL25=packetloss,15,25,LIMIT,UN,UNKN,INF,IF \
CDEF:PL50=packetloss,25,50,LIMIT,UN,UNKN,INF,IF \
CDEF:PL75=packetloss,50,75,LIMIT,UN,UNKN,INF,IF \
CDEF:PL100=packetloss,75,100,LIMIT,UN,UNKN,INF,IF \
AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
GPRINT:roundtrip:MIN:"Min\: %5.2lf\n" \
AREA:PLNone#6c9bcd:"0-2%":STACK \
AREA:PL2#00ffae:"2-8%":STACK \
AREA:PL15#ccff00:"8-15%":STACK \
AREA:PL25#ffff00:"15-25%":STACK \
AREA:PL50#ffcc66:"25-50%":STACK \
AREA:PL75#ff9900:"50-75%":STACK \
AREA:PL100#ff0000:"75-100%":STACK \
COMMENT:"(Packet Loss Percentage)"

# Add daily to graph
echo "
<img src='ping_{$3}_day.png'><br>
<br>
<H3>Weekly Round-Trip & Packetloss Stats(1min average)</H3>
" >> ping_{$3}.html


# Make weekly
rrdtool graph ping_{$3}_week.png -h 225 -w 600 -a PNG \
--imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
--lazy --start -604800 --end -1800 \
-v "Round-Trip Time (ms)" \
--rigid \
--lower-limit 0 \
DEF:roundtrip=$1:rtt:AVERAGE \
DEF:packetloss=$1:pl:AVERAGE \
CDEF:PLNone=packetloss,0,2,LIMIT,UN,UNKN,INF,IF \
CDEF:PL2=packetloss,2,8,LIMIT,UN,UNKN,INF,IF \
CDEF:PL15=packetloss,8,15,LIMIT,UN,UNKN,INF,IF \
CDEF:PL25=packetloss,15,25,LIMIT,UN,UNKN,INF,IF \
CDEF:PL50=packetloss,25,50,LIMIT,UN,UNKN,INF,IF \
CDEF:PL75=packetloss,50,75,LIMIT,UN,UNKN,INF,IF \
CDEF:PL100=packetloss,75,100,LIMIT,UN,UNKN,INF,IF \
AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
GPRINT:roundtrip:MIN:"Min\: %5.2lf\n" \
AREA:PLNone#6c9bcd:"0-2%":STACK \
AREA:PL2#00ffae:"2-8%":STACK \
AREA:PL15#ccff00:"8-15%":STACK \
AREA:PL25#ffff00:"15-25%":STACK \
AREA:PL50#ffcc66:"25-50%":STACK \
AREA:PL75#ff9900:"50-75%":STACK \
AREA:PL100#ff0000:"75-100%":STACK \
COMMENT:"(Packet Loss Percentage)"

# Add weekly to html
echo "
<img src='ping_{$3}_week.png'><br>
<br>
<H3>Monthly Round-Trip & Packetloss Stats(1min average)</H3>
" >> ping_{$3}.html

# Make monthly
rrdtool graph ping_{$3}_month.png -h 225 -w 600 -a PNG \
--imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
--lazy --start -2592000 --end -7200 \
-v "Round-Trip Time (ms)" \
--rigid \
--lower-limit 0 \
DEF:roundtrip=$1:rtt:AVERAGE \
DEF:packetloss=$1:pl:AVERAGE \
CDEF:PLNone=packetloss,0,2,LIMIT,UN,UNKN,INF,IF \
CDEF:PL2=packetloss,2,8,LIMIT,UN,UNKN,INF,IF \
CDEF:PL15=packetloss,8,15,LIMIT,UN,UNKN,INF,IF \
CDEF:PL25=packetloss,15,25,LIMIT,UN,UNKN,INF,IF \
CDEF:PL50=packetloss,25,50,LIMIT,UN,UNKN,INF,IF \
CDEF:PL75=packetloss,50,75,LIMIT,UN,UNKN,INF,IF \
CDEF:PL100=packetloss,75,100,LIMIT,UN,UNKN,INF,IF \
AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
GPRINT:roundtrip:MIN:"Min\: %5.2lf\n" \
AREA:PLNone#6c9bcd:"0-2%":STACK \
AREA:PL2#00ffae:"2-8%":STACK \
AREA:PL15#ccff00:"8-15%":STACK \
AREA:PL25#ffff00:"15-25%":STACK \
AREA:PL50#ffcc66:"25-50%":STACK \
AREA:PL75#ff9900:"50-75%":STACK \
AREA:PL100#ff0000:"75-100%":STACK \
COMMENT:"(Packet Loss Percentage)"

# Add monthly to HTML
echo "
<img src='ping_{$3}_month.png'><br>
<br>
<H3>Yearly Round-Trip & Packetloss Stats(1min average)</H3>
" >> ping_{$3}.html

# Make yearly
rrdtool graph ping_{$3}_year.png \
--imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
--lazy --start -31536000 --end -86400 -h 225 -w 600 -a PNG \
-v "Round-Trip Time (ms)" \
--rigid \
--lower-limit 0 \
DEF:roundtrip=$1:rtt:AVERAGE \
DEF:packetloss=$1:pl:AVERAGE \
CDEF:PLNone=packetloss,0,2,LIMIT,UN,UNKN,INF,IF \
CDEF:PL2=packetloss,2,8,LIMIT,UN,UNKN,INF,IF \
CDEF:PL15=packetloss,8,15,LIMIT,UN,UNKN,INF,IF \
CDEF:PL25=packetloss,15,25,LIMIT,UN,UNKN,INF,IF \
CDEF:PL50=packetloss,25,50,LIMIT,UN,UNKN,INF,IF \
CDEF:PL75=packetloss,50,75,LIMIT,UN,UNKN,INF,IF \
CDEF:PL100=packetloss,75,100,LIMIT,UN,UNKN,INF,IF \
AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
GPRINT:roundtrip:MIN:"Min\: %5.2lf\n" \
AREA:PLNone#6c9bcd:"0-2%":STACK \
AREA:PL2#00ffae:"2-8%":STACK \
AREA:PL15#ccff00:"8-15%":STACK \
AREA:PL25#ffff00:"15-25%":STACK \
AREA:PL50#ffcc66:"25-50%":STACK \
AREA:PL75#ff9900:"50-75%":STACK \
AREA:PL100#ff0000:"75-100%":STACK \
COMMENT:"(Packet Loss Percentage)"

# Add yearly to HTML
echo "
<img src='ping_{$3}_year.png'><br>
<br>
</BODY>
</HTML>
" >> ping_{$3}.html
