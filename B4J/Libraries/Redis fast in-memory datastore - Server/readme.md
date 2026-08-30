### Redis fast in-memory datastore - Server by Peter Simpson
### 08/26/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171902/)

Hello everyone,  
I previously released the Redis Client library, but I was using a separate third party Redis Server package not developed in B4J. Nolonger is this the case. here is a Redis Server library that you can just run and forget about, it runs silently as a background worker ready for datastore requests. Datastore requests are calls or queries sent to create, read, update, or delete data within a storage repository.  
   
The B4J client library can be found [**HERE**](https://www.b4x.com/android/forum/threads/redis-client-fast-in-memory-datastore.171730/)  
  
There are other Redis server solutions on the forum created by excellent developers, and if you are looking for a Redis server, you should take a look at those as well.  
  
**What is Redis?**  
Redis is a **high‑performance, in‑memory datastore** used for speed critical applications such as caching, messaging, real time analytics, and distributed systems. The one line takeaway is that **Redis is a super fast key value database that lives in RAM and is perfect for real‑time workloads.**  
  
Once up and running, Redis clients can use it as a fast in‑memory datastore. It is primarily designed for local in‑memory datastore, but it can easily be used on a server to support multiple client connections. I have successfully tested multiple remote client connectivity sessions.  
  
**B4J library tab**  
![](https://www.b4x.com/android/forum/attachments/173135)  
  
[SPOILER="B4J Redis Server in-memory startup procedure"]  
2026-08-25 23:26:36.821:INFO :eek:ejs.Server:main: jetty-11.0.9; built: 2022-03-30T17:44:47.085Z; git: 243a48a658a183130a8c8de353178d154ca04f04; jvm 19.0.2+7-44  
2026-08-25 23:26:36.944:INFO :eek:ejss.DefaultSessionIdManager:main: Session workerName=node0  
2026-08-25 23:26:36.960:INFO :eek:ejsh.ContextHandler:main: Started o.e.j.s.ServletContextHandler@123f1134{/,file:///C:/Users/Peter/Documents/B4X/B4X/B4X%20Forum%20Code%20-%20Wrappers/Redis/Redis%20Background%20Worker%20Server/RedisBackgroundWorkerServer/Objects/www/,AVAILABLE}  
2026-08-25 23:26:37.006:INFO :eek:ejs.RequestLogWriter:main: Opened C:\Users\Peter\Documents\B4X\B4X\B4X Forum Code - Wrappers\Redis\Redis Background Worker Server\RedisBackgroundWorkerServer\Objects\logs\b4j-2026\_08\_25.request.log  
2026-08-25 23:26:37.138:INFO :eek:ejs.AbstractConnector:main: Started ServerConnector@d041cf{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}  
2026-08-25 23:26:37.156:INFO :eek:ejs.Server:main: Started Server@3fee9989{STARTING}[11.0.9,sto=0] @642ms  
Worker ended (class b4j.example.redisserver)  
RedisServer: Binding Redis to 0.0.0.0:6379  
Redis Server Log: Starting native Redis server on 0.0.0.0:6379  
RedisServer: Redis reported started on 0.0.0.0:6379  
[/SPOILER]  
  
**SS\_RedisServer  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **RedisServer**

- **Events:**

- **Log** (Message As String)
- **ServerError** (Error As String, StackTrace As String)
- **ServerStarted** (Success As Boolean, Port As Int)
- **ServerStopped** (Reason As String)

- **Functions:**

- **Close**
*Closes the server instance, stops background worker threads, and releases resources.*- **GetPort** As Int
*Returns the port number the server is configured to use.*- **Initialize** (maxThreads As Int)
*Initialize with default queue size (100).*- **InitializeEx** (maxThreads As Int, queueSize As Int)
*Initialize with custom thread count and queue size.*- **IsInitialized** As Boolean
*Returns true if the server object has been initialized and not yet closed.*- **IsRunning** As Boolean
*Returns true if the embedded server is currently running and active.*- **SetDebugMode** (debug As Boolean)
*Enable or disable debug mode. When enabled, error results and logs include additional details.*- **StartServerAsync** (EventName As String, Port As Int)
*Starts the embedded Redis server asynchronously on the specified port using local loopback binding only.*- **StartServerExAsync** (EventName As String, Port As Int)
*Starts the embedded Redis server asynchronously on the specified port using across all network interfaces.*- **StopServer**
*Stops the embedded Redis server, can start again as long as you have not followed up with Close.*
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE**](https://www.dropbox.com/scl/fi/mgc5jowrslle1u87da8kt/RedisBackgroundWorkerServer-Dependencies.zip?rlkey=u6ifsptnmw8feduxsg2d9v5br&dl=0) to download extra dependencies <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**