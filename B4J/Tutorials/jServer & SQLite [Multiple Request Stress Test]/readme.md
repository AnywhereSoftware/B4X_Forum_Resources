### jServer & SQLite [Multiple Request Stress Test] by tchart
### 03/20/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130575/)

**Should I use SQLite as my web server database?**  
  
This has come up before and last week it came up again in the "Chit Chat" forum. The question has already been answered here before and there are many arguments for and against using SQLite, especially when you have lots of users who may be reading or writing at the same time.  
  
As mentioned in the various threads using SQLite is actually fine for most use cases and alleviates many issues such as DB maintenance, extra services, extra load on your server etc.  
  
You should probably have a read of these threads if you are interested.  
  
<https://www.b4x.com/android/forum/threads/would-you-recommend-sqlite.113915/>  
<https://www.b4x.com/android/forum/threads/mysql-vs-sqlite-vs-mongodb.130400/>  
  
I use SQLite for many projects including with jServer. As these are web applications I expect multiple concurrent requests which may be reading or writing at the same time. Ive never had any issues with SQLite in any of my projects (even commercial ones).  
  
Just to be 100% sure I put together a quick test using jServer/SQLite and then stress tested it using Web Surge (<https://websurge.west-wind.com/>).  
  
I created a simple web server with two handlers; one that inserts a row & reads and another that just does a read (all using the same table). I then stress tested this with Web Surge using 100 threads over 60 seconds.  
  
As you can see below there are no failed requests over 10k+ requests. I repeated this several times and can never get any errors. The SQLite database didnt even have WAL turned on initially. With WAL enabled the requests are much quicker and I get over 700 request per second, again with no failures.  
  
I know this is a simplistic test but it does prove the point that unless you are having several thousand requests per second then SQLite will probably be just fine.  
  
**WAL Off**  
  
![](https://www.b4x.com/android/forum/attachments/113105)  
  
**WAL On**  
  
![](https://www.b4x.com/android/forum/attachments/113106)  
  
Another option is to use the H2 database - <https://www.h2database.com/html/main.html>  
  
H2 is another database that can be used as an embedded database, hybrid (embedded + auto server) or as a TCP based server. It has many advantages over SQLite.  
  
One of the more appealing things is that you can run H2 in modes that are compatible with larger RDBMS systems. For example when I use H2 I use Postgres mode (MODE=PostgreSQL) which means that if I ever get to a point where I need to scale then I can move to Postgres with almost zero effort.  
  
I performed the same test as above but with H2 as the backend (in embedded mode) and as you can see I got over 6 times the requests per second.  
  
**H2 Embedded Mode**  
  
![](https://www.b4x.com/android/forum/attachments/113156)  
**UPDATE 2022-03-02**  
  
[USER=1]@Erel[/USER] has confirmed there is a limitation with the Xerial JDBC driver that means it will only process queries in series when using a single shared connection.  
  
It may be useful to read this thread; <https://www.b4x.com/android/forum/threads/concurrent-execution-with-jserver-and-sqlite.138803/>  
  
This means that;  
  
1. Queries are queued and processed one after the other.  
2. There is no risk of queries ever clashing if you are using a single connection (because of point #1)  
3. It does however mean that queries submitted after a long running query will have to wait.  
  
The work around for this is to use different connections or a connection pool (see the thread above). Be warned though that using multiple connections is fine for read only but you should not use multiple connections for writing.  
  
**UPDATE 2022-03-21**  
  
A couple of updates.  
  
1. Truncating data and compacting the database speeds SQLite up. Doing this I can squeeze ~1000 transactions per second out of SQLite (reading and writing using the same connection). The performance does degrade with more data in the database.  
2. Using a pool manager (eg HikariCP) results in a bit more performance but only by a bit. However as pointed out ([here](https://www.b4x.com/android/forum/threads/concurrent-execution-with-jserver-and-sqlite.138803/)) if you have any potentially long running queries then a pool manager is a good option as it wouldnt block the single connection.  
  
**SQLite Compacted with shared/single Connection**  
  
![](https://www.b4x.com/android/forum/attachments/126781)  
**SQLite Compacted DB with Hikari CP**  
  
![](https://www.b4x.com/android/forum/attachments/126782)