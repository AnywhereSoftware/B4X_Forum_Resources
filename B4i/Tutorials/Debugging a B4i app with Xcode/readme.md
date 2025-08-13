### Debugging a B4i app with Xcode by Erel
### 01/23/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/165221/)

This can be useful when you encounter hard crashes. I usually use it when encountering hard crashes with new libraries. Requires a local Mac.  
Alternative method: [Tip: on device logs](https://www.b4x.com/android/forum/threads/156056/#content)   
  
1. Set the device ip to Simulator.  
2. Run the app in release mode (Alt + T + B + R)  
The simulator will open and the app will be installed on the simulator.  
  
3. On the Mac, go to the UploadedProjects folder and open B4iProject.xcodeproj.  
  
![](https://www.b4x.com/android/forum/attachments/161042)  
  
4. Click on the folder icon in the top left corner and then on then twice on B4iProject. You should see the project settings.  
  
![](https://www.b4x.com/android/forum/attachments/161043)  
  
5. Change the architecture to the "Standard…" option.  
6. At this point, a yellow triangle sign will appear. Click on it.  
  
![](https://www.b4x.com/android/forum/attachments/161044)  
7. On the left side, you will have an option to "update to recommended settings". Click on it and then on Perform Changes.  
  
8. Change the target to the open simulator:  
  
![](https://www.b4x.com/android/forum/attachments/161046)  
(It should be iPhone 16 Pro here)  
  
Now you can run the app and debug it.