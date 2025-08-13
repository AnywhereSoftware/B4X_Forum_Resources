B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Dim version As String = 0.35
	Private Root As B4XView
	Private xui As XUI
	Private butRefresh As B4XView
	Private butTest As B4XView

	Private b4xVectEdit_component1, b4xVectEdit_component2, b4xVectEdit_component3 As b4xVectEdit_component
	Private Editor As B4XView	

	Dim scale As Double = 1
	Dim start_scale As Double = 1.0
	Dim scale_step As Double = 0.2
	Dim MinScale As Float = 0.1
	Dim MaxScale As Float = 5
	Dim DefaultAreaSide As Int = 3000dip
	Private DownX, DownY As Int, Dragging As Boolean, DraggingStart As Long	'ignore
	Private MouseX, MouseY As Double
	
	Dim objs As List, LeftTops, WidthHeights As Map
	Private Area As B4XView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "v." & version)
	LeftTops.Initialize
	WidthHeights.Initialize
	objs.Initialize
	butRefresh_Click
		
	xui.MsgboxAsync("LeftMouseButton - drag objects, RMB - move work area, wheel - zoom." & CRLF & "Component right-clickable, pins - left- and right-clickable", "CAD-interface")
End Sub

Sub Init_Area
	Editor.SetLayoutAnimated(0, 0, 0, DefaultAreaSide, DefaultAreaSide)
	Scale_Editor(start_scale)
End Sub

Sub Generate_Diagram
'	Editor.LoadLayout("test")
'	For Each v As B4XView In Editor.GetAllViewsRecursive
'		objs.Add(v)
'	Next
'	
'	Return
'	'----------or uncomment -------------------
	
	Private b4xVectEdit_component1, b4xVectEdit_component2, b4xVectEdit_component3 As b4xVectEdit_component
	
	If b4xVectEdit_component1.IsInitialized = False Then
		objs.Add(b4xVectEdit_component1.Initialize(Me, "VectorComponent"))
		b4xVectEdit_component1.Name = "Unit1"
		b4xVectEdit_component1.DesignerCreateView(Editor, Null, Null)
	End If
	b4xVectEdit_component1.Base_Resize(500dip, 500dip)
	
	If b4xVectEdit_component2.IsInitialized = False Then
		objs.Add(b4xVectEdit_component2.Initialize(Me, "VectorComponent"))
		b4xVectEdit_component2.Name = "Unit2"
		b4xVectEdit_component2.DesignerCreateView(Editor, Null, Null)
	End If
	b4xVectEdit_component2.Base_Resize(100dip, 300dip)

	If b4xVectEdit_component3.IsInitialized = False Then
		objs.Add(b4xVectEdit_component3.Initialize(Me, "VectorComponent"))
		b4xVectEdit_component3.InternalView = True
		b4xVectEdit_component3.Name = "Unit3_internal"
		b4xVectEdit_component3.DesignerCreateView(b4xVectEdit_component1.mRect.mBase, Null, Null)
	End If
	b4xVectEdit_component3.Base_Resize(200dip, 220dip)
	b4xVectEdit_component3.mRoot.Left = 65dip
	
	Editor.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_ARGB(50, 0, 0, 0), 0)	'transparent container
End Sub

Sub setHandler(ob As JavaObject, eventName As String, handlerName As String)
	ob.RunMethod(eventName, Array(ob.CreateEventFromUI("javafx.event.EventHandler",handlerName,True)))
End Sub

Sub scroll_Event(MethodName As String, Args() As Object)
	Dim jo As JavaObject
	jo.InitializeStatic("javafx.scene.input.ScrollEvent")
	jo = Args(0)
	Dim delta As Float = jo.RunMethod("getDeltaY", Null)

	'If Main.KEY_CTRL_PRESSED Then
		If delta > 0 And scale <= MaxScale Then
			scale = scale + scale_step
		End If
		If delta < 0 And scale >= MinScale Then
			scale = scale - scale_step
			scale = Max(MinScale, scale)
		End If
		
		Dim obj As B4XView = Editor.GetView(0)
		
		Dim PrevLeft As Double = obj.Left
		Dim PrevTop As Double = obj.Top

		Scale_Editor(scale)

		Editor.Left = Editor.Left + (PrevLeft - obj.Left)
		Editor.Top = Editor.Top + (PrevTop - obj.Top)

		
		B4XPage_Resize(Root.Width, Root.Height)

'		Log("Area: " & Area.Left & ", " & Area.Top & ", " & Area.Width & ", " & Area.Height)
'		Log("Editor: " & Editor.Left & ", " & Editor.Top & ", " & Editor.Width & ", " & Editor.Height)
'		Log("MouseX,Y = " & MouseX & ", " & MouseY)
	'End If
End Sub

Private Sub B4XPage_Resize (Width As Double, Height As Double)
	Editor.Width = DefaultAreaSide * scale
	Editor.Height = DefaultAreaSide * scale
'	For i = objs.Size - 1 To 0 Step -1
'		Dim obj As b4xVectEdit_component = objs.Get(i)
'		obj.Scale = scale
'		obj.Base_Resize(obj.mBase.Width, obj.mBase.Height)
'	Next
End Sub

Private Sub butRefresh_Click
	Editor.RemoveAllViews
	Init_Area
	
	For i = objs.Size - 1 To 0 Step -1
		objs.RemoveAt(i) ' will remove the reference from list which in turn (assuming nothing else reference that object) will make the original object available to GC
	Next

	Generate_Diagram	'create the work area
	
	LeftTops.Initialize
	WidthHeights.Initialize
	Save_Dimensions(Editor, scale, True)
	
	setHandler(Editor,"setOnScroll", "scroll")
End Sub

Sub Scale_Editor(factor As Double)
	scale = Round2(factor, 3)
'	Log("Scale_factor = " & scale)
	If WidthHeights.Size > 0 Then
		Scale_View(Editor, scale)
	End If
End Sub

Sub View_Changed (panel As B4XView)
	Save_Dimensions(panel, scale, False)
End Sub

Private Sub butTest_Click
	'others.Rotate_View(b4xVectEdit_component2.mRoot, 90)
	
	#if B4J
	others.SavePicture(File.DirApp, "pic.png", Editor.Snapshot)
	Sleep(10)
	Dim sh As Shell
	sh.Initialize("", File.Combine(File.DirApp, "pic.png"), Null)
	sh.Run(1)
	#End if
End Sub

Sub Scale_View(v As B4XView, ratio As Double)
	Dim empty_lt As LeftTop
	Dim empty_wh As WidthHeight
	For Each v2 As B4XView In v.GetAllViewsRecursive
		Dim lt As LeftTop = LeftTops.GetDefault(v2, empty_lt)
		Dim wh As WidthHeight = WidthHeights.GetDefault(v2, empty_wh)
		If lt.IsInitialized And wh.IsInitialized Then
			v2.SetLayoutAnimated(0, lt.Left * ratio, lt.Top * ratio, wh.Width * ratio, wh.Height * ratio)
		End If
	Next
End Sub

Sub Save_Dimensions(v As B4XView, ratio As Double, all As Boolean)
	Dim isFirst As Boolean = (WidthHeights.Size = 0)
	If all Then
		For Each v2 As B4XView In v.GetAllViewsRecursive
			Dim lt As LeftTop
			lt.Initialize
			lt.left = v2.Left / ratio
			lt.top = v2.Top / ratio
			LeftTops.Put(v2, lt)
			If isFirst Then
				Dim wh As WidthHeight
				wh.Initialize
				wh.Width = v2.Width
				wh.Height = v2.Height
				WidthHeights.Put(v2, wh)
			End If
		Next
	Else
		Dim lt As LeftTop
		lt.Initialize
		lt.left = v.Left / ratio
		lt.top = v.Top / ratio
		LeftTops.Put(v, lt)
	End If
End Sub

Private Sub Editor_MousePressed (EventData As MouseEvent)
	If EventData.SecondaryButtonPressed Then
		Dragging = True
		DraggingStart = DateTime.Now
		DownX = EventData.X
		DownY = EventData.Y
	End If
	EventData.Consume
End Sub

Private Sub Editor_MouseDragged (EventData As MouseEvent)
	If EventData.SecondaryButtonPressed Then
		If DateTime.Now - DraggingStart < 100 Then
			Return
		End If
		Editor.Left = Editor.Left + EventData.X - DownX
		Editor.Top = Editor.Top + EventData.Y - DownY
	End If
	EventData.Consume
End Sub

Private Sub Editor_MouseReleased (EventData As MouseEvent)
	If EventData.SecondaryButtonPressed Then
		Dragging = False
	End If
	EventData.Consume
End Sub

'just for future functions
Private Sub Editor_MouseMoved (EventData As MouseEvent)
	MouseX = EventData.X
	MouseY = EventData.Y
End Sub

Sub VectorComponent_LongClick
	Dim c As b4xVectEdit_component = Sender
	Main.toast.Show(c.Name &  ": TODO menu for renaming...")
End Sub
