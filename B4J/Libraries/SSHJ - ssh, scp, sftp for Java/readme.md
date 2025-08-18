### SSHJ - ssh, scp, sftp for Java by mindful
### 07/27/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/88615/)

This is a wrapper for: <https://github.com/hierynomus/sshj>  
  
Dependencies:  
#AdditionalJar: slf4j-api-1.7.25  
#AdditionalJar: sshj-0.23.0  
#AdditionalJar: eddsa-0.2.0  
#AdditionalJar: bcprov-jdk15on-159  
  
  
  
You can download this libraries from:  
slf4j-api-1.7.25: <https://mvnrepository.com/artifact/org.slf4j/slf4j-api>  
sshj-0.23.0: <https://mvnrepository.com/artifact/com.hierynomus/sshj>  
eddsa-0.2.0: <https://mvnrepository.com/artifact/net.i2p.crypto/eddsa>  
(B4J) bcprov-jdk15on-159: <https://www.bouncycastle.org/latest_releases.html>  
(B4A) prov-1.58.0.0.jar: <https://mvnrepository.com/artifact/com.madgag.spongycastle/prov>  
  
**\*NOTE1\*** I tested this only with B4J, it should work for Android too!  
**\*NOTE2\*** Also when running in Release you should set #MergeLibraries: False because of the bouncy castle dependency (bcprov-jdk15on-159) which is a signed jar, and when running with #MergeLibraries: True that jar is decompiled and compiled in your jar and therefore losses its signing.  
**\*NOTE3\*** For Android you need to download spongy castle instead of bouncy castle. You can download it from <https://mvnrepository.com/artifact/com.madgag.spongycastle/prov>. I don't know if NOTE2 applies in this case.  
  
First steps:  

```B4X
    Dim ssh As SSHJ  
    ssh.Initialize("ssh")  
    '…… or ……  
    ssh.Initialize2("ssh", 15) ' where 15 is the KeepAliveInterval - usefull for portforward and future sftp.
```

  
As connecting through ssh to a server wants to mean that is secure you have to add the server hostkey:  

```B4X
ssh.LoadKnownHosts 'loads the known_hosts file from some default locations.  
'or  
ssh.LoadKnownHosts2("/tmp/known_hosts")  
'or  
ssh.AddHostKeyVerifier("SHA1:2Fo8c/96zv32xc8GZWbOGYOlRak=")  
'or finnaly if you really trust the server and do not want to verify it's key  
ssh.AddHostKeyPromiscuousVerifier
```

  
Next step is the authentication. You can supply multiple authentication methods:  

```B4X
ssh.AddAuthPassword("youruserpass")  
'or/and  
ssh.AddAuthPublicKey("/location/to/my/key", "null if not encrypted")  
'or/and  
ssh.AddAuthPublicKey2("key-key-key-key…", "empty string if public key is in private key string", "null if not encrypted")
```

  
Finnaly now we connect:  

```B4X
ssh.Connect("hostname/ip", 22, "yourusername")
```

  
  
All the execution methods (read details in ide) - Exec, Shell, SCPUpload, SCPDownload, LocalPortforwarder, RemotePortForwarder and all methods of SFTPClient - are async and work with Wait For feature of B4X.  
  
Like always if you encounter problems i will do my best to help, but I'm no expert!  
  
Edit by Erel: You need to add this line for it to work with the built-in packager:  

```B4X
#PackagerProperty: VMArgs = –add-opens b4j/org.bouncycastle.jcajce.provider.asymmetric.ec=java.base
```