### GeoIP (ip to location) with maxmind by Erel
### 05/28/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171137/)

Step 1: register with maxmind: <https://www.maxmind.com/en/geolite2/signup>  
Step 2: download the free binary (mmdb) GeoLite Country database:  
![](https://www.b4x.com/android/forum/attachments/171701)  
  
Step 3: Download attached libs +  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.21.3/jackson-databind-2.21.3.jar>  
+  
<https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.21.3/jackson-core-2.21.3.jar>  
  
Put the 6 jars in the additional libraries folder.  
Code:  
Main module:  

```B4X
#AdditionalJar: geoip2-5.1.0.jar  
#AdditionalJar: jackson-annotations-2.21.jar  
#AdditionalJar: jackson-core-2.21.3.jar  
#AdditionalJar: jackson-databind-2.21.3.jar  
#AdditionalJar: jackson-datatype-jsr310-2.21.3.jar  
#AdditionalJar: maxmind-db-4.1.0.jar
```

  
  
Create a DatabaseReader object and store it with a global variable. Pass an InputStream opened from the mmdb file:  

```B4X
Private Sub CreateReader (In As InputStream) As JavaObject  
    Dim cache As JavaObject  
    cache.InitializeNewInstance("com.maxmind.db.CHMCache", Null)  
    Dim Builder As JavaObject  
    Dim Reader As JavaObject = Builder.InitializeNewInstance("com.maxmind.geoip2.DatabaseReader$Builder", Array(In)) _  
        .RunMethodJO("withCache", Array(cache)).RunMethod("build", Null)  
    Return Reader  
End Sub
```

  
  
Use reader to geolocate ip address with this code:  

```B4X
'Returns empty string if location not found.  
Private Sub FindCountry (Reader As JavaObject, IP As String) As String  
    Dim IndetAddress As JavaObject  
    IndetAddress = IndetAddress.InitializeStatic("java.net.InetAddress").RunMethod("getByName", Array(IP))  
    Dim response As JavaObject = Reader.RunMethod("tryCountry", Array(IndetAddress))  
    If response.RunMethod("isPresent", Null) = True Then  
        Dim res As Object = response.RunMethodJO("get", Null).RunMethodJO("country", Null).RunMethod("name", Null)  
        If Initialized(res) Then Return res.As(String)  
    End If  
    Return ""  
End Sub
```

  
  

```B4X
'Declared in Class_Globals with: Private DatabaseReader As JavaObject  
DatabaseReader = CreateReader(File.OpenInput("C:\Users\H\Downloads\GeoLite2-Country_20260526\GeoLite2-Country.mmdb", ""))  
Log(FindCountry(DatabaseReader, "21.4.139.35"))
```

  
  
Note that the GeoIP SDK depends on Java 17+.