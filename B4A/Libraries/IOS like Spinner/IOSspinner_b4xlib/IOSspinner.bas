B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#Event: ItemClicked (ID as String, Result as Map)
#DesignerProperty: Key: ID, Displayname: Unique Spinner ID, FieldType: String, DefaultValue: 1
#DesignerProperty: Key: OnlyOne, DisplayName: Click only One, FieldType: Boolean, DefaultValue: false
#DesignerProperty: Key: Type, DisplayName: Type of Control, FieldType: String, DefaultValue: None, List: None|CheckBox|RadioButton
#DesignerProperty: Key: Image, DisplayName: Background image, FieldType: String, DefaultValue: SpinnerBackground.png, Description: Name of the Image file
#DesignerProperty: Key: RowHeight, DisplayName: Item height, FieldType: Int, DefaultValue: 20
#DesignerProperty: Key: TextColor, DisplayName: Text color, FieldType: Color, DefaultValue: 0xFF0000FF
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 14

#region ### clas basic ###
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public MainPanel As Panel
	Public SpinnerProps As Map
	Public SpinnerResult As Map
	Public SpinnerItems As B4XOrderedMap
	Private scv As ScrollView
	Private Row As Int = 0
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	MainPanel.Initialize("item")
	scv.Initialize(100)
	SpinnerProps.Initialize
	SpinnerResult.Initialize
	SpinnerItems.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	' do logic check and correction
	SpinnerProps=Props
	If SpinnerProps.Get("OnlyOne") = True Then
		SpinnerProps.Put("Type","None")
	Else
		If SpinnerProps.get("Type") = "None" Then
			SpinnerProps.Put("Type","CheckBox")
		End If	
	End If
	
	' set scrollview basic values
	scv.Height = mBase.Height '-50dip
	scv.Width = mBase.Width
	scv.Panel.Width = mBase.Width
	
	' set mainpanel basic values
	MainPanel.SetBackgroundImage(LoadBitmap(File.DirAssets,Props.Get("Image")))
	MainPanel.Padding= Array As Int (0,15,0,15dip)
	
	' add scrollview do mainpanel
	MainPanel.AddView(scv,0,15,mBase.width,mBase.Height)
	
	' add mainpanel to base
	mBase.AddView(MainPanel,0,0,mBase.width,mBase.Height)
	
	' bring base to front
	SetElevation(mBase, 10)
	
	' hide base
	mBase.Visible=False
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub
#end region 

' ###########################################################

#region ### scrollview items ###

' build spinner (scrollview) items from SpinnerItems Map
Public Sub Spinner_build

	If SpinnerItems.Size > 0 Then
		
		' remove all items
		SpinnerResult.Clear
		scv.panel.RemoveAllViews
		
		Dim w ,h As Int
		h = SpinnerProps.Get("RowHeight")
		
		' set items
		For Each ID As String In SpinnerItems.Keys
			'creat item panel
			Dim ipnl As Panel: ipnl.initialize("PNL")
			ipnl.Width=scv.width
				
			' create checkbox or radiobutton 
			Dim cb As CheckBox : cb.initialize("CB")
			cb.Checked=False
			cb.Tag=ID
			cb.Width = 50dip:cb.height=DipToCurrent(SpinnerProps.Get("RowHeight"))
			
			Dim rb As RadioButton : rb.initialize("CB")
			rb.Checked=False
			rb.Width=50dip:rb.height=DipToCurrent(SpinnerProps.Get("RowHeight"))
			
			' create label and add to scrollview
			Dim lb As Label : lb.initialize("LB")
			lb.Width = scv.panel.Width - w - 50
			lb.Height = DipToCurrent(h)
			lb.TextSize = SpinnerProps.Get("TextSize")
			lb.TextColor = SpinnerProps.Get("TextColor")
			lb.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.Left)
			lb.Typeface = Typeface.SANS_SERIF
			lb.Text = SpinnerItems.Get(ID)		
			lb.Tag = ID
			ipnl.AddView(lb,0,0,lb.Width,lb.Height)
		
			' add checkbox or radiobutton if OnlyOne = false
			If SpinnerProps.Get("Type") = "CheckBox" And SpinnerProps.Get("OnlyOne") = False Then		
				cb.Checked=False
				cb.Tag=ID
				cb.Width = 50dip:cb.height=DipToCurrent(SpinnerProps.Get("RowHeight"))
				w = cb.width
				h = cb.height
				ipnl.AddView(cb,ipnl.Width - cb.Width,0,cb.Width,cb.Height)
			else if SpinnerProps.Get("Type") = "RadioButton" And SpinnerProps.Get("OnlyOne") = False  Then	
				w = rb.width
				h = rb.height
				rb.Tag=ID
				ipnl.AddView(rb,ipnl.Width - rb.Width,0,rb.Width,rb.Height)
			End If
				
			' set intern panel height
			ipnl.Height =h
			
			' add intern panel to scrollview
			scv.Panel.AddView(ipnl,10,Row,scv.Width,ipnl.Height)
			
			' got to next row
			Row = Row + h + 10
			scv.Panel.Height = DipToCurrent(Row)
			' set row/top value
		Next
		scv.Panel.Height = DipToCurrent(Row) + h
	End If
	
End Sub
#end region

' ###########################################################

#region ### events ###

Sub CB_CheckedChange(Checked As Boolean)
	Dim v As View = Sender
	If SpinnerProps.Get("OnlyOne") = True Then
		SpinnerResult.Clear
		SpinnerResult.Put(v.Tag,Checked)
		close
	Else
		SpinnerResult.Put(v.Tag,Checked)
	End If
End Sub

Sub LB_click
	Dim v As View = Sender
	If SpinnerProps.Get("OnlyOne") =True Then
		SpinnerResult.Clear
		SpinnerResult.Put(v.Tag,False)
		close
	End If
End Sub

Sub LB_LongCLick
	close
End Sub

#end region

' ###########################################################

#region ### helpers ###
Sub SetElevation(v As View, e As Float)
	Dim jo As JavaObject
	Dim p As Phone
   
	If p.SdkVersion >= 21 Then
		jo = v
		jo.RunMethod("setElevation", Array As Object(e))
	End If
End Sub

Sub close
	mBase.Visible=False
	If SubExists(mCallBack,"IOSspinner_ItemClicked") Then
		CallSub3(mCallBack,"IOSspinner_ItemClicked",SpinnerProps.Get("ID"),SpinnerResult)
	End If	
	reset
End Sub

public Sub reset
	For Each v As View In scv.Panel.GetAllViewsRecursive
		If v Is CheckBox Then
			Dim c As CheckBox = v
			c.Checked=False
		Else If v Is RadioButton Then
			Dim r As RadioButton = v
			r.Checked=False
			End If
	Next
	SpinnerResult.Clear
End Sub
#end region
' ###########################################################
' (C) TechDoc G. Becker
' ###########################################################