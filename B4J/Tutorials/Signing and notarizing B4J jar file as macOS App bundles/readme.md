### Signing and notarizing B4J jar file as macOS App bundles by David Meier
### 06/14/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/119021/)

Hi  
I happen to have a mac program, which I created with B4J. When I tried to distribute the program I ran into different difficulties. One was the nagging dialogues that the download package could no been verified and thus not been downloaded. With an extra effort I could prepare a read me and explain the users how to skirt the obstacle. But I got also problems because macOS does not give the downloaded apps sufficient rights if not signed and notarized. To be honest I have not yet found out how the mechanics are precisely, but I found a way how to distribute my B4J App on the mac without obstacles and with the sufficient rights to run. Should anybody else look for such a solution, here you find the description of how I did it:  
[**<https://www.app-art.ch/notarizing-installers-for-macos-catalina.html>**](https://www.app-art.ch/notarizing-installers-for-macos-catalina.html)  
  
If anybody has a better solution, then I happily go through it ;)  
  
Regards  
David  
  
BTW: One issue I came along is the writing of files into file.DirApp. Somehow this did not work (insufficient rights? respectively no permission to write there?). I used:  

```B4X
folder = GetSystemProperty("user.home", "") & "/Documents/"
```

  
This is not elegant, but it works…