###  Audio Streaming TCP (with server) by Star-Dust
### 08/01/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/120757/)

Based on **[this](https://www.b4x.com/android/forum/threads/walkie-talkie-audio-streaming-over-wifi-or-bluetooth.30648/#content) @Erel** code that simulated a Walkie Talkie, I developed a system for streaming audio between Android and Desktop devices with the addition of a Desktop server.  
  
I chose to create a separate server in order to make it easier to connect with multiple devices.  
  
You can find the version that uses the UDP protocol in [**this**](https://www.b4x.com/android/forum/threads/b4x-audio-streaming-udp.120786/) link  
  
**Note**: The B4J version requires the Audiolorecord library. The B4A requires the Audio library. The B4a version works better if you have headphones (avoid the [**return of audio**](https://en.m.wikipedia.org/wiki/Audio_feedback)) or turn off listening when you speak and vice versa …