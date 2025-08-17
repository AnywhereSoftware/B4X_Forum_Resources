### jRDC2 client example (using modded jRDC2) by OliverA
### 07/29/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/85581/)

Attached you find an example of accessing a jRDC2 server. This is a conversion of the DBUtils example program (here: <https://www.b4x.com/android/forum/threads/dbutils-example.34611/#content>). Please use the modded jRDC2 server (here: <https://www.b4x.com/android/forum/threads/modded-jrdc2-w-sqlite-support-and-more.85578/>). I used this client to do some "smoke" testing and remove some uncaught exceptions errors that I triggered in the original jRDC2 code (here: <https://www.b4x.com/android/forum/threads/class-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/>). Please note that I create a "helper" code module jRDC2Utils that encapsulates some of the jRDC2 communication. This may not be the way to go, but it seems to work. I do seem to have some issues with events and order of events (one is documented in the source, the end of the AppStart method). For now it shows a small glimpse of jRDC2.  
  
2024/07/27:  
 Moved notes from Main to here (code module AppNotes)  
 Fixed another bug in cmbStudentID\_ValueChanged  
  
2018/05/29 Update: Fixed a race condition in cmbStudentID\_ValueChanged. Tried three options (see code) and picked third one. Thanks once more to [USER=110208]@Diceman[/USER] for pointing it out and making me look at it more closely. (<https://www.b4x.com/android/forum/threads/jrdc2-client-example-using-modded-jrdc2.85581/#post-588834>)  
  
2018/05/16 Update: Updated client application to use newer bjl layout file instead of older fxml format. Thanks to [USER=110208]@Diceman[/USER] for pointing out the issue. (<https://www.b4x.com/android/forum/threads/jrdc2-client-example-using-modded-jrdc2.85581/#post-591798>)