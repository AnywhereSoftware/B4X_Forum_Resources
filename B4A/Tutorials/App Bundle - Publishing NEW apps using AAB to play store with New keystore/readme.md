### App Bundle - Publishing NEW apps using AAB to play store with New keystore by mcqueccu
### 12/10/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/129163/)

There is an increasing concern about how to publish apps using the app bundle (aab) format. I will try as much as possible to simplify the steps for you.  
  
**[SIZE=6]IMPORTANT UPDATE IN POST #3[/SIZE]  
  
[SIZE=6]OPTION 1: Creating and Using New Keystore File[/SIZE]**  
This option can be used by those who are new and about to create a new Keystore file, or having existing keystore but want to create RSA Supported Keystore file.  
Google play store is requiring an RSA-generated Keystore file for newly created applications.  
  
Steps:  
1. Navigate to bin folder of your java directory, example C:\java\jdk-11.0.1\bin  
2. Run the following command and supply your information like password, name, city, company name, etc.  

```B4X
keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias b4a
```

  
  
![](https://www.b4x.com/android/forum/attachments/110596)  
  
***[SIZE=5]Keep your Keystore File and password safe and private[/SIZE]***  
  
So far so good.  
  
Next, To compile your application, If you don't have bundletool.jar make sure to Download [**bundletool.jar**](https://www.b4x.com/android/files/bundletool.jar) **and put it in <android sdk>\tools\bin**  
  
Next: Select **Release or Release Obsfucated i**n the IDE.  
  
Add this conditional compilation command with your password and location of the Keystore file  
  

```B4X
#if AAB  
   #SignKeyFile: C:\keyfile\my-release-key.keystore  
    #SignKeyPassword: 12345678  
    #SignKeyAlgorithm: -digestalg SHA1 -sigalg SHA256withRSA  
#end if
```

  
  
  
Next: Goto Project -> Build App Bundle (the AAB file will be created in the objects folder)  
  
**UPLOADING TO PLAY STORE**  
  
A. Goto your developer Dashboard (Google play console) and create a NEW APP. Fill in the information.  
B. Click on Production and click on Create New Release  
  
![](https://www.b4x.com/android/forum/attachments/110600)  
  
C. Select Manage App Signing Key  
  
![](https://www.b4x.com/android/forum/attachments/110601)  
  
D. Next, Choose option 3 **(Export and upload a key from Java Keystore**). Also, download the pepk.jar tool. Place it possible at the location where the new Keystore file is.  
  
Next Copy the code and Run in cmd using the pepk.jar. Enter password and alias password (The passwords should be the same, unless you changed the alias password)  
  
Note: Remove the $ simple from the beginning of the Code. Also, Change the Keystore file name to the name you use, and alias as well. You can choose to change the output.zip file name if you wish.  
  
![](https://www.b4x.com/android/forum/attachments/110602)  
  
![](https://www.b4x.com/android/forum/attachments/110603)  
  
E. After your output file is generated, upload it to the play store console (screenshot above) and click UPdate  
Next. Click CONTINUE. You will see a green mark with inscription **Releases signed by Google Play**  
  
  
You can now upload your AAB file  
  
![](https://www.b4x.com/android/forum/attachments/110605)