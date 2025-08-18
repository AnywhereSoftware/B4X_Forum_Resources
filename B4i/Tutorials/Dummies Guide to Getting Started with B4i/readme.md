### Dummies Guide to Getting Started with B4i by Falcon
### 08/11/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/124564/)

Hi Everyone,  
  
Since I joined this forum and started with B4i many people have given their time generously to help me.  
So in the spirit of giving back to the community, I have created a 'Dummies' guide which I hope can be of assistance to other beginners.  
  
The purpose of this guide was to try and make it as simple as possible to get to grips with the Basics of setting up your Apple Developer account, the B4i IDE, compiling your App. and then showing how to distribute it to a client for testing and also finally how to publish it to the App Store.  
  
I am in no way an expert, and still pretty much a 'noob' myself, but this guide was created by my own personal experiences and trial and errors.  
You use this guide at your own risk. Some of my methods may/may not agree with the way others have done things, or be the best way of doing something,  
but the methods used here worked for me.  
  
If you are not sure of something I will try to help where I can, with the limited knowledge I have.  
  
I hope it can help someone!  
  
Regards Jacques.  
  
  
———————————–  
SUMMARY  
———————————-  
1. Setup the Bi IDE (Development Environment) for first time - see the 'SETTING UP B4I IDE FOR FIRST TIME' section below.  
  
2. Setup your Apple Developer Account - see the 'SETTING UP APPLE ACCOUNT' section below.  
  
3. Install B4i Bridge on the development device (Works through Wifi or USB cable connection)  
 See point 7 of the 'SETTING UP B4I IDE FOR FIRST TIME' section below.  
  
4. Deploying to Client for testing / or to Apple Store.  
 See 'DEPLOYING APP TO CLIENT FOR TESTING' or 'PUBLISHING APP TO THE APPLE STORE' section below.  
  
  
———————————————  
 SETTING UP B4I IDE FOR FIRST TIME  
———————————————  
1. Run the 'b4i Setup.exe' file.  
  
2. On the first run B4i will ask you to locate the license file (b4i-license.text) and afterwards it will ask you for the Email address you have used when you've purchased  
 B4i.  
  
3. Click 'Tools' –> 'Configure Paths'  
  
 javac.exe = The folder path where the javac.exe file is located on your PC.  
  
 Keys Folder = Can be any folder of your choosing to keep your Private Sign Keys in.  
 This is where the .csr (Certificate Signing Request), 'Profile' (.mobileprovision) and 'Certificate' (.cer) files should be stored on your PC.  
 The .csr file (Given to you when registering with Apple) is basically needed to setup the Certificate file/s in the Apple Account.  
 The 'Profile' and 'Certificate' files are used in conjunction with each other when compiling the App to allow the App to either run  
 on a test Device or to be Published to the Apple Store.   
   
 See the 'SETTING UP APPLE ACCOUNT' section below for more info. Read the 'Certificates' and 'Profiles' sections.  
  
 Additional Libraries = E:\B4i\Additional Libraries  
 This is the folder on your PC where you may want to store any Additional B4i libraries.  
  
  
4. Setup Mac Builder Service. This is needed to compile app without the need for a real Mac PC. It is a subscribed to service with an annual fee payable.  
 If you have a Mac PC, you can omit this step.  
 NB!!!!!: Even if you use the Mac Builder Service, you will still need a real IOS device however to develop the app on !  
  
 Do the following:  
  
 \* In the IDE, under Tools -> Build Server -> Server Settings -> User Id, enter: xxxxxxx (Where xxxxxxx = the ID you were issued with from B4i)  
 NOTE: This user id should only be used by a single developer!  
 \* Make sure 'Use Hosted Builder' option is ticked.  
 \* In 'Server Ip' enter: 192.168.0.100  
 \* In 'Server Port (https):' enter: 51042.  
  
 Click 'OK'.  
  
 NB!!!!!!! It was found that sometimes a 'Communication Error or timeout' occurs with the Mac Builder Server when trying to compile.  
 To solve this problem, just increase the value in the B4i IDE under 'Tools' –> 'IDE Options' –> 'Configure Process Timeout'. I increased this to 240 and it seems  
 to have fixed comms issues.  
  
  
5. Tools –> Private Sign Key  
 Just enter a password here of your choosing. The other fields can be left as is.  
 Click 'Create New'.  
  
  
6. Project –> Build Configurations (This is App/Project Independant)  
 NOTE: For each project you create the 'Package' name MUST always start with your Domain name, e.g:  
 com.YourDomain.xxxx <—- The xxxx part is the only part that will change from App Project to App Project and it is your App's name.  
 E.g: Package: com.MyDomainName.MyAppName  
  
  
7. To connect to a Development device from the IDE, the 'B4i Bridge' app must first be installed on the Device.  
  
 In the IDE Click 'Project' –> 'Build Configurations', in 'Package', enter the Package Name, ie. 'com.MyDomain.MyAppName', then click 'OK'.  
 NB!!!! The name entered here should match the first part of the name given in the 'SETTING UP APPLE ACCOUNT' section below for the Main Identifier.  
 So if for example you used 'com.MyDomain.\*' for the Main Identifier in the Apple Account setup, then the name entered here should be 'com.MyDomain.MyAppName'.  
  
 Now Click 'Tools' –> 'Build Server' –> 'Build B4i-Bridge App'.  
  
 Once it has finished 'Sending Data to remote compiler', then Open Safari on the iOS Device and navigate to: builder1.b4x.com:51041/xxxxx (or whatever URL is given)  
 Then click on the 'Install button'. B4i Bridge should now be installed on the Device.  
  
 Once installed on the device, make sure the App is listening for an incomming connection by starting the server on it,  
 then from the B4i IDE, goto 'Tools' –> 'Device IP Address' and either select the existing IP address of the device on the list or add a new one.  
  
 Once connected, the 'Play' (Debug mode) button can then simply be used to start the App on the device during Development.  
  
 Reference:  
 <https://www.b4x.com/android/forum/threads/installing-b4i-bridge-and-debugging-first-app.45871/>  
  
  
  
 ———————————————————————————  
 SETTING UP APPLE ACCOUNT  
 ———————————————————————————  
  
 The following refers to the various Sections in the Apple Developer Account once you have logged in with your credentials (developer.apple.com).  
 NOTE: You must first register with Apple as an iOS developer (costs $99 per year).  
  
 It is advisable to setup in the order given below, although it is not essential.  
  
  
 Devices  
 ———————–  
 All Devices, e.g. Ipads, Iphones etc which are required to be used during Development and/or testing MUST be registered here.  
 To add a Device here, it's UDID must first be obtained - see the 'GET UDID'S OF DEVICES' section below.  
  
 1. From the Overview screen, click 'Certificates, Identifiers & profiles'.  
 2. Click 'Devices'.  
 3. Click the '+' next to the 'Devices' heading.  
 4. Paste the UDID obtained in 'GET UDID'S OF DEVICES' section, into the 'Device ID (UDID)' text box and give the Device a Name in the 'Device Name' textbox, then click 'Continue'.  
 5. Now click 'All Devices' to go back to the previous screen.  
  
 NB!!!! If they are not registered here first, then a particular App will not be able to start on the device. May give a message like  
 'App could not be installed' or something similar when trying to run the app on the device by clicking it's icon.  
 Generally if the icon is not a Light Blue colour, but rather Black, it probably won't work.  
 This will occur mostly if a Device is not registered first and/or the wrong Profile type was used, see 'Profile' section below.  
  
  
 Identifiers  
 ———————–  
 Basically a Main Identifier (Common Identifier of the Software Publisher) is needed as well as an Identifier for EACH App (Only needed once you want to Publish a specific App to the Apple Store).  
 It is used amongst other things to set up a Profile/s (See 'Profiles' below).  
  
 1. Click 'Identifiers', then click the '+' next to the 'Identifiers' heading.  
 2. Select 'App IDs' and click 'Continue'.  
 3. Click 'App', then 'Continue'.  
 4. Under 'Description' enter any decription you like such as 'Main Identifier' etc.  
 5. For the 'Main' Identifier, next to the 'Bundle ID' heading, select 'Wildcard', then enter 'com.xxxxx.\*' in the text box. <— Where xxxx = Your Domain name  
 For all other Identifiers you would use 'Explicit' and enter something like 'com.mydomain.MyAppName', or just use the same name as you have in 'Package' under Build Configurations in the IDE.  
 6. Click 'Register'.  
  
 e.g.  
 Main Identifier Settings:  
 Name = My Identifier  
 Identifier = com.MyDomainName.\*  
  
 Specific App Identifier Settings:  
 Name = My App  
 Identifier = com.MyDomainName.MyAppName (Just make this the same as the 'Package' name of the App in the B4i IDE under 'Project' –> 'Build Configurations')  
  
  
 Certificates:  
 ———————–  
 At least 2 different Certificate types will need to be created (.cer files).  
 Each will be tied to a specific 'Profile' (See 'Profiles' below).  
  
 The first must be of type 'iOS Distribution' and will be used in conjunction with a 'App Store' type Profile (See 'Profiles' below) to Publish the finished App to the Apple Store,  
 this can be used for ALL apps developed from now on.  
  
 The second must be of type 'iOS Development' and will be used in conjunction with a 'Development' type Profile to give to another Person/Client for testing on their device,  
 and also for when you are still developing the App on your Development device. This too can be used for ALL apps developed from now on.  
  
 1. Click 'Certificates', then click the '+' next to the 'Certificates' heading.  
 2. For the 'iOS Distribution' type, select 'iOS Distribution (App Store and Ad Hoc)' under the 'Software' heading, then click 'Continue'.  
 For the 'iOS Development' type you would select 'iOS App Development' under the 'Software' heading.  
 3. Click 'Choose File', then select 'certSigningRequest.csr' which should be located in the folder  
 which you selected under 'Paths Configuration' –> 'Keys Folder' in the IDE.  
 4. Click 'Continue'.  
 5. Click 'Download' and save the 'ios\_distribution.cer' file to your 'Keys Folder'.  
 6. Repeat this process to create other Certificates, just changing the Type every time.  
  
 Now to use a certain Certificate/s in an App's code, just above the 'Project Attributes' region, put the following line of code:  
 #CertificateFile: MyStoreCertificate.cer (This file should be located in the 'Keys Folder' path you specified in the B4i IDE)  
  
 TIP:  
 If you want to setup different Certificate files to be used automatically, then simply create different Build Configurations under 'Project' –> 'Build Configurations'.  
 For example you could have a 'Release' and 'Development' configuration.  
  
 If you set the Configuration's 'Conditional Symbols' to 'RELEASE' for example, you could then do the following (Instead of the #CertificateFile: MyStoreCertificate.cer' code line above)  
  
 #If RELEASE  
 #CertificateFile: MyStoreCertificate.cer  
 #Else  
 #CertificateFile: MyDevelopmentCertificate.cer  
 #End If  
  
 NB!!!!!! If you do not put the above code in and have more than one Certificate type file in your 'Keys' folder, then you will get an error when trying to compile as B4i  
 will not know which Certificate you want to use!  
 If you only have one Certificate file in the 'Keys' folder and omit the above code, it will work without error as it will  
 just Default to that Certificate.  
  
  
 Profiles:  
 ———————–  
 At least 2 different Profile types will need to be created (.mobileprovision files)  
  
 The first must be of type 'App Store' and will be used in conjunction with a 'iOS Distribution' type Certificate (See 'Certificates' above) to Publish the finished App to the Apple Store,  
 this can be used for ALL apps developed from now on.  
  
 The second must be of type 'Development' and will be used in conjunction with a iOS Development' type Certificate to give to another Person/Client for testing  
 and also for when you are still developing the App on your Development device.  
 This too can be used for ALL apps developed from now on.  
  
 1. Click 'Profiles'.  
 2. Click the '+' next to the 'Profiles' heading.  
 3. Select 'App Store' for type 'App Store' under 'Distribution', then click 'Continue'. You would choose 'iOS App Development' under 'Development' for type 'Development'.  
 4. Under 'App ID', select the Main Identifier you created in the 'Identifiers' section (See 'Identifiers' above).  
 5. Select the relevant Certificate created in the 'Certificates' section above, then click 'Continue'.  
 6. Select the Device/s created in 'Devices' above, then click 'Continue'.  
 7. Type a name in the 'Provisioning Profile Name' textbox, e.g. 'Development\_Profile' or 'Store\_Profile' and click 'Generate'.  
 8. Click 'Download' and save the Provision Profile file to your 'Keys Folder'.  
 6. Repeat this process to create other Certificates, just changing the 'Software' (Type) every time.  
  
 Now to use a certain Profile/s in an App's code, just above the 'Project Attributes' region, put the following line of code:  
 #ProvisionFile: Store\_Profile.mobileprovision (This file should be located in the 'Keys Folder' path you specified in the B4i IDE)  
  
 TIP:  
 If you want to setup different Profile files to be used automatically, then simply create different Build Configurations under 'Project' –> 'Build Configurations'.  
 For example you could have a 'Release' and 'Development' configuration.  
  
 If you set the Configuration's 'Conditional Symbols' to 'RELEASE' for example, you could then do the following (Instead of the #ProvisionFile: Store\_Profile.mobileprovision code line above)  
  
 #If RELEASE  
 #ProvisionFile: Store\_Profile.mobileprovision  
 #Else  
 #ProvisionFile: Development\_Profile.mobileprovision  
 #End If  
  
 NB!!!!!! If you do not put the above code in and have more than one Profile type file in your 'Keys' folder, then you will get an error when trying to compile as B4i  
 will not know which Profile you want to use!  
 If you only have one Profile file in the 'Keys' folder and omit the above code, it will work without error as it will  
 just Default to that Profile.  
  
  
  
 —————————————————–  
 GET UDID'S OF DEVICES  
 —————————————————–  
  
 To find the UDID of a Device you can use an Online Service such as: <https://showmyudid.com/> (Must use Safari Browser or it will not work).  
 You will need a Device's UDID if you want to give an App to someone to test for example on their Device.  
  
 NB!!!! Before continuing, first make sure that 'Request Desktop Website' is disabled or this will not work!!!  
 Go to Settings —> Safari —> Settings for Websites (Section) —> Request Desktop Website (Disable)  
 See this link: <https://www.b4x.com/android/forum/threads/getting-the-udid.116808/>  
  
 Once on the site, click the button that says 'Tap To find UDID' (or something similar to that),  
 then when it says 'This website is trying to download a configuration profile. Do you want to allow this? Click 'Allow'.  
 Now go into settings (Might be Under the 'Ipad Settings Suggestions' heading), click 'View profile', then 'Install'  
  
 Once that is done, and you return to showmyudid.com, you should now see your device's UDID.  
  
  
  
—————————————————–  
COMPILING / GETTING IPA FILE  
—————————————————–  
  
There are 2 versions of a Compiled App.  
  
The first is just a 'Development' version which you will need if you want to give your App to someone to test on their Device.  
The second is the 'Release' version which you will need once you are ready to publish the App on the Apple Store.  
  
  
Getting Development Version:  
—————————————  
Make sure you use the 'Development' type Certificicate & Profile as set up in the 'SETTING UP APPLE ACCOUNT' section above.  
  
So for example you would have this in your code:  
  
#ProvisionFile: Development\_Profile.mobileprovision  
#CertificateFile: ios\_development.cer  
  
Now go to 'Tools' —> 'Build Server' —> 'Build Release App'.  
NOTE: If you are using the remote Mac Builder server to compile your App, this may take some time depending on the speed of your Internet Connection.  
If it fails, make the value under 'Tools' —> 'IDE Options' —> 'Configure Process Timeout' higher.  
  
Once that has completed, you should see in the log: 'Application compliled with non store provision profile', this tells us that it is the  
Development version which is suitable to be given to someone for testing, but it will not be able to be put on the Apple Store.  
Now click on 'Tools' —> 'Build Server' —> 'Download Last Build'  
NOTE: Again, this may take some time depending on the speed of your Internet, so just be patient!  
Once downloaded, you will see the IPA file (Install File) in the 'Objects' folder of your project's Root folder.  
This IPA file is then given to the person wanting to test the App, see 'DEPLOYING APP TO CLIENT FOR TESTING / APPLE STORE' below.  
  
  
Getting Release (Apple Store) Version:  
—————————————  
Make sure you use the 'Store/Release' type Certificate & Profile as set up in the 'SETTING UP APPLE ACCOUNT' section above.  
  
So for example you would have this in your code:  
  
#ProvisionFile: Store\_Profile.mobileprovision  
#CertificateFile: ios\_distribution\_adhoc\_and\_store.cer  
  
Now go to 'Tools' —> 'Build Server' —> 'Build Release App'.  
NOTE: If you are using the remote Mac Builder server to compile your App, this may take some time depending on the speed of your Internet Connection.  
If it fails, make the value under 'Tools' —> 'IDE Options' —> 'Configure Process Timeout' higher.  
  
Once that has completed, you should see in the log: 'Application compliled with store provision profile', this tells us that it is the  
Release version which is suitable to be published to the Apple Store.  
Now click on 'Tools' —> 'Build Server' —> 'Download Last Build'  
NOTE: Again, this may take some time depending on the speed of your Internet, so just be patient!  
Once downloaded, you will see a 'Archive.zip' file (Which contains among other things the IPA file) in the 'Objects' folder of your project's Root folder.  
This Zip file can then be used directly to upload the App to the Apple Store.  
  
  
  
————————————————————————  
DEPLOYING APP TO CLIENT FOR TESTING  
————————————————————————  
  
NB!!!!! First make sure the Client's test device UDID has been added to the Apple Account under 'Devices' Section - see 'SETTING UP APPLE ACCOUNT' above.  
Also make sure the 'Development' type Profile is used to compile the App or it will not install on the test Device - see 'COMPILING / GETTING IPA FILE' above.  
  
Then use one of the following methods:  
  
  
Method 1 (Diawi):  
————————–  
  
To send Install Link for App use free Diawi service:  
  
\* Browse to <https://www.diawi.com/>  
\* Drag and drop the IPA file in to the box provided. See 'COMPILING / GETTING IPA FILE' above to obtain the IPA file (Compiled Install File) of your App.  
  
NOTE: Although this service works 100%, you may need to be patient as it could take some time uploading depending on the speed of your internet connection.  
Sometimes you may also have to try again if it fails the first time to Upload.  
Once completed, click the 'Send' button and a link will be returned which can then be given to the client.  
  
  
  
Method 2 (OTA Deployer):  
—————————  
Using OTA deployer made by Erel from Anywhere Software.  
  
See this link for info and to download the OTA deployer:  
<https://www.b4x.com/android/forum/threads/tool-ota-deployer-easily-distribute-your-app-to-beta-testers.61672/>  
Use this tool to Upload your IPA File (compiled File) To a server, once completed uploading a link will then be returned which can be given to the Client.  
  
Double click the 'OTA.jar' file you downloaded.  
  
Use the following for the Settings when the OTA loads:  
  
Account ID = Tools –> Build Server –> Server Settings –> User Id (Use what is contained in the User Id textbox here)  
IPA File = The IPA File To upload  
Package Name = Project –> Build Configurations –> Package (Use the name here)  
App Name = In the code of the App, under 'Project Attributes' region, 'ApplicationLabel'  
  
  
  
————————————————-  
PUBLISHING APP TO THE APPLE STORE  
————————————————-  
  
To publish an App to the Apple Store, an Identifier must first be created for it in your Apple Developer account.  
NOTE: Each App that you plan on publishing must have it's own unique Identifier.  
  
Also you must have a Security Password setup in your Apple Developer Account (Once off process).  
  
  
CREATING IDENTIFIER FOR APP:  
—————————–  
  
1. First compile your App to 'Release' mode, see 'COMPILING / GETTING IPA FILE' above (Getting Release/Apple Store version section).  
2. NOTE: This step can be ommitted if you already have a password set up.  
 Goto <https://appleid.apple.com/account/manage> and Log In.  
 In the 'Security' section, click 'Change Password', type in your new password, then click 'Change Password'.  
2. Log into your Apple Developer account, then click the '+' in the Identifiers section, to add a new Identifier.  
3. Select 'App IDs' and click 'Continue'.  
4. Select 'App' then click 'Continue'.  
5. In description enter anything you like, such as 'My App Name Identifier' etc.  
 By the 'Bundle ID' heading, make sure 'Explicit' is selected.  
 In the text box there, enter the same Package Name you used for your App in the B4i IDE.  
 You can find this in the IDE by going to 'Project' –> 'Build Configurations'. In the 'Package' textbox is the name you want, such  
 as 'com.MyDomain.MyAppName' etc.  
 Now under 'Capabilities' tick whichever features you would like.  
6. Click 'Continue'.  
7. Click 'Register'.  
  
  
Now that you have created an Identifier for the App and a Password, do the following:  
  
  
8. If you are not still logged into your Apple Account, do so. Click on 'App Store Connect', then click 'Go to App Store Connect'.  
9. Click 'My Apps'.  
10. Click the '+' next to the 'Apps' heading. On the menu that pops up, click 'New App'.  
11. In the name box, enter the name of your app, e.g. 'My App Name'. Choose the primary language you prefer. In 'Bundle ID' select the Identifier  
 you created in Steps 2-7 above. It should appear in the dropdown list by the 'Bundle ID' heading. If it does not, do steps 2-7 again to create  
 an Identifier. In 'SKU' enter the Package Name you used for your App in the B4i IDE.  
 You can find this in the IDE by going to 'Project' –> 'Build Configurations'. In the 'Package' textbox is the name you want, such  
 as 'com.MyDomain.MyAppName' etc.  
12. Click 'Create'.  
  
  
The App should now appear in the 'App Store Connect' in the 'My Apps' section.  
When you go to that section and click on the App Icon, you will then be able to Edit the Apps description, screenshots, keywords, support URL, promotional text etc.  
  
NOTE: To get screenshots on an Ipad, hold in the 'Home' and 'Top' button at the same time, then release the 'Top' button.  
  
  
The next step is to upload a build (see below), before it is submitted for review.  
  
  
  
UPLOADING A BUILD TO APPLE:  
——————————  
  
1. In the B4i IDE goto 'Build Server' —> 'Upload App to Itunes Connect'  
2. When a page pops up, enter the following:  
  
 User ID: <Your Apple User ID>  
 Password: <see below note>  
 To get above password, go to '<https://appleid.apple.com/account/manage>', then under 'Security' –> 'Generate Password'  
 For 'Password Label' enter the name of your app, e.g.'My App'  
  
 Archive File: <Browse to Archive.zip> of last Release build in 'Objects' folder.  
  
 Now click 'Upload', may take a few minutes, gives these messages in order:  
 Uploading ipa file.  
 Submitting app (this step can take several minutes to complete)  
 App uploaded successfully.  
  
 Once it has completed and says 'App uploaded successfully', then goto App Store Connect, click 'My Apps' –> Click your App name –> Click 'Activity' (One of the Top Section Headings),  
 you should see a Build of your app appear under the heading 'iOS Builds', if you see it there then you know it has uploaded successfully.  
  
 Now click 'App Store' (In App Store Connect) heading, and scroll down till you see 'Build +'.  
 Click '+' next to build. Your uploaded App should appear in the list here. Select it's radio button and click 'Done'.  
 The app version should now appear under the 'Build' heading.  
  
 Click 'Save'.  
  
 Now just make sure all other relevant sections are filled in, then you will be able to Submit it for Review (Click 'Submit For Review' button at Top right).  
 If you are not sure what else needs to be filled in, then click the Submit for Review button and it will tell you what is still required.  
  
 Once your App has been submitted for review, and Apple has completed reviewing it, you should receive an email from them to let you know if everything was successful  
 or if any issues were found which need to be rectified.  
 NOTE: If you receive a message with an issue something like: 'ITMS-90078: Missing Push Notification Entitlement', this can just be safely ignored.  
  
 For more help, see this:  
 <https://help.apple.com/app-store-connect/#/dev34e9bbb5a> - Overview of Publishing an app.  
  
 NOTE: To change the App's Store Icon, see 'CHANGING APP ICON' below.  
 To Upload screenshots see 'APP SCREENSHOTS FOR APPLE STORE' below.  
  
  
CHANGING APP ICON:  
——————————–  
  
Put the following images as you wish your Icon to look, (All shown below are needed) in the 'Files/Special' folder of the project (In PNG format & Bit Depth 24).  
These are the sizes and names that the icons should be (Must be named exactly as shown):  
icon-store-1024.png = 1024x1024  
[EMAIL]icon-76@2x.png[/EMAIL] = 152x152  
icon-76.png = 76x76  
[EMAIL]icon-60@2x.png[/EMAIL] = 120x120  
icon-60.png = 60x60  
icon-40.png = 40x40  
  
  
  
APP SCREENSHOTS FOR APPLE STORE  
——————————–  
Screenshots may simply be dragged and dropped into your App's setup screen (Goto App Store Connect, click 'My Apps' –> Click your App name).  
  
For iPad they must be this size: 2048x2732  
For iPhone 5.5" they must be this size: 1242x2208  
For iPhone 6.5" they must be this size: 1242x2688