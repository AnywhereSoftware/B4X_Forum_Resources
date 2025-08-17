### NHCalculateHash - Calculate Hash for everything  -  It Cannot be Used In B4A by hatzisn
### 08/17/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149630/)

This library caclulates the hash for everything.  
  
The object is CalculateHash  
  
Calculate with ByteArray  
  

```B4X
    Dim clCH As CalculateHash  
    clCH.Initialize  
    Dim b() As Byte  
    b=File.ReadBytes("C:\MyFolder", "somefile.dat")  
    Dim sReturn As String = clCH.CalculateHasFromByteArray(b)
```

  
  
Or  
  

```B4X
    Dim clCH As CalculateHash  
    clCH.Initialize  
    Dim sReturn As String = clCH.CalculateTheHash(txtField.Text)
```

  
  
  
  
  
**(2023-08-17)** Added Calculate Hash with MD5, SHA-256, SHA-1 Algorithms  
  

```B4X
    Dim clCH As CalculateHash  
    clCH.Initialize  
    Log(clCH.CalculateTheHashWithAlgorithm("Let's try this to see.", clCH.MD5))  
    Log(clCH.CalculateTheHashWithAlgorithm("Let's try this to see.", clCH.SHA256))  
    Log(clCH.CalculateTheHashWithAlgorithm("Let's try this to see.", clCH.SHA1))
```

  
  
Or calculate also with byte array  
  

```B4X
    Dim clCH As CalculateHash  
    clCH.Initialize  
    Log(clCH.CalculateTheHashWithAlgorithmFromByteArray("Let's try this to see.".GetBytes("UTF8"), clCH.MD5))  
    Log(clCH.CalculateTheHashWithAlgorithmFromByteArray("Let's try this to see.".GetBytes("UTF8"), clCH.SHA256))  
    Log(clCH.CalculateTheHashWithAlgorithmFromByteArray("Let's try this to see.".GetBytes("UTF8"), clCH.SHA1))
```