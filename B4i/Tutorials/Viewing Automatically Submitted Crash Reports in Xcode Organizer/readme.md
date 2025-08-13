### Viewing Automatically Submitted Crash Reports in Xcode Organizer by Alexander Stolte
### 01/23/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/165224/)

Xcode Organizer allows developers to view automatically submitted crash reports without using a third-party service. This feature, introduced in Xcode 11, helps analyze app crashes and fix issues efficiently by providing detailed information about crashes that users have anonymously sent.  
  
I use KSCrash, but since I see errors in the dashboard and the users rarely send me the crash reports, I was looking for a way to get the log files that are displayed in the dashboard and apple actually offers exactly that.  
  
Requires a local Mac.  
1. Open Xcode  
2. Open the "Window" Menu in the top bar  
3. Click on "Organizer"  
4. Add your Apple Developer Account  
5. Choose the App you want on the Left Top Corner  
6. Click on "Crashes"  
  
Here you now have a list of all crashes, you can filter by many things to get an overview.  
  
![](https://www.b4x.com/android/forum/attachments/161047)  
  
**Open in Project**  
If you have the B4i XCode project open, you can jump directly to the place in the code where the error occurred  
  
1. Run the app in release mode (Alt + T + B + R)  
The simulator will open and the app will be installed on the simulator.  
  
2. On the Mac, go to the UploadedProjects folder and open B4iProject.xcodeproj.  
![](https://www.b4x.com/android/forum/attachments/161048)  
  
Now you can press the “Open in Project” button in the Organizer and the place in the code should open.  
  
The following tutorial describes how to run the Xcode project.   
This can be useful when you encounter hard crashes.  
<https://www.b4x.com/android/forum/threads/debugging-a-b4i-app-with-xcode.165221/>