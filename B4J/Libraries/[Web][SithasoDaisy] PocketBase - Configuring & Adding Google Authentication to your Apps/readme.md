### [Web][SithasoDaisy] PocketBase - Configuring & Adding Google Authentication to your Apps by Mashiane
### 03/27/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/160129/)

Hi Fam  
  
**Step 1**  
  
1. Create client id and client secret. On the Google API, select "Credentials" > Create Credentials > OAuth Client ID  
  
Follow these instructions here from the google api console.  
  
<https://support.google.com/googleapi/answer/6158849?hl=en#zippy=%2Cstep-create-a-new-client-secret>  
  
You will use the Client ID & Client Secret in the PocketBase Admin Screen > Settings > Auth Providers  
  
**Step 2**  
  
OAuth Consent Screen. Update your app settings for the consent screen. I didnt use a logo for my app. For testing purposes, I have used "*<http://127.0.0.1:8010/api/oauth2-redirect>"* for the redirect url. My app is running on port 8010.  
  
**Step 3**  
  
In your PocketBase Admin screen, select settings on  
  
![](https://www.b4x.com/android/forum/attachments/152232)  
  
The Auth Providers  
  
![](https://www.b4x.com/android/forum/attachments/152233)  
  
Select the Google gear and update the **Client ID** and **Client Secret** with the content you got from google and save.  
  
In your app call,  
  

```B4X
Dim userData As Map = banano.Await(pb.USER_AUTH_WITH_GOOGLE)
```

  
  
This will show a google web prompt to authenticate your app.  
  
Have fun!