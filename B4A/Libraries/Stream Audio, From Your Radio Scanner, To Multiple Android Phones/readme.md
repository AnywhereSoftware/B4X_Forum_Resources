### Stream Audio, From Your Radio Scanner, To Multiple Android Phones by B9X Electronics
### 01/29/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170154/)

This is an additional application for the library described at:  
[Add Secure And Private Voice Chat, Voice Conferencing And Texting To Your B4A App](https://www.b4x.com/android/forum/threads/add-secure-and-private-voice-chat-voice-conferencing-and-texting-to-your-b4a-app.170103/)  
  
Stream Audio:  
\* From Your Radio Scanner.  
\* From Amateur Radio Receiver.  
\* From A Shortwave Receiver.  
  
Please note that only legally acceptable frequencies are allowed.  
  
Features:  
\* Crystal Clear Audio With Low Latency.  
\* ‌Interactive With Client Phones Ability To Talk With Each Other Between Scanner Audio Broadcasts.  
  
Steps To Get Started:  
  
1) Follow the steps in the link below to setup two phones and the server.  
[Add Secure And Private Voice Chat, Voice Conferencing And Texting To Your B4A App](https://www.b4x.com/android/forum/threads/add-secure-and-private-voice-chat-voice-conferencing-and-texting-to-your-b4a-app.170103/)  
  
2) Install the attached example on a Chromebook.  
  
3) Route audio out from your scanner to soundcard on your Chromebook. The best way to do this is by using a DigiRig and cable that fits your scanner. You can also try a direct connect to a soundcard if your scanner supports this. With direct connect, you may experience some low level hum.  
  
4) Most scanners have a 3.5mm 3 prong 'Ext Spk' Jack. The DigiRig is a soundcard and COM port. It is one device with only one USB connection. The COM port is not required for this application. The DigiRig provides for clean audio when you are extracting audio from a external speaker jack. The items we used were:  
  
[DigiRig USB Soundcard/COM Port Module](https://digirig.net/product/digirig-mobile/?msclkid=881e98daa2a41e6c3778f1a03ca132d3)  
[DigiRig Audio Connection Cable](https://digirig.net/product/icom-rj45-cable/)  
  
5) Goto Settings | Device | Audio on your Chromebook. Make sure the DigiRig soundcard is selected on 'Output' and 'Input'. Later, you can adjust audio on 'Input' to a desired level.  
  
6) Click 'Connect', on the example app, to provide the audio feed to B9X Voice Server.  
  
7) The audio from your scanner is now available to stream to any connected clients. The example app uses VOX to determine when to send audio from your scanner. Just connect the two phones, that were setup in step one, to B9X Voice Server and enjoy listening.  
  
If you have any questions, please feel free to contact us at support @ b9xelectronics.com (no spaces in email address).