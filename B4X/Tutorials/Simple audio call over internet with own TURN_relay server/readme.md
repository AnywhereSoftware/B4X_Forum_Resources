###  Simple audio call over internet with own TURN/relay server by Biswajit
### 02/27/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/128108/)

Hi everyone,  
  
I posted a thread long ago about [the audio/video calling over the internet](https://www.b4x.com/android/forum/threads/audio-video-calling-over-internet-using-socket-io.118564/#post-795340). Here is a simple example of how you can call almost (will discuss below) realtime.  
  
**Why only a simple audio calling example while I said that I will post both audio and video calling examples?**  
While working on this project I realized that a good quality audio/video calling application with all required functionalities needs huge time and effort. Because like whatsapp, google duo if you want faster calling app then you have to compress the audio/video buffer before sending and decompress the audio/video buffer after receiving. This may sound like a simple byte compression job but it isn't. Compressing/decompressing audio/video buffer in realtime and playing requires lots of research about audio/video processing, audio/video codes, how conversion works, and many other things. Thus I decided to post a simple example of how it works for free and will post a full example that will be chargeable. That will have lots of functionalities, check below to know more.  
  
**This will work**,  

1. From Android to Android
2. From Android to iOS
3. From iOS to Android
4. From iOS to iOS

**Functionalities**:  

1. **Apps**:

1. List all the connected users and update in realtime
2. Call any connected users
3. Check if the user is busy or not
4. Show custom in-app incoming call screen with accept/reject button
5. Play ringtone for incoming call
6. Automatic screen dimming while talking
7. Call accepted/rejected/ended/busy/offline status
8. Call timer
9. Incoming call notification while the app is in the background (Android)
10. Noise cancellation, Acoustic echo cancellation, Automatic gain control (Android)

2. **Server**:

1. Can handle multiple connections simultaneously.
2. Deliver call requests and status
3. Broadcast connected user list
4. Check if the callee is busy or not
5. Work as a relay server for delivering audio buffers to respective clients

**Limitations**:  

1. Few milliseconds delay in delivering audio buffer (sometimes). Because,

1. The example apps are processing uncompressed audio buffer (24Kb-30Kb buffer per seconds)
2. The test server (you can find the IP inside the project) has been configured to limit bandwidth usage for testing purposes.

2. No notifications when the app is closed. I haven't included that because it's a simple example.

**How to run**:  

1. **App**:

1. Download latest socket.io client library wrapper ([B4A](https://www.b4x.com/android/forum/posts/802738/) / [B4I](https://www.b4x.com/android/forum/threads/117619/))
2. Download, extract and run.
3. For ios, you need a working developer certificate because it will not work on the simulator.

2. **Server**: The test server is always up. If you want to test with the test server then just run the app. If you want to run it on your local server, then

1. Install **Node.js**
2. Extract the server code
3. Open terminal/cmd and navigate to the folder where you have extracted the code
4. Run **npm install** (it will take few minutes)
5. Run **node app.js**
6. That's it.

**Functionalities that the full **example** will have**,  

1. Audio/Video call
2. End to end encryption
3. Switching audio output between speakers/headphone
4. Faster calling even with low internet speed (5-10kbps)
5. Incoming calling screen that will show even when the app is not running.
6. Register a name for your device. So the other users can see who is calling
7. Example of [STUN](https://en.wikipedia.org/wiki/STUN) server as default server and fallback to [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) server
8. Example of Socket.IO server along with WebSocket Server
9. \**Maybe group calling.*

**The full example will be chargeable. I haven't decided the amount yet. It will be between $50 - $100.**  
  
Though the test server has bandwidth limitations, it can handle more than 100-200 users.  
  
[Download the test apk for testing.](https://drive.google.com/file/d/1SGYNgUlpIAEhPAMGRMg1BpxGTEGEP2-k/view?usp=sharing)