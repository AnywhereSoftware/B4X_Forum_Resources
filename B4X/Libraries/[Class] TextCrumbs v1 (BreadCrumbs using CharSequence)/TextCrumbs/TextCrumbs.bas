B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
#Event: _Clicked ( Position as int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI
	Private crumbs As List
	Private ccolor As Int
	Private lbl As B4XView
	Private separate As Object
	Private cs As CSBuilder
	Public	ClickColor As Int = xui.Color_Blue		' ClickColor: color of clickable items ( this sets default )
	Public  underline As Boolean					' Underline: boolean to underline text or not
End Sub

'Initializes the object. You can add parameters to this method if needed.

' mList: the list holding bread crumbs
' mLabel: Label to show the bread crumbs in
' Separator: any char /symbol to use as separator like ">" (charsequence accepted)
Public Sub Initialize (Callback As Object, EventName As String, mList As List, mlabel As B4XView, separator As Object)
	mCallBack = Callback
	mEventName = EventName
	crumbs = mList
	ccolor = ClickColor
	lbl = mlabel
	separate = separator
	Refresh
End Sub


' Refresh after changes to list
Public Sub Refresh

	cs.Initialize
	For i = 0 To crumbs.Size - 1
		If underline Then cs.Underline
		cs.Color(ccolor).Clickable("word", i).Append(crumbs.Get(i)).PopAll '
'		If uline Then cs.Pop
		If i<> crumbs.Size-1 Then cs.Append(separate)
	Next
	
	lbl.Text = cs
	cs.EnableClickEvents(lbl)

End Sub

Public Sub getWidth As Int
	Return  CSWidth + 100dip
End Sub



Sub CSWidth As Float
	Dim bc As B4XCanvas
	bc.Initialize(lbl)
	Dim r As B4XRect = bc.MeasureText(lbl.Text, lbl.Font)
	Return r.Width
End Sub


private Sub word_click (Position As Object)
	If xui.SubExists(mCallBack, mEventName&"_Clicked",1) Then
		CallSubDelayed2(mCallBack,mEventName&"_Clicked",Position)
	Else
		Log($"No Receiver found ${CRLF} item ${Position} clicked !"$)
	End If
End Sub
