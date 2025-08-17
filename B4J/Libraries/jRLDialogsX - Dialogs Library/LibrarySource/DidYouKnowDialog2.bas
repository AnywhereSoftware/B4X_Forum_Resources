B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#Region Notes
'Class DidYouKnowDialog2 - Provide a did you know dialog with dyk's as list and prev & next dyk selection
'IMPORTANT: Ensure the layout file DidYouKnowDialog2.bjl is added to the jar archive jRLDialogsXFiles.jar in the archive folder Files.
'TODO: Use library CSSUtils to set the style of the header.
'@author Robert W.B. Linn
'@version 20171108
#End Region
Private Sub Class_Globals
	Private fx As JFX
	Private Form_Dialog As Form
	Private Label_Header As Label
	Private ImageView_Icon As ImageView
	Private TextArea_Content As TextArea
	Private Button_NextTip As Button
	Private Button_PreviousTip As Button
	Private Button_Close As Button
	' Locals
	Private mItems As List
	Private mItemIndex As Int = 0
	Private Const CRLFPLACEHOLDER As String = "#CRLF#"
	Private Const TABPLACEHOLDER As String = "#TAB#"
End Sub

'Initializes the object.
'Owner - set the owner, i.e.MainForm
'Title - set the title text
'Items - the items as list
'DefaultItem - set the default item between 0 and items.size - 1 or -1 to set the first item
'Width - the dialog width. -1 sets default 500.
'Height - the dialog height. -1 sets default 400
Public Sub Initialize(Owner As Form, Title As String, Header As String, Items As List, DefaultItem As Int, Width As Double, Height As Double)
	If Width < 0 Then Width = 500
	If Height < 0 Then Height = 400
	Form_Dialog.Initialize("frm", Width, Height)
	Form_Dialog.SetFormStyle("UTILITY")
	Form_Dialog.Resizable = False
	Form_Dialog.RootPane.LoadLayout("DidYouKnowDialog2")
	If Owner <> Null Then Form_Dialog.SetOwner(Owner)
	Form_Dialog.Title = Title
	Label_Header.Text = Header
	ImageView_Icon.SetImage(fx.LoadImage(File.DirAssets, "dyk.png"))
	If DefaultItem >= 0 Then mItemIndex = DefaultItem
	mItems = Items
	If mItems.Size > 0 Then
		TextArea_Content.Text = SetDYK(mItems.Get(mItemIndex))
	Else
		TextArea_Content.Text = "There are no Did You Know items"
	End If
End Sub

' NOT USED - Close request handling 
Private Sub Form_ListDialog_CloseRequest (EventData As Event)
'
End Sub

Public Sub ShowAndWait As String
	Form_Dialog.ShowAndWait
	Return mItemIndex
End Sub

#Region Buttons
Private Sub Button_PreviousTip_Action
	If mItemIndex > 0 Then
		mItemIndex = mItemIndex - 1
		TextArea_Content.Text = SetDYK(mItems.Get(mItemIndex))
	End If
End Sub

Private Sub Button_NextTip_Action
	If mItemIndex < mItems.Size - 1 Then
		mItemIndex = mItemIndex + 1
		TextArea_Content.Text = SetDYK(mItems.Get(mItemIndex))
	End If
End Sub

Private Sub Button_Close_Action
	Form_Dialog.Close
End Sub
#End Region

#Region TextArea

'Set the content of the did you know text.
'Placeholders: #CRLF# replaced by CRLF, #TAB# replaced by TAB
Private Sub SetDYK(Content As String) As String
	If Content.ToUpperCase.Contains(CRLFPLACEHOLDER) Then
		Content = Content.Replace(CRLFPLACEHOLDER, CRLF)
	End If
	If Content.ToUpperCase.Contains(TABPLACEHOLDER) Then
		Content = Content.Replace(TABPLACEHOLDER, CRLF)
	End If
	Return Content
End Sub
#End Region

#Region Properties
'Set or get the text of the title.
Public Sub setTitle(Title As String)
	Form_Dialog.Title = Title
End Sub
Public Sub getTitle As String
	Return Form_Dialog.Title
End Sub

'Set or get the text of the header.
Public Sub setHeader(Header As String)
	Label_Header.Text = Header
End Sub
Public Sub getHeader As String
	Return 	Label_Header.Text
End Sub

'Set or get the text of the close button.
Public Sub setButton_CloseText(Text As String)
	Button_Close.Text = Text
End Sub
Public Sub getButton_CloseText As String
	Return Button_Close.Text
End Sub

'Set or get the text of the next tip button.
Public Sub setButton_NextTipText(Text As String)
	Button_NextTip.Text = Text
End Sub
Public Sub getButton_NextTipText As String
	Return Button_NextTip.Text
End Sub

'Set or get the tooltip text of the next tip button.
Public Sub setButton_NextTipToolTipText(Text As String)
	Button_NextTip.TooltipText = Text
End Sub
Public Sub getButton_NextTipToolTipText As String
	Return Button_NextTip.TooltipText
End Sub

'Set or get the tip text of the previous tip button.
Public Sub setButton_PreviousTipText(Text As String)
	Button_PreviousTip.Text = Text
End Sub
Public Sub getButton_PreviousTipText As String
	Return Button_PreviousTip.Text
End Sub

'Set or get the tooltip text of the previous tip button.
Public Sub setButton_PreviousTipToolTipText(Text As String)
	Button_PreviousTip.TooltipText = Text
End Sub
Public Sub getButton_PreviousTipToolTipText As String
	Return Button_PreviousTip.TooltipText
End Sub

'Set or get the style property of the header label.
'Example <code>
'Dim dyk As DYK2Dialog
'lfd.HeaderStyle = "-fx-text-fill:blue;-fx-background-color:white;"
'</code>
Public Sub setHeaderStyle(Style As String)
	Label_Header.Style = Style
End Sub

Public Sub getHeaderStyle As String
	Return Label_Header.Style
End Sub

#End Region
