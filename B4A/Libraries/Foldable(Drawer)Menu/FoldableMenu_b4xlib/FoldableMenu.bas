B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
' ###############################################
' (C) TechDoc G. Becker - http://gbecker.de
' ###############################################
' Custom View:	FoldableMenu
' Language:		B4A
' Designer:		Yes with custom props
' Version:		Alpha 2.5/2020
' Used Libs:	B4XCollections, Core, XUI, StringUtils
' ###############################################
' Usage is Roayalty free for Private and commercial
' use only for B4X-Anywhere Board Members.
' ###############################################

#Event: click (ID as string)

#DesignerProperty: Key: OnlyOne, DisplayName: Open only One, FieldType: boolean,DefaultValue: true, Description: Opens one (true) or mor (false) Branches and Leafs.

#DesignerProperty: Key: MenuBackColor, DisplayName: Menu Background Color, FieldType: Color,DefaultValue: 0xFFFFFFFF, Description: Background color of the menu item.

#DesignerProperty: Key: TitleBackColor, DisplayName: Title Background Color, FieldType: Color,DefaultValue: 0xFFD3D3D3, Description: Background color of the Title
#DesignerProperty: Key: TitleTxtSize, DisplayName: Title Text Size, FieldType: int,DefaultValue: 22, Description: Textsize of the Title.
#DesignerProperty: Key: TitleFont, DisplayName: Tile Font, FieldType: String, DefaultValue: Sans_Serif, List: Sans_Serif|Serif|Monospace|FontAwesome|Material Icons
#DesignerProperty: Key: TitleTxtColor, DisplayName: Title Text Color, FieldType: Color,DefaultValue: 0xFF000000, Description: Color of the Title text.
#DesignerProperty: Key: TitleTxt, DisplayName: Title Text, FieldType: string,DefaultValue: Main Menu, Description: Text of the Title.

#DesignerProperty: Key: BranchBackColor, DisplayName: Branch Background Color, FieldType: Color,DefaultValue: 0xFFFFFFFF, Description: Background color of the Branch.
#DesignerProperty: Key: BranchTxtSize, DisplayName: Branch Text Size, FieldType: int,DefaultValue: 18, Description: Textsize of the Branch menu item text.
#DesignerProperty: Key: BranchTxtFont, DisplayName: Branch Font, FieldType: String, DefaultValue: Sans_Serif, List: Sans_Serif|Serif|Monospace|FontAwesome|Material Icons
#DesignerProperty: Key: BranchTxtColor, DisplayName: Branch Text Color, FieldType: Color,DefaultValue: 0xFF000000, Description: Color of the branch item text.

#DesignerProperty: Key: LeafBackColor, DisplayName: Leaf Background Color, FieldType: Color,DefaultValue: 0xFFFFFFFF, Description: Background color of the Leaf.
#DesignerProperty: Key: LeafTxtSize, DisplayName: Leaf Text Size, FieldType: int,DefaultValue: 14, Description: Textsize of the Leaf menu item text.
#DesignerProperty: Key: LeafTxtFont, DisplayName: Leaf Font, FieldType: String, DefaultValue: Sans_Serif, List: Sans_Serif|Serif|Monospace|FontAwesome|Material Icons
#DesignerProperty: Key: LeafTxtColor, DisplayName: Leaf Text Color, FieldType: Color,DefaultValue: 0xFF000000, Description: Color of the leaf item text.

#DesignerProperty: Key: ImgHeight, DisplayName: Image Height, FieldType: int,DefaultValue: 36, Description: Height of the leading bitmap.
#DesignerProperty: Key: ImgWidth, DisplayName: Image Width, FieldType: int,DefaultValue: 36, Description: Width of the leading bitmap.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private pnl As Panel
	Private ItemPnl As Panel
	Private iProps As Map
	Private iv As ImageView
	Private labl As Label
	Private onlyOneFlag As String
	Private su As StringUtils
	Private scv As ScrollView
	
	Public MenuItems As B4XOrderedMap
	
	Type MenuItem ( _
		Branch As Boolean, _
		HasLeafs As Boolean, _
		img As Bitmap, _
		Txt As String, _
		Tg As String, _
		ParentID As String, _
		Show As Boolean)
		
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	pnl.Initialize("pnl")
	ItemPnl.Initialize("item")
	iProps.Initialize
	MenuItems.Initialize
	MenuItems.Keys.Sort(True)
End Sub

'Base type must be Object
' ## Vers. 2.4 added scrollview and put pnl as child view
Public Sub DesignerCreateView (Base As Object, lbl As Label, props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	' save props map for further usage
	iProps = props

	' mainpanel setup
	pnl.Color=props.Get("MenuBackColor")
	pnl.Width =mBase.Width : pnl.height=2*mBase.height

	' add mscrollview to layout (2.4)
	scv.Initialize(mBase.height)
	scv.Width = mBase.width
	scv.Panel.Height=pnl.height
	scv.Panel.AddView(pnl,0,0,pnl.Width,pnl.Height)
	mBase.AddView(scv,0,0,mBase.Width,mBase.height)

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

' ## build one menu branch or leaf and poulate MenuItems Map
Public Sub buildItem( _
	Id As String, _
	ParentId As String, _
	Branch As Boolean, _
	HasLeafs As Boolean, _
	Img As Bitmap, _
	Text As String)
	
	Dim item As MenuItem
	item.Branch=Branch
	item.HasLeafs=HasLeafs
	item.img = Img
	item.Txt = Text
	item.ParentID = ParentId
	
	Try
		MenuItems.put(Id,item)
	Catch
		xui.MsgboxAsync(LastException,"Build Menu Item")
	End Try
End Sub

' ## build the menu
' ## Vers. 2.2 iv.Gravity=Fill implemented
' ## Vers. 2.3 auto label height, dip in iv
Public Sub buildMenu()
	Try
		Dim row As Int =0
		Dim parentID As String =""
		
		' build the menu tree
		If MenuItems.Size > 0 Then
			
			' sort map ascending
			MenuItems.Keys.Sort(True)
				
			' clear main panel
			pnl.RemoveAllViews
		
			' set title parameter
			Dim lb As Label
			lb.Initialize("lb")
			lb.TextSize = iProps.Get("TitleTxtSize")
			lb.Width = pnl.Width
			' find best possible labelheight depending on textsize
			' add 20dip foe bottom padding
			lb.height=su.MeasureMultilineTextHeight(lb, lb.Text) + 20dip
			lb.Color = iProps.Get("TitleBackColor")
			lb.TextColor = iProps.Get("TitleTxtColor")
			Select iProps.Get("TitleFont")
				Case "Sans_Serif"
					lb.Typeface = Typeface.SANS_SERIF
				Case "Serif"
					lb.Typeface = Typeface.SERIF
				Case "Monospace"
					lb.Typeface = Typeface.MONOSPACE
				Case "FontAwesome"
					lb.Typeface = Typeface.FONTAWESOME
				Case "Material Icons"
					lb.Typeface = Typeface.MATERIALICONS
			End Select
			lb.Text = iProps.Get("TitleTxt")
			lb.Gravity = Typeface.STYLE_BOLD
			lb.Gravity= Bit.Or(Gravity.CENTER_VERTICAL, Gravity.CENTER_HORIZONTAL)
			' add title
			pnl.AddView(lb,0,0,pnl.Width,lb.height)
			row = row + lb.height  + 20' next menu row, padding bottom 20
			
			For  each k In MenuItems.keys
				' get menu item defintion from map
				Dim mItem As MenuItem
				mItem.Initialize
				mItem = MenuItems.Get(k)
				' save parent id
				parentID = mItem.ParentID
				' set item pamel parameters
				ItemPnl.Initialize("item")
				ItemPnl.tag =  k 'used for click Event
				ItemPnl.RemoveAllViews
				ItemPnl.Height = DipToCurrent(iProps.get("ImgHeight")) ' 2.3
				ItemPnl.Width = pnl.width
				' if item is a branch build the item panel
				If mItem.Branch = True Then
					' ITEMPANEL ---------------
					' set item panel parameter
					ItemPnl.Color = iProps.Get("BranchBackColor")
					
					' BITMAP  ---------------
					' bitmap has left padding 20dip
					' set image view parameter
					iv.Initialize("item") ' click event
					iv.Height = DipToCurrent(iProps.get("ImgHeight")) ' 2.3
					iv.Width=DipToCurrent(iProps.get("ImgWidth")) ' 2.3
					iv.Gravity = Gravity.FILL
					If mItem.img.IsInitialized Then
						iv.Bitmap=mItem.img					
					End If
					iv.Tag = k  'used for click Event
					' LABEL  ---------------
					' label has left padding 20dip
					' set label parameter
					labl.Initialize("item") ' click event
					labl.Height = iv.Height
					labl.Width = ItemPnl.Width - 20 -iv.Width -20
					labl.TextColor = iProps.Get("BranchTxtColor")
					labl.Gravity = Typeface.STYLE_BOLD
					labl.Gravity= Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
					labl.Tag= k 'used for click Event
					labl.Text = mItem.Txt
					labl.TextSize=iProps.Get("BranchTxtSize")
					Select iProps.Get("BranchTxtFont")
					Case "Sans_Serif"
						labl.Typeface = Typeface.SANS_SERIF
					Case "Serif"
							labl.Typeface = Typeface.SERIF
					Case "Monospace"
							labl.Typeface = Typeface.MONOSPACE
					Case "FontAwesome"
							labl.Typeface = Typeface.FONTAWESOME
					Case "Material Icons"
							labl.Typeface = Typeface.MATERIALICONS
					End Select
		
					' add bitmap and label to item panel
					ItemPnl.AddView(iv,20,0,iv.Width,iv.Height)
					ItemPnl.addview(labl,20+iv.Width+20,0,labl.width,iv.Height)
					
					' add item panel to main panel
					pnl.AddView(ItemPnl,0,row,mBase.Width,ItemPnl.height)
					row = row +ItemPnl.Height +10 ' next menu row
					
				Else 'ist a leaf
					
					If mItem.Show = True Then
						' ITEMPANEL ---------------
						' set item panel parameter
						ItemPnl.Color = iProps.Get("LeafBackColor")
					
						' BITMAP  ---------------
						' bitmap has left padding 20dip
						' set image view parameter
						iv.Initialize("item") ' click event
						iv.Height = DipToCurrent(iProps.get("ImgHeight"))' 2.3
						iv.Width=DipToCurrent(iProps.get("ImgWidth"))' 2.3
						iv.Gravity = Gravity.FILL
						If mItem.img.IsInitialized Then
							iv.Bitmap=mItem.img
						End If
						iv.Tag = k  'used for click Event
						' LABEL  ---------------
						' label has left padding 20dip
						' set label parameter
						labl.Initialize("item") ' click event
						labl.Height = iv.Height
						labl.Width = ItemPnl.Width - 20 -iv.Width - 20 - iv.Width - 20
						labl.TextColor = iProps.Get("LeafTxtColor")
						'labl.Gravity = Typeface.STYLE_BOLD
						labl.Gravity= Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
						labl.Tag= k 'used for click Event
						labl.Text = mItem.Txt
						labl.TextSize=iProps.Get("LeafTxtSize")
						Select iProps.Get("LeafTxtFont")
							Case "Sans_Serif"
								labl.Typeface = Typeface.SANS_SERIF
							Case "Serif"
								labl.Typeface = Typeface.SERIF
							Case "Monospace"
								labl.Typeface = Typeface.MONOSPACE
							Case "FontAwesome"
								labl.Typeface = Typeface.FONTAWESOME
							Case "Material Icons"
								labl.Typeface = Typeface.MATERIALICONS
						End Select	
						' add bitmap and label to item panel
						ItemPnl.AddView(iv,20 + iv.Width + 20,0,iv.Width,iv.Height)
						ItemPnl.addview(labl,20 + iv.Width + 20 + iv.width+20,0,labl.width,iv.Height)
						
						' add item panel to main panel
						pnl.AddView(ItemPnl,0,row,mBase.Width,ItemPnl.height)
						row = row +ItemPnl.Height +10 ' next menu row
					End If
				End If
			Next
			scv.Invalidate 'redraw scv content - 2.4
		End If
	Catch
		xui.MsgboxAsync(LastException,"Build Menu")
	End Try
End Sub

' ## Item click event for all branche and all leaf items
' ## Vers. Alpha 2.3 implement OnlyOny
' ## Vers. Alpha 2.3 implement auto close/open
private Sub item_click
	Try
		Dim cItem As B4XView=Sender
		Dim item As MenuItem
		Dim ID As String
		Dim ParentID As String = "0"
		
		' get menu item
		ID = cItem.tag
		item = MenuItems.Get(ID)
		' if a branch is clicked
		If item.Branch = True Then
			ParentID = ID
			' if branch has no leafs/children
			' then do action
			If item.HasLeafs = False Then
				' do action for branches without leafs
				' other activity/page selected call activity/page event
				' to load new activity/page
				If SubExists(mCallBack,"FoldableMenu1_click") Then
					CallSub2(mCallBack,"FoldableMenu1_Click",ID)
				End If
			Else ' toggle leafs visibility
				' close old branch clicked
				If (onlyOneFlag = "" Or onlyOneFlag <> ID) And iProps.Get("OnlyOne") = True Then '(2.5)
					For Each k As String In MenuItems.Keys
						item = MenuItems.Get(k)
						If item.ParentID = onlyOneFlag Then
							item.Show=False
						End If
					Next
					onlyOneFlag=ID
					buildMenu
				End If
				' open new branch clicked
				If (onlyOneFlag = "" Or onlyOneFlag = ID) And iProps.Get("OnlyOne") = True Then ' 2.3				
					For Each k As String In MenuItems.Keys
						item = MenuItems.Get(k)
						If item.ParentID = ID Then
							item.Show=Not(item.show)
							If item.Show = True Then 
								onlyOneFlag=item.parentid
							Else
								onlyOneFlag=""
							End If
						End If
					Next
					' rebuild menu
					buildMenu
				Else if (onlyOneFlag = "" Or onlyOneFlag = ID) And iProps.Get("OnlyOne") = False Then ' 2.3
					item = MenuItems.Get(k)
					For Each k As String In MenuItems.Keys
						item = MenuItems.Get(k)
						If item.ParentID = ID Then
							item.Show=Not(item.show)
							onlyOneFlag=""
						End If
					Next
					' rebuild menu
					buildMenu
				End If
			End If
		Else' a leaf is clicked
			' other activity/page selected call activity/page event
			' to load new activity/page
			If SubExists(mCallBack,"FoldableMenu1_click") Then
				CallSub2(mCallBack,"FoldableMenu1_Click",ID)
			End If	
		End If
	Catch
		xui.MsgboxAsync(LastException,"Menu Item clicked")
	End Try
End Sub

' ###############################################
' (C) TechDoc G. Becker - http://gbecker.de
' ###############################################
