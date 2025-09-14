B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
'	Private fx As JFX
End Sub

Public Sub UnwrapMap(M As Map) As Map
	
	For Each S As String In M.Keys
		Dim O As Object = M.Get(S)
		If O Is List Then
			M.Put(S,UnwrapList(O))
		Else If O Is Map Then
			M.Put(S,UnwrapMap(O))
		Else If O Is NitriteDocument Or O Is NitriteId Then
			M.Put(S,CallSub(O,"getObject"))
		End If
	Next
	Return M
End Sub

Public Sub UnwrapList(L As List) As List
	For i = 0 To L.Size - 1
		Dim O As Object = L.Get(i)
		If O Is List Then
			L.Set(i,UnwrapList(O))
		Else If O Is Map Then
			L.set(i,UnwrapMap(O))
		Else If O Is NitriteDocument Or O Is NitriteId Then
			L.Set(i,CallSub(O,"getObject"))
		End If
	Next
	Return L
End Sub