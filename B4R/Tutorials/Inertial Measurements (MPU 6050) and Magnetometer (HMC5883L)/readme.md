### Inertial Measurements (MPU 6050) and Magnetometer (HMC5883L) by derez
### 05/27/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/65917/)

With big help from Erel here are two examples of connecting two boards by the I2C/TWI (A4 and A5 pins), using the rWire library.  
Inertial Measurements (mpu6050) :  

```B4X
' MPU 6050 board - Inertial Measurements  
' connect SCL to A5, SDA to A4, 3.3V and ground  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #StackBufferSize: 300  
#End Region  
Sub Process_Globals  
   Public Serial1 As Serial  
   Private wire As WireMaster  
   Private raf As RandomAccessFile  
   Private const MPU As Int = 0x68  
   Private AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ As Int  
   Private tmr As Timer  
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   wire.Initialize  
   wire.WriteTo(MPU, Array As Byte(0x6b, 0))  
   tmr.Initialize("tmr_tick",700)  
   tmr.Enabled = True  
  
End Sub  
  
Sub tmr_tick  
   wire.WriteTo(MPU, Array As Byte(0x3b))  
   Dim b() As Byte = wire.RequestFrom(MPU, 14)  
   If b.Length = 14 Then  
    raf.Initialize(b,False)  
    AcX  = raf.ReadInt16(raf.CurrentPosition)  
     AcY  = raf.ReadInt16(raf.CurrentPosition)  
     AcZ  = raf.ReadInt16(raf.CurrentPosition)  
    Dim temp As Double  
    Tmp  = raf.ReadInt16(raf.CurrentPosition)  
     temp = Tmp /340.00+36.53  
    GyX  = raf.ReadInt16(raf.CurrentPosition)  
     GyY  = raf.ReadInt16(raf.CurrentPosition)  
    GyZ  = raf.ReadInt16(raf.CurrentPosition)  
     Log("acx: ", AcX , ", acy: ", AcY ," ,acz: ", AcZ,", Tmp: ",NumberFormat(temp,1,1) , ", GyX: ", GyX , ", GyY: ", GyY ," ,GyZz: ", GyZ)  
   Else  
     Log("Missing data…")  
   End If  
End Sub
```

  
  
Magnetometer (HMC5883L) :  

```B4X
' HMC5883L board - magnetometer  
' connect SCL to A5, SDA to A4, 3.3v and ground  
  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
   Public Serial1 As Serial  
   Private wire As WireMaster  
   Private raf As RandomAccessFile  
   Private const addr As Int = 0x1E  
   Private X,Y,Z As Int  
   Private tmr As Timer  
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   wire.Initialize  
   wire.WriteTo(addr, Array As Byte(0x02, 0))  
   tmr.Initialize("tmr_tick",700)  
   tmr.Enabled = True  
End Sub  
  
Sub tmr_tick  
   wire.WriteTo(addr, Array As Byte(0x03))  
   Dim b() As Byte = wire.RequestFrom(addr, 6)  
   If b.Length = 6 Then  
    raf.Initialize(b,False)  
    X  = raf.ReadInt16(raf.CurrentPosition)  
     Z  = raf.ReadInt16(raf.CurrentPosition)  
     Y  = raf.ReadInt16(raf.CurrentPosition)  
    Dim heading As Double = ATan2(y, x) *180/cPI  
    If heading < 0 Then heading = heading + 360  
    Log("x:  ", X , ",  y:  ", Y ,",  z:  ", Z,  "   Hdg:  ", NumberFormat(heading,1,1))  
   Else  
     Log("Missing data…")  
   End If  
End Sub
```

  
  
Tip: the magnetometer will not function correctly near running motors due to their effect on the magnetic field.  
Note: Since the two devices have different addresses you can connect both of them in one program.  
Edit: corrected per Erel's recomendation.