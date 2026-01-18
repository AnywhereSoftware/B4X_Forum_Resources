### [PyBridge] Text to speech with Pocket TTS by Erel
### 01/14/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/170014/)

<https://github.com/kyutai-labs/pocket-tts>  
  
"A lightweight text-to-speech (TTS) application designed to run efficiently on CPUs. Forget about the hassle of using GPUs and web APIs serving TTS models. With Kyutai's Pocket TTS, generating audio is just a pip install and a function call away."  
  
![](https://www.b4x.com/android/forum/attachments/169366)  
  
Using it is quite simple and the results are good. The dependencies and models are quite large (~1gb overall).  
  
Install the required dependencies:  

```B4X
pip install pocket-tts
```

  
  
Run the example. On the first run it will download the model. Once downloaded, it can work offline.  
  
In the example, the generated audio is immediately played. It should be simple to save it instead and then play it with MediaPlayer.