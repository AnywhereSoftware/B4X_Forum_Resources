###  Format dates in GMT time zone without changing the app's time zone by Erel
### 04/08/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/129502/)

Usage example:  

```B4X
Dim formatter As GMTFormatter  
formatter.Initialize("yyyy-MM-dd-'T'HH:mm:ss'Z'")  
Log(formatter.Format(DateTime.Now))
```