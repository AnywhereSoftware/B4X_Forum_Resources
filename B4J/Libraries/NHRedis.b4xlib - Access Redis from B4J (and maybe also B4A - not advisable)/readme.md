### NHRedis.b4xlib - Access Redis from B4J (and maybe also B4A - not advisable) by hatzisn
### 07/20/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171601/)

This is a library created by three minds. Two artificial and one human. This is a collaboration result of Google Gemini (which taught me the fundamentals of Redis and created some code), OpenAI's Codex (reviewed and edited it) and me (following the examples of jedis in javadoc.io). With this library you can access Redis directly from B4J and it gives you access to:  
  
Strings  
Hashes  
Lists  
Sets  
SortedSets  
Streams  
  
Place it in your B4J's additional libraries and then all you have to do is:  
  

```B4X
Dim rds As Redis  
rds.Instructions
```

  
  
While writting the second line you will be presented with a code that you will copy in order to paste it in your current class to try it and learn it. Then you can delete the above code.  
It contains all the info on which libraries you need to download from [www.mvnrepository.com](http://www.mvnrepository.com) and put them in your B4J's additional libraries and then add them as #AdditionalJars  
  
In order to create a live Redis server in your computer to check it, create a VirtualBox Linux Machine (I have tried it with Debian but it works also in Ubuntu by 100%), and then add the shell script contained in installredis.zip. The script installs docker and starts a container with Redis from this official image "redis/redis-stack-server". You must have sudo access. If you want to change the Redis password you will have to do it both in the shell script (you will have to edit it) and the UseRedis sub. You will not have to do anything else again in the VirtualBox Linux Machine as each time you start it it will start Redis server automatically. In the UseRedis sub you will have to change also the IP of the server to your VirtualBox Linux machine's IP. Make sure you start your linux machine with network bridged so it takes a local IP which you can access from your computer. You run the shell script with:  
  

```B4X
#You need to have sudo access  
sh installredis.sh
```