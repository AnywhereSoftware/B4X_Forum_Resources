B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.3
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public TCPSck1 As Socket ' requires Network library
	Public ServerSocket1 As ServerSocket  ' requires Network library
	Public MyIP As String
	Public TargetIP As String
	Public Port As Int = 8899
	Public TimeOut As Int = 500
End Sub ' Process_Globals

Sub Service_Create

End Sub ' Service_Create

Sub Service_Start( StartingIntent As Intent )
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
	
	If ServerSocket1.IsInitialized Then ServerSocket1.Close
	ServerSocket1.Initialize( 0, "" )
	MyIP = ServerSocket1.GetMyIP
	ServerSocket1.Close
End Sub ' Service_Start()

Sub Service_TaskRemoved
	
End Sub ' Service_TaskRemoved

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error( Error As Exception, StackTrace As String ) As Boolean
	Return True
End Sub ' Application_Error()

Sub Service_Destroy

End Sub ' Service_Destroy

Sub Connect
	If TCPSck1.IsInitialized = False Then
		TCPSck1.Initialize( "TCPSck1" )
	End If
	If TCPSck1.Connected = True Then
		TCPSck1.Close
	End If
	TCPSck1.Connect( TargetIP, Port, TimeOut )
	Log( "Connecting to " & TargetIP & ", " & Port )
End Sub ' Connect

Sub TCPSck1_Connected( success As Boolean )
	If success Then
		Dispatch( "Connected" )
	Else
		Dispatch( "ConnectFailure" )
	End If
End Sub ' TCPSck1_Connected()

Sub Dispatch( fct As String )
	CallSub( Main, fct )
End Sub ' Dispatch()
