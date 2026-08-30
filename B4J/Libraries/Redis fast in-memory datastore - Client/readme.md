### Redis fast in-memory datastore - Client by Peter Simpson
### 08/26/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171730/)

Hello everyone,  
After reading the post by [USER=72271]@hatzisn[/USER] [HERE](https://www.b4x.com/android/forum/threads/redis-a-great-tutorial.171466/) titled 'Redis - A great tutorial', I decided to look more into Redis. Even though I personally cannot ever see myself using this Redis library (I prefer B4X KVS or in‑memory SQLite). But, B4X (B4J) developers might want to use it, and of course that means yet another useful library for B4J developers.  
  
**What is Redis?**  
Redis is a **high‑performance, in‑memory datastore** used for speed critical applications such as caching, messaging, real time analytics, and distributed systems. The one line takeaway is that **Redis is a super fast key value database that lives in RAM and is perfect for real‑time workloads.**  
  
To run the in-memory datastore, you need to first run [**THIS**](https://www.b4x.com/android/forum/threads/redis-client-fast-in-memory-datastore-server.171902/) B4J Redis server solution locally or on a remote machine.  
  
The B4J redis server library can be found [**HERE**](https://www.b4x.com/android/forum/threads/redis-client-fast-in-memory-datastore-server.171902/)  
  
**B4J library tab**  
![](https://www.b4x.com/android/forum/attachments/173140)  
  
[SPOILER="B4J Redis in memory test logs"]  
Redis Pool Initialized: true  
Raw Pool GET Result: Hello from B4XPages!  
Command: HSET | Success: true | Result: 1  
HSET completed. Fetching field 'name'…  
Command: SET | Success: true | Result: OK  
Command: HDEL | Success: true | Result: 1  
Hash field deleted successfully. Result: 1  
Command: HSET | Success: true | Result: 0  
HSET completed. Fetching field 'name'…  
Command: HSET | Success: true | Result: 0  
HSET completed. Fetching field 'name'…  
Command: EXPIRE | Success: true | Result: 1  
Expire set successfully. Result: 1  
Command: EXISTS | Success: true | Result: true  
Key Exists: true  
Command: HEXISTS | Success: true | Result: true  
Hash Field Exists: true  
Command: HGETALL | Success: true | Result: {name=Peter, role=developer}  
Retrieved All Hash Fields Count: 2  
Command: LPUSH | Success: true | Result: 50  
LPUSH list length: 50  
Command: RPUSH | Success: true | Result: 49  
RPUSH list length: 49  
Command: SADD | Success: true | Result: 0  
SADD added count: 0  
Command: SMEMBERS | Success: true | Result: [unique\_member]  
SMEMBERS items count: 1  
Command: LRANGE | Success: true | Result: [item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_left, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right, item\_right]  
LRANGE items count: 50  
Command: HGET | Success: true | Result: Peter  
Retrieved Hash Field Value: Peter  
Command: HGET | Success: true | Result: Peter  
Retrieved Hash Field Value: Peter  
Command: HGET | Success: true | Result: Peter  
Retrieved Hash Field Value: Peter  
Command: GET | Success: true | Result: Hello from B4XPages!  
Retrieved Value: Hello from B4XPages!  
[/SPOILER]  
  
**SS\_RedisClient**  
  
**Author:** Peter Simpson  
**Version:** 1.01  

- **RedisClient**

- **Events:**

- **CommandResult** (Command As String, Success As Boolean, Result As Object)
- **Error** (Error As String)
- **Log** (Message As String)
- **MessageReceived** (Channel As String, Message As String)
- **PoolInitialized** (Success As Boolean)
- **TaskRejected** (Command As String, Reason As String)

- **Functions:**

- **Close**
*Close everything: unsubscribe, close pool, shutdown executor.*- **DBSizeAsync**
*Async DBSIZE  
 Returns the number of keys in the currently selected database.*- **DecrAsync** (key As String)
*Async DECR  
 Decrements the number stored at key by one.*- **DecrByAsync** (key As String, value As Long)
*Async DECRBY  
 Decrements the number stored at key by value.*- **DelAsync** (key As String)
*Async DEL*- **ExistsAsync** (key As String)
*Async EXISTS  
 Checks if a key exists in Redis. Returns a boolean.*- **ExpireAsync** (key As String, seconds As Long)
*Async EXPIRE  
 Sets a timeout on a key in seconds.*- **GetAsync** (key As String)
*Async GET*- **GetRawPool** As redis.clients.jedis.JedisPool
*Expose raw pool for advanced usage. Use with caution.*- **HDelAsync** (key As String, field As String)
*Async HDel - Hash*- **HExistsAsync** (key As String, field As String)
*Async HEXISTS - Hash  
 Checks if a specific hash field exists.*- **HGetAllAsync** (key As String)
*Async HGETALL - Hash  
 Retrieves all fields and values in a hash.*- **HGetAsync** (key As String, field As String)
*Async HGET - Hash*- **HSetAsync** (key As String, field As String, value As String)
*Async HSET - Hash*- **IncrAsync** (key As String)
*Async INCR  
 Increments the number stored at key by one.*- **IncrByAsync** (key As String, value As Long)
*Async INCRBY  
 Increments the number stored at key by value.*- **InfoAsync** (section As String)
*Async INFO  
 Retrieves information and statistics about the Redis server.  
 Pass an empty string or section name such as memory, clients, server.*- **Initialize** (maxThreads As Int)
*Initialize with default queue size (100).*- **InitializeEx** (maxThreads As Int, queueSize As Int)
*Initialize with custom thread and queue sizes.*- **InitializePool** (EventName As String, host As String, port As Int, timeoutMs As Int, password As String, database As Int, maxTotal As Int, maxIdle As Int)
*Initialises a Jedis Redis connection pool.  
 EventName: B4X event prefix used for callbacks (e.g., EventName + "\_PoolInitialized").  
 Host: Redis server hostname or IP ("127.0.0.1" for local, cloud endpoint for hosted Redis).  
 Port: Redis TCP port (default 6379).  
 TimeoutMs: Socket timeout in milliseconds (typical 2000-5000).  
 Password: Redis authentication password; empty if not required.  
 Database: Logical Redis database index (0-15), default is 0.  
 MaxTotal: Maximum total connections allowed in the pool.  
 MaxIdle: Maximum idle connections kept ready for reuse.  
 Notes:  
 - Fires EventName + "\_PoolInitialized" with success/failure.  
 - Failure indicates DNS, socket, or authentication issues.  
 - Call Redis.Close() on shutdown to release pool resources.*- **IsInitialized** As Boolean
*Returns true if the object has been initialized and not yet closed.*- **KeysAsync** (pattern As String)
*Async KEYS  
 Retrieves all keys matching the given pattern as a B4X List.*- **LLenAsync** (key As String)
*Async LLEN - List  
 Returns the length of a list.*- **LPopAsync** (key As String)
*Async LPOP - List  
 Removes and returns the first element of a list.*- **LPushAsync** (key As String, value As String)
*Async LPUSH - List  
 Inserts a value at the head of a list.*- **LRangeAsync** (key As String, start As Long, stop As Long)
*Async LRANGE - List  
 Retrieves a range of elements from a list.  
 To see all elements, set stop to -1.*- **PublishAsync** (channel As String, message As String)
*Async PUBLISH*- **RPopAsync** (key As String)
*Async RPOP - List  
 Removes and returns the last element of a list.*- **RPushAsync** (key As String, value As String)
*Async RPUSH - List  
 Inserts a value at the tail of a list.*- **SAddAsync** (key As String, member As String)
*Async SADD - Set  
 Adds a unique member to a set.*- **SCardAsync** (key As String)
*Async SCARD - Set  
 Returns the member count (cardinality) of a set.*- **SetAsync** (key As String, value As String)
*Async SET*- **SetBlockingSubmit** (blocking As Boolean)
*Configure whether submissions should block when the queue is full (CallerRunsPolicy) or use the default rejection handler.  
 Must be called after Initialize/InitializeEx.*- **SetDebugMode** (debug As Boolean)
*Enable or disable debug mode. When enabled, error results include stack traces.*- **SetSubscriberJoinTimeout** (timeoutMs As Long)
*Set subscriber join timeout in milliseconds used when waiting for subscriber thread termination during Unsubscribe.*- **SIsMemberAsync** (key As String, member As String)
*Async SISMEMBER - Set  
 Checks if a member exists in a set.*- **SMembersAsync** (key As String)
*Async SMEMBERS - Set  
 Returns all members of a set as a list.*- **SRemAsync** (key As String, member As String)
*Async SREM - Set  
 Removes a member from a set.*- **Subscribe** (channel As String)
*Subscribe to a channel. Uses a dedicated subscriber thread and Jedis instance.*- **TTLAsync** (key As String)
*Async TTL  
 Gets the remaining time to live of a key in seconds.*- **Unsubscribe**
*Unsubscribe and attempt to deterministically stop the subscriber thread.*- **ZAddAsync** (key As String, score As Double, member As String)
*Async ZADD - Sorted Set  
 Adds a member with a score to a sorted set.*- **ZCardAsync** (key As String)
*Async ZCARD - Sorted Set  
 Returns the member count (cardinality) of a sorted set.*- **ZRangeAsync** (key As String, start As Long, stop As Long)
*Async ZRANGE - Sorted Set  
 Retrieves a range of members from a sorted set by index.*- **ZRemAsync** (key As String, member As String)
*Async ZREM - Sorted Set  
 Removes a member from a sorted set.*
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.  
[CLICK HERE](https://www.dropbox.com/scl/fi/09pqy4ws14moq2ndklamk/Redis.zip?rlkey=iy6ve6xesdrvjilg7beqpj9i9&dl=0)** to download the dependencies <<<<<<<<<<<<<<<<<<<<<<<<  
  
D = 68 + 70  
  
  
**Enjoy…**