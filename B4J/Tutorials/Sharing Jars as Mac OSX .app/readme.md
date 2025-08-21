### Sharing Jars as Mac OSX .app by Markos
### 03/21/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/115201/)

Hi All  
  
I wanted to share some facts which was very fuzzy for me and perhaps it may help those who are new to the Mac publishing world.  
  
I will limit my focus on how to successfully share or sell Jar Apps produced using B4J outside of Mac Store  
  
While it is true that the Jar files work seamlessly between Windows and Mac (executable by jdk 8 and by shell command for jdk11+). This freedom is slowly slipping away with the Noterizatiin requirement.  
  
The firdt casualty is jdk which fails Noterizatiin because Apole has new security standards. But as of this writing MacOSX still lets you have a say if you want it to run or not. This will change in time to cannot run.  
  
Before I outline the steps to use B4J built Jar's as viable 'Mac Apps'. I will explain and unbox the Noterization process as I discovered. This took me 7 days reading numerous manuals and Articles with no sleep.  
  
The steps are as follows:  
  
1. Make your App  
2. Code Sign your App and all executables contained therein using your Developer ID Application Certificate. 'codesign'. Is the command line tool to accomplish the task  
3. Zip the App and its resources if separate files or resources  
OR  
Create a packaged installer with ext pkg. Afterwhich you sign with your Developer ID Installer. Then you place in a DMG mounted drive and you then codesign thst with a Developer ID Application Certificate.  
4. You send you submit the Zip or DMG for noterization using 'xcrun altool' Xcode command line tool  
5. You will receive an email with the status of your submission it was Success or Invalid  
  
Everywhere online does not address if it fails and how to trwat with it bit I will touch on that at the end.  
Assuming success you will then have one last step. To 'Staple' the Archive or mount you sent for noterization. Again it is xcrun stapler staple <filename>  
  
This step is to embed a signature in the Mac App to allow the program to run if the Mac is offline.  
The details of the command line syntax can be found easily online once you have the command tool names its quite easy.  
  
I will now state facts you must know or spend several days trying and trying with less luck as I did.  
  
Codesign must include -o runtime. This is to enfoce time signature. If not it will pass signing but fail noterisatiin  
  
Xcrun must use entitkements on complex executables. This it to prevent codsign breaking your app or its executable dependencies.  
  
The Username and password required for xcrun altool to noterize is your apple ID ie your email. Ignore all mention or ninsense about ID or apple.com thats from years past. The password is one where you request App Specific from appleid.com. the Apo name I used was altool. This little fact eluded me for 48hrs as it was not communicated clearly and Apple error msg's was less thsn clear.  
  
Now finslly how to apply this to publish Jar apps fro. B4J.  
  
Provided you sign all runtime and resources executables Ive noticed only thus fsr. Then you use a fun app called platypus which packages the output from B4J Packager 11 as a Mac .app. then you apoly the prior steps to be able to install and yse your Apps on any Mac.  
  
This works as of todsy and for the years to come as it complies with the strictest policies that are not yet fully enforced.  
  
So B4J and Packager 11 have alot if life still.  
  
I wanted to share and hopefully help some other needy soul who is new to the Mac world as I am and frustrated by the lack of knowledge veing shared with thos aspect of softwate publushing.  
  
I can Apply this with a slight change at the end certificate wise to publish on Mac Store but after I am rested and successful I will share same.  
  
P.S. I almost forgot. There are two switches to check the status or error log of your noterization submission.(xcrun altool)  
  
1. Noterize-history  
2. Noterize-informatiin  
  
The spelling may be incorrect but you can google it.  
  
The noterize-information in the case of errors will provide a url report link that will highlight all the issues that are usually attributed to codesign. The only issue you cannot fix without recompiling using a newer jdk will say sdk less thsn 10.9 Mac OSX. As jdk8 is black listed as far as Noterization is concernef  
  
  
P.S. I forgor