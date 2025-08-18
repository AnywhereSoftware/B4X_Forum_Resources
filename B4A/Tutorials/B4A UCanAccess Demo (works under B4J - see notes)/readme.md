### B4A UCanAccess Demo (works under B4J - see notes) by OliverA
### 08/25/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/121546/)

This demo is a slight modification of [USER=42649]@klaus[/USER]'s B4XPages SQLiteLight2 demo (<https://www.b4x.com/android/forum/threads/b4x-b4xpages-b4xpages_sqlitelight2-cross-platform-project.119258/#content>). It demonstrates that UCanAccess can work under Android, given one uses the right version of UCanAccess and supporting libraries.  
  
Here are some notes that accompany the demonstration:  
  
'Notes:  
'1) <http://ucanaccess.sourceforge.net/site.html> states that V5.0.0 and up require Java 1.8. Older version require 1.6. Since  
' Android's implementation is based on 1.7 we're sticking with the latest 4.x.x release, which as of 2020/08/24 is 4.0.4  
'2) <http://hsqldb.org/doc/2.0/changelist_2_0.txt> states that as of 2.4.0 HSQLDB requires Java 1.8. The 4.0.4 bundle comes with  
' 2.3.1, which is not the latest 2.3.x version, but will run with it first.  
'3) The UCanAccess zip file seems to contain all necessary support files: commons-lang-2.6.jar, commmons-logging-1.1.3.jar, hsqldb.jar,  
' and jackcess-1.1.11.jar  
'4) The above jars (including ucanaccess-4.0.4.jar) are copied into the additional libraries folder. The hsqldb.jar has been renamed  
' to hsqldb-2.3.1.jar  
  
Additional notes:  
A) This demo does not deal with accessing files across the network. It just demonstrates that UCanAccess can function under Android  
B) This does not make me an expert on UCanAccess. I may not know the answers to questions in regards to proper UCanAccess usage  
C) One should read <http://ucanaccess.sourceforge.net/site.html#examples> and pay attention to the transactions section. The demo application does not use batch processing and seems to do just fine with adding/modifying/deleting records of the demo. For batch processing, see <https://www.b4x.com/android/forum/threads/jrdc-with-ucanaccess-not-committing-inserts-solved.96142/>  
D) This demo also includes a B4J demo (yeah to B4XPages! oh, and [USER=42649]@klaus[/USER]'s work). Note, I just used it to get things going. It uses the same older jar's as the B4A version and seems to work correctly. Technically, B4J could use the new 5.0.0 version of UCanAccess (see <https://www.b4x.com/android/forum/threads/opening-ms-access-databases-mdb.107963/#content>), but that aspect of UCanAccess was not the purpose of this post.  
E) I have only tested this on my S9 running Android 10. Your mileage may vary under other Android versions.  
  
Update: Fixed incorrect SQLiteLight2 attribution. Added link to project.  
Update2: Correcting a small typo in the B4A app that kept it from compiling