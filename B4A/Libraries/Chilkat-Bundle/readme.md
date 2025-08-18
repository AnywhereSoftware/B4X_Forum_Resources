### Chilkat-Bundle by DonManfred
### 12/31/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/125870/)

This is a - partially - wrap for the Components of <https://www.chilkatsoft.com/>  
  
Note that the B4A and B4J wrappers are free but you need a Chilkat License to Unlock the Chilkat Library.  
The prices starting at $US 289  
  
> **Buy a Chilkat License  
> More information about licensing:** [Licensing Explained](http://www.chilkatsoft.com/licensingExplained.asp)  
>   
> **Licensing Information:**  
>
> - The Bundle provides licenses to all existing Chilkat classes.
> - A 1-Developer license is for a **single named developer**, 4-Developers allows for up to 4 named developers.
> - A Site-Wide license is for any number of developers at a single company location.
> - A license is valid across all supported operating systems, programming languages, architectures, frameworks, etc.
> - The license covers new versions while maintenance/support has not expired.

  
  
The interesting part is "A license is valid across all supported operating systems, programming languages, architectures, frameworks, etc." which means that you only need ONE License to use the Chilkat Library in every programming language you want.  
  
I do use them in the 1st line in Delphi for example. But i also wanted to use them in B4J and B4A so i started doing wrappers for it :)  
  
> Chilkat is a cross-language, cross-platform API providing 90+ classes for many Internet protocols, formats, and algorithms.   
> Some classes need a license: SSH, SFTP, FTP2, HTTP, REST, Socket/TLS, IMAP, …  
> Some are free: JSON, XML, Cert, PrivateKey, …

  
The Objects wrapped so far are:  

- CkAuthGoogle
- CkBinData
- CkCert
- CkDateTime ' Testedpartially (it is used n the Dropboxtest)
- CkDtObj ' Testedpartially (it is used n the Dropboxtest)
- CkEmail
- CkFileAccess
- CkFtp2
- CkFtp2Progress
- CkGlobal ' Tested. It is needed to Unlock the Chilkat Library
- CkHttp ' Tested partially (it is used n the Dropboxtest)
- CkImap ' Tested partially (it is used in the IMAP Test)
- CkJavaKeyStore
- CkJsonObject' Tested partially (it is used n the Dropboxtest)
- CkJwt
- CkOAuth2
- CkPem
- CkPfx
- CkPrivateKey
- CkPrng
- CkPublicKey
- CkRest' Tested partially (it is used in the Dropboxtest)
- CkRsa
- CkScp
- CkSFtp
- CkSFtpDir
- CkSFtpFile
- CkSFtpProgress
- CkSocket
- CkSsh ' Tested partially (it is used in the SSHtest)
- CkSshKey
- CkSshTunnel
- CkStream' Tested partially (it is used n the Dropboxtest)
- CkString
- CkStringArray
- CkStringBuilder
- CkTask
- CkUrl
- CkWebSocket
- CkZipCrc

But, honestly, only a few of them are tested as of now :D  
I spent a lot of time doing the wraps though  
  
Some notes:  
- As the Library behind (-so Files) is written to support multiple languages the Methods are somehow "Crypted" looking at them from a B4X perspective.  
I did try to change the Methods and Properties available to be "B4X conform" :)  
  
For example:  

```B4X
  public int get_AnsiCodePage() {  
    return chilkatJNI.CkGlobal_get_AnsiCodePage(swigCPtr, this);  
  }  
  
  public void put_AnsiCodePage(int newVal) {  
    chilkatJNI.CkGlobal_put_AnsiCodePage(swigCPtr, this, newVal);  
  }
```

  
The 1st is a getter, the second a setter for the Values inside the native code.  
  
Inside the wrapper such code is translated into  

```B4X
  public int getAnsiCodePage() {  
    return this.getObject().get_AnsiCodePage();  
  }  
  
  public void setAnsiCodePage(int newVal) {  
      this.getObject().put_AnsiCodePage(newVal);  
  }
```

  
meaning that in B4A and B4J you would use  

```B4X
' Set  
global1.AnsiCodepage = 1  
' Get  
dim cp as Int = global1.AnsiCodepage
```

  
- Usually the Methods wants to return something "into a special Object". But all methods also has a similar Method/Property which returns a String instead of using CkString-Object.  

```B4X
  public void getThreadPoolLogPath2(CkString str) {  
      this.getObject().get_ThreadPoolLogPath(str);  
  }  
  
  public String getThreadPoolLogPath() {  
    return this.getObject().threadPoolLogPath();  
  }
```

  
getThreadPoolLogPath2(CkString str) will return the result into the CkString Object named str.  
and getThreadPoolLogPath() will return the String directly.  
  
Library and Example can be downloaded from this Dropbox Link:  
<https://www.dropbox.com/sh/wqnt9mbnrn586t4/AAAa758rgd7hWGdqKkBy296ta?dl=0>  
  
The B4J Version is [HERE](https://www.b4x.com/android/forum/threads/chilkat-bundle.125869/).