#Monitorering

Var først inspireret af: http://www.void.gr/kargig/blog/2007/03/21/round-trip-and-packet-loss-stats-with-rrdtool/
men har udviklet sig en del.



##Setup

Først bruges create_rrdfile.sh til at initialisere en rrd-file:

```
./create_rrdfile.sh /sti/til/rrdfil.rrd
```


Så bruges ping.sh til at hodle øje med hosten, dette sættes f.eks. i crontab:

```
*/5 * * * * /sti/til/ping.sh hostnavn_eller_ip /sti/til/rrdfil.rrd 
```

Og ping_graph.sh til at opdatere graferne med

```
2,7,12,17,22,27,32,37,42,47,52,57 * * * * /sti/til/ping_graph.sh /sti/til/rrdfil.rrd /sti/til/htmldir/ titel/hostnavn
```



Levende eksempel:
´´´
# Telenor router
*/5 * * * * /home/pi/monitoring/ping.sh 10.0.0.1 /home/pi/monitoring/rrds/ping_10.0.0.1.rrd 
2,7,12,17,22,27,32,37,42,47,52,57 * * * * /home/pi/monitoring/ping_graph.sh /home/pi/monitoring/rrds/ping_10.0.0.1.rrd /home/pi/monitoring/html/ 10.0.0.1

# Tysk server
*/5 * * * * /home/pi/monitoring/ping.sh moss.gpweb.dk /home/pi/monitoring/rrds/ping_moss.gpweb.dk.rrd 
2,7,12,17,22,27,32,37,42,47,52,57 * * * * /home/pi/monitoring/ping_graph.sh /home/pi/monitoring/rrds/ping_moss.gpweb.dk.rrd /home/pi/monitoring/html/ moss.gpweb.dk


´´´
