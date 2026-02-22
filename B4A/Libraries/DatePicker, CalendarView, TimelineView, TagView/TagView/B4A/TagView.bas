B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: ItemClick (index As int, selected as boolean)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object

	Private Items As Map
	Private scrollContent As ScrollView
	Dim tagItems(10) As TagAdapter
End Sub

Public Sub Initialize (Callback As Object, EventName As String, width As Int, height As Int)
	mEventName = EventName
	mCallBack = Callback
		
	mBase.Initialize("mBase")
	scrollContent.Initialize(1000dip)
	mBase.AddView(scrollContent,0,0, width, height)
	'mBase.Color = Colors.DarkGray
End Sub

Private Sub DrawItems()
	Dim positionX As Int = 0
	Dim positionY As Int = 0
	
	Dim tagItems(Items.Size) As TagAdapter
	
	For i=0 To Items.Size - 1
		
		tagItems(i).Initialize(Me, "TagAdapter1", 420dip, 25dip, Items.GetKeyAt(i))
		scrollContent.Panel.AddView(tagItems(i).GetView, positionX, positionY, 400dip, 25dip)
		tagItems(i).Text = Items.GetKeyAt(i)
		tagItems(i).Tag = i
		If Items.GetValueAt(i) = True Then
			tagItems(i).isSelected(True)
		Else
			tagItems(i).isSelected(False)
		End If
		
		positionX = positionX + tagItems(i).Width + 5dip
		
		If ((positionX + 100dip) > scrollContent.Width) Then
			positionX = 0
			positionY = positionY + 30dip
		End If		
		
	Next
End Sub

Public Sub SetItems(value As Map)
	Items = value
	DrawItems
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub AddItem(Key As String, selected As Boolean)
	Items.Put(Key, selected)
End Sub

Public Sub GetView() As Panel
	Return mBase
End Sub

Public Sub GetSelectedItem() As List
	Dim result As List
	result.Initialize
	
	For i=0 To Items.Size - 1
		If tagItems(i).Selected = True Then
			Dim t As String = tagItems(i).Text
			result.Add(t)
		End If		
	Next
	
	Return result
End Sub

Sub TagAdapter1_Click(index As String)
	Dim ta As TagAdapter = Sender	
	CallSub3(mCallBack, mEventName & "_ItemClick", ta.Tag, ta.Selected)
End Sub