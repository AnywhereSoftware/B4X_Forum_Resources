### Google MAPS problem in android 28 by Hamied Abou Hulaikah
### 01/24/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/113328/)

I have updated my app to target android sdk 28 and I'm using google maps 17  
On old devices my app works fine, but in android 9 google maps doesn't work, I got this error:  

```B4X
java.lang.NoClassDefFoundError: Failed resolution of: Lorg/apache/http/ProtocolVersion;
```

  
I googling for the causes, All talking about adding this line to manifest file, I added it:  

```B4X
AddApplicationText(<uses-library android:name="org.apache.http.legacy" android:required="false"/>)
```

  
  
When adding it all things work fine..