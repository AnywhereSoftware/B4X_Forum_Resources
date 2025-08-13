### Jakarta Websocket Server Library by Addo
### 01/08/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/158506/)

Hey everyone, I was interested to [**Tyrus**](https://eclipse-ee4j.github.io/tyrus/) Server to deploy a Websocket server using [**Jakarta**](https://jakarta.ee/specifications/websocket/).  
So I ends up wrapping this library hopefully you find it useful to your needs.  
  
**Library Functionality:**  

- **Initialize(EventName As String, contextpath As String, port As Int)**
- **Start**
- **Stop**

**Library Events:**  

- **Private Sub EventName\_onOpen (session As SessionInfo)**
- **Private Sub EventName\_onMessage (session As SessionInfo, message As String)**
- **Private Sub EventName\_onClose (session As SessionInfo, statusCode As int, reason As String)**
- **Private Sub EventName\_onError (session As SessionInfo, errortext As String)**
- **Private Sub EventName\_onException (methodName As String, Exception As String)**

**SessionInfo :**  

- **Session\_Id**
- **isOpen**
- **isSecure**
- **MaxIdleTimeout**
- **MaxTextMessageBufferSize**
- **Protocol**
- **ProtocolVersion**
- **sendMessage(message As String)**
- **close(statuscode as int, reason as string)**

**Closecodes\_Utils :  
Use it with SessionInfo.close method to specify the status code.  
  
Example Attached with html test client so you can test the server.**  
  
[**[SIZE=5]Download Additional Jars From here[/SIZE]**](https://drive.google.com/file/d/1AaKI7VGH_nNEG9DqqNUx9HBl2ir3f5-J/view?usp=sharing)  
  
[SIZE=4]have a good day everyone and happy new year..[/SIZE]