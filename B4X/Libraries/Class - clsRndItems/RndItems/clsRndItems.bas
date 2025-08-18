B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private mCallback As Object
	Private mEventName As String
	
	Private mNumOfItems As Int
	Private mlstAvailItems As List
	Private mNumOfAvail As Int
End Sub

#Region EVENTS 
#Event: NoItemsAvailable
#End Region

'Creates, by default, a list of numeric items, from 1 to NumOfItems you will provide.
'You can change next the total number of Items using the "NumOfItems" property.
'You can also set a list of Items of any size and type using the "Items" property.
Public Sub Initialize(Callback As Object, EventName As String, NumOfItems As Int)
	mCallback = Callback
	mEventName = EventName
	
	mlstAvailItems.Initialize
	mNumOfItems = NumOfItems
	InitAvailNums
End Sub

#Region PROPERTIES 

'Creates (or replaces, if needed, i.e. if a list of items of different type
' was set using setitems) a list of numeric items, from 1 to Num you are setting.
Public Sub setNumOfItems(Num As Int)
	mNumOfItems = Num
	InitAvailNums
End Sub
Public Sub getNumOfItems As Int
	Return mNumOfItems
End Sub

'Returns the number of still available items.
Public Sub getNumOfAvailableItems As Int
	Return mNumOfAvail
End Sub

Public Sub setItems(Items As List)
	mlstAvailItems.Clear
	For Each obj As Object In Items
		mlstAvailItems.Add(obj)
	Next
	mNumOfItems = mlstAvailItems.Size
	mNumOfAvail = mNumOfItems
End Sub
Public Sub getItems As List
	Return mlstAvailItems
End Sub

#End Region

#Region PUBLIC METHODS 

'Returns a random item among those still available,
'making it no longer available.
'Useful to get unique Items.
Public Sub PopRndItem As Object
	LogIfThereAreNoItems(True)
	
	Dim Index As Int = Rnd(0, mNumOfAvail)
	Dim Item As Object = mlstAvailItems.Get(Index)
	mlstAvailItems.Set(Index, mlstAvailItems.Get(mNumOfAvail - 1))
	mlstAvailItems.Set(mNumOfAvail - 1, Item)
	mNumOfAvail = mNumOfAvail - 1
	If mNumOfAvail = 0 Then
		Dim FullSubName As String
		FullSubName = mEventName & "_NoItemsAvailable"
		CallSubDelayed(mCallback, FullSubName)
	End If
	Return Item
End Sub

'Returns a random item among those still available,
'without removing it.
Public Sub GetRndAvailItem As Object
	LogIfThereAreNoItems(True)
	Return mlstAvailItems.Get(Rnd(0, mNumOfAvail))
End Sub

'Returns a random item among all existing ones
'(not only among those still available),
'without removing it.
Public Sub GetRndItemAmongAll As Object
	LogIfThereAreNoItems(False)
	Return mlstAvailItems.Get(Rnd(0, mNumOfItems))
End Sub

'Makes all the previously "Popped" items available again.
Public Sub Reset
	mNumOfAvail = mNumOfItems
End Sub

#End Region

#Region PRIVATE METHODS 

Private Sub InitAvailNums
	mlstAvailItems.Clear
	For N = 1 To mNumOfItems
		mlstAvailItems.Add(N)
	Next
	mNumOfAvail = mNumOfItems
End Sub

Private Sub LogIfThereAreNoItems(AvailableOnly As Boolean)
	Dim NumOfItems As Int = IIf(AvailableOnly, mNumOfAvail, mNumOfItems)
	If NumOfItems = 0 Then
		Log("clsRndItems - no items available")
	End If
End Sub

#End Region
