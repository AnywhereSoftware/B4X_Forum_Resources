### B4a Janus Webrtc Audio Bridge Library by Addo
### 12/25/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/143975/)

Hello everyone. if you are familiar with Janus Webrtc server then this library might be useful for you.  
if you want to read more about meetecho janus gateway you can find it on this [github](https://github.com/meetecho/janus-gateway).  
  
This is not a wrapper or any kind of ready to compile Project.  
This Project is made with curiosity From A To Z. starting from android studio codebase to the last piece of the code logic.  
that's why this library is not for free. since there is many efforts and time has been given to make this library possible to b4a.  
  
[SIZE=5]**Functionality :**[/SIZE]  
**B4a Okhttp Websocket**  

- **AddoWebsocket [Okhttp Websocket Client to communicate with Janus]**
- **Initialize**
- **Connect**
- **isConnected**
- **Close**
- **sendMessage**

**B4a Websocket Events**  

- **\_onClosed(Code As Int, reason As String)**
- **\_onFailure(response As String, err As String)**
- **\_onMessage(text As String)**
- **\_onOpen**

**B4a PeerConnection Client**  

- **addoPeerConnection [a webrtc peer connection Client ]**
- **Initialize(sessionId As Long, Userid As Long, Stunserver As String, Usertoken As String, DisableBuiltinAEC As Boolean, DisableBuiltinAGC As Boolean, DisableBuiltinNS As Boolean, "eventName")**
- **isIntialized**
- **StartJanusPeerConnection**
- **Close**
- **CreatePeerConnectionClient**
- **CreateOffer**
- **CreateBroadCastReceiver**
- **AdjustAudioOutput**
- **DefaultAudioOutPut**
- **AdjustSpeakervolume**
- **MuteMic**
- **MuteSound**
- **startAudio**
- **stopAudio**
- **RequestAudioFocus**

  
**Events**  

- **\_PeerFactoryCreated**
- **\_PeerConnectionCreated**
- **\_offercreated**
- **\_sendmessage**
- **\_PublishAudioEnabled**
- **\_BroadcastReciver**
- **\_AudioManager**

  
**B4j (Back-End)**  

- **janusAdminws [websocket Client to safely Authenticate and manage users from the server side creating rooms, deleting rooms, kicking users and so on…]**
- **janusAdminApi [HttpClient shows how to safely interact with janus admin panel from the server side to moderate tokens and sessions.]**

  
**Current Version is 1.50 if you are interested contact me via DM.**