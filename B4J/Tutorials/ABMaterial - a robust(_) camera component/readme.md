### ABMaterial - a robust(?) camera component by JackKirk
### 05/05/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/160415/)

**PREAMBLE**  
  
I apologise in advance for the scale of this but it is forced by browsers only allowing access to cameras (i.e. mediaDevices API) when in a secure context (i.e. https://…)  
  
I find I need to develop a webapp form of some major B4A/i apps I have developed.  
  
But I have no HTML/CSS/javascript skills - and no real desire to develop any more than essential.  
  
So I have decided to have a go at ABMaterial - about which I also have no skills - but I do have solid B4J experience.  
  
One of the fundamental requirements of my planned webapp is the need to be able to take a selfie - but there is no serious camera component in ABMaterial.  
  
I find the best way to learn is by doing so I have set to and come up with the following.  
  
It is based on several elements already accessible in the forums:  
  
**1.** Alain's introductory ABM template - used as a base for this exercise:  
  
 [https://www.b4x.com/android/forum/t...-absolute-beginners-update-2024-05-02.117237/](https://www.b4x.com/android/forum/threads/abmaterial-abmserver-mini-template-for-absolute-beginners-update-2024-05-02.117237/)  
  
**2.** Mashiane's MashCameraPlain module:  
  
 <https://www.b4x.com/android/forum/threads/abmaterial-mashcameraplain.86132/post-545527>  
  
which appears to have been last updated about 7 years ago - spent a lot of time inserting this in 1. - but it simply did not work - but have been able to use it as a means of providing a rough framework of what needed to be done.  
  
Also (I suspect) it predates browsers only allowing access to cameras (i.e. mediaDevices API) when in a secure context (i.e. https://…).  
  
**3.** This reference describes how to make a self-signed keystore - sufficient for testing, putting server behind a <https://localhost>:…  
   
 <https://eclipse.dev/jetty/documentation/jetty-9/index.html#generating-key-pairs-and-certificates-JDK-keytool>  
  
**4.** Erel's B4J library for LetsEncrypt SSL certificates - incorporated because self-signed keystores are not adequate in a production environment (browser in use will throw up ugly "not safe" warnings):  
  
 <https://www.b4x.com/android/forum/threads/server-letsencrypt-ssl-certificates.159285/#content>  
  
You should note that I have adopted an **absolutely minimalistic approach** to presenting this - I have stripped out everything that does not have a direct bearing on putting a camera in ABMaterial.  
  
[**INSTALLATION**](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984985)  
[**RUN WITH SELF-SIGNED SSL ON LOCALHOST**](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984986)  
[**RUN WITH CERTIFICATE AUTHORITY (LetsEncrypt) SIGNED SSL ON REMOTE PC**](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984987)  
**[CORRECTIONS AND UPDATES LOG](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984988)**  
[****POSSIBLE ENHANCEMENTS****](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984989)  
[******KNOWN BUGS******](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984990)  
[********BROWSER TESTING TO DATE********](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984991)  
[**ADDITIONAL NOTES**](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984992)  
[**USE OF Windows Copilot**](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984993)  
**[A TRICK I HAVE FOUND THAT MAY HAVE GENERAL USE IN ABMaterial](https://www.b4x.com/android/forum/threads/abmaterial-a-robust-camera-component.160415/post-984994)**