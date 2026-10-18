### FirebaseAuth - Error Fix! by ilan
### 10/15/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172272/)

hi,  
  
after making many apps and also using firebaseauth quite frequently i struggled to use it in my latest app and it was frustrating.  
  
it didnot matter what i did it just did not work and all i got was:  
  
> ResultArrived Error: com.google.android.gms.common.api.ApiException: 10:

  
i search the forum googled but could not find a solution.  
after spending many hours with chatgpt (that could not give me a solution) i downloaded again the google-services.json and checked for the packagename and for my surprise it didnot appear the same way other apps appeared.  
  
so i went to Google Cloud Console from my Firebase Console:  
  
![](https://www.b4x.com/android/forum/attachments/174186)  
  
there i went to -> Apis & Services -> Credentials  
  
and i tried to create manually a new credential and for my surprise i got a error message:  
  
[HEADING=2]Reached Limit on Number of Clients[/HEADING]  
  
so apparently when you add a new APP in firebase Console GOOGLE automatically creates a credential record inside google cloud but because i reached the limit no record was created i only noticed it when i tried to do it manually. So all i had to do is delete old credentials that are no longer in use and added manually a record with my new app package name (i could also just go back to firebase console, remove the app and add it again and google would have done it automatically)  
  
So now everything works again and i wanted to share my experience with you guys.  
  
Maybe [USER=1]@Erel[/USER] can update the FirebaseAuth setup instruction and mention that the free use has a limit of 35 Apps!  
  
Thanks and keep coding ;)  
  
  
**POINT #2:**  
  
EDIT: another thing that i want to add to this tutorial is, according to the firebaseAuth tutorial here:  
<https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users.67875/#content>  
  
the only SHA1 signature you need to add is the SHA1 from the Private Sign Key window in b4a IDE.  
when you do it you will be able to sign in and everything is fine BUT this will work only for the app you have installed directly from your pc but if you upload this build  
to the store and then uninstall your app and install it from the store you wont be able to log in using firebaseauth!  
  
the only fix that worked for me is also putting a second SHA1 signature that can be found in the google play console under your app ONLY AFTER you upload the first build (no need to publish just upload a \*.aab file to the store that will generate the app SHA1 signature that is different then the SHA1 in the IDE)  
  
UPLOAD YOUR APP -> GO TO DEV CONSOLE -> YOUR APP -> PROTECT WITH PLAY -> PLAY STORE PROTECTION -> MANAGE PLAY APP SIGNING  
  
![](https://www.b4x.com/android/forum/attachments/174202)  
  
  
Press on SHA1 Certificate fingerprint:  
  
![](https://www.b4x.com/android/forum/attachments/174203)  
  
  
Go to your firebase console and add this SHA1 fingerprint TOO! so you should see 2 fingerprint SHA1 in your app  
  
  
![](https://www.b4x.com/android/forum/attachments/174205)  
  
after you do this DOWNLOAD again the "google-service.json" file and compile your app again -> upload to the store and now you will be able to login using firebaseauth also from app installed from the store!  
  
Happy coding ;)