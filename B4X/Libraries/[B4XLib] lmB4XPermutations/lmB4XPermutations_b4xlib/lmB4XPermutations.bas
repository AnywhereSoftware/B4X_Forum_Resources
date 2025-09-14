B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13
@EndOfDesignText@
'Static code module

Sub Process_Globals
	Private xui As XUI
	
	Public Callback As Object = Null
	Public EventName As String
	Public StepLength As Int = 50
	
	Private mlstPermutations As List
	Private mSwapCount As Int
End Sub

#Region PUBLIC PROPERTIES 

#End Region

#Region PUBLIC METHODS 

'Callback and EventName are optional. You will only need to set them
'if you implement the [EventName]_PermStep Sub-event, which is useful
'if you pass a long list of items and the processing time may be long,
'to display an animation.
'Example:
'<code>
''	lmB4XPermutations.Callback = Me
''	lmB4XPermutations.EventName = "per"
'	Wait For (lmB4XPermutations.Generate(lstItems)) Complete(lstPermutations As List)
'	For Each lst As List In lstPermutations
'		Log(lst)
'	Next
'
''Public Sub per_PermStep
''
''End Sub
'</code>
Public Sub Generate(lstItems As List) As ResumableSub
	mlstPermutations.Initialize
	FindPermutations(lstItems, 0, lstItems.Size - 1)
	Return mlstPermutations
End Sub

#End Region

#Region PRIVATE METHODS 

Private Sub FindPermutations(lstItems As List, Left As Int, Right As Int)
	If Left = Right Then
		Dim copy As List = CopyObject(lstItems)
		mlstPermutations.Add(copy)
	Else
		For i = Left To Right
			Swap(lstItems, Left, i)
			FindPermutations(lstItems, Left + 1, Right)
			Swap(lstItems, Left, i)
		Next
	End If
End Sub

Private Sub Swap(lstItems As List, IndexA As Int, IndexB As Int)
	Dim temp As Object = lstItems.Get(IndexA)
	lstItems.Set(IndexA, lstItems.Get(IndexB))
	lstItems.Set(IndexB, temp)
	mSwapCount = mSwapCount + 1
	If mSwapCount Mod 5 = 0 Then
		If Callback <> Null And EventName.Length > 0 Then
			If xui.SubExists(Callback, EventName & "_PermStep", 0) Then
				CallSub(Callback, EventName & "_PermStep")
			End If
		End If
	End If
End Sub

Private Sub CopyObject(SourceObject As Object) As List
	Dim xSer As B4XSerializator
	Return xSer.ConvertBytesToObject(xSer.ConvertObjectToBytes(SourceObject))
End Sub

#End Region