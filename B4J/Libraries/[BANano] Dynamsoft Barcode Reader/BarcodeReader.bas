B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano
	Public mReader As BANanoObject	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Dynamsoft As BANanoObject)
	mReader = BANano.Await(Dynamsoft.GetField("DBR").GetField("BarcodeReader").RunMethod("createInstance",Null))
End Sub

Public Sub decode(data As Object) As TextResult()
	Dim results As List=BANano.Await(mReader.RunMethod("decode",Array(data)))	
	Return ConvertTextResult(results)
End Sub

private Sub ConvertTextResult(results As List) As TextResult()
	Dim values(results.Size) As TextResult
	Dim index As Int=0
	For Each result As BANanoObject In results
		Dim tr As TextResult
		tr.Initialize(result)
		values(index)=tr
		index=index+1
	Next
	Return values
End Sub