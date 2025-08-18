### Arduino Radar by Mark Read
### 04/15/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/139900/)

Here is a radar display for use with an Arduino, servo motor and a HC-SR04. Its not yet perfect as the window resize is not working properly, except maximise window. Libraries required are at the top of the code. Sorry about the GIF, I am still trying to get to grips with ShareX.  
  
The Arduino code is also included. I have not yet converted it to B4R.  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 1000  
    #MainFormHeight: 800  
#End Region  
  
  
' This simulates a radar screen using data from an Arduino and HC-SR04 ultrasound sensor  
'mounted on a servo motor. The servo has an angle from approx. 15 to 165 degrees. The sensor can  
'detect objects up to 40 cm away. The Arduino is connected to an USB port on the PC.  
'  
' The Arduino generates the angle and distance as a string in the form "angle, distance." ("85, 10.")  
'  
' Two canvases have been used: One for the background and one for the data. The window can  
' be re-sized as required.  
'  
'Libraries: jCore, jFX, jRandonAccessFile, jSerial, jXUI  
  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
         
    Dim RPane As B4XView  
    Private RadarBackground, RadarData As B4XCanvas  
    Private rOriginx, rOriginy As Double                                'new origin for the radar  
    Private Screeny As Double                                            'Canvas origin  
    Private Offset As Double=50                                            'Move radar origin up  
    Private Rect As B4XRect  
    Private MyFont As Font=fx.CreateFont("Arial",20,False,False)  
     
    Private iAngle, iLength, iDistance As Int  
     
    Private BaudRate As Int=9600  
    Private myserial As Serial  
    Private astream As AsyncStreams  
    Private rcvStr As String  
    Private InfoText As String=""  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    RPane = MainForm.RootPane  
    RPane.Height=MainForm.Height  
    RPane.Width=MainForm.Width  
    myserial.Initialize("")  
    myserial.Close  
    DrawRadarBackground  
    ConnectToSerial  
     
End Sub  
  
Sub ConnectToSerial  
    myserial.Open("COM5")                        ' Change accordingly!  
    myserial.SetParams(BaudRate,8,1,0)  
    astream.Initialize(myserial.GetInputStream,myserial.GetOutputStream,"astream")  
End Sub  
  
' Called when serial port gets new data  
Sub astream_NewData (Buffer() As Byte)  
    rcvStr = BytesToString(Buffer, 0, Buffer.Length, "UTF8")  
    'Log("Received: " & rcvStr)  
    iAngle=rcvStr.SubString2(0,rcvStr.IndexOf(","))  
    iDistance=rcvStr.SubString(rcvStr.IndexOf(",")+1)  
     
    'Log("Angle: " & iAngle & "  Distance: " & iDistance)  
    ReactToData  
End Sub  
  
  
Sub ReactToData  
    'Reset after a full sweep  
    If iAngle=165 Or iAngle=15 Then  
        Rect.Initialize(0,0,RPane.Width, RPane.Height)  
        RadarData.ClearRect(Rect)  
        InfoText="No Object found:"  
        RadarData.DrawText(InfoText,10,20,MyFont,xui.Color_Green,"LEFT")  
    End If  
     
    If iDistance<40 Then  
        iLength=iDistance*rOriginx/40  
        'Draw first part of line greeen and rest red to show object  
        RadarData.DrawLine(rOriginx,rOriginy,rOriginx-iLength*CosD(iAngle),rOriginy-iLength*SinD(iAngle),xui.Color_Green,2)  
        RadarData.DrawLine(rOriginx-iLength*CosD(iAngle),rOriginy-iLength*SinD(iAngle),rOriginx-rOriginx*CosD(iAngle),rOriginy-rOriginx*SinD(iAngle),xui.Color_Red,2)  
         
        Rect.Initialize(0,0,RPane.Width, 50)  
        RadarData.ClearRect(Rect)  
        InfoText="Object found at : " & iDistance & " cm"  
        RadarData.DrawText(InfoText,10,20,MyFont,xui.Color_Green,"LEFT")  
    Else  
        RadarData.DrawLine(rOriginx,rOriginy,rOriginx-rOriginx*CosD(iAngle),rOriginy-rOriginx*SinD(iAngle),xui.Color_Green,2)  
         
    End If  
     
     
    'This can be used to test  
     
'    Rect.Initialize(0,0,RPane.Width, RPane.Height)  
'    RadarData.ClearRect(Rect)  
'    For i=0 To 180 Step 2  
'        RadarData.DrawLine(rOriginx,rOriginy,rOriginx-rOriginx*CosD(i),rOriginy-rOriginx*SinD(i),xui.Color_Green,2)  
'        Sleep(100)  
'    Next  
'    RadarData.ClearRect(Rect)  
'    
'    For i=180 To 0 Step -2  
'        RadarData.DrawLine(rOriginx,rOriginy,rOriginx-rOriginx*CosD(i),rOriginy-rOriginx*SinD(i),xui.Color_Green,2)  
'        Sleep(100)  
'    Next  
'    ReactToData  
     
End Sub  
  
Sub DrawRadarBackground    
    RadarBackground.Initialize(RPane)  
    'Define new origin for drawing  
    rOriginx=RPane.Width/2  
    rOriginy=RPane.Height-Offset  
    Screeny=RPane.Height  
    RPane.Color=xui.Color_Black    
     
    'Draw arcs representing 10, 20 30 and 40 cm distance  
    For I=1 To 4  
        RadarBackground.DrawCircle(rOriginx,rOriginy,(rOriginx*i/4),xui.Color_Green,False,2)  
        RadarBackground.DrawText(I*10,(rOriginx*(4-i)/4)+10,Screeny,MyFont,xui.Color_Green,"LEFT")  
    Next  
     
    'Draw the angle lines  
    RadarBackground.DrawLine(-rOriginx,rOriginy,rOriginx*2,rOriginy,xui.Color_Green,2)  
    For i=30 To 150 Step 30  
        RadarBackground.DrawLine(rOriginx,rOriginy,rOriginx-rOriginx*CosD(i),rOriginy-(rOriginx)*SinD(i),xui.Color_Green,2)  
    Next  
     
    'Add data canvas  
    RadarData.Initialize(RPane)  
    InfoText="No Object found:"  
    RadarData.DrawText(InfoText,10,20,MyFont,xui.Color_Green,"LEFT")  
End Sub  
  
Sub MainForm_Resize (Width As Double, Height As Double)  
    RPane.Height=MainForm.Height  
    RPane.Width=MainForm.Width  
    'remove old background and redraw  
    Rect.Initialize(0,0,RPane.Width, RPane.Height)  
    RadarBackground.ClearRect(Rect)  
    RadarData.ClearRect(Rect)  
    DrawRadarBackground    
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/127934)