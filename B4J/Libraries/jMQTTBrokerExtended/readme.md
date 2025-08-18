### jMQTTBrokerExtended by Informatix
### 03/02/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/119977/)

This library is an extended version of jMQTTBroker2. It includes additional features (events, authentication, permissions, log backup, internal publishing) and fixes stability issues.  
  
You can implement different levels of authentication:  
- None: all accesses are anonymous.  
- Generic: all clients must authenticate with a generic username and password.  
- Per client: all clients must authenticate with their own username and password.  
- Mixed: the access can be done with username and password, but also anonymously (guest mode).  
  
You can set topic permissions for each user:  
- Read: the client can subscribe to the topic.  
- Write: the client can publish to the topic.  
  
You can also define your own rules to allow or prohibit what a client can do.  
  
There are 9 events:  
- Authenticator(ClientID As String, Username As String, Password() As Byte) As Boolean  
- Authorizator(ClientID As String, Username As String, Topic As String, Permission As String) As Boolean  
- Connect(ClientID As String, Username As String, ProtocolName As String, ProtocolVersion As Byte, QOS As String, KeepAlive As Int, IsCleanSession As Boolean, IsDupFlag As Boolean, IsRetainFlag As Boolean, IsWillFlag As Boolean)  
- Disconnect(ClientID As String, Username As String)  
- ConnectionLost(ClientID As String, Username As String)  
- LastWill(ClientID As String, Username As String, QOS As Byte, TopicName As String, Message() As Byte, IsRetainFlag As Boolean)  
- Publish(ClientID As String, Username As String, QOS As String, TopicName As String, Message() As Byte, IsDupFlag As Boolean, IsRetainFlag As Boolean)  
- Subscribe(ClientID As String, Username As String, RequestedQOS As String, TopicFilter As String)  
- Unsubscribe(ClientID As String, Username As String, TopicFilter As String)  
  
There are 5 severity levels for the log:  
- Trace  
- Debug  
- Info (default)  
- Warn  
- Error  
  
Five demonstration projects (B4J, B4A) are provided:  
- "Authorization" demonstrates how to authorize or prohibit access or actions.  
- "Chat" is a simple application for exchanging short messages between several users.  
- "Multiplayers" provides all the code needed to add multiplayer functionality in a turn-based game.  
- "Station" is a typical example of the use of MQTT, with several sensors sending their data back to a controller that can remotely activate or deactivate them.  
- "Stress" subjects the broker to intensive testing with numerous clients and messages. This example compares the stability and processing speed of jMQTTBroker2 with those of jMQTTBrokerExtended.  
  
The current version (2.1) is based upon [Moquette](https://github.com/andsel/moquette) v0.14.3 by Fraunhofer IOSB.  
  
**You need an [additional file (moquette-0.14.jar)](https://drive.google.com/file/d/1MNxoRa8bYGHBtR10i138kZjX3hAbQ_6s/view?usp=sharing) for this library.**