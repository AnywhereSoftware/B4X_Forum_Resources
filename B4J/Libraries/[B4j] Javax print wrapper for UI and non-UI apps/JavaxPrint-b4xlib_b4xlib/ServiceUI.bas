B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
	Private TH As Thread			'Ignore
End Sub

'*
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("javax.print.ServiceUI",Null)
	TH.Initialise("TH")
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub

'Presents a dialog to the user for selecting a print service (printer).
Public Sub PrintDialog_NoThread(X As Int, Y As Int, Services As List, DefaultService As PrintService, Flavor As Object, Atts As Object) As PrintService
	If Flavor <> Null Then Flavor = CallSub(Flavor,"GetObject")
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.ServiceUI")
	Dim O As Object = Tjo1.RunMethod("printDialog",Array As Object(Null, X, Y,  UnWrapTypedList(Services, "javax.print.PrintService"), DefaultService.GetObject, Flavor, Atts))
	Dim Wrapper As PrintService
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub

Public Sub PrintDialog(X As Int, Y As Int, Services As List, DefaultService As PrintService, Flavor As Object, Atts As Object) As ResumableSub

	TH.Start(Me,"PrintDialog_Do",Array(X, Y,  UnWrapTypedList(Services, "javax.print.PrintService") , DefaultService.GetObject, Flavor, Atts))

	Wait For Dialog_Done(O As Object)
	
	Dim Wrapper As PrintService
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub

Private Sub PrintDialog_Do(X As Int, Y As Int, Services As Object, DefaultService As Object, Flavor As Object, Atts As Object)
	If Flavor <> Null Then Flavor = CallSub(Flavor,"GetObject")
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
'	Dim Gc As Object = (Me).As(JavaObject).RunMethod("getGraphicsConfiguration",Null)
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.ServiceUI")
	Dim O As Object = Tjo1.RunMethod("printDialog",Array As Object(Null, X, Y, Services, DefaultService, Flavor, Atts))
	CallSub2(Me,"Dialog_Done",O)
End Sub

'Private Sub TH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
'	Log("TH " & endedOK & TAB & error)
'End Sub

#If Java
import java.awt.GraphicsEnvironment;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;

public static GraphicsConfiguration getGraphicsConfiguration(){
	GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	GraphicsDevice[] devices = ge.getScreenDevices();
	return devices[0].getConfigurations()[0];
}
#End If

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

'UnWrap a Wrapped array . 
'Arr is an array of wrapped objects
Private Sub UnWrapTypedList(L As List,UnWrapType As String) As Object
	Dim P1 As JavaObject
	Dim ResultArr(L.Size) As Object
	For i = 0 To L.Size - 1
		ResultArr(i) = GetWrappedObject(L.Get(i))
	Next
	If UnWrapType = "" Then UnWrapType = GetType(ResultArr(0))
	P1.InitializeArray(UnWrapType,ResultArr)
	Return P1
End Sub
'Gets a wrapped object from any wrapper class that has a AsObject Sub 
'without knowing it's type
Private Sub GetWrappedObject(jObj As JavaObject) As JavaObject
	Try
		'Unwrap JOLibs
    #if Debug
    Return jObj.RunMethod("_getobject",Array(jObj))
    #end if
    #if Release
		Return jObj.RunMethod("_getobject",Null)
    #End if
	Catch
		Try
			'Unwrap B4x objects
			Return jObj.RunMethod("getObject",Null)
		Catch
			Log(LastException)
			Log("Invalid type passed to Sub " & GetType(jObj))
		End Try
    
		Return Null
	End Try
End Sub