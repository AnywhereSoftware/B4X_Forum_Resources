B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private RedisClient As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'<code>
''Download from www.mvnrepository.com the following libraries
''and put those libraries in the additional libraries folder
''Add the following AdditionalJars In Main
''#AdditionalJar: jedis-7.5.3
''#AdditionalJar: commons-pool2-2.13.0.jar 
'
'Sub Process_Globals
'	Private rds As Redis
'End Sub
'
'Private Sub UseRedis
'	' 1. Initialize the Jedis Client pointing to your Redis server
'	' Syntax: NewJedisClient(Host, Port)
'	rds.Initialize
'	If rds.ConnectToRedis("192.168.1.35", 6379, "mypassword") = False Then
'		Return
'	End If
'    
'	' ==========================================
'	' 1. STRINGS (Key-Value)
'	' ==========================================
'	Log("--- 1. Testing Strings ---")
'	rds.StringSet("app:version", "v2.5.0")
'	Log("Version: " & rds.StringGet("app:version"))
'    
'	' ==========================================
'	' 2. HASHES (Objects)
'	' ==========================================
'	Log("--- 2. Testing Hashes ---")
'	Dim profile As Map = CreateMap("name": "Alex", "status": "Active")
'	rds.HashSet("user:100", profile)
'	Log("User Name: " & rds.HashGetField("user:100", "name"))
'
'	' ==========================================
'	' 3. LISTS (Ordered Queue/Stack)
'	' ==========================================
'	Log("--- 3. Testing Lists (Queues) ---")
'	rds.Delete("task:queue") ' Clear old testing data
'    
'	rds.ListPushTo("task:queue", "ProcessImage")
'	rds.ListPushTo("task:queue", "SendEmail")
'	Log("Second Value in List: " & rds.ListGetItem("task:queue", 1))
'	rds.ListResetItem("task:queue", 1, "SendEmailAgain")
'	Log("Second Value in List after Reset: " & rds.ListGetItem("task:queue", 1))
'	
'	Log("Popped Item: " & rds.ListPopFrom("task:queue")) ' Returns "ProcessImage" (FIFO)
'    
'	' ==========================================
'	' 4. SETS (Unique Unordered Items)
'	' ==========================================
'	Log("--- 4. Testing Sets ---")
'    
'    
'	rds.SetAddTo("user:tags", "developer")
'	rds.SetAddTo("user:tags", "b4j-fan")
'	rds.SetAddTo("user:tags", "developer") ' Duplicate, will be ignored by Redis
'    
'	Dim tagsList As List = rds.SetGetMembers("user:tags")
'	Log("Unique Tags Count: " & tagsList.Size) ' Will be 2, not 3
'    
'	' ==========================================
'	' 5. SORTED SETS (ZSET - Leaderboards)
'	' ==========================================
'	Log("--- 5. Testing Sorted Sets ---")
'	rds.Delete("game:leaderboard")
'    
'	rds.SortedSetAddTo("game:leaderboard", 4500, "PlayerAlpha")
'	rds.SortedSetAddTo("game:leaderboard", 9200, "PlayerBeta")
'	rds.SortedSetAddTo("game:leaderboard", 1500, "PlayerCharlie")
'    
'	' Get top players sorted by highest score down
'	Dim topPlayers As List = rds.SortedSetGetTopFrom("game:leaderboard", 0, 2)
'	For Each player As String In topPlayers
'		Log("Top Leaderboard Entry: " & player)
'	Next
'
'	' ==========================================
'	' 6. STREAMS
'	' ==========================================
'	Dim STREAM_KEY As String = "stream:orders"
'	rds.Delete(STREAM_KEY)
'
'	Log("--- 6. Testing Streams ---")
'	
'	Log(rds.ExplainStreams)
'	
'	' -------------------------------------------------------------
'	' 1. XADD: Add an event to the stream
'	' -------------------------------------------------------------
'	Log("--- 1. Adding Stream Entry (XADD) ---")
'	Dim order1 As Map = CreateMap("user_id": "101", "action": "checkout", "amount": "49.99")
'	Dim order2 As Map = CreateMap("user_id": "102", "action": "checkout", "amount": "120.50")
'    
'	
'	Dim id1 As String = rds.StreamAddTo(STREAM_KEY, order1)
'	Dim id2 As String = rds.StreamAddTo(STREAM_KEY, order2)
'    
'	Log("Created Entry 1 ID: " & id1)
'	Log("Created Entry 2 ID: " & id2)
'
'	' -------------------------------------------------------------
'	' 2. XREVRANGE: Read the latest entries from the stream
'	' -------------------------------------------------------------
'	Log("--- 2. Reading Latest Entries (XREVRANGE) ---")
'	rds.StreamReadLatestEntries(STREAM_KEY, 5)
'
'	' -------------------------------------------------------------
'	' 3. XGROUP CREATE: Create a consumer group
'	' -------------------------------------------------------------
'	
'	Dim GROUP_NAME As String = "MyConsumerGroup"
'	Log("--- 3. Creating Consumer Group (XGROUP) ---")
'	' Starts reading from index "0" (from the very beginning)
'	rds.StreamCreateConsumerGroup(STREAM_KEY, GROUP_NAME, 0)
'
'	' -------------------------------------------------------------
'	' 4. XREADGROUP: Worker reads next unprocessed message
'	' -------------------------------------------------------------
'	Log("--- 4. Worker Processing Message (XREADGROUP) ---")
'	Dim processedId As String = rds.StreamReadNextFromGroup(STREAM_KEY, GROUP_NAME, "worker_1")
'
'	' -------------------------------------------------------------
'	' 5. XACK: Worker acknowledges processing is complete
'	' -------------------------------------------------------------
'	If processedId.Length > 0 Then
'		Log("--- 5. Acknowledging Message (XACK) ---")
'		rds.StreamAcknowledgeMessage(STREAM_KEY, GROUP_NAME, processedId)
'	End If
'    
'	' Close connection gracefully on exit
'	rds.CloseRedis
'End Sub
'</code>
Public Sub Instructions
	
End Sub


' Initializes the Java Jedis client
Sub ConnectToRedis (Host As String, Port As Int, passwordtologin As String) As Boolean
	Try
		Dim jo As JavaObject
		' Instantiates new redis.clients.jedis.Jedis(host, port)
		RedisClient = jo.InitializeNewInstance("redis.clients.jedis.Jedis", Array($"redis://${Host}:${Port}"$))
		Log("⚡ Successfully connected to Redis!")
		If RedisClient.RunMethod("auth", Array(passwordtologin)).As(String) = "OK" Then
			Log(AllDataTypes)
			Return True
		Else
			Return False
		End If
		
	Catch
		Log("❌ Connection failed: " & LastException.Message)
		Return False
	End Try
End Sub

' --- Core Redis Operations ---

Sub AllDataTypes As String
	Return $"
Redis has evolved far beyond its original 5 core data types. With the standard engine, Redis Stack extensions, and modern probabilistic features, there are exactly **20 major data structures** you can leverage today.

---

## 1. Core Data Structures

These are the fundamental, general-purpose types available in every standard Redis installation.

* **1. Strings:** The most basic type, holding plain text, numbers, or raw binary data up to 512 MB.
* *Best Use Case:* Simple HTML caching, API response caching, global page counters, or API rate limiters.


* **2. Hashes:** Flat maps of field-value pairs that represent structured objects.
* *Best Use Case:* User profiles (e.g., storing `name`, `email`, `role`) or database row mirrors.


* **3. Lists:** A sequence of strings ordered strictly by insertion time.
* *Best Use Case:* Lightweight background job queues (FIFO) or application activity/chat history.


* **4. Sets:** Unordered collections of unique strings with mathematical operations like intersection and union.
* *Best Use Case:* Tracking unique user IDs, tags for articles, or checking for "mutual friends".


* **5. Sorted Sets (ZSET):** Unique strings ordered by an associated numerical score.
* *Best Use Case:* Gaming leaderboards, real-time trending hash-tags, or high-throughput sliding window rate limiters.


* **6. Streams:** Append-only transaction logs engineered for multi-consumer event processing.
* *Best Use Case:* Event-sourcing, activity audit logs, or building a distributed message-broker similar to Kafka.



---

## 2. Advanced Native Subtypes & Structural Extensions

These function at the bit or structural level directly inside Redis's core memory space.

* **7. Bitmaps:** String values treated as a giant array of bits (0s and 1s).
* *Best Use Case:* Ultra-low memory user activity tracking (e.g., marking bit index `UserID` as 1 if they logged in today).


* **8. Bitfields:** Strings configured to behave as arrays of integers with custom bit widths.
* *Best Use Case:* Storing game character stats (e.g., keeping health, mana, and armor compactly in a few bits).


* **9. Arrays:** Explicitly ordered indexable sequences with constant-time range updates.
* *Best Use Case:* Fixed-size bounded metric buffers or positioning updates over sparse numeric structures.


* **10. Geospatial Indexes (Geo):** A specialized Sorted Set wrapper using Geohashes to translate Earth coordinates.
* *Best Use Case:* Ride-sharing apps looking to locate the nearest drivers or finding restaurants within a 5km radius.



---

## 3. Redis Stack & Extended Features

Modern distributions (Redis Stack) provide rich document and query layers directly inside memory.

* **11. JSON Documents:** A native hierarchical data structure matching standard text JSON files.
* *Best Use Case:* Document storage where you need to read or mutate nested keys without rewriting the entire string.


* **12. Search Indexes (RediSearch):** Dynamic secondary indexes built over Hashes or JSON keys.
* *Best Use Case:* Text search autocomplete engines, geo-distance query aggregation, or real-time catalog filtering.


* **13. Vector Sets:** High-dimensional arrays engineered for vector math execution.
* *Best Use Case:* AI applications, semantic search engines, LLM chat memory, and Retrieval-Augmented Generation (RAG).


* **14. TimeSeries Data:** Specialized append-only numerical structures tracking data across timestamps.
* *Best Use Case:* DevOps server metrics, IoT sensor data feeds, or tracking real-time stock ticker price changes.



---

## 4. Probabilistic Data Structures

These handle multi-million element telemetry tracking with fixed, minuscule memory footprints by using smart approximations.

* **15. HyperLogLog:** Estimates unique items in a set using constant memory (max 12 KB per key) with a minor error margin.
* *Best Use Case:* Counting millions of unique daily website visitors or distinct IP addresses across lookups.


* **16. Bloom Filter:** Space-efficient data structure to instantly test if an item is *definitely not* in a set or *might be* in a set.
* *Best Use Case:* Checking if a username is available during registration before hitting the main database.


* **17. Cuckoo Filter:** Similar to a Bloom Filter, but it allows you to dynamically delete items from the filter.
* *Best Use Case:* Real-time ad-frequency capping where items expire out of your tracking list.


* **18. Count-Min Sketch:** A sub-linear space frequency table that keeps track of item hit counts.
* *Best Use Case:* Identifying heavily repeated phrases or operations to protect networks against DDoS attacks.


* **19. Top-K:** An allocation table that filters and isolates the absolute top $K$ most frequent items in a stream.
* *Best Use Case:* Extracting the top 10 most played songs or most viewed products on an e-commerce platform right now.


* **20. t-Digest:** A structure that approximates fractions and distributions across streaming data values.
* *Best Use Case:* Pinpoint calculations for 99th percentile response latencies across your system architecture.	
	"$
End Sub

' --- 0. Delete Objects ---
Sub Delete(Key As String)
	RedisClient.RunMethod("del", Array(Key))
End Sub

' --- 1. String Helpers ---
Sub StringSet (Key As String, Value As String)
	RedisClient.RunMethod("set", Array(Key, Value))
End Sub

Sub StringGet (Key As String) As String
	Return RedisClient.RunMethod("get", Array(Key))
End Sub

' --- 2. Hash Helpers ---
Sub HashSet (Key As String, Fields As Map)
	RedisClient.RunMethod("hset", Array(Key, Fields))
End Sub

Sub HashGetField (Key As String, Field As String) As String
	Return RedisClient.RunMethod("hget", Array(Key, Field))
End Sub

' --- 3. List Helpers ---
Sub ListPushTo (Key As String, Item As String)
	' rpush appends to the tail of the list
	RedisClient.RunMethod("rpush", Array(Key, Array As String(Item)))
End Sub

Sub ListPopFrom (Key As String) As String
	' lpop extracts from the head of the list
	Return RedisClient.RunMethod("lpop", Array(Key))
End Sub

Sub ListResetItem(Key As String, Index As Long, NewValue As String)
	Try
		RedisClient.RunMethod("lset", Array(Key, Index, NewValue))
		Log("✓ Successfully reset item at index " & Index)
	Catch
		Log("❌ Error: " & LastException.Message)
		' Common error: "ERR index out of range" if the list is shorter than your index
	End Try
End Sub

Sub ListGetItem(Key As String, Index As Long) As String
	Dim result As String = RedisClient.RunMethod("lindex", Array(Key, Index))
	If result = Null Then
		Return ""
	Else
		Return result
	End If
End Sub


' --- 4. Set Helpers ---
Sub SetAddTo (Key As String, Member As String)
	RedisClient.RunMethod("sadd", Array(Key, Array As String(Member)))
End Sub

Sub SetGetMembers (Key As String) As List
	Dim nativeSet As JavaObject = RedisClient.RunMethod("smembers", Array(Key))
    
	' Convert java.util.HashSet to java.util.ArrayList
	Dim arrayList As JavaObject
	arrayList.InitializeNewInstance("java.util.ArrayList", Array(nativeSet))
    
	Dim items As List
	items.Initialize
	items.AddAll(arrayList)
	Return items
End Sub

' --- 5. Sorted Set Helpers ---
Sub SortedSetAddTo (Key As String, Score As Double, Member As String)
	RedisClient.RunMethod("zadd", Array(Key, Score, Member))
End Sub

Sub SortedSetGetTopFrom (Key As String, StartIndex As Long, EndIndex As Long) As List
	' zrevrange grabs items sorted by highest score to lowest score
	Dim nativeSet As JavaObject = RedisClient.RunMethod("zrevrange", Array(Key, StartIndex, EndIndex))
	Dim elements As List
	elements.Initialize
	elements.AddAll(nativeSet)
	Return elements
End Sub


#Region Streams

Sub ExplainStreams As String
	Return $"
	A **Redis Stream** is an append-only log data structure that acts as a lightweight, lightning-fast message broker. If you've ever heard of Apache Kafka or RabbitMQ, a Redis Stream works similarly—it lets you record real-time events and process them across multiple workers without losing data.

Unlike Redis Pub/Sub (which is "fire-and-forget" and loses messages if no one is currently listening), a Redis Stream **persists messages to memory**. This means consumers can read past events, catch up if they go offline, and acknowledge messages once processed.

---

## 4 Killer Features You Can Capitalize On

### 1. Unique Auto-Generated IDs (Time-Series Ordering)

Every entry added to a Stream receives a unique ID structured like `1719830400000-0` (`millisecondsTimestamp-sequenceNumber`).

* **Why it helps:** You get automatic, microsecond-accurate time-series sorting out of the box, making it simple to query range events between two specific timestamps.

### 2. Consumer Groups (Load Balancing)

You can group multiple worker apps together into a **Consumer Group** to split up the workload.

* **Why it helps:** If 1,000 order tasks enter the stream, 3 background worker instances inside a single Consumer Group will automatically divide the work so each order is processed **exactly once**.

### 3. Acknowledgment & Recovery (`XACK` & Pending Entries)

When a consumer reads a message, Redis marks it as "pending" for that specific worker. Once the worker finishes its job, it sends an acknowledgment (`XACK`).

* **Why it helps:** If a background worker crashes halfway through processing a task, the message remains in the Pending Entries List (PEL). Another worker can reclaim that unfinished task—ensuring **zero data loss**.

### 4. Historical Catch-Up

Because data stays in the stream, a new app or service can join at any time and read old messages from 5 minutes ago or 5 days ago simply by specifying a starting ID.

---

## Real-World Use Cases

| Scenario | How Redis Streams Handles It |
| --- | --- |
| **E-Commerce Order Processing** | A customer places an order. The API adds an `order_created` event to the stream. Separate workers asynchronously handle charging the card, sending a confirmation email, and updating inventory. |
| **IoT & Sensor Telemetry** | Thousands of temperature sensors dump readings into a stream every second. Analytics services consume the stream in real-time to trigger alerts on overheating. |
| **Activity Feeds / Audit Logs** | Track every user action (`user_logged_in`, `file_uploaded`, `password_changed`) as an append-only ledger for security analysis. |

---

## Quick Reference of Core Commands

```bash
# 1. Add an event to 'orders_stream' (returns auto-generated ID)
XADD orders_stream * user_id "101" action "checkout" amount "49.99"

# 2. Read the latest 5 entries from the stream
XREVRANGE orders_stream + - COUNT 5

# 3. Create a consumer group named 'email_workers' starting from the beginning (0)
XGROUP CREATE orders_stream email_workers 0

# 4. A worker in 'email_workers' reads the next unprocessed message
XREADGROUP GROUP email_workers worker_1 COUNT 1 STREAMS orders_stream >

# 5. Worker confirms processing complete for entry ID '1719830400000-0'
XACK orders_stream email_workers 1719830400000-0

```

---

> **Summary:** Use **Pub/Sub** when you need instant, simple broadcasting and don't care if a disconnected user misses a message (e.g., live chat). Use **Streams** when you need a reliable job queue, message persistence, worker load balancing, or task guarantees (e.g., payment processing).
	"$
End Sub

Private Sub StreamGetEntryID (Id As String) As JavaObject
	Dim joID As JavaObject
	Dim streamEntryIDClass As JavaObject = joID.InitializeStatic("redis.clients.jedis.StreamEntryID")
	
	Select Id
		Case "*"
			Return streamEntryIDClass.GetField("NEW_ENTRY")
		Case "$"
			Return streamEntryIDClass.GetField("XGROUP_LAST_ENTRY")
		Case ">"
			Return streamEntryIDClass.GetField("XREADGROUP_UNDELIVERED_ENTRY")
		Case "+"
			Return streamEntryIDClass.GetField("MAXIMUM_ID")
		Case "-"
			Return streamEntryIDClass.GetField("MINIMUM_ID")
	End Select
	
	Dim idObj As JavaObject
	idObj.InitializeNewInstance("redis.clients.jedis.StreamEntryID", Array(Id))
	Return idObj
End Sub

' 1. XADD orders_stream * field value ...
Sub StreamAddTo (Key As String, Fields As Map) As String
	' Use special static entry indicator: redis.clients.jedis.StreamEntryID.NEW_ENTRY
	' This passes the "*" wildcard letting Redis auto-generate the timestamp ID
	Dim newEntryId As JavaObject = StreamGetEntryID("*")
    
	Dim assignedId As JavaObject = RedisClient.RunMethod("xadd", Array(Key, newEntryId, Fields))
	Return assignedId.RunMethod("toString", Null)
End Sub

' 2. XREVRANGE orders_stream + - COUNT count
Sub StreamReadLatestEntries (StreamKey As String, Count As Int)
	Try
		' Use explicit Redis range strings to select Jedis' xrevrange(String, String, String, int) overload.
		' Passing Null here is unsafe because xrevrange has several overloads in Jedis 7.x.
		Dim entries As List = RedisClient.RunMethod("xrevrange", Array As Object(StreamKey, "+", "-", Count))
        
		If entries.IsInitialized And entries.Size > 0 Then
			For Each entry As JavaObject In entries
				' Using RunMethodJO for chained Java calls
				Dim entryId As String = entry.RunMethodJO("getID", Null).RunMethod("toString", Null)
				Dim fieldsMap As Map = entry.RunMethod("getFields", Null)
				Log(" -> Entry ID: " & entryId & " | Data: " & fieldsMap)
			Next
		Else
			Log("No entries found in stream.")
		End If
	Catch
		Log("❌ Error reading stream: " & LastException.Message)
	End Try
End Sub

' 3. XGROUP CREATE orders_stream email_workers 0
Sub StreamCreateConsumerGroup (StreamKey As String, GroupName As String, StartFromId As String)
	Try
		' 1. Normalize shorthand input string ("0" -> "0-0")
		Dim normalizedId As String = StartFromId
		If normalizedId = "0" Then normalizedId = "0-0"
        
		Dim startIdObj As JavaObject
        
		' 2. Handle special Redis Stream symbols vs complete ID strings
		If normalizedId = "$" Then
			' "$" means only listen for brand NEW incoming entries
			startIdObj = StreamGetEntryID("$")
		Else
			' "0-0" (or any specific timestamp-seq ID like "1620000000000-0")
			startIdObj = StreamGetEntryID(normalizedId)
		End If
        
		' 3. Create group (True = create stream if key doesn't exist)
		RedisClient.RunMethod("xgroupCreate", Array(StreamKey, GroupName, startIdObj, True))
		Log("✓ Consumer Group '" & GroupName & "' created successfully.")
	Catch
		Log("⚠️ Group creation skipped: " & LastException.Message)
	End Try
End Sub
' 4. XREADGROUP GROUP email_workers worker_1 COUNT 1 STREAMS orders_stream >

Sub StreamReadNextFromGroup (StreamKey As String, GroupName As String, ConsumerName As String) As String
	Try
		' 1. Properly instantiate XReadGroupParams using Java static factory method
		Dim joParamsFactory As JavaObject
		Dim params As JavaObject = joParamsFactory.InitializeStatic("redis.clients.jedis.params.XReadGroupParams").RunMethod("xReadGroupParams", Null)
		params.RunMethod("count", Array(1))
        
		' 2. Build stream map (StreamKey -> StreamEntryID)
		Dim streamMap As Map
		streamMap.Initialize
        
		' Fetch the static constant explicitly provided by Jedis for XREADGROUP '>'.
		Dim unassignedId As JavaObject = StreamGetEntryID(">")
		streamMap.Put(StreamKey, unassignedId)
        
		' 3. Execute XREADGROUP as a map to avoid fragile Map.Entry reflection.
		Dim resultMap As JavaObject = RedisClient.RunMethod("xreadGroupAsMap", Array(GroupName, ConsumerName, params, streamMap))
        
		If resultMap.IsInitialized Then
			Dim hasStream As Boolean = resultMap.RunMethod("containsKey", Array(StreamKey))
			If hasStream Then
				Dim entries As List = resultMap.RunMethod("get", Array(StreamKey))
            
				If entries.IsInitialized And entries.Size > 0 Then
					' Extract the first StreamEntry
					Dim entry As JavaObject = entries.Get(0)
                
					' Get ID and Fields safely using RunMethodJO for chained calls
					Dim entryId As String = entry.RunMethodJO("getID", Null).RunMethod("toString", Null)
					Dim fieldsMap As Map = entry.RunMethod("getFields", Null)
                
					Log("⚙️ Consumer [" & ConsumerName & "] acquired message:")
					Log("   ID: " & entryId)
					Log("   Fields: " & fieldsMap)
					Return entryId
				End If
			End If
		End If
        
		Log("No new messages to process.")
		Return ""
	Catch
		Log("❌ Error reading from group: " & LastException.Message)
		If LastException.IsInitialized Then Log("   Cause: " & LastException.Message)
		Return ""
	End Try
End Sub

' 5. XACK orders_stream email_workers 1719830400000-0
Sub StreamAcknowledgeMessage (StreamKey As String, GroupName As String, EntryId As String) As Long
	Try
		' 1. Format ID safely ("0" -> "0-0")
		Dim normalizedId As String = EntryId
		If normalizedId = "0" Then normalizedId = "0-0"
        
		' 2. Instantiate StreamEntryID
		Dim idObj As JavaObject = StreamGetEntryID(normalizedId)
        
		' 3. Create native StreamEntryID[] array for Jedis' varargs xack signature.
		Dim idsArray As JavaObject
		idsArray.InitializeArray("redis.clients.jedis.StreamEntryID", Array(idObj))
        
		' 4. Execute XACK
		Dim ackCount As Long = RedisClient.RunMethod("xack", Array(StreamKey, GroupName, idsArray))
		Log("✓ Acknowledged " & ackCount & " message(s). Removed from Pending Entries List.")
		Return ackCount
	Catch
		Log("❌ Error acknowledging message: " & LastException.Message)
		If LastException.IsInitialized Then Log("   Cause: " & LastException.Message)
		Return 0
	End Try
End Sub

#End Region



Sub CloseRedis
	If RedisClient.IsInitialized Then
		RedisClient.RunMethod("close", Null)
		Log("🔌 Redis connection closed.")
	End If
End Sub

