B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.9
@EndOfDesignText@
' Code Module: Boost.bas

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	' MoveHUB
	Public Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
'	Public HUBPorts() As Byte = Array As Byte(0x00,0x01,0x10,0x02,0x03,0x32,0x3A,0x3B,0x3C)
'	Public HUBPortsID() As String = Array As String("A","B","AB","C","D","LED","TILT","CURRENT","VOLTAGE")

	' Min number of serialized data objects received
	Public Const SER_DATA_MIN_LENGTH As Byte = 2
	Public Const SER_DATA_OBJECTS_BUFFER_SIZE As Byte = 10

	#if B4A or B4J
	' MoveHUB Ports
	Public Const PORT_A As Byte = 0x00
	Public Const PORT_B As Byte = 0x01
	Public Const PORT_AB As Byte = 0x10
	Public Const PORT_C As Byte = 0x02
	Public Const PORT_D As Byte = 0x03
	Public Const PORT_LED As Byte = 0x32
	Public Const PORT_TILT As Byte = 0x3A
	Public Const PORT_CURRENT As Byte = 0x3B
	Public Const PORT_VOLTAGE As Byte = 0x3C
	' Battery = 0x4A, Shutdown = 0x4B, Debug = 0x4C, DistanceSensor = 0x4D, ColorSensor = 0x4E, HubConnectionState = 0x4F

	' MoveHUB LED Colors
	Public Const LED_BLACK As Byte = 0
	Public Const LED_PINK As Byte = 1
	Public Const LED_PURPLE As Byte = 2
	Public Const LED_BLUE As Byte = 3
	Public Const LED_LIGHTBLUE As Byte = 4
	Public Const LED_CYAN As Byte = 5
	Public Const LED_GREEN As Byte = 6
	Public Const LED_YELLOW As Byte = 7
	Public Const LED_ORANGE As Byte = 8
	Public Const LED_RED As Byte = 9
	Public Const LED_WHITE As Byte = 10
	Public Const LED_NONE As Byte = 255

	' MoveHUB Braking Style
	Public Const BRAKINGSTYLE_BRAKE As Byte	= 127
	Public Const BRAKINGSTYLE_HOLD As Byte	= 126
	Public Const BRAKINGSTYLE_FLOAT As Byte	= 0
	#end if

	' COMMANDS
	Public Const CMD_PREFIX As Byte = 63

	' BOOST
	' Move forward or back (Port AB) with the default speed, stop after the number of steps
	' MoveForward(int steps);
	' Cmd: MOVEHUB_PREFIX, CMD_MOVEFORWARD, 5
	Public Const CMD_MOVEFORWARD As Byte = 0x01
	Public Const CMD_MOVEBACKWARD As Byte = 0x02
	' Rotate (Port AB) with default speed, stop after degrees
	' degrees - (negative: left, positive: right)
	Public Const CMD_ROTATE As Byte = 0x03
	Public Const CMD_ROTATELEFT As Byte = 0x04
	Public Const CMD_ROTATERIGHT As Byte = 0x05
	Public Const CMD_MOVEARC As Byte = 0x06
	Public Const CMD_MOVEARCLEFT As Byte = 0x07
	Public Const CMD_MOVEARCRIGHT As Byte = 0x08

	' HUB LED

	' Set the color of the HUB LED with predefined colors
	' color - byte = BLACK=0,PINK=1,PURPLE=2,BLUE=3,LIGHTBLUE=4,CYAN=5,GREEN=6,YELLOW=7,ORANGE=8,RED=9,WHITE=10,NONE=255
	Public Const CMD_SET_LED_COLOR As Byte = 0x20
	' r, g, b - Set the color of the HUB LED with RGB values 0..255
	Public Const CMD_SET_LED_RGBCOLOR As Byte = 0x21
	' Set color HUB LED with HSV values LED_LIGHTBLUE:0..360,saturation - 0..1,value - 0..1
	Public Const CMD_SET_LED_HSVCOLOR As Byte = 0x22

	' HUB MOTORS
	
	' Stop the motor on a defined port.
	' port - Port of the Hub on which the motor will be stopped (A, B) or (0, 1)
	' Calls SetBasicMotorSpeed with speed 0
	Public Const CMD_STOP_BASICMOTOR As Byte = 0x30

	' Set the motor speed on a defined port.
	' port - Port of the Hub on which the speed of the motor will set (A, B, AB)
	' speed - Speed of the Motor -100..0..100 negative values will reverse the rotation
	Public Const CMD_SET_BASICMOTOR_SPEED As Byte = 0x31

	' Set the acceleration profile
	' port - Port of the Hub on which the speed of the motor will set (A, B, AB)
	' time - Time value in ms of the acceleration from 0-100% speed/Power
	Public Const CMD_SET_ACCELERATION_PROFILE As Byte = 0x32

	' Set the deceleration profile
	' port - Port of the Hub on which the speed of the motor will set (A, B, AB)
	' time - Time value in ms of the deceleration from 100-0% speed/Power
	Public Const CMD_SET_DECELERATION_PROFILE As Byte = 0x33

	' Stop the motor on a defined port.
	' port - Port of the Hub on which the motor will be stopped (A, B, AB, C, D)
	Public Const CMD_STOP_TACHOMOTOR As Byte = 0x34

	' Set the motor speed on a defined port.
	' port - Port of the Hub on which the speed of the motor will set
	' speed - Speed of the Motor -100..0..100 negative values will reverse the rotation
	' maximum - Power of the Motor 0..100
	' brakingStyle - Braking style how the motor will stop. Brake, Float, Hold are available
	Public Const CMD_SET_TACHOMOTOR_SPEED As Byte = 0x35

	' Set the motor speed on a defined port.
	' port - Port of the Hub on which the speed of the motor will set
	' speed - Speed of the Motor -100..0..100 negative values will reverse the rotation
	' time - Time in miliseconds for running the motor on the desired speed
	' maximum - Power of the Motor 0..100
	' brakingStyle - Braking style how the motor will stop. Brake, Float, Hold are available
	Public Const CMD_SET_TACHOMOTOR_SPEED_FOR_TIME As Byte = 0x36

	' Set the speed of a motors
	' port - Port of the Hub on which the speed of the motor will set
	' speed - Speed of the Motor -100..0..100 negative values will reverse the rotation
	' degrees - till which rotation in degrees the motors should run
	' maximum - Power of the Motor 0..100 (default value = 100)
	' brakingStyle - Braking style how the motor will stop. Brake(default), Float, Hold are available
	Public Const CMD_SET_TACHOMOTOR_SPEED_FOR_DEGREES As Byte = 0x37

	' Set the speeds of the MoveHub Motors
	' speedLeft - Speed of the left motor
	' speedRight - speed of the right motor
	' degrees - till which rotation in degrees the motors should run
	' maximum - Power of the Motor 0..100 (default value = 100)
	' brakingStyle - Braking style how the motor will stop. Brake(default), Float, Hold are available
	Public Const CMD_SET_TACHOMOTOR_SPEEDS_FOR_DEGREES As Byte = 0x38

	' Set the motor absolute position on a defined port.
	' port - Port of the Hub on which the speed of the motor will set (A, B, AB)
	' speed - Speed of the Motor 0..100 positive values only
	' position - Position in degrees (relative to zero point on power up, or encoder reset) -2,147,483,648..0..2,147,483,647
	' maximum - Power of the Motor 0..100 (default value = 100)
	' brakingStyle - Braking style how the motor will stop. Brake(default), Float, Hold are available
	Public Const CMD_SET_ABSOLUTE_MOTOR_POSITION As Byte = 0x39

	' Set the motor encoded position on a defined port.
	' port - Port of the Hub on which the speed of the motor will set (A, B, AB)
	' position - Position in degrees to encode (0 = Reset) -2,147,483,648..0..2,147,483,647
	Public Const CMD_SET_ABSOLUTE_MOTOR_ENCODER_POSITION As Byte = 0x40

	' Calibrate the motor on a defined port.
	' This should be done once.
	' During calibration, approx 5 seconds, the LED turns orange And To yellow If finished.
	' port - Port of the Hub the motor will calibrated (A, B, AB For Tacho motor; C Or D For Basic motor).
	Public Const CMD_SET_MOTOR_CALIBRATION As Byte = 0x41

	' CURRENT VOLTAGE
	Public Const CMD_GET_VOLTAGE As Byte = 0x50
	Public Const CMD_GET_CURRENT As Byte = 0x51

	' TILT SENSOR
	Public Const CMD_GET_TILT As Byte = 0x52
  
	' COLOR DISTANCE SENSOR

	' Get the distance in mm
	Public Const CMD_GET_DISTANCE As Byte = 0x53
	' Get the color
	Public Const CMD_GET_COLOR As Byte = 0x54

	' BATTERY
	Public Const CMD_GET_BATTERY_LEVEL As Byte = 0x55

	' MOVEHUB STATE
	Public Const CMD_SHUTDOWN As Byte = 0x56
	Public Const CMD_GET_CONNECTION_STATE As Byte = 0x57

	' VARIOUS
	Public Const CMD_SET_HUB_MESSAGE As Byte = 0xFE
	Public Const CMD_SET_DEBUG_MODE As Byte = 0xFF

	' HELPER
	#If B4A or B4J
	Private bc As ByteConverter
	#End If
	
End Sub


#if B4A or B4J
' LED
Public Sub Command_Set_LED_Color(value As Byte) As Object()
	Log_Cmd("Command_Set_LED_Color", CMD_SET_LED_COLOR)
	Return Array As Object(CMD_PREFIX, CMD_SET_LED_COLOR, value)
End Sub

' CONNECTIONSTATE
Public Sub Command_Get_Connection_State As Object()
	Log_Cmd("Command_Get_ConnectionState", CMD_GET_CONNECTION_STATE)
	Return Array As Object(CMD_PREFIX, CMD_GET_CONNECTION_STATE)
End Sub

' HUB MESSAGE
Public Sub Command_Set_Bridge_Message(msg As String) As Object()
	Log_Cmd("Command_Set_Bridge_Message", CMD_SET_HUB_MESSAGE)
	Return Array As Object(CMD_PREFIX, CMD_SET_HUB_MESSAGE, msg)
End Sub

' BATTERYLEVEL
Public Sub Command_Get_BatteryLevel As Object()
	Log_Cmd("Command_Get_BatteryLevel", CMD_GET_BATTERY_LEVEL)
	Return Array As Object(CMD_PREFIX, CMD_GET_BATTERY_LEVEL)
End Sub

' VOLTAGESENSOR
Public Sub Command_Get_Voltage As Object()
	Log_Cmd("Command_Get_Voltage", CMD_GET_VOLTAGE)
	Return Array As Object(CMD_PREFIX, CMD_GET_VOLTAGE)
End Sub

' DISTANCESENSOR
Public Sub Command_Get_Distance(port As Byte) As Object()
	Log_Cmd("Command_Get_Distance", CMD_GET_DISTANCE)
	Return Array As Object(CMD_PREFIX, CMD_GET_DISTANCE, port)
End Sub

' MOTOR

' Move motor forward.
' port - default AB
Public Sub Command_Move_Forward(port As Byte, speed As Int) As Object()
	Log($"${DateTime.Time(DateTime.Now)} Command_Move_Forward: Port=${port}, Speed=${speed}"$)
	Return Array As Object(CMD_PREFIX, CMD_SET_TACHOMOTOR_SPEED, port, speed)
End Sub

' Move motor backward.
' port - default AB
Public Sub Command_Move_Backward(port As Byte, speed As Int) As Object()
	Log($"${DateTime.Time(DateTime.Now)} Command_Move_Backward: Port=${port}, Speed=${speed}"$)
	Return Array As Object(CMD_PREFIX, CMD_SET_TACHOMOTOR_SPEED, port, speed)
End Sub

' Stop the motor.
' port - default AB
Public Sub Command_Move_Stop(port As Byte) As Object()
	Log($"${DateTime.Time(DateTime.Now)} Command_Move_Stop: Port=${port}"$)
	Return Array As Object(CMD_PREFIX, CMD_SET_TACHOMOTOR_SPEED, port, 0)
End Sub

' Calibrate the motor.
' port - Use port C (default) or D with the Basic motor connected
Public Sub Command_Motor_Calibrate(port As Byte) As Object()
	Log($"${DateTime.Time(DateTime.Now)} Command_Motor_Calibrate: Port=${port}"$)
	Return Array As Object(CMD_PREFIX, CMD_SET_MOTOR_CALIBRATION, port)
End Sub

' Set the absolute motor position
' Position in degrees (relative to zero point on power up, or encoder reset)
' port - Use port C (default) or D with the Basic motor connected
' position - 0 = center, -45 to 45
Public Sub Command_Motor_Position(port As Byte, position As Long) As Object()
	Log($"${DateTime.Time(DateTime.Now)} Command_Motor_Position: Port=${port}, Position=${position}"$)
	Return Array As Object(CMD_PREFIX, CMD_SET_ABSOLUTE_MOTOR_POSITION, port, 100, position, 100, BRAKINGSTYLE_BRAKE)
End Sub
#end if
	
#Region HELPER
#If B4A or B4J
' Log a command with command strng, de and hex value
Private Sub Log_Cmd(cmds As String, cmd As Byte)
	Log($"${DateTime.Time(DateTime.Now)} ${cmds}: Command=${cmd} (0x${bc.HexFromBytes(Array As Byte(cmd))})"$)
End Sub
#End If

#End Region
