### Managing multiple certificates / provision files by Erel
### 02/07/2024
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/48539/)

This tutorial is only relevant after you were able to build and install B4i-Bridge.  
If you haven't yet started with B4i then please go over these two tutorials instead:  
[SIZE=4]**[Creating a certificate and provisioning profile](https://www.b4x.com/android/forum/threads/creating-a-certificate-and-provisioning-profile.45880/)  
[Installing B4i-Bridge and debugging first app](https://www.b4x.com/android/forum/threads/installing-b4i-bridge-and-debugging-first-app.45871/)**[/SIZE]  
  
5 different files are required in order to compile and sign an app:  
- B4i.keystore  
- B4i.p12  
- certSigningRequest.csr  
- Certificate file (ios\_\*.cer)  
- Provision file (.mobileprovision)  
  
The first three files are created by the IDE when you select Tools - Private sign key - Create new key.  
The certificate file is downloaded from Apple developer console based on the certSigningRequest.csr file.  
The provision file is also downloaded from Apple developer console and it internally references the certificate file.  
The provision file also references an App Id. Usually it will be a wildcard id (this means that it can be used with multiple package names).  
**It is important to understand that you can create multiple certificates based on the same certSigningRequest.csr file.**  
  
Sooner or later you will need to create more certificate files and / or provision files. For example you need to use a different pair of files when you are ready to upload your app to the store.  
  
Push notifications requires a non-wildcard provision profile. This means that this file can only be used with one specific app (based on the package name).  
  
B4i v1.5 adds two attributes which you can use to explicitly set the certificate file and the provision file:  

```B4X
#CertificateFile: ios_development.cer  
#ProvisionFile: Push.mobileprovision
```

  
The files must be located in the keys folder and they must be derived from the same certSigningRequest.csr file.  
You can use these attributes together with the conditional compilation feature to select different files based on the compilation type.  
  
Note that if there are multiple certificate files (or provision files) and you don't explicitly set the file then the compiler will raise an error. That is unless there is a file named default.cer or default.mobileprovision.