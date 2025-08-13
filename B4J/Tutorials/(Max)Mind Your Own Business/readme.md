### (Max)Mind Your Own Business by drgottjr
### 09/12/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142882/)

a forum member mentioned maxmind many years ago. maxmind is a database company specializing in, among other things, mapping ip addresses to locations and networks.  
  
they have for a long time made a version of their product available free of charge. not for commercial use, naturally. a few years ago, they changed a few things and began requiring registration before allowing accesss to the databases. but they are still free. and pretty inclusive.  
  
the databases are available in binary format or csv. if you choose the csv format, you need to build a suitable database yourself from the csv file. if you choose the binary format, maxmind provides an api, which can be turned into a library for b4x (which i did).  
  
i maintain a mail server which, like smtp servers all over, is constantly bombarded by scripts looking for open relays. the number of probes (even for a tiny domain such as mine) is staggering.  
  
i like to keep a map of the world showing markers where these probes emanate from and a kind of leader board (brazil, we have a winner!). i use maxmind to tell me where these ip addresses are (lat,lon,city,country,network). yes, there are such services available online (maxmind among them), but i'm talking about mapping thousands of hits a day. the online services have limits, and they involve rest access, so there is the expense of starting up and tearing down socket connections over and over. so i use maxmind's databases to handle the lookups.  
  
attached please find a simple project for b4j including a library/wrapper and the 2 api's provided by maxmind. i can't include the databases due to size. i could post them somewhere for downloading, but if you're interested, you should go to maxmind.com and download them for yourself.  
  
note: technically, a similar app for b4a would run the same, but because it involves either copying/pasting ip addresses or keying them in by hand, i went with b4j because both means of input are easier in b4j. even keying in a single ip address in android is to difficult for my fingers.  
  
put the .jar's/xml in your b4j additional libraries folder. obtain the databases from maxmind and put them somewhere easy to find (they are updated regularly, so you will download updates and store them where the app knows to look).  
  
the project will not run as posted:  
1) you need the databases. go to maxmind.com for the databases: <https://dev.maxmind.com/geoip/geolite2-free-geolocation-data?lang=en>  
you're looking for the binary format of GeoLite2-ASN.mmdb and GeoLite2-City.mmdb  
2) you need to tell the app where you're going to locate them. you can always use dirapp if you like. (if i share databases between b4j and b4a, then i prefer a more centralized location.)  
  
once you have dealt with those matters, build and run the project. a sample ouput is provided for your convenience.  
  
i do a certain amount of parsing of the input. based on what i'm expecting, it handles typical variations. your case use might be different.