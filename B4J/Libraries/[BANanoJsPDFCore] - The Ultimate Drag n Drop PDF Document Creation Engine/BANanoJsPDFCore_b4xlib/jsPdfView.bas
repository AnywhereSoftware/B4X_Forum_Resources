B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#DesignerProperty: Key: FileName, DisplayName: URL, FieldType: String, DefaultValue: , Description: URL
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag. 
#DesignerProperty: Key: Styles, DisplayName: Styles, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String, use = 
#DesignerProperty: Key: Attributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String, use =

Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore 
	Private mTarget As BANanoElement 'ignore 
	Private mElement As BANanoElement 'ignore 
	Private mClasses As String = "" 
	Private mStyles As String = "" 
	Private mAttributes As String = "" 
	Public VElement As BAElement 
	Private sFileName As String
	Private sIFrame As String 
End Sub

Sub Initialize (CallBack As Object, Name As String, EventName As String) 
	mName = Name.tolowercase 
	mEventName = EventName.ToLowerCase 
	mCallBack = CallBack	 
	mName = mName.Replace("#","") 
	mEventName = mEventName.Replace("#","") 
	If mName <> "" Then 
		Dim fKey As String = $"#${mName}"$ 
		If BANano.Exists(fKey) Then  
			mElement = BANano.GetElement(fKey) 
		End If 
	End If 
End Sub

Sub DesignerCreateView (Target As BANanoElement, Props As Map) 
	mTarget = Target 
	If Props <> Null Then 
		mClasses = Props.GetDefault("Classes", "") 
		mStyles = Props.GetDefault("Styles", "") 
		mAttributes = Props.GetDefault("Attributes","") 
		sFileName = Props.GetDefault("FileName", "")
	End If 
	' 
	'build and get the element 
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	' 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.Classes = mClasses 
	VElement.Styles = mStyles 
	VElement.Attributes = mAttributes 
	VElement.AddAttr("width", "100%")
	VElement.AddAttr("height", "100%")
	VElement.AddStyle("width", "100%")
	VElement.AddStyle("height", "100%")
	VElement.AddStyle("max-width", "100%")
	VElement.AddStyle("max-height", "100%")
	'
	'add the iframe
	sIFrame = $"${mName}iframe"$
	VElement.Append($"<iframe id="${sIFrame}"></iframe>"$)
	'
	Dim iFrame As BAElement
	iFrame.Initialize(mCallBack, sIFrame, sIFrame)
	iFrame.AddAttr("width", "100%")
	iFrame.AddAttr("height", "100%")
	iFrame.AddStyle("width", "100%")
	iFrame.AddStyle("height", "100%")
	iFrame.AddStyle("max-width", "100%")
	iFrame.AddStyle("max-height", "100%")
	iFrame.AddAttr("scrolling", "no")
	iFrame.AddAttr("src", sFileName)
End Sub

public Sub Remove() 
	mTarget.Empty 
	BANano.SetMeToNull 
End Sub

Sub AddClass(s As String) 
	VElement.AddClass(s) 
End Sub

Sub AddAttr(p As String, v As Object) 
	VElement.AddAttr(p, v) 
End Sub

Sub AddStyle(p As String, v As String) 
	VElement.AddStyle(p, v) 
End Sub

Sub RemoveAttr(p As String) 
	VElement.RemoveAttr(p) 
End Sub

Sub getID As String 
	Return mName 
End Sub

Sub getHere As String 
	Return $"#${mName}"$ 
End Sub

'change the file name
Sub SetValue(vVModel As String)
	Dim iFrame As BANanoElement
	iFrame.Initialize($"#${sIFrame}"$)
	iFrame.SetField("src", vVModel)
End Sub
