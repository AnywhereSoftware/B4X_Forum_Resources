### Firebase Phone Authentication in B4A using WebView + WebServer (Working Example) by scsjc
### 02/27/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/170447/)

[HEADING=2]Firebase Phone Authentication in B4A using WebView + WebServer (Step-by-Step Setup)[/HEADING]  
This example shows how to implement **Firebase Phone Authentication in B4A** using a **WebView + remote WebServer** instead of a native Firebase Phone library.  
  
I was forced to look for an alternative solution because the Firebase Phone Auth library I was previously using is currently **not compatible with the latest version of B4A**. After testing different approaches, I found this simple and stable method, which might help others facing the same issue.  
Below are the steps to make it work.  
  
  
![](https://www.b4x.com/android/forum/attachments/170298)  
  
  
  

---

  
[HEADING=2]1) Load the B4A Example Project[/HEADING]  
First, download and open the provided **B4A example project**.  
The example:  

- Opens a **WebView**
- Loads the authentication page from your server
- Waits for the result (OK / ERROR)
- Continues the login flow inside the app

⚠ **Important:**  
Inside the class **FirebaseAuthPhoneWeb** you must set the URL of your own webserver.  

```B4X
Dim url As String = "https://www.domain.com/urlphoneauth"
```

  
  

---

  
[HEADING=2]2) Upload the WebServer Files to Your Server[/HEADING]  
You must upload the required web files to your hosting/server.  
  
Create a folder on your server, for example:  
<https://www.domain.com/firebaseauth/>  
Inside that folder upload these files (from the webserver folder in the example):  

- index.php
- verify.php
- styles.php

---

  
[HEADING=2]3) Configure Firebase in index.php[/HEADING]  
Open index.php and complete the Firebase configuration block with your real project credentials:  
  
  

```B4X
// — Firebase config —  
const firebaseConfig = {  
  apiKey: "<?php echo $firebase_auth_apiKey; ?>",  
  authDomain: "<?php echo $firebase_auth_authDomain; ?>",  
  projectId: "<?php echo $firebase_auth_projectId; ?>",  
  appId: "<?php echo $firebase_auth_appId; ?>"  
};
```

  
  
Make sure these PHP variables are properly defined (for example in a config section or at the top of the file).  
You can get these values from:  
Firebase Console → Project Settings → General → Your Apps  
  

---

  
[HEADING=2]4) Update the fetch() URL to Your Domain[/HEADING]  
Inside index.php, locate this line:  
const res = await fetch('<https://www.domain.com/firebaseauth/verify.php>'  
Replace [www.domain.com](http://www.domain.com) with your real domain.  
  

---

  
[HEADING=2]5) Install Firebase PHP SDK (kreait/firebase-php)[/HEADING]  
On your server, inside the same folder where index.php and verify.php are located, run:  
composer.phar require kreait/firebase-php  
This will generate:  

- composer.json
- composer.lock
- vendor/ folder

The vendor folder is required for verify.php to work.  
  
![](https://www.b4x.com/android/forum/attachments/170297)  
  

---

  
[HEADING=2]6) Download and Add service-account.json[/HEADING]  
From Firebase Console:  
Project Settings → Service Accounts → Generate new private key  
Download the file (usually called):  
service-account.json  
It contains fields like:  

- project\_id
- private\_key\_id
- private\_key
- client\_email

Place this file in your webserver folder (or wherever your verify.php expects it).  
⚠ Do NOT upload this file to public repositories.  
  

---

  
[HEADING=2]7) Test Firebase Phone Authentication (Real SMS)[/HEADING]  
Once everything is configured:  

- Web files uploaded
- Firebase config added
- Composer installed
- vendor/ present
- service-account.json added

You can run the B4A example.  
  
Firebase will:  

- Send a real SMS
- Validate the OTP
- Return the authentication result to your app

---

  
[HEADING=2]Debug Mode in the B4A Example[/HEADING]  
In the B4A example, I added a debug parameter to avoid getting blocked due to too many verification attempts.  
The URL is built like this:  
urlphoneauth = url & "?debug=1&rid=" & rid  
When debug=1 is enabled, you can safely test the flow without triggering too many real SMS requests (depending on your server-side implementation).  
  

---

  
[HEADING=2]Using Test Phone Numbers in Firebase (No Real SMS Needed)[/HEADING]  
Firebase allows you to configure **test phone numbers** with predefined verification codes.  
In Firebase Console:  
Authentication → Sign-in method → Phone → Add test phone number  
Example used in the demo:  

- Test phone number: 666555444
- Verification code: 665544

This allows you to test the full flow without sending real SMS messages.  
  

---

  
If anyone needs improvements or wants to adapt it to a fully WebServer (embedded in the device), feel free to ask.  
Hope this helps others facing Firebase Phone Auth issues in B4A 👍