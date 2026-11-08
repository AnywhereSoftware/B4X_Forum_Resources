B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano
	Public mScanner As BANanoObject
	Private mEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Dynamsoft As BANanoObject,eventName As String)
	mEventName=eventName
	mScanner = BANano.Await(Dynamsoft.GetField("DBR").GetField("BarcodeScanner").RunMethod("createInstance",Null))
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

'Show the camera UI element, open the camera, and start decoding.
public Sub show
	Dim results As Object
	Dim txt As Object
	Dim result As Object
	mScanner.AddEventListenerOpen("onUnduplicatedRead",Array(txt,result))
	If SubExists(Main,mEventName&"_onUnduplicatedRead") Then
		Dim tr As TextResult
		tr.Initialize(result)
		BANano.CallSub(Main, mEventName&"_onUnduplicatedRead", Array(txt,tr))
	End If	
	mScanner.CloseEventListener
	
	mScanner.AddEventListenerOpen("onFrameRead",results)
	If SubExists(Main,mEventName&"_onFrameRead") Then
		BANano.CallSub(Main, mEventName&"_onFrameRead", Array(ConvertTextResult(results)))
	End If
	mScanner.CloseEventListener
	
	mScanner.RunMethod("show",Null)
End Sub

public Sub setUIElement(e As BANanoElement)
	mScanner.SetField("getUIElement",e)
End Sub

public Sub getUIElement As BANanoElement
	Return mScanner.GetField("getUIElement")
End Sub
