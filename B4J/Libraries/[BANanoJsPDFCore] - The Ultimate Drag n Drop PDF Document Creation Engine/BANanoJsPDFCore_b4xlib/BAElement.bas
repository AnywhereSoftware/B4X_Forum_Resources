B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	Private mName As String 'ignore
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mElement As BANanoElement 'ignore
End Sub

'initialize the custom view
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name.ToLowerCase
	mEventName = EventName.ToLowerCase
	mName = mName.Replace("#","")
	mEventName = mEventName.Replace("#","")
	mCallBack = CallBack
	'
	If mName <> "" Then
		Dim fKey As String = $"#${mName}"$
		If BANano.Exists(fKey) Then 
			mElement = BANano.GetElement(fKey)
		End If
	End If
End Sub

Sub AddStyle(k As String, v As String)
	Dim m As Map = CreateMap()
	m.Put(k, v)
	'
	Dim j As String = BANano.ToJson(m)
	mElement.SetStyle(j)
End Sub

Sub AddAttr(k As String, v As String)
	mElement.SetAttr(k, v)
End Sub

Sub AddClass(cls As String)
	mElement.AddClass(cls)
End Sub

Sub Append(str As String)
	mElement.Append(str)
End Sub

Sub RemoveAttr(v As String)
	mElement.RemoveAttr(v)
End Sub	

Sub setClasses(cls As String)
	AddClass(cls)
End Sub

Sub setStyles(styles As String)
	Dim mxItems As List = BANanoShared.StrParse(";", styles)
	For Each mt As String In mxItems
		Dim k As String = BANanoShared.MvField(mt,1,"=")
		Dim v As String = BANanoShared.MvField(mt,2,"=")
		AddStyle(k, v)
	Next
End Sub

Sub setAttributes(attrs As String)
	Dim mxItems As List = BANanoShared.StrParse(";", attrs)
	For Each mt As String In mxItems
		Dim k As String = BANanoShared.MvField(mt,1,"=")
		Dim v As String = BANanoShared.MvField(mt,2,"=")
		AddAttr(k, v)
	Next
End Sub
