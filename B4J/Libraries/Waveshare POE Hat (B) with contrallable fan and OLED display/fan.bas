B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@

Sub Process_Globals
Private bus As JavaObject 
Private device As JavaObject
Private tmr_Temp_Control As Timer
Private Temp_Control_Trigger_Value As Int
Private Temparature As Int
Private fan_state As String
End Sub

Sub Init(i2cbus As Byte, fan_i2c_device As Byte) 
	bus = i2c.GetBus(i2cbus)
	device = i2c.GetDevice(bus, fan_i2c_device)

 tmr_Temp_Control.Initialize("tmr_Temp_Control",1000*5)
	tmr_Temp_Control.Enabled=True
	On
End Sub

Sub command(pData As Int)
	i2c.Write2(device, Array As Byte (0x80, pData), 0, 2)
End Sub

Sub On
 If fan_state<>"On" Then command(0x00)
 fan_state="On"
End Sub
        
Sub Off
	If fan_state<>"Off" Then	command(0x01)
	fan_state="Off"
End Sub        
        
Sub Get_Temp As Int
	If File.Exists("/sys/class/thermal/thermal_zone0","temp") Then
		Dim t As String
		t=File.ReadString("/sys/class/thermal/thermal_zone0","temp")
		Temparature=t/1000		
	End If
	Return Temparature
End Sub

Sub Temp_Control_Enable(Temp As Int)
	Temp_Control_Trigger_Value=Temp
	tmr_Temp_Control.Enabled=True
End Sub

Sub Temp_Control_Disable
	tmr_Temp_Control.Enabled=False
End Sub

Sub tmr_Temp_Control_Tick
	If Get_Temp>=Temp_Control_Trigger_Value Then
		On
	Else
		Off
	End If
 update_display
End Sub

Sub update_display
	ssd1306.WriteText($"Fan: ${fan_state}  "$,0,1,False)
	ssd1306.WriteText($"Temp: ${Temparature} "$,0,2,False)
End Sub