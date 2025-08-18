###  Amazon SimpleDB by roumei
### 11/16/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/136077/)

Amazon SimpleDB is a web service for NoSQL data storage. I use it in my location sharing app PickiMicki ([Google Play](https://play.google.com/store/apps/details?id=com.planlauf.pickimicki) and [App Store](https://apps.apple.com/de/app/pickimicki/id1573029909#?platform=iphone)) because I don't want to set up and maintain my own server. The first 25 machine hours per month are free. Only 25 writes per second are possible for each domain but you can create up to 250 domains to speed things up.  
  
Introduction: <https://aws.amazon.com/simpledb>  
  
The attached project (B4J, B4A and B4I) shows how to access Amazon SimpleDB. The relevant code module is 'AWSSimpleDB'. You should first initialize the class with your credentials (put them in Main.Process\_Globals in order to obfuscate them):  

```B4X
Private SDB As AWSSimpleDB  
SDB.Initialize(Main.SimpleDBAccessKey, Main.SimpleDBSecretAccessKey, Main.SimpleDBEndPoint)
```

  
  
This is an example of how to perform a PutAttribute request:  

```B4X
Wait For(SDB.SendRequest(SDB.PutAttributeRequest(tbDomain.Text, tbItem.Text, tbAttributeName.Text, tbAttributeValue.Text, True))) Complete (Result As String)
```

  
  
Not all operations are implemented but it should be easy to add them based on the examples.  
  
![](https://www.b4x.com/android/forum/attachments/121771)