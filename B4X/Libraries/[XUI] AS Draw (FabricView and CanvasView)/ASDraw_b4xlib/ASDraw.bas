B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.801
@EndOfDesignText@
'Name: ASDraw
'Author: Alexander Stolte
'Version: 1.08
#If Focumentation
Changelog:
V1.0
	-Release
V1.01
	-Fix B4J draw bug
	-Fix import
	-Fix resize
V1.02
	-Add Property BackgroundImage_setImage - sets a background iamge behind the drawing
	-Add Property BackgroundImage - gets the background image
	-Add Event Touch
V1.03
	-Add new mode to DrawMode: Line
V1.04
	-Bug Fixes
V1.05
	-Add CropImageOnExport - exports the image with its dimensions and from the painted
V1.06	
	-Add RotateImage - rotate the background image to the degree you want
V1.07
	-BugFix better resize handling with background images
V1.08
	-Intern Function IIF renamed to iif2
V1.09
	-BugFix - ExportDrawing
	-Intern Function iif2 replaced with the core iif function
V1.10
	-BugFixes
#End If

#DesignerProperty: Key: Enable, DisplayName: Enable, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: DrawMode, DisplayName: Draw Mode, FieldType: String, DefaultValue: Draw, List: Draw|Erase|Line
#DesignerProperty: Key: StrokeWidth, DisplayName: Stroke Width, FieldType: Float, DefaultValue: 5
#DesignerProperty: Key: StrokeColor, DisplayName: Stroke Color, FieldType: Color, DefaultValue: 0xFF000000

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: Touch (Action As Int, XY As Map)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private xpnl_base As B4XView
	Private xiv_base As B4XView
	Private xiv_backgroundimage As B4XView

	Private xbc_main As BitmapCreator

	Private isini_xcv As Boolean = False
	
	Private xp_main2 As BCPath
	Private lst_items As List
	Private current_index As Int = 0
	Private g_x,g_y As Float
	'Properties
	Private g_enable As Boolean
	Private g_drawmode As String
	Private g_strokewidth As Float
	Private g_strokecolor As Int
	
	Private g_backgroundcolor As Int
	
	Private g_cropimageonexport As Boolean
	Private g_KeepAspectRatio As Boolean = False
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lst_items.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	ini_props(Props)
  
	xpnl_base = xui.CreatePanel("xpnl_base")
	xiv_backgroundimage = CreateImageView("")
	xiv_base = CreateImageView("")
	
	#if B4J
	Dim jo As JavaObject = xiv_base
	jo.RunMethod("setMouseTransparent", Array(True))
	Dim jo As JavaObject = xiv_backgroundimage
	jo.RunMethod("setMouseTransparent", Array(True))
    #End If
	
	mBase.AddView(xpnl_base,0,0,mBase.Width,mBase.Height)
	mBase.AddView(xiv_backgroundimage,0,0,mBase.Width,mBase.Height)
	mBase.AddView(xiv_base,0,0,mBase.Width,mBase.Height)
  #if b4a 
  Base_Resize(mBase.Width,mBase.Height)
#End If
  
End Sub

Private Sub ini_props(Props As Map)
	g_enable = Props.Get("Enable")
	g_drawmode = Props.Get("DrawMode")
	g_strokewidth = Props.Get("StrokeWidth")
	g_strokecolor = xui.PaintOrColorToColor(Props.Get("StrokeColor"))
	g_backgroundcolor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xpnl_base.SetLayoutAnimated(0,0,0,Width,Height)
	xiv_backgroundimage.SetLayoutAnimated(0,0,0,Width,Height)
	xiv_base.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_base.Color = g_backgroundcolor
	mBase.Color = g_backgroundcolor
  
	If xpnl_base.Width > 0 And xpnl_base.Height > 0 And isini_xcv = False Then
		xbc_main.Initialize(Width,Height)
		isini_xcv = True
		Else
		xbc_main.Initialize(Width,Height)
		For i = 0 To lst_items.Size -1
			Dim tmp_i As Map = lst_items.Get(i)
			Dim tmp_bcp As BCPath = tmp_i.Get("draw_path")
			'xbc_main.drawar
			For Each tmp_ibcpd As InternalBCPathPointData In tmp_bcp.Points
				xbc_main.DrawCircle(tmp_ibcpd.X,tmp_ibcpd.y,tmp_i.Get("stroke_width")/2,tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
			Next
			xbc_main.DrawPath(tmp_i.Get("draw_path"),tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
		Next
		xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
	End If
	
	If xiv_backgroundimage.IsInitialized = True And xiv_backgroundimage.GetBitmap.IsInitialized = True And xiv_backgroundimage.GetBitmap <> Null Then
		xiv_backgroundimage.SetBitmap(xiv_backgroundimage.GetBitmap.Resize(Width,Height,g_KeepAspectRatio))
	End If
End Sub

Private Sub xpnl_base_Touch (Action As Int, X As Float, Y As Float)
	If g_enable = True Then
		If xui.SubExists(mCallBack, mEventName & "_Touch",2) Then
			CallSub3(mCallBack, mEventName & "_Touch",Action,CreateMap("X": X,"Y":Y))
		End If
		
		
		If Action = xpnl_base.TOUCH_ACTION_DOWN Then
			Dim tmp_bcp As BCPath
			tmp_bcp.Initialize(X,Y)
			g_x = X
			g_y = y
			xp_main2 = tmp_bcp
			xp_main2.LineTo(x,y)
			xbc_main.DrawCircle(X,Y,g_strokewidth/2,IIf(g_drawmode = DrawMode_DRAW,g_strokecolor,xui.Color_Transparent),False,g_strokewidth)
			xbc_main.DrawPath(xp_main2,IIf(g_drawmode = DrawMode_DRAW,g_strokecolor,xui.Color_Transparent),False,g_strokewidth)
			xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
		Else if Action = xpnl_base.TOUCH_ACTION_MOVE Then
			If g_drawmode = DrawMode_LINE Then
			
				xbc_main.Initialize(mBase.Width,mBase.Height)

				If lst_items.Size > 0 Then
					
				For i = 0 To current_index
					Dim tmp_i As Map = lst_items.Get(i)
					Dim tmp_bcp As BCPath = tmp_i.Get("draw_path")
					For Each tmp_ibcpd As InternalBCPathPointData In tmp_bcp.Points
						xbc_main.DrawCircle(tmp_ibcpd.X,tmp_ibcpd.y,tmp_i.Get("stroke_width")/2,tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
					Next
					xbc_main.DrawPath(tmp_i.Get("draw_path"),tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
				Next
				xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
			End If
			
				Dim tmp_bcp As BCPath
				tmp_bcp.Initialize(g_x,g_y)
				xp_main2 = tmp_bcp
				xp_main2.LineTo(x,y)
				
				xbc_main.DrawCircle(g_x,g_y,g_strokewidth/2,g_strokecolor,False,g_strokewidth) 'begin
				xbc_main.DrawCircle(x,y,g_strokewidth/2,g_strokecolor,False,g_strokewidth) 'end
				xbc_main.DrawPath(xp_main2,g_strokecolor,False,g_strokewidth)
				xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
			Else
				xp_main2.LineTo(x,y)
				xbc_main.DrawCircle(X,Y,g_strokewidth/2,IIf(g_drawmode = DrawMode_DRAW,g_strokecolor,xui.Color_Transparent),False,g_strokewidth)
				xbc_main.DrawPath(xp_main2,IIf(g_drawmode = DrawMode_DRAW,g_strokecolor,xui.Color_Transparent),False,g_strokewidth)
				xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
			End If
		Else if Action = xpnl_base.TOUCH_ACTION_UP Then
					
				If current_index < lst_items.Size -1 Then
					For i = current_index To lst_items.Size
						If current_index < (lst_items.Size -1) Then
							lst_items.RemoveAt(current_index +1)
						End If
					Next
			
				End If
				If g_drawmode = DrawMode_LINE Then
					lst_items.Add(CreateItems(g_strokewidth,g_strokecolor,xp_main2))
				Else
					lst_items.Add(CreateItems(g_strokewidth,IIf(g_drawmode = DrawMode_DRAW,g_strokecolor,xui.Color_Transparent),xp_main2))
				End If
			
				current_index = lst_items.Size -1		
		End If
	End If
End Sub

Public Sub Undo
	If (current_index) > -1 And lst_items.Size > 0 Then
		'xcv_main.ClearRect(xcv_main.TargetRect)
		'Dim tm As BitmapCreator
		xbc_main.Initialize(mBase.Width,mBase.Height)

		For i = 0 To current_index -1
			Dim tmp_i As Map = lst_items.Get(i)
			Dim tmp_bcp As BCPath = tmp_i.Get("draw_path")			
			'xbc_main.drawar
			For Each tmp_ibcpd As InternalBCPathPointData In tmp_bcp.Points
				xbc_main.DrawCircle(tmp_ibcpd.X,tmp_ibcpd.y,tmp_i.Get("stroke_width")/2,tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))				
			Next		
			xbc_main.DrawPath(tmp_i.Get("draw_path"),tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
		Next		
		xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
		current_index = current_index -1
	End If
End Sub

Public Sub Redo
	If (current_index +1) < lst_items.Size Then
		current_index = current_index +1
		Dim tmp_i As Map = lst_items.Get(current_index)
		'xcv_main.DrawPath(tmp_i.Get("draw_path"),tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
		'xcv_main.Invalidate
		Dim tmp_bcp As BCPath = tmp_i.Get("draw_path")
		For Each tmp_ibcpd As InternalBCPathPointData In tmp_bcp.Points
			xbc_main.DrawCircle(tmp_ibcpd.X,tmp_ibcpd.y,tmp_i.Get("stroke_width")/2,tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
		Next
		xbc_main.DrawPath(tmp_i.Get("draw_path"),tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
		xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
	End If
End Sub

'it is better to set 90 degrees steps
Public Sub RotateImage(degrees As Int)
	xiv_backgroundimage.SetBitmap(xiv_backgroundimage.GetBitmap.Rotate(degrees).Resize(xiv_backgroundimage.Width,xiv_backgroundimage.Height,True))
End Sub

Public Sub Clear
	xbc_main.Initialize(mBase.Width,mBase.Height)
	xiv_base.SetBitmap(Null)
	lst_items.Clear
End Sub

Private Sub  CreateItems (stroke_width As Float, stroke_color As Int, draw_path As BCPath) As Map
	Dim t1 As Map
	t1.Initialize
	t1.Put("stroke_width",stroke_width)
	t1.Put("stroke_color",stroke_color)
	t1.Put("draw_path",draw_path)
	Return t1
End Sub

'import a exported list of drawings
'new: if false then the items in the list are added to the existing ones
'new: if true then the intern list is reset
Public Sub ImportDrawing(drawings As List,new As Boolean)
	If new = True Then
		lst_items.Clear
		lst_items = drawings
		Else			
			For Each tmp_map As Map In drawings
				lst_items.Add(tmp_map)
			Next		
	End If	
	current_index = lst_items.Size -1
	
	xbc_main.Initialize(mBase.Width,mBase.Height)
	For i = 0 To lst_items.Size -1
		Dim tmp_i As Map = lst_items.Get(i)
		Dim tmp_bcp As BCPath = tmp_i.Get("draw_path")
		'xbc_main.drawar
		For Each tmp_ibcpd As InternalBCPathPointData In tmp_bcp.Points
			xbc_main.DrawCircle(tmp_ibcpd.X,tmp_ibcpd.y,tmp_i.Get("stroke_width")/2,tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
		Next
		xbc_main.DrawPath(tmp_i.Get("draw_path"),tmp_i.Get("stroke_color"),False,tmp_i.Get("stroke_width"))
	Next
	xbc_main.SetBitmapToImageView(xbc_main.Bitmap,xiv_base)
	
End Sub

'export the drawing as list to import this later or to save it for later use, for example: the user make a break
Public Sub ExportDrawing As List
	
	Dim NewList As List
	NewList.Initialize
	
	For Each Item As Object In lst_items
		NewList.Add(Item)
	Next
	
	Return NewList
End Sub

#Region Enums

Public Sub DrawMode_DRAW As String
	Return "Draw"
End Sub

Public Sub DrawMode_ERASE As String
	Return "Erase"
End Sub

Public Sub DrawMode_LINE As String
	Return "Line"
End Sub

#End Region

#Region Properties

Public Sub getCropImageOnExport As Boolean
	Return g_cropimageonexport
End Sub

Public Sub setCropImageOnExport(b As Boolean)
	 g_cropimageonexport = b
End Sub

'gets the background image
Public Sub getBackgroundImage As B4XBitmap
	Dim tmp_biv As ImageView = xiv_backgroundimage
	#if B4J
	Return tmp_biv.GetImage
	#Else
	Return tmp_biv.Bitmap
	#End if
End Sub

'sets a background image
Public Sub BackgroundImage_setImage(image As B4XBitmap,KeepAspectRatio As Boolean)
	g_KeepAspectRatio = KeepAspectRatio
	xiv_backgroundimage.SetBitmap(image.Resize(xiv_backgroundimage.Width,xiv_backgroundimage.Height,KeepAspectRatio))
End Sub

'gets or sets the draw enable, if false then the touch event is ignored
Public Sub getEnable As Boolean
	Return g_enable
End Sub

Public Sub setEnable(enable As Boolean)
	g_enable = enable
End Sub

Public Sub setDrawMode(mode As String)
	g_drawmode = mode
End Sub

Public Sub getDrawMode As String
	Return g_drawmode
End Sub

'gets the complete view as image
Public Sub getImageComplete As B4XBitmap
	If g_cropimageonexport And xiv_backgroundimage.GetBitmap.IsInitialized Then
		
		Dim smallest_top As Float = xiv_backgroundimage.Height/2 - xiv_backgroundimage.GetBitmap.Height/2
		Dim heigehst_top As Float = xiv_backgroundimage.GetBitmap.Height
		If lst_items.Size <> 0 Then
		For i = 0 To current_index
		'For i = 0 To lst_items.Size -1
		
			Dim tmp_i As Map = lst_items.Get(i)
			Dim tmp_bcp As BCPath = tmp_i.Get("draw_path")
			'xbc_main.drawar
			For Each tmp_ibcpd As InternalBCPathPointData In tmp_bcp.Points
				
				If tmp_ibcpd.y < smallest_top Then
					smallest_top = tmp_ibcpd.Y - tmp_i.Get("stroke_width")
					
				End If
				
				If tmp_ibcpd.Y > heigehst_top Then
					heigehst_top = tmp_ibcpd.Y + tmp_i.Get("stroke_width")
				End If
				
			Next
		Next
		End If
		'smallest_top = Max(0,smallest_top -1)
		'heigehst_top = Min(xiv_backgroundimage.Height,heigehst_top +1)
		Return mBase.Snapshot.Crop(xiv_backgroundimage.Width/2 - xiv_backgroundimage.GetBitmap.Width/2,smallest_top,xiv_backgroundimage.GetBitmap.Width,heigehst_top)
		'Return mBase.Snapshot.Crop(xiv_backgroundimage.Width/2 - xiv_backgroundimage.GetBitmap.Width/2,xiv_backgroundimage.Height/2 - xiv_backgroundimage.GetBitmap.Height/2,xiv_backgroundimage.GetBitmap.Width,xiv_backgroundimage.GetBitmap.Height)
		Else
		Return mBase.Snapshot
	End If
End Sub

'gets the drawing as image
Public Sub getImage As B4XBitmap
	Dim tmp_iv As ImageView = xiv_base
	#If B4J
	Return tmp_iv.GetImage
	#Else
	Return tmp_iv.Bitmap
	#End If
End Sub

'gets or sets the View Background Color
Public Sub getBackgroundColor As Int
	Return g_backgroundcolor
End Sub

Public Sub setBackgroundColor(color As Int)
	g_backgroundcolor = color
	Base_Resize(mBase.Width,mBase.Height)
End Sub

'gets or sets the thickness of the draw line
Public Sub getStrokeWidth As Float
	Return g_strokewidth
End Sub

Public Sub setStrokeWidth(width As Float)
	g_strokewidth = width
End Sub

'gets or sets the color of the draw line
Public Sub getStrokeColor As Int
	Return g_strokecolor
End Sub

Public Sub setStrokeColor(color As Int)
	g_strokecolor = color
End Sub

#End Region

Private Sub CreateImageView(EventName As String) As B4XView
	Dim tmp_iv As ImageView
	tmp_iv.Initialize(EventName)
	Return tmp_iv
End Sub