B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#Region Notes
'Class ListFindDialog - Provide a listview dialog with a find option
'IMPORTANT: Ensure the layout file ListFindDialog.jar is added to the jar archive jRLDialogsXFiles.jar in the archive folder Files.
'TODO: Use library CSSUtils to set the style of the title.
'@author Robert W.B. Linn
'@version 20171026
#End Region
Private Sub Class_Globals
	Private fx As JFX
	Private Form_Dialog As Form
	Private Button_Cancel As Button
	Private Button_Select As Button
	Private ListView_Items As ListView
	Private TextField_FindItem As TextField
	Private Label_Title As Label
	' Locals
	Private mItem As String = ""
End Sub

'Initializes the object.
'Owner - set the owner, i.e.MainForm
'Title - set the title text
'Items - the items as list
'DefaultItem - set the default item between 0 and items.size - 1 or -1 to set the first item
'Width - the dialog width. -1 sets default 300.
'Height - the dialog height. -1 sets default 400
Public Sub Initialize(Owner As Form, Title As String, Items As List, DefaultItem As Int, Width As Double, Height As Double)
	If Width < 0 Then Width = 300
	If Height < 0 Then Height = 400
	Form_Dialog.Initialize("frm", Width, Height)
	Form_Dialog.SetFormStyle("UNDECORATED")
	Form_Dialog.RootPane.LoadLayout("ListFindDialog")
	If Owner <> Null Then Form_Dialog.SetOwner(Owner)
	Label_Title.Text = Title
	If Items.Size > 0 Then
		ListView_Items.Items.AddAll(Items)
		If (DefaultItem <> -1) And (DefaultItem < ListView_Items.Items.Size -1) Then
			ListView_Items.SelectedIndex = DefaultItem
		Else
			ListView_Items.SelectedIndex = 0
			End If
	Else
		ListView_Items.Items.Add("There are no items")
	End If
End Sub

' NOT USED - Close request handling - this is handled by the buttons select or cancel.
Private Sub Form_ListDialog_CloseRequest (EventData As Event)
	If ListView_Items.SelectedIndex = -1 Then EventData.Consume
End Sub

Public Sub ShowAndWait As String
	Form_Dialog.ShowAndWait
	Return mItem
End Sub

Private Sub TextField_FindItem_TextChanged (Old As String, New As String)
	ListView_Items_Select(New)
'	ListView_Items.SelectedIndex = ListView_Items.Items.IndexOf(New)
End Sub

Private Sub TextField_FindItem_Action
' NOT USED	
End Sub

Private Sub ListView_Items_SelectedIndexChanged(Index As Int)
	If Index < 0 Then Return	
	mItem = ListView_Items.Items.Get(Index)
End Sub

'Set the selected item.
Private Sub ListView_Items_Select(Item As String)
	For Each s As String In ListView_Items.Items
		If s.ToLowerCase.StartsWith(Item.ToLowerCase) Then
			ListView_Items.SelectedIndex = ListView_Items.Items.IndexOf(s)
			ListView_Items.ScrollTo(ListView_Items.SelectedIndex)
			Return
		End If
	Next
End Sub

'Handle listview mouse double click.
Private Sub ListView_Items_MouseClicked (EventData As MouseEvent)
	If EventData.ClickCount = 2 Then
		Button_Select_Action
	End If
End Sub

#Region Buttons
Private Sub Button_Select_Action
	Form_Dialog.Close
End Sub

Private Sub Button_Cancel_Action
	mItem = ""
	Form_Dialog.Close
End Sub
#End Region

#Region Properties
'Set or get the visibility of the textfield FindItem
Public Sub setFindItemVisible(Visible As Boolean)
	TextField_FindItem.Visible = Visible
End Sub
Public Sub getFindItemVisible As Boolean
	Return TextField_FindItem.Visible
End Sub

'Set or get the content of the textfield FindItem
Public Sub setFindItem(Value As String)
	TextField_FindItem.Text = Value
End Sub
Public Sub getFindItem As String
	Return TextField_FindItem.Text
End Sub

'Set or get the item selected in the listview.
'Item - text of the item to be selected
Public Sub setItemSelected(Item As String)
	ListView_Items.SelectedIndex = ListView_Items.Items.IndexOf(Item)
End Sub
Public Sub getItemSelected As String
	If ListView_Items.SelectedIndex < 0 Then
		Return ""
	Else
		Return ListView_Items.SelectedItem
	End If
End Sub

'Set or get the text of the title.
Public Sub setTitle(Title As String)
	Label_Title.Text = Title
End Sub
Public Sub getTitle As String
	Return Label_Title.Text
End Sub

'Set or get the text of the textfield find item.
Public Sub setFindItemPromptText(PromptText As String)
	TextField_FindItem.PromptText = PromptText
End Sub
Public Sub getFindItemPromptText As String
	Return TextField_FindItem.PromptText
End Sub

'Set or get the text of the cancel button.
Public Sub setButton_CancelText(Text As String)
	Button_Cancel.Text = Text
End Sub
Public Sub getButton_CancelText As String
	Return Button_Cancel.Text
End Sub

'Set or get the text of the select button.
Public Sub setButton_SelectText(Text As String)
	Button_Select.Text = Text
End Sub
Public Sub getButton_SelectText As String
	Return Button_Select.Text
End Sub

'Set or get the style property of the title label.
'Example <code>
'Dim lfd As ListFindDialog
'lfd.TitleStyle = "-fx-text-fill:blue;-fx-background-color:white;"
'</code>
Public Sub setTitleStyle(Style As String)
	Label_Title.Style = Style
End Sub
Public Sub getTitleStyle As String
	Return Label_Title.Style
End Sub

#End Region
