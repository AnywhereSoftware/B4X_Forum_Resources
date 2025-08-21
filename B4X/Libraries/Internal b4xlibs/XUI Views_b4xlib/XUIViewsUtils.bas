B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Code module
Sub Process_Globals
	#if B4i
	Private FeedbackGenerator As NativeObject
	#End If
	Private UtilsInitialized As Boolean
	Private xui As XUI
End Sub

Private Sub Initialize
	If UtilsInitialized Then Return
	UtilsInitialized = True
	#if B4I
	FeedbackGenerator.Initialize("UIImpactFeedbackGenerator")
	If FeedbackGenerator.IsInitialized Then
		FeedbackGenerator = FeedbackGenerator.RunMethod("alloc", Null).RunMethod("initWithStyle:", Array(0)) 'light
	End If
	#End If
End Sub

Public Sub PerformHapticFeedback (View As B4XView)
	Initialize
   #if B4A
	Dim jo As JavaObject = View
	jo.RunMethod("performHapticFeedback", Array(1))
	#Else if B4i
	If FeedbackGenerator.IsInitialized Then
		FeedbackGenerator.RunMethod("impactOccurred", Null)
	End If
	#end if
End Sub

'adds a stub item to CLV to fill the ScrollView.
Public Sub AddStubToCLVIfNeeded(CustomListView1 As CustomListView, Color As Int)
	If CustomListView1.Size = 0 Then Return
	Dim LastItem As CLVItem = CustomListView1.GetRawListItem(CustomListView1.Size - 1)
	If LastItem.Offset + LastItem.Panel.Height < CustomListView1.AsView.Height Then
		'add a stub item
		Dim p As B4XView = xui.CreatePanel("stub")
		p.Color = Color
		Dim Height As Int = CustomListView1.AsView.Height - LastItem.Offset - LastItem.Panel.Height - 3dip
		If xui.IsB4J Then Height = Height + 5
		p.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, Height)
		CustomListView1.Add(p, "")
		CustomListView1.sv.ScrollViewContentHeight = CustomListView1.sv.ScrollViewContentHeight - CustomListView1.DividerSize
	End If
End Sub

'Sets text or CSBuilder to a label.
Public Sub SetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)
	#if B4A or B4J
	xlbl.Text = Text
	#else if B4i
	If Text Is CSBuilder And xlbl Is Label Then
		Dim lbl As Label = xlbl
		lbl.AttributedText = Text
	Else 
		If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)
		xlbl.Text = Text
	End If
	#end if
End Sub

'Sets a bitmap and sets the gravity to Fill.
Public Sub SetBitmapAndFill (ImageView As B4XView, Bmp As B4XBitmap)
	ImageView.SetBitmap(Bmp)
	Dim iiv As ImageView = ImageView
	#if B4A
	iiv.Gravity = Gravity.FILL
	#Else If B4J
	iiv.PreserveRatio = False
	#else if B4i
	iiv.ContentMode = iiv.MODE_FILL
	#End If
End Sub

'Create a Label.
Public Sub CreateLabel As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	Return lbl
End Sub

'Creates a B4XImageView. You need to add B4XImageView.mBase to the layout tree.
Public Sub CreateB4XImageView As B4XImageView
	Dim iv As B4XImageView
	iv.Initialize(Null, "")
	Dim base As B4XView = xui.CreatePanel("")
	base.SetLayoutAnimated(0, 0, 0, 100dip, 100dip)
	iv.DesignerCreateView(base, Null, CreateMap("Round": False, "ResizeMode": "FIT", "BackgroundColor": 0xFFAAAAAA, "CornersRadius": 0))
	Return iv
End Sub

'Level between 0 (transparent) to 1 (opaque)
Public Sub SetAlpha (View As B4XView, Level As Float)
    #if B4A
    Dim jo As JavaObject = View
    Dim alpha As Float = Level
    jo.RunMethod("setAlpha", Array(alpha))
    #Else If B4J
	Dim n As Node = View
	n.Alpha = Level
    #else if B4i
    Dim v As View = View
    v.Alpha = Level
    #End If
End Sub