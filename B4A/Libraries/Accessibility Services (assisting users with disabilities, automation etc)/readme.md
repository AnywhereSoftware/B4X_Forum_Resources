### Accessibility Services (assisting users with disabilities, automation etc) by moster67
### 02/22/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/95216/)

This is a partial wrap/library for Android's Accessibility Services which you can read about here:  
<https://developer.android.com/reference/android/accessibilityservice/AccessibilityService>  
  
Android's Accessibility Services is meant to assisting users with disabilities in using Android devices and apps but can also be used for automation.  
Some automation tools, such as Tasker, are using Accessibility Services. In this post, I am attaching a sample app which permits you to automate WhatsApp so messages can be sent to contacts and groups without any user-interaction.  
  
It should be noted that an app such as the attached WhatsApp-sample might not be permitted on Google Play since it could be used as a bot unless you are able to motivate that it is purely used for users with disabilities.  
  
I started to write this wrapper for a personal app I am using when riding my motorbike. I have seen many requests for a wrap of the Accessibility Services and initially, I meant to write a complete and generic wrapper but I have realized that it is a huge task and I simply don't have enough time to do so. It is much easier to write a customized wrapper which covers your requirements. If you would like a customized library and you want me to help you, you can contact me by PM.  
  
That said, the attached library contains the most important functionality and should be usable for many projects you might have in mind. Open the sample-app to better understand how it works. You also need to add some things in the Manifest and there are also some configuration-files which need to be set up properly. You can find these files in the Resource-library which is attached.  
  
Read also the docs. Unfortunately, there isn't much documentation to be found on the internet except for the official documentation provided by Google (see the link earlier in this post) although you can find some information/examples on StackOverflow.  
  
22/02/2020 - updated library to version 0.11 (bug fix)  
22/02/2020 - updated sample app to use targetSDK = 28  
  
  
Here is a YouTube video to see the WhatsApp sample app in action:  
  
[MEDIA=youtube]ohE0zbg0UcM[/MEDIA]  
  
**Please remember that creating libraries and maintaining them takes time and so does supporting them. Please consider a donation if you use my free libraries as this will surely help keeping me motivated. Thank you!**  
  
Good luck!