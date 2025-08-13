### TensorFlowLite -Update- an experimental machine/deep learning wrapper for B4A by Zkshazly
### 08/30/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/148100/)

Hello,  
This is to complete an old discussion of TensorFlowLite started in this link  
<https://www.b4x.com/android/forum/threads/tensorflowlite-an-experimental-machine-deep-learning-wrapper.96410/page-3#posts>  
which had been posted by [USER=2353]moster67[/USER]  
@[USER=2353]moster67[/USER] –> Thanks for the initiative to develop tensorflowlite library  
I have just updated the library to work with [Lobe](https://www.lobe.ai/examples#microscope) and other new versions of platforms  
attached the library & the following is the link of the tensorflow-lite-2.2.0.aar file which should be copied into the additional library folder as well  
<https://repo1.maven.org/maven2/org/tensorflow/tensorflow-lite/2.2.0/tensorflow-lite-2.2.0.aar>  
  
Edit by Erel:  
With B4A v13+ you should add these lines to the main module:  

```B4X
#ExcludedLib: guava-26.0-android.jar  
#AdditionalJar: com.google.guava:guava  
#AdditionalJar: com.google.guava:listenablefuture
```