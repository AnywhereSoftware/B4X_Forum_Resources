### ABMaterial - an exploration of cookies by JackKirk
### 05/05/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/160940/)

****PREAMBLE****  
  
A useful primer:  
  
<https://clearcode.cc/blog/browsers-first-third-party-cookies/>  
  
I apologise in advance for the scale of this but it is forced by the need to explore cookie behaviour under various server settings - local/remote secure/unsecure selfsigned/certificate authority signed.  
  
As part my effort to get on top of ABMaterial for a webapp I am planning I need to master cookies for remembering logins etc.  
  
This is not a code snippet or a tutorial or a library - but as it can be installed and run standalone I will claim it as a library.  
  
You may like to have a look at [**A TOUR THROUGH THE COOKIE JAVASCRIPT**](https://www.b4x.com/android/forum/threads/abmaterial-an-exploration-of-cookies.160940/post-987785) before deciding if it interests you enough to go through the (quite heavy) installation process.  
  
It is based on several elements already accessible in the forums:  
  
**1.** Alain's introductory ABM template - used as a base for this exercise:  
  
[https://www.b4x.com/android/forum/t...-absolute-beginners-update-2024-05-02.117237/](https://www.b4x.com/android/forum/threads/abmaterial-abmserver-mini-template-for-absolute-beginners-update-2024-05-02.117237/)  
  
**2.** This reference describes how to make a self-signed keystore - sufficient for testing, putting server behind a [https://localhost](https://localhost/):…  
  
[https://eclipse.dev/jetty/documenta...rating-key-pairs-and-certificates-JDK-keytool](https://eclipse.dev/jetty/documentation/jetty-9/index.html#generating-key-pairs-and-certificates-JDK-keytool)  
  
**3.** Erel's B4J library for LetsEncrypt SSL certificates - incorporated because self-signed keystores are not adequate in a production environment (browser in use will throw up ugly "not safe" warnings):  
  
<https://www.b4x.com/android/forum/threads/server-letsencrypt-ssl-certificates.159285/#content>  
  
You should note that I have adopted an **absolutely minimalistic approach** to presenting this - I have stripped out everything that does not have a direct bearing on creating/inspecting/deleting cookies in ABMaterial.