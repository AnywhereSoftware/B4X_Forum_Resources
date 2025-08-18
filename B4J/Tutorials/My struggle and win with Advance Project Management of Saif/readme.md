### My struggle and win with Advance Project Management of Saif by AnandGupta
### 05/24/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131025/)

Hi Members,  
  
Warning: This a first post I have written so long that it may cure insomnia of members. I tagged this post as tutorial as it has guidance for solving errors as I found.  
  
First I will like to thank Saif to giving me this amazing product for free.  
<https://www.b4x.com/android/forum/threads/advance-project-management-jira-alternative-source-code.130674/>  
  
Now some background.  
 I have little knowledge of MS SQL environment setting.  
 Our company has full setup of it and I connect and use the given database.  
 I never needed and never tried to know more than required to write the codes.  
 I have never done any project in B4J for database connection etc. (I have lots of samples in my hdd, though)  
  
Due to lock-down our company office is closed and I am doing office work from my home on my laptop.  
After I got the codes from Saif, I was wondering how to run it. The screen-shots and praise from fellow members made me think that I must try this product instead of just keeping in the hdd.  
  
I compiled the B4J project and it gave error about sql-java version problem. Hmm..I have Java 8.  
I downloaded jdbc driver for java 8 from  

```B4X
https://mvnrepository.com/artifact/com.microsoft.sqlserver/mssql-jdbc/7.4.1.jre8
```

  
  
The B4J project ran Ok and opened Saif's given ip address database. I was happy but wanted my database.  
  
Ok, so I have MySql, installed for my son's school project and I have have learnt tables and select from his project.  
Saif also gave us the mysql script. But it gave error using 'source <file>' command. Since I had no idea how to fix it I asked him for help.  
Thanks to Saif, as he guided me and gave me some link to start from as I was struggling at the base itself.  
  
After few hours of working on it, I realized that I have to hold MySql and try MSSql instead as given codes are based on it and members are happily using it.  
  
Looking for MSSql, I found Sql2008 server installed in my laptop itself. Happy that it might have been installed along with .Net C++ I was trying few years back.  
But it turned out to be corrupt for the least and did not allow to login using Sql connection.  
  
Without giving up, I installed Sql2008 R2 server over it and created new user and I could create database, tables etc.. All Ok.  
  
But the connection to my database still eluded me. Below are the errors I faced and the solutions I applied. This may be trivial for masters here but may help beginners like me.  
  

```B4X
prob: Error connecting to database with jtds  
    java.sql.SQLException: Unknown server host name  
  
    Solu: https://titanwolf.org/Network/Articles/Article?AID=9519989b-181f-48b1-a0be-15076f19c0d7#gsc.tab=0  
            String url = "jdbc: jtds: sqlserver://localhost: 1433; instanceName = SQLEXPRESS; databaseName = news";  
  
prob: Connection refused: connect  
  
    Solu: https://titanwolf.org/Network/Articles/Article?AID=9519989b-181f-48b1-a0be-15076f19c0d7#gsc.tab=0  
        1. Open SQL Server Configuration Manager-> Protocols for SQLEXPRESS-> TCP/IP  
        2. Right-click to start TCP/IP  
        3. Double-click to enter the property and set the TCP port in IP all in IP address to 1433  
        4. Restart the SQL Server 2005 service  
  
prob: The TCP/IP connection to the host localhost, port 1433 has failed  
  
    solu: https://stackoverflow.com/questions/33590030/the-tcp-ip-connection-to-the-host-localhost-port-1433-has-failed-error-need-as  
        Have you enabled 'Named Pipes' and 'TCP/IP'?  
        Open the 'Sql Server Configuration' application.  
        In the left pane, go to 'SQL Server Network Configuration' -> 'Protocols for [instance-name]'  
        Right-click on both 'Named Pipes' and 'TCP/IP' and select 'enable'.  
  
        Have you used the correct port?  
        Double-click on 'TCP/IP'  
        Select 'IP Addresses' tab  
        Scroll to IPAII. Your port number is here.
```

  
  
Ahh..the result is so sweet if you have worked hard for it.  
  
The .bak file given in the project, requires Sql Server 12 and I have Sql Server 2008.  
Since this is different matter due to different Sql version one has, I have created a new post for its errors and solution.  
<https://www.b4x.com/android/forum/threads/using-sql-server-2008-with-advance-project-management-of-saif.131026/>  
  
Below are some of the screen-shots of the running project. Thank you Saif.  
  
![](https://www.b4x.com/android/forum/attachments/113910) ![](https://www.b4x.com/android/forum/attachments/113911) ![](https://www.b4x.com/android/forum/attachments/113912) ![](https://www.b4x.com/android/forum/attachments/113913) ![](https://www.b4x.com/android/forum/attachments/113914)  
  
Regards,  
  
Anand