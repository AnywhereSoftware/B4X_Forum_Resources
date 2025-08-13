B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.8
@EndOfDesignText@
#Event:ServiceState(State as boolean)


Sub Class_Globals
	Private mUnitID As Byte
	Private xui As XUI
	Private mCaller As Object
	Private mEventName As String
	Private const ServiceStateEvent As String = "ServiceState"
	Private InternalID As Short = 0
	Private MyQueryMap As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Caller As Object,EventName As String, unitId As Byte)
	mCaller = Caller
	mEventName = EventName
	setUnitID(unitId)
	InternalID = 0
	MyQueryMap.Initialize
End Sub

#Region Properties
	'Get Unit ID
	Public Sub getUnitID() As Byte
		Return mUnitID
	End Sub

	'Set Unit ID
	Public Sub setUnitID(value As Byte)
		mUnitID = value
	End Sub
#End Region

'Create Connection Parameter
Public Sub CreateConnection(IPaddress As String, Port As Int, Timeout As Int, ReadTime As Int) As ConnectionParams
	Dim MyCOM As ConnectionParams
	MyCOM.Initialize
	MyCOM.IPAddress = IPaddress
	MyCOM.Port = 502
	MyCOM.Timeout = Timeout
	MyCOM.UnitID = mUnitID
	MyCOM.ReadTime =  ReadTime
	MyCOM.Paramered = True
	Return MyCOM
End Sub

#Region QueryManagement
'Create a Task Query for Reading Cycle
Public Sub CreateQuery(Function As Short, StartAddress As Short, Count As Short) As ModbusQuery
	Dim MyMSG As ModbusQuery
	MyMSG.Initialize
	MyMSG.Function = Function
	MyMSG.StartAddress = StartAddress
	MyMSG.Count = Count
	MyMSG.Busy = False
	MyMSG.Id = InternalID
	InternalID = InternalID + 1
	Return MyMSG
End Sub

'Add a single value to querylist. You Must call "CreateNewQueryList"
Public Sub AddToQuery(Value As ModbusQuery)
	Dim key As Short = Value.Id
	MyQueryMap.Put(key,Value)
End Sub

'Add an array to querylist. You Must call "CreateNewQueryList"
Public Sub AddToQuery2(Value() As ModbusQuery)
	For Each v As ModbusQuery In Value
		Dim key As Short = v.Id
		MyQueryMap.Put(key,v)
	Next
End Sub

'Remove a Query by Id. You Must call "CreateNewQueryList"
Public Sub RemoveFromQuery(Key As Short)
	MyQueryMap.Remove(Key)
End Sub

'Clear QueryList
Public Sub ResetQueryList()
	MyQueryMap.Clear
End Sub

'Put New Modified Map to Background
Public Sub CreateNewQueryList()
	CallSub2(ModbusService,"UpdateQuery",MyQueryMap)
End Sub

Private Sub AdjustQuery()
	Dim QueryList As List
	QueryList.Initialize
	InternalID = 0
	For Each q As ModbusQuery In MyQueryMap.Values
		If q.Count > 125 Then
			Dim reloop As Int = 0
			reloop= q.Count / 125
			
			For i = 0 To reloop
				Dim MyQ As ModbusQuery
				MyQ.Initialize
				MyQ.Function = q.Function
				MyQ.Id = InternalID
				MyQ.StartAddress = q.StartAddress + (125*i)
				MyQ.Count = 125			
				QueryList.Add(MyQ)
				InternalID = InternalID + 1
			Next
		Else
			QueryList.Add(q)
			InternalID = InternalID + 1
		End If
	Next
	ResetQueryList
	Dim MyListArray() As ModbusQuery = Conversion.List2Array(QueryList)
	AddToQuery2(MyListArray)
End Sub

#End Region

'Start Comunication to Server
Public Sub StartCOM(COM As ConnectionParams)
	Dim state As Boolean = IsPaused(ModbusService)
	If state = True Then
		ModbusService.COM.Initialize
		ModbusService.COM = COM
		AdjustQuery
		ModbusService.ReadingQuery = MyQueryMap
		StartService(ModbusService)
	End If
	Raise_ServiceState
End Sub

'Stop Comunication to Server
Public Sub StopCOM()
	Dim state As Boolean = IsPaused(ModbusService)
	If state = False Then
	StopService(ModbusService)
	End If
	Raise_ServiceState
End Sub

#Region Methods

'Set Single Coil
Public Sub SetCoil(Address As Short, Value As Boolean)
	CallSub3(ModbusService,"SetCoil",Address,Value)
End Sub

'Set Single Hold
Public Sub SetHold(Address As Short, Value As Short)
	CallSub3(ModbusService,"SetHold",Address,Value)
End Sub

Public Sub SetMultipleHold(Address As Short, Value() As Short)
	CallSub3(ModbusService,"SetMultipleHold",Address,Value)
End Sub

'Get All Coils (65536)
Public Sub GetCoil() As Boolean()
	Dim MyCoils() As Boolean = CallSub(ModbusService,"GetCoil")
	Return MyCoils
End Sub

'Get All Holds (65536)
Public Sub GetHolds() As Short()
	Dim MyHolds() As Short = CallSub(ModbusService,"GetHolds")
	Return MyHolds
End Sub

#End Region

Private Sub Raise_ServiceState()
	If SubExists(mCaller,$"${mEventName}_${ServiceStateEvent}"$) Then
		CallSubDelayed2(Me,$"${mEventName}_${ServiceStateEvent}"$,IsPaused(ModbusService))
	End If
End Sub







