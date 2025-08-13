###  Audio Streaming UDP by Star-Dust
### 09/21/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/120786/)

Based on **[this](https://www.b4x.com/android/forum/threads/walkie-talkie-audio-streaming-over-wifi-or-bluetooth.30648/#content) @Erel** code that simulated a Walkie Talkie, I developed a system for streaming audio between Android and Desktop devices with UDP.  
You can connect with multiple devices.  
  
I found that some routers lose a lot of **UDP** packets (a high percentage) and the sound is not uniform. If you notice a discontinuous and disturbed sound, it could be the router system.  
  
You can find the version that uses the TCP protocol in [**this**](https://www.b4x.com/android/forum/threads/b4x-audio-streaming-tcp-with-server.120757/) link  
  
**Note**: The B4J version requires the AudioRecord library. The B4A requires the Audio library. The B4a version works better if you have headphones (avoid the [**return of audio**](https://en.m.wikipedia.org/wiki/Audio_feedback)) or turn off listening when you speak and vice versa …