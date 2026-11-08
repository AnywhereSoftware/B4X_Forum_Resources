B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: Event (MethodName As String, Args() As Object) As Int
'Printable / Paintable
'Event sub example :
'<code>
'Private Sub Print_Event (MethodName As String, Args() As Object) As Int
'	Dim G As Graphics2d = Args(0)
'	Dim PF As PageFormat = Args(1)						'ignore
'	Dim PageIndex As Int = Args(2)
'
'	If PageIndex > Lastpage Then Return NO_SUCH_PAGE '(Int value = 1) to stop printing
'
'	'paint on the Graphics2d Object
'
'	Return PAGE_EXISTS' (Int value = 0)  another page will be requested
'End Sub</code>
Sub Class_Globals
	Private mCallBack As Object
	Private mEventName As String
	Private Obj As Object
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object,EventName As String) As Object
	mCallBack = CallBack
	mEventName = EventName
	Dim JO As JavaObject = CallBack
	Obj = JO.CreateEvent("java.awt.print.Printable","Print",0)
	Return Obj
End Sub

Public Sub GetObject As Object
	Return Obj
End Sub

Private Sub Print_Event (MethodName As String, Args() As Object) As Object
	Dim G As Graphics2d
	G.Initialize
	G.SetObject(Args(0))
	Args(0) = G
	Dim PF As PageFormat
	PF.Initialize
	PF.SetObject(Args(1))
	Args(1) = PF
	Return CallSub3(mCallBack,mEventName & "_Event",MethodName,Args)
End Sub

'Testing
'#If Java
'
'import java.awt.print.Printable;
'import java.awt.print.PrinterException;
'import java.awt.Graphics;
'import java.awt.print.PageFormat;
'import anywheresoftware.b4a.keywords.Common;
'
'public class MyPrintable implements Printable{
'
'	@Override
'	public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {  
'		return (int) ba.raiseEvent(this,"print_event",graphics,pageFormat,pageIndex);
'	}
'}
'
'
'#End If