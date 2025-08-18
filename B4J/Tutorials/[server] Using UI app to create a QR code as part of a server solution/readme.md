### [server] Using UI app to create a QR code as part of a server solution by Erel
### 11/09/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/123704/)

Online example: <https://b4x.com:51041/qrgenerator/index.html>  
   
![](https://www.b4x.com/android/forum/attachments/101839)  
  
A question was posted about generation of QR codes in a server solution (<https://www.b4x.com/android/forum/threads/solved-jserver-html-js.123679/>).  
I thought that I can quickly create a nice and simple example where the server uses jShell to call a very simple UI app, that doesn't show anything and just creates the QR code using QRGenerator (<https://www.b4x.com/android/forum/threads/93092/#content>).  
I was wrong.  
It was more complicated and required several non-trivial steps. Hopefully this tutorial will help other developers who need to add features that are not available in non-ui apps to a server solution.  
  
The main problem was that the UI app failed to start on the Linux server as it failed to create the display / rendering pipeline.  
This won't happen on a server with graphical environment, such as Windows servers.  
  
The solution for running the UI app on the Linux server was to install gtk and xvfb and to run it with xvfb-run.  
This introduced another challenge. Starting a program with xvfb-run is slow. It can take 5 or more seconds until it is ready. So instead of starting the QR program each time, we will start it when needed and it will keep running. The main server will communicate with the QR server using UDP. QR server is the UI app.  
  
This means that we need to take care of starting the QR server when it is not running. Theoretically we can manually start it when the main server is started, however this will be problematic as UI apps are not expected to run for weeks or months like jServer solutions. The main server will start the QR server if it didn't receive a response.  
It might need some tweaking. We will need to wait a few days and test it.  
  
Some interesting points:  

1. The main server writes the text to a text file. The QR server writes the image to an image file. The file name is based on Main.srvr.CurrentThreadIndex. Each active connection will have a different "thread index" number.
2. The main server sends a 4 bytes UDP packet (with the thread index) to the QR server. If the QR server doesn't respond in 10 seconds, the main server will try to start it (unless it is already being started). Note the usage of MessageIndex. It is increased every request and it is increased when a packet is arrived.
3. The image is converted to a base64 string and is set with SetHtml. The other option is to save the image in the www folder and provide a link to that image. In that case you need to think of security and also cleaning.
4. Both servers run with Java 11+ (Linux OpenJDK is available here: <https://www.b4x.com/android/forum/threads/b4jpackager11-the-simplest-way-to-distribute-ui-apps.99835/#content>).
Starting a Java 11+ UI app is a bit more complicated. See the server code. The required *release\_java\_modules.txt* file is available in B4J installation folder.
  
That's it.  
  
QRGenerator - The WebSocket handler class.  
  
The QR server code (UI app):  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form 'ignore  
    Private xui As XUI  
    Private socket As UDPSocket  
    Private bc As ByteConverter  
    Private qr As QRGenerator  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    socket.Initialize2("socket", 51042, 8192, True, True)  
    qr.Initialize(400)  
End Sub  
  
Sub Socket_PacketArrived (Packet As UDPPacket)  
    Dim response As UDPPacket  
    Try  
        Dim ThreadIndex As Int = bc.IntsFromBytes(Packet.Data)(0)  
        Dim bmp As B4XBitmap = qr.Create(File.ReadString(File.DirApp, $"qr/${ThreadIndex}.txt"$))  
        Dim out As OutputStream = File.OpenOutput(File.DirApp, $"qr/${ThreadIndex}.png"$, False)  
        bmp.WriteToStream(out, 100, "PNG")  
        out.Close  
        response.Initialize(Array As Byte(1), Packet.Host, Packet.Port)  
    Catch  
        response.Initialize(Array As Byte(2), Packet.Host, Packet.Port)  
        Log(LastException)  
    End Try  
    socket.Send(response)  
End Sub
```