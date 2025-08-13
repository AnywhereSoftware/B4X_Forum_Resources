### xSocket -  The socket library is fully functional for event and semantic message streams by tummosoft
### 07/31/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/160029/)

xSocket is a library wrapped around Socket.d.  
Socket.d has a collection of many connection protocols: TCP, UDP and WS. It can be used for MSG, RPC, IM, MQ and other scenarios, and can replace Http, Websocket, gRpc and other protocols. Such as the connection between the mobile device and the server, such as some microservice scenarios, etc.  
[HEADING=2][/HEADING]  
[HEADING=2]Main Features[/HEADING]  

- Event-based, each message can be event-routed
- The so-called semantics is described by the meta-information
- Stream dependency, where related messages are strung together in a stream
- Language independent, binary transport (tcp, ws, udp) Support multi-language, multi-platform
- Disconnection reconnection, automatic connection restoration
- Multiplexing, allowing multiple request and response messages to run simultaneously on a single connection
- Two-way communication, single link two-way listening and sending
- Automatic sharding，Data over 16Mb (configurable) will be automatically split and reassembled (except udp)
- Simple interface, reactive but with callback interface

  
**\* Extends Java:** [https://drive.google.com/file/d/1AASIjlcINkuU5u607hXxR3c8Y4d7MD7u/view?usp=sharing](https://drive.google.com/file/d/1LfFh1KWbz3lGbPMLGDRZqxjPE65_SdM5/view?usp=sharing)  
  
**\* Language supported:** B4X, .NET, Javascript, PHP;  
  
**There are fully functional xSocket supported:**  
- Send (Qos0) : Yes  
- SendAndRequest (Qos1) : Yes  
- SendAndSubscribe (stream) : Yes  
- Reply or respond : Yes  
- Single connection two-way communication : Yes  
- Data sharding : Yes  
- Disconnection automatically reconnect : Yes  
- Meta information : Yes  
- Event（or path）: Yes  
- StreamId (or message correlation): Yes  
- Broker pattern cluster: Yes  
- Asynchronous: Async  
- Interface experience: Classic  
- Basic transport protocol: tcp, udp, ws  
  
**\* Server Method: (Version 2.12)**  
- xSession:  
- xMessage:  
- xStringEntity  
- xEntityDefault  
- xFileEntity  
- xInetSocketAddress  
- xMessageDefault  
- xRequestStream  
- xSendStream  
  
**\* Client Method: (Version 2.12)**  
- xClientSocket  
- xClientSession  
- xEntity  
  
**\* Server Event:**  
  
- OnConnected(session as xSession)  
- OnMessage(session as xSession, message as xMessage)  
- OnClose(session as xSession)  
- OnError(session as xSession, error as String)  
- MQOnRequest(session as xSession)  
- MQOnMessage(session as xSession, messagex as xMessage)  
- MQOnClose(session as xSession)  
- MQOnError(session as xSession, error as String)  
  
**[SIZE=6]If you want to compile the application into a .jar file, you need to use SocketD 2.5.10[/SIZE]**