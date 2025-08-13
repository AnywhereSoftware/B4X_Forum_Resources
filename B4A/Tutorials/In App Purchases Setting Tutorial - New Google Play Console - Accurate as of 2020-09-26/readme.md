### In App Purchases Setting Tutorial - New Google Play Console - Accurate as of 2020-09-26 by hatzisn
### 08/27/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/122777/)

Hey everyone,  
  
This is a tutorial on how you can add In App Purchases to your Android App in the New Google Play Console.  
  
1) Add GooglePlayBilling library in your project and the following code in manifest:  
  

```B4X
'In App billing  
CreateResourceFromFile(Macro, GooglePlayBilling.GooglePlayBilling)
```

  
  
  
  
2) Create the license testers list. This list includes gmail accounts of users that will test your In App Purchases and **they will not be charged.** You may add obviously your own developer account. You can do it in the main page of the new Google Play Console. See this picture:  
  
![](https://www.b4x.com/android/forum/attachments/100508)  
  
  
  
3) Add the test users that will test your app. This list is different than the previous one because it can contain license testers gmail accounts and non license testers gmail accounts. The first category of e-mails will not be charged, the second will. Obviously you will have to include all License testing's list gmail accounts. See the following picture (first create the test users list and then add the e-mails) :  
  
a) Create the list  
![](https://www.b4x.com/android/forum/attachments/100509)  
  
b) Add test users to your list  
  
![](https://www.b4x.com/android/forum/attachments/100510)  
  
  
  
4) Create the app in Google Play Console but do not upload the APK in release mode.  
  
  
![](https://www.b4x.com/android/forum/attachments/100511)  
  
  
  
5) Set all the info of the app in the dash board but do not upload again an APK in release mode.  
  
![](https://www.b4x.com/android/forum/attachments/100512)  
  
  
6) Go to Closed Testing and select the Alpha Test Track:  
  
![](https://www.b4x.com/android/forum/attachments/100513)  
  
  
  
7) Upload a release to be tested in closed track  
  
![](https://www.b4x.com/android/forum/attachments/100514)  
  
  
8) Select countries and testers. **Absolutely crucial - in Testers tab check the checkbox of the testers list you have created.** See the following pictures (select countries - select testers)  
  
a) Select countries  
![](https://www.b4x.com/android/forum/attachments/100515)  
  
  
b) Select testers - **Check the **checkbox of the** testers' list you have created!!!**  
![](https://www.b4x.com/android/forum/attachments/100516)  
  
  
  
9) Create the In App Products or Subscriptions - the procedure is almost the same (you select an identifying code for the relative In App Purchase and you fill the relative info)  
  
![](https://www.b4x.com/android/forum/attachments/100517)  
  
  
  
  
  
You are good to go.  
  
If you encounter the "Item unavailable in your country" in the test cards problem, the fix is on the following link:  
  
<https://www.b4x.com/android/forum/threads/test-card-always-approves-item-unavailable-in-your-country.142543/#post-903252>  
  
  
You may use this class to add In App Purchases to your project on the fly which will make it as easy as A-B-C to you.  
<https://www.b4x.com/android/forum/threads/chargeable-class-add-in-app-purchases-on-the-fly-to-your-b4a-and-b4i-projects.122780/>