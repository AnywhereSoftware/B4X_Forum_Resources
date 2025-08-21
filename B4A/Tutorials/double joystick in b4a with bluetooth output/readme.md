### double joystick in b4a with bluetooth output by Xakko Gris
### 12/02/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/111852/)

Hi. here is my code. it's a double joystick to can control things trough bluetooth. I made some things in Arduino:  
  
[MEDIA=youtube]m3x6-bFyonA[/MEDIA]  
  
[https://github.com/xakko/camioncito](https://www.youtube.com/redirect?v=m3x6-bFyonA&event=video_description&q=https%3A%2F%2Fgithub.com%2Fxakko%2Fcamioncito&redir_token=THWm-xsebgnN4qemec2pW2_ptnd8MTU3NTMxNzM1MEAxNTc1MjMwOTUw)  
  
With BT with Arduino, it was fine. Now was the turn of B4A to be able to control through my smartphone. The basic idea is send always the same string, so i can change the control with not change the program of the receiver.  
  
thanks to:  
<https://www.b4x.com/android/forum/threads/android-multitouch-tutorial.10419/>  
<https://www.b4x.com/android/forum/threads/android-serial-tutorial.6908/>  
<https://www.b4x.com/android/forum/threads/joystick.11137/>  
  
<https://www.b4x.com/android/forum/threads/class-gamepad-multitouch-gamepad.19483/>  
  
Still i've got one problem. I cant 'reset' to the center one stick when I leave it but still the otherone is moving  
  
Sorry… other thing, i thing i wil see it these days: take out ONE string with the movment of both sticks together  
  
'Still studying, learning, teaching and sharing'  
Xakko  
  
  
  

```B4X
#Region Module Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
    #ApplicationLabel: DosJoys  
    #VersionCode: 1  
    #VersionName:  
    #SupportedOrientations: Landscape  
    #CanInstallToExternalStorage: False  
#End Region  
  
'Activity module  
Sub Process_Globals  
    Type PointType(x As Int,y As Int)  
    Dim Center1 As PointType  
    Dim Center2 As PointType  
   
    'velocidad del movimiento. mas grande, mas lento  
    Dim Pixel As Int: Pixel = 1  
   
    'variables de los vectores de cada joystick  
    Dim Magnitude1 As Double  
    Dim Angle1 As Double  
    Dim Magnitude2 As Double  
    Dim Angle2 As Double  
   
    'tipo de joystick  
    Dim circular As Boolean  
   
    'tamaño del joystick  
    Dim Ancho As Double: Ancho = 768  
    Dim Medio As Double: Medio = Ancho / 2  
    Dim Triple As Double: Triple = Ancho * 3  
    Dim Mitad As Double  
   
    'timer para salida de valores  
    Dim timer1 As Timer  
    Dim timer2 As Timer  
   
    'bluetooth  
    Dim Serial1 As Serial  
    Dim connected As Boolean  
    Dim TextWriter1 As TextWriter  
  
End Sub  
  
Sub Globals  
  
    Dim bgd As Panel  
    Dim G As Gestures  
    Dim TouchMap As Map  
    Type Point(Id As Int, prevX As Int, prevY As Int, Color As Int)  
  
    'sticks de los joysticks  
    Dim sprite1 As ImageView  
    Dim sprite2 As ImageView  
   
    'botones en pantalla  
    Dim BotonI, BotonD As Button  
    Dim ConBT, DesBT As Button  
    Dim sw As CheckBox  
  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
  
    'tipo de joystick  
    circular = False  
  
    'inicializacion variables  
    Magnitude1 = 0  
    Angle1 = 0  
    Magnitude2 = 0  
    Angle2 = 0  
  
    'Pantalla  
    'Crea un panel para los joysticjs  
    bgd.Initialize("")  
    Activity.AddView(bgd, 127, 256, Triple, Ancho)  
    If (circular = True) Then  
        bgd.SetBackgroundImage( LoadBitmap(File.DirAssets,"cursor1x2.png"))  
    Else  
        bgd.SetBackgroundImage( LoadBitmap(File.DirAssets,"cursor2x2.png"))  
    End If  
  
    'Agrega un listener para este panel  
    G.SetOnTouchListener(bgd, "Gestures_Touch")  
    TouchMap.Initialize  
   
    ' Crea Botón Izquierdo (BotonI)  
    BotonI.Initialize("BotonI")  
    BotonI.TextColor = Colors.Red  
    BotonI.Text = "I"  
    Activity.AddView(BotonI, 230dip, 30dip, 10%x, 20%y)  
  
    ' Crea Botón Derecho (BotonD)  
    BotonD.Initialize("BotonD")  
    BotonD.TextColor = Colors.Red  
    BotonD.Text = "D"  
    Activity.AddView(BotonD, 315dip, 30dip, 10%x, 20%y)  
   
    ' Crea Switch (sw) - Joystick Redondo o Cuadrado  
    sw.Initialize("sw")  
    sw.TextColor = Colors.Red  
    sw.Text = "[]"  
    Activity.AddView(sw, 280dip, 80dip, 10%x, 20%y)  
   
    ' Crea Botón Conectar BT (ConBT)  
    ConBT.Initialize("ConBT")  
    ConBT.TextColor = Colors.Red  
    ConBT.Text = "+BT"  
    Activity.AddView(ConBT, 230dip, 130dip, 10%x, 20%y)  
  
    ' Crea Botón DesConectar BT (ConBT)  
    DesBT.Initialize("DesBT")  
    DesBT.TextColor = Colors.Red  
    DesBT.Text = "-BT"  
    Activity.AddView(DesBT, 315dip, 130dip, 10%x, 20%y)  
   
    'Centro de Coordenadas de cada stick de cada joystick  
    'la distancia en el medio de los dos joystick tiene a proposito el tamaño de un joystick  
    'izquierdo  
    Center1.Initialize  
    Center1.x = (bgd.Width / 3) * 0.5  
    Center1.y = bgd.Height / 2  
  
    'derecho  
    Center2.Initialize  
    Center2.x = (bgd.Width / 3) * 2.5  
    Center2.y = bgd.Height/2  
   
    'Sprite de los sticks en los Joystick  
    sprite1.initialize("sprite1")  
    Activity.AddView(sprite1,0,0,128,128)  
    sprite1.Bitmap= LoadBitmap(File.DirAssets,"Dot2.png")  
    sprite1.Gravity=Gravity.FIll  
  
    sprite2.initialize("sprite2")  
    Activity.AddView(sprite2,0,0,128,128)  
    sprite2.Bitmap= LoadBitmap(File.DirAssets,"Dot2.png")  
    sprite2.Gravity=Gravity.FIll  
   
    'Setup Timer  
    'Cambiando el Intervalo, cabia la velocidad de los Sprites  
    timer1.Initialize("Timer1",10)  
    timer2.Initialize("Timer2",10)  
   
    'posiciono al sprite de la palanca en el medio del joystick  
    'lugar del joystick + mitad del ancho del joystick - mitad del ancho del mismo sprite  
    sprite1.left = (bgd.Left) + ((bgd.Width / 3) / 2)  - (sprite1.width / 2)  
    sprite1.Top = (bgd.Top) + (bgd.Height / 2) - (sprite1.height / 2)  
  
    sprite2.left = (bgd.Left) + ((bgd.Width / 3) * 2.5)  - (sprite2.width / 2)  
    sprite2.Top = (bgd.Top) + (bgd.Height / 2) - (sprite2.height / 2)  
   
    Mitad = bgd.Left + (bgd.Width / 2)  
   
    'Bluetooth  
    If FirstTime Then  
        Serial1.Initialize("Serial1")  
    End If  
  
End Sub  
  
  
  
Sub Activity_Resume  
    If Serial1.IsEnabled = False Then  
        Msgbox("Activa el Bluetooth.", "")  
    Else  
        'Serial1.Listen 'escuchando comunicaciones de entrada  
    End If  
End Sub  
  
  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
  
  
Sub Gestures_Touch(View As Object, PointerID As Int, Action As Int, X As Float, Y As Float) As Boolean  
    Dim p As Point  
    Dim px, py As Int  
    Dim cp As Int  
   
    Select Action  
        'movimiento en el panel  
        Case g.ACTION_DOWN, g.ACTION_POINTER_DOWN  
            p.Id = PointerID  
            TouchMap.Put(PointerID, p)  
      
        'sin movimientos  
        Case g.ACTION_POINTER_UP  
            p0_Touch(2,0,0)  
            p1_Touch(2,0,0)  
            'TouchMap.Remove(PointerID)  
  
        Case g.ACTION_UP  
            p0_Touch(2,0,0)  
            p1_Touch(2,0,0)  
  
            'fin de este gesture  
            TouchMap.Clear  
    End Select  
  
    cp = TouchMap.Size - 1' un touch  
    If cp > 0 Then  
        cp = 1 'no mas de dos touches  
    End If  
   
    For i = 0 To cp  
        'lugar donde se mueven los stickes  
        p = TouchMap.GetValueAt(i)  
        px = g.GetX(p.id)  
        py = g.GetY(p.id)  
  
        If px < Mitad Then 'joystick izquierdo  
            p0_Touch(1,px,py)  
            'HERE THE RESET RIGHT STICK:  
            'If (cp = 0) Then p1_Touch(2,0,0)  
        Else    'joystick derecho  
            p1_Touch(1,px,py)  
            'HERE THE RESET LEFT STICK:  
            'If (cp = 0) Then p0_Touch(2,0,0)  
        End If  
    Next  
   
  
    bgd.Invalidate  
    Return True  
End Sub  
  
  
  
  
'joystick izquierdo  
Sub p0_Touch (Accion As Int, X As Float, Y As Float)  
    Dim dh, dw As Double  
    'ubicacion relativa del lugar pulsado con respecto al centro del joystick  
    dw = Center1.X - X  
    dh = Center1.Y - Y  
  
    'control de bordes de joystick cuadrado  
    If (circular = False) Then  
        If (dw > Medio) Then dw = Medio  
        If (dh > Medio) Then dh = Medio  
        If (dw < -Medio) Then dw = -Medio  
        If (dh < -Medio) Then dh = -Medio  
    End If  
  
    'control minimo  
    If (dw = 0) And (dh = 0) Then  
        Magnitude1 = 0  
        Angle1 = 0  
    Else  
        'radio. distancia al centro del joystick  
        Magnitude1 = Sqrt((dw*dw) + (dh*dh))  
        'angulo al centro del joystick  
        Angle1  = ATan(dh/dw)  
        If (dw > 0) Then Angle1 = Angle1 + 3.14159  
      
        'control de bordes de joystick redondo  
        If (circular = True) Then  
            If (Magnitude1 > Medio) Then Magnitude1 = Medio  
        End If  
      
    End If  
   
    Select Case Accion  
        'si se esta pulsando, habilito el timer  
        Case 1 'Activity.ACTION_DOWN  
            timer1.enabled = True  
            'si no se esta pulsando, desactivo el timer y 'vuelvo' al centro al joystick  
        Case 2 'Activity.ACTION_UP  
            timer1.enabled = False  
              
            'vuelvo al sprite del stick al medio del joystick  
            sprite1.Left = (bgd.Left) + ((bgd.Width / 3) / 2)  - (sprite1.width / 2)  
            sprite1.Top = (bgd.Top) + (bgd.Height / 2) - (sprite1.height / 2)  
              
            Delay(100)  
            Salida (0,0,5)  
          
        Case Else  
    End Select  
   
End Sub  
  
Sub p1_Touch (Accion As Int, X As Float, Y As Float)  
    Dim dh, dw As Double  
    'ubicacion relativa del lugar pulsado con respecto al centro del joystick  
    dw = Center2.X - X  
    dh = Center2.Y - Y  
  
    'control de bordes de joystick cuadrado  
    If (circular = False) Then  
        If (dw > Medio) Then dw = Medio  
        If (dh > Medio) Then dh = Medio  
        If (dw < -Medio) Then dw = -Medio  
        If (dh < -Medio) Then dh = -Medio  
    End If  
   
    'control minimo  
    If (dw = 0) And (dh = 0) Then  
        Magnitude2 = 0  
        Angle2 = 0  
    Else  
        'radio. distancia al centro del joystick  
        Magnitude2 = Sqrt((dw*dw) + (dh*dh))  
        'angulo al centro del joystick  
        Angle2  = ATan(dh/dw)  
        If (dw > 0) Then Angle2 = Angle2 + 3.14159  
      
        'control de bordes de joystick redondo  
        If (circular = True) Then  
            If (Magnitude2 > Medio) Then Magnitude2 = Medio  
        End If  
  
    End If  
   
    Select Case Accion  
        'si se esta pulsando, habilito el timer  
        Case 1 'ACTION_DOWN  
            timer2.enabled = True  
            'si no se esta pulsando, desactivo el timer y 'vuelvo' al centro al joystick  
        Case 2 'ACTION_UP  
            timer2.Enabled = False  
              
            'vuelvo al sprite del stick al medio del joystick  
            sprite2.Left = (bgd.Left) + ((bgd.Width / 3) * 2.5) - (sprite2.width / 2)  
            sprite2.Top = (bgd.Top) + (bgd.Height / 2) - (sprite2.height / 2)  
              
            Delay(100)  
            Salida (0,0,5)  
        Case Else  
    End Select  
   
End Sub  
  
  
'boton 1  
Sub BotonI_Click  
    Salida (0,0,3)  
End Sub  
  
'boton 2  
Sub BotonD_Click  
    Salida (0,0,4)  
End Sub  
  
  
'movimiento en el joysick 1  
Sub Timer1_Tick  
    Dim vx1 As Int  
    Dim vy1 As Int  
  
    'ubicacion del stick en el joystick izquierdo  
    vx1 = (Magnitude1/Pixel) * Cos(Angle1)  
    vy1 = (Magnitude1/Pixel) * Sin(Angle1)  
  
    'posiciono al sprite del joystick izquierdo  
    sprite1.left = (bgd.Left) + ((bgd.Width / 3) / 2) + vx1 - (sprite1.width / 2)  
    sprite1.Top = (bgd.Top) + (bgd.Height / 2) + vy1 - (sprite1.height / 2)  
   
    'saco los valores al bluetooth  
    Salida (vx1,vy1,1)  
  
End Sub  
  
  
'movimiento en el joysick 2  
Sub Timer2_Tick  
    Dim vx2 As Int  
    Dim vy2 As Int  
   
    'ubicacion del stick en el joystick derecho  
    vx2 = (Magnitude2/Pixel) * Cos(Angle2)  
    vy2 = (Magnitude2/Pixel) * Sin(Angle2)  
  
    'posiciono al sprite del joystick derecho  
    sprite2.left = (bgd.Left) + ((bgd.Width / 3) * 2.5) + vx2 - (sprite2.width / 2)  
    sprite2.Top = (bgd.Top) + (bgd.Height / 2) + vy2 - (sprite2.height / 2)  
   
    'saco los valores al bluetooth  
    Salida (vx2,vy2,2)  
  
End Sub  
  
  
'tipo de joysticks: redondos o cuadrados  
Sub sw_CheckedChange(Checked As Boolean)  
    If Checked Then  
        circular = True  
        sw.Text = "()"  
    Else  
        circular = False  
        sw.Text = "[]"  
    End If  
   
    If (circular = True) Then  
        bgd.SetBackgroundImage( LoadBitmap(File.DirAssets,"cursor1x2.png"))  
    Else  
        bgd.SetBackgroundImage( LoadBitmap(File.DirAssets,"cursor2x2.png"))  
    End If  
   
End Sub  
  
  
'Retardo  
Sub Delay(milis As Long)  
    Dim ini As Long  
    Dim fin As Long  
    fin = DateTime.Now + milis  
    ini = DateTime.Now  
    Do While ini < fin  
        ini = DateTime.Now  
        If fin < ini Then  
            Return  
        End If  
    Loop  
End Sub  
  
  
'BLUETOOTH  
  
Sub ConBT_Click  
    Dim PairedDevices As Map  
    PairedDevices = Serial1.GetPairedDevices  
    Dim l As List  
    l.Initialize  
    For i = 0 To PairedDevices.Size - 1  
        l.Add(PairedDevices.GetKeyAt(i))  
    Next  
    Dim res As Int  
    res = InputList(l, "Seleccione un dispositivo", -1)  
    If res <> DialogResponse.CANCEL Then  
        Serial1.Connect(PairedDevices.Get(l.Get(res)))  
    End If  
End Sub  
  
Sub Serial1_Connected (Success As Boolean)  
    If Success Then  
        ToastMessageShow("Conectado", False)  
        'TextReader1.Initialize(Serial1.InputStream)  
        TextWriter1.Initialize(Serial1.OutputStream)  
        'Timer3.Enabled = True  
        connected = True  
    Else  
        connected = False  
        'Timer3.Enabled = False  
        Msgbox(LastException.Message, "Error de conexion.")  
    End If  
End Sub  
  
Sub DesBT_Click  
    Serial1.Disconnect  
    connected = False  
End Sub  
  
  
'Salida por el bluetooth del string  
Sub Salida (cx As Int, cy As Int, joy As Byte)  
    'forma del string de salida  
    '"+IV1512IH1512PDV1512DH1512DB-"  
   
    Dim vx As Int  
    Dim vy As Int  
    Dim sal As String  
   
    vx = 1000 + 1024 * (cx + Medio) / Ancho  
    vy = 2024 - 1024 * (cy + Medio) / Ancho  
   
    'control de limites  
    If (vx > 2023) Then vx = 2023  
    If (vy > 2023) Then vy = 2023  
    If (vx < 1000) Then vx = 1000  
    If (vy < 1000) Then vy = 1000  
   
  
    Select Case joy  
        'palanca izquierda  
        Case 1  
            sal = "+IV" & vy & "IH" & vx & "PDV1512DH1512DN-"  
        'palanca derecha  
        Case 2  
            sal = "+IV1512IH1512NDV" & vy & "DH" & vx & "DN-"  
        'boton 1  
        Case 3  
            sal = "+IV1512IH1512PDV1512DH1512DN-"  
        'boton 2  
        Case 4  
            sal = "+IV1512IH1512NDV1512DH1512DB-"  
        'reseteo  
        Case 5  
            sal = "+IV1512IH1512NDV1512DH1512DB-"  
        'cualquier otra cosa (no deberia llegar a aqui  
        Case Else  
            sal = "+IV1512IH1512NDV1512DH1512DN-"  
    End Select  
   
    'Log(sal)  
   
    'mando por bluetooth el strig formado  
    If connected Then  
        TextWriter1.WriteLine(sal)  
        TextWriter1.Flush  
        sal = ""  
    End If  
End Sub
```