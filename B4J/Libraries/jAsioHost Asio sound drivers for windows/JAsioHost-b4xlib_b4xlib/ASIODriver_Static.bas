B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public Const STATE_UNLOADED As String = "UNLOADED"
	Public Const STATE_UNLOADED_ORDINAL As String = 0
	Public Const STATE_LOADED As String = "LOADED"
	Public Const STATE_LOADED_ORDINAL As String = 1
	Public Const STATE_INITIALIZED As String = "INITIALIZED"
	Public Const STATE_INITIALIZED_ORDINAL As String = 2
	Public Const STATE_PREPARED As String = "PREPARED"
	Public Const STATE_PREPARED_ORDINAL As String = 3
	Public Const STATE_RUNNING As String = "RUNNING"
	Public Const STATE_RUNNING_ORDINAL As String = 4
	
End Sub

'The designated ASIO driver Is loaded And returned in the <code>INITIALIZED</code> state. If a driver Is
'already loaded And it Is the named driver, Then that driver object Is returned. If the named
'driver Is different from the one currently loaded, Then the currently loaded driver Is shut
'down And a new one Is instantiated. There Is only ever one loaded driver.
'@param driverName  The name of the driver To load, As returned by <code>GetDriverNames()</code>.
'@return The named AsioDriver object.
'@throws AsioException  Thrown If the driver could Not be loaded into memory.
' @throws NullPointerException  Thrown If the input Is <code>Null</code>.
Public Sub GetDriver(DriverName As String) As ASIODriver
	Dim TJO As JavaObject
	TJO.InitializeStatic("com.synthbot.jasiohost.AsioDriver")
	Dim Wrapper As ASIODriver
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getDriver",Array(DriverName)))
	Return Wrapper
End Sub

Public Sub GetDriverNames As List
	Dim TJO As JavaObject
	TJO.InitializeStatic("com.synthbot.jasiohost.AsioDriver")
	Return TJO.RunMethod("getDriverNames",Null)
End Sub

Public Sub StateOrdinal(State As String) As Int
	Select  State
		Case STATE_INITIALIZED
			Return 0
		Case STATE_LOADED
			Return 1
		Case STATE_PREPARED
			Return 2
		Case STATE_RUNNING
			Return 3
		Case STATE_UNLOADED
			Return 4
	End Select
	Return -1
End Sub