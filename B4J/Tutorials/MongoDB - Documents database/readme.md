### MongoDB - Documents database by Erel
### 01/10/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/72160/)

![](https://www.b4x.com/basic4android/images/chrome_J5GiDDvNFt.png)  
  
MongoDB is one of the most popular NoSQL databases.  
It is a nice and refreshing alternative to traditional relational databases (SQL databases).  
  
Each represented entity is stored as a single document instead of being split into multiple tables.  
Whether it will be better / simpler to use MongoDB compared to MySQL or a similar database server depends on the specific data.  
  
Overall it is simple to start working with MongoDB and it is definitely a good tool to add to the toolbox.  
  
At this point it is recommended to go over MongoDB manual: <https://docs.mongodb.com/manual/introduction/>  
  
To start with MongoDB you need to:  
  
1. Download and install: <https://www.mongodb.com/download-center?jmp=docs>  
2. Create the default data folder (can be changed): c:\data\db  
3. Run mongod from the command line.  
  
In most cases you will use a three tier configuration where the clients access a B4J server and the B4J server communicates with the local MongoDB server.  
  
I will post more examples next week. An example based on Alexa sites ranking data is available here:  
[www.b4x.com/b4j/files/MongoDBAlexaExample.zip](https://www.b4x.com/b4j/files/MongoDBAlexaExample.zip)  
The data is loaded from a CSV file and then analyzed with different kinds of queries.  
  
The library is attached.  
It depends on an additional jar: <https://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/3.12.11/mongo-java-driver-3.12.11.jar>  
Copy the library and the jars to the additional libraries folder.