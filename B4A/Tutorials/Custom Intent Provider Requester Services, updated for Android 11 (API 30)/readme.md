### Custom Intent Provider Requester Services, updated for Android 11 (API 30) by swChef
### 03/26/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/139420/)

Not long ago [Don provided example Provider Requester Activity based communication via Intents](https://www.b4x.com/android/forum/threads/send-receive-string-between-two-applications.116801/post-730545).  
  
Although that Activity version had some hints in it for Service based version, it took several additional steps to get it working ([Service Intent must be explicit](https://stackoverflow.com/questions/27842430/service-intent-must-be-explicit-intent), which may reflect more on my knowledge level) and ([API 30 requires Manifest listing of packages](https://medium.com/androiddevelopers/package-visibility-in-android-11-cc857f221cd9), without this the Requester has to be at/below API 29).  
  
So here is my two B4A test projects, ProviderService.zip and RequesterService.zip, to save others some effort. It includes some optional code and comments and logged information as a 'template' that should help intent newbies like myself when developing and testing out their own solution. The intention is to start with these two projects, develop the two necessary Services, and then move them over into the destination Apps. Don't forget to adjust and copy over the Manifests' content below "End of default text" and update Requester references to b4a.Requester and b4a.Provider packages to your own package domains, and if you rename either Service to adjust that also in the Manifest(s).  
  
Although this functions, it is my first Intent based inter-App communication. If there is any error or improvement, please respond here. The only warning is I have not yet deployed an App to Play store with this solution.