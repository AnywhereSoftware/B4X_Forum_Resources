B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public PDFView1 As B4XView
	Public Document As NativeObject
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Dim no As NativeObject
	PDFView1 = no.Initialize("PDFView").RunMethod("new", Null)
	mBase.AddView(PDFView1, 0, 0, 0, 0)
End Sub

'Loads the pdf file. Set the password to "" if not needed.
Public Sub LoadPDF (Dir As String, FileName As String, Password As String)
	Dim b() As Byte = File.ReadBytes(Dir, FileName)
	Document = Document.Initialize("PDFDocument").RunMethod("alloc", Null).RunMethod("initWithData:", _
		Array(Document.ArrayToNSData(b)))
	If Password <> "" Then
		Document.RunMethod("unlockWithPassword:", Array(Password))
	End If
	PDFView1.As(NativeObject).SetField("document", Document)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	PDFView1.SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub