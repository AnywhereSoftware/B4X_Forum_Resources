### simple ssh terminal by Knoppi
### 06/19/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167476/)

Here is an example of a simple SSH terminal.  
It is based on <https://www.b4x.com/android/forum/threads/sshj-ssh-scp-sftp-for-java.88615/>  

- Small history function with cursor up/down
- Save connections

Note: Password is saved in plain text  
  
#Region AdditionalJar copy to ..\Objects\libs  
'#MergeLibraries: false  
' bcprov-jdk15on-154.jar  
' eddsa-0.2.0.jar  
' JavaObject.jar  
' jCore.jar  
' jFX.jar  
' jReflection.jar  
' Json.jar  
' jXUI.jar  
' slf4j-api-1.7.25.jar  
' slf4j-nop-1.7.25.jar  
' SSHJ.jar  
' sshj-0.23.0.jar  
#End Region  
  
![](https://www.b4x.com/android/forum/attachments/164846)