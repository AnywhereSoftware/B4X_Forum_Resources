B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release: shared B4X liquid glass renderer for B4A, B4i and B4J
V1.01
	-Batched updates; native Android renderer avoids B4X pixel loops
	-Independent rim lighting and glass visibility for composed menu triggers
	-Fix: check Android parent type before wrapping, including debug builds
	-Fix: stop ancestor traversal at Android's non-view window parent
#End If

#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 28, MinRange: 0
#DesignerProperty: Key: BlurRadius, DisplayName: Blur Radius, FieldType: Int, DefaultValue: 6, MinRange: 0
#DesignerProperty: Key: RefractionHeight, DisplayName: Refraction Height, FieldType: Int, DefaultValue: 12, MinRange: 0
#DesignerProperty: Key: BevelWidth, DisplayName: Bevel Width, FieldType: Int, DefaultValue: 20, MinRange: 1
#DesignerProperty: Key: DispersionStrength, DisplayName: Dispersion Strength, FieldType: Float, DefaultValue: 0.12, MinRange: 0, MaxRange: 1
#DesignerProperty: Key: Saturation, DisplayName: Saturation, FieldType: Float, DefaultValue: 1.2, MinRange: 0, MaxRange: 3
#DesignerProperty: Key: GlassTint, DisplayName: Glass Tint, FieldType: Color, DefaultValue: 0x28FFFFFF
#DesignerProperty: Key: HighlightOpacity, DisplayName: Highlight Opacity, FieldType: Float, DefaultValue: 0.7, MinRange: 0, MaxRange: 1
#DesignerProperty: Key: RenderScale, DisplayName: Render Scale, FieldType: Float, DefaultValue: 0.5, MinRange: 0.1, MaxRange: 1

#Event: Click
#Event: Rendered

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Public Tag As Object
	Private xui As XUI
	Private xiv_Glass As B4XView
	Private xpnl_Content As B4XView
	Private renderer As AS_LiquidGlassRenderer
	Private m_Backdrop As B4XBitmap
	Private m_Source As B4XView
	Private m_SourceX, m_SourceY As Float
	Private m_SourceWidth, m_SourceHeight As Float
	Private m_CornerRadius As Float = 28dip
	Private m_BlurRadius As Float = 6dip
	Private m_RefractionHeight As Float = 12dip
	Private m_BevelWidth As Float = 20dip
	Private m_DispersionStrength As Float = 0.12
	Private m_Saturation As Float = 1.2
	Private m_GlassTint As Int = 0x28FFFFFF
	Private m_HighlightOpacity As Float = 0.7
	Private m_RimOpacity As Float
	Private m_RenderScale As Float = 0.5
	Private m_LightX As Float = -1
	Private m_LightY As Float = -1
	Private tmr_Refresh As Timer
	Private m_Disposed As Boolean
	Private m_Rendering As Boolean
	Private m_UpdateDepth As Int
	Private m_RefreshPending As Boolean
End Sub

Public Sub Initialize(Callback As Object, EventName As String)
	mCallBack = Callback
	mEventName = EventName
	renderer.Initialize
	tmr_Refresh.Initialize("tmr_Refresh", 100)
End Sub

Public Sub CreateViewPerCode(Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float)
	Dim base As B4XView = xui.CreatePanel("")
	Parent.AddView(base, Left, Top, Width, Height)
	Dim lbl As Label
	lbl.Initialize("")
	DesignerCreateView(base, lbl, CreateMap())
End Sub

Public Sub DesignerCreateView(Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	m_CornerRadius = DipToCurrent(Props.GetDefault("CornerRadius", 28))
	m_BlurRadius = DipToCurrent(Props.GetDefault("BlurRadius", 6))
	m_RefractionHeight = DipToCurrent(Props.GetDefault("RefractionHeight", 12))
	m_BevelWidth = DipToCurrent(Props.GetDefault("BevelWidth", 20))
	m_DispersionStrength = Props.GetDefault("DispersionStrength", 0.12)
	m_Saturation = Props.GetDefault("Saturation", 1.2)
	m_GlassTint = xui.PaintOrColorToColor(Props.GetDefault("GlassTint", 0x28FFFFFF))
	m_HighlightOpacity = Props.GetDefault("HighlightOpacity", 0.7)
	m_RenderScale = Props.GetDefault("RenderScale", 0.5)
	mBase.Color = xui.Color_Transparent
	Dim iv As ImageView
	iv.Initialize("")
	xiv_Glass = iv
	mBase.AddView(xiv_Glass, 0, 0, mBase.Width, mBase.Height)
	#If B4J
	xiv_Glass.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
	#Else If B4i
	xiv_Glass.As(ImageView).UserInteractionEnabled = False
	#End If
	xpnl_Content = xui.CreatePanel("xpnl_Content")
	mBase.AddView(xpnl_Content, 0, 0, mBase.Width, mBase.Height)
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize(Width As Double, Height As Double)
	If xiv_Glass.IsInitialized = False Then Return
	xiv_Glass.SetLayoutAnimated(0, 0, 0, Max(0, Width), Max(0, Height))
	xpnl_Content.SetLayoutAnimated(0, 0, 0, Max(0, Width), Max(0, Height))
	Refresh
End Sub

'Use after resizing from code (B4A does not raise Base_Resize automatically).
Public Sub Resize(Width As Float, Height As Float)
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, Max(0, Width), Max(0, Height))
	Base_Resize(Width, Height)
End Sub

'Content is drawn above the glass. Keep child views within the rounded silhouette.
Public Sub getContentPanel As B4XView
	Return xpnl_Content
End Sub

'Toggle the glass image without hiding custom trigger content.
Public Sub setGlassVisible(Value As Boolean)
	xiv_Glass.Visible = Value
End Sub

'Bitmap must be aligned to the backdrop coordinate space. Region is in bitmap pixels.
'Call again after moving/resizing the glass when using bitmap mode.
Public Sub SetBackdrop(Bitmap As B4XBitmap, Left As Float, Top As Float, Width As Float, Height As Float)
	If Bitmap.IsInitialized = False Then Return
	Dim empty As B4XView
	m_Source = empty
	m_Backdrop = Bitmap
	m_SourceX = Left
	m_SourceY = Top
	m_SourceWidth = Width
	m_SourceHeight = Height
	Refresh
End Sub

'Source must NOT contain this glass or any other glass sampling the same source.
'Left/Top are explicit offsets in Source view coordinates; width/height follow mBase.
'Use a separate background panel behind the glass, never its common parent.
Public Sub SetBackdropView(Source As B4XView, Left As Float, Top As Float)
	Dim ancestor As B4XView = mBase
	Do While ancestor.IsInitialized
		If ancestor = Source Then
			Log("AS_LiquidGlass: backdrop must not contain the glass view.")
			Return
		End If
		ancestor = ParentViewOrEmpty(ancestor)
	Loop
	m_Source = Source
	m_SourceX = Left
	m_SourceY = Top
	Refresh
End Sub

'Android's topmost view may have a ViewRootImpl parent which B4XView cannot wrap.
'Treat that native window boundary as the end of the view hierarchy.
Private Sub ParentViewOrEmpty(View As B4XView) As B4XView
	#If B4A
	Dim native As JavaObject = Me
	Return native.RunMethod("parentViewOrNull", Array(View))
	#Else
	Return View.Parent
	#End If
End Sub

#If B4A
#If Java
public Object parentViewOrNull(android.view.View view) {
    android.view.ViewParent parent = view.getParent();
    return parent instanceof android.view.View ? parent : null;
}
#End If
#End If

'Update offsets after moving the glass relative to the source view.
Public Sub SetBackdropOffset(Left As Float, Top As Float)
	m_SourceX = Left
	m_SourceY = Top
	Refresh
End Sub

'Captures only the separate source view. Does not hide the glass or its content.
Public Sub BeginUpdate
	m_UpdateDepth = m_UpdateDepth + 1
End Sub

Public Sub EndUpdate
	m_UpdateDepth = Max(0, m_UpdateDepth - 1)
	If m_UpdateDepth = 0 And m_RefreshPending Then
		m_RefreshPending = False
		Refresh
	End If
End Sub

Public Sub Refresh
	If m_UpdateDepth > 0 Then
		m_RefreshPending = True
		Return
	End If
	If m_Disposed Or m_Rendering Or mBase.IsInitialized = False Then Return
	If mBase.Width <= 0 Or mBase.Height <= 0 Then Return
	m_Rendering = True
	Try
		Dim regionX As Float = m_SourceX, regionY As Float = m_SourceY
		Dim regionW As Float = m_SourceWidth, regionH As Float = m_SourceHeight
		If m_Source.IsInitialized Then
			If m_Source.Width > 0 And m_Source.Height > 0 Then
				m_Backdrop = m_Source.Snapshot
				regionX = m_SourceX / m_Source.Width * m_Backdrop.Width
				regionY = m_SourceY / m_Source.Height * m_Backdrop.Height
				regionW = mBase.Width / m_Source.Width * m_Backdrop.Width
				regionH = mBase.Height / m_Source.Height * m_Backdrop.Height
			End If
		End If
		If m_Backdrop.IsInitialized And regionW > 0 And regionH > 0 Then
			'Invalid regions are rejected instead of silently stretching a partial crop.
			If regionX >= 0 And regionY >= 0 And regionX + regionW <= m_Backdrop.Width + 0.5 And regionY + regionH <= m_Backdrop.Height + 0.5 Then
				Dim crop As B4XBitmap = m_Backdrop.Crop(regionX, regionY, Min(regionW, m_Backdrop.Width - regionX), Min(regionH, m_Backdrop.Height - regionY))
				'Bound work for large desktop panels: maximum 100k pixels and 512 per axis.
				Dim scale As Float = Max(0.1, Min(1, m_RenderScale))
				scale = Min(scale, Min(512 / Max(mBase.Width, mBase.Height), Sqrt(100000 / (mBase.Width * mBase.Height))))
				Dim w As Int = Max(1, Round(mBase.Width * scale)), h As Int = Max(1, Round(mBase.Height * scale))
				Dim bitmap As B4XBitmap = renderer.RenderWithLighting(crop, w, h, m_CornerRadius * scale, Round(m_BlurRadius * scale), m_RefractionHeight * scale, m_BevelWidth * scale, m_DispersionStrength, m_Saturation, m_GlassTint, m_HighlightOpacity, m_LightX, m_LightY, m_RimOpacity)
				Dim bc As BitmapCreator
				bc.Initialize(1, 1)
				bc.SetBitmapToImageView(bitmap, xiv_Glass)
				If xui.SubExists(mCallBack, mEventName & "_Rendered", 0) Then CallSubDelayed(mCallBack, mEventName & "_Rendered")
			Else
				Log("AS_LiquidGlass: backdrop region is outside the source.")
			End If
		End If
	Catch
		Log("AS_LiquidGlass.Refresh: " & LastException.Message)
	End Try
	m_Rendering = False
End Sub

'Opt-in polling; CPU rendering is not a 60 fps GPU replacement. Stop on page disappear.
Public Sub StartAutoRefresh(IntervalMs As Int)
	If m_Disposed Then Return
	tmr_Refresh.Interval = Max(50, IntervalMs)
	tmr_Refresh.Enabled = True
End Sub

Public Sub StopAutoRefresh
	tmr_Refresh.Enabled = False
End Sub

Private Sub tmr_Refresh_Tick
	If mBase.IsInitialized Then
		If mBase.Visible Then Refresh
	End If
End Sub

'Light direction, e.g. (-1,-1) for top-left. Can be driven by pointer or sensors.
Public Sub SetLightDirection(X As Float, Y As Float)
	m_LightX = X
	m_LightY = Y
	Refresh
End Sub

'Stops polling and releases the stored backdrop. Create a new instance to reuse.
Public Sub Dispose
	StopAutoRefresh
	m_Disposed = True
	Dim emptyBitmap As B4XBitmap
	Dim emptyView As B4XView
	m_Backdrop = emptyBitmap
	m_Source = emptyView
	If xiv_Glass.IsInitialized Then xiv_Glass.SetBitmap(Null)
End Sub

#If B4J
Private Sub xpnl_Content_MouseClicked(EventData As MouseEvent)
#Else
Private Sub xpnl_Content_Click
#End If
	If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then CallSub(mCallBack, mEventName & "_Click")
End Sub

'Distances use B4X layout units: pass dip values from code.
Public Sub setCornerRadius(Value As Float)
	m_CornerRadius = Max(0, Value)
	Refresh
End Sub
Public Sub getCornerRadius As Float
	Return m_CornerRadius
End Sub
Public Sub setBlurRadius(Value As Float)
	m_BlurRadius = Max(0, Min(64dip, Value))
	Refresh
End Sub
Public Sub getBlurRadius As Float
	Return m_BlurRadius
End Sub
Public Sub setRefractionHeight(Value As Float)
	m_RefractionHeight = Max(0, Value)
	Refresh
End Sub
Public Sub getRefractionHeight As Float
	Return m_RefractionHeight
End Sub
Public Sub setBevelWidth(Value As Float)
	m_BevelWidth = Max(1dip, Value)
	Refresh
End Sub
Public Sub getBevelWidth As Float
	Return m_BevelWidth
End Sub
Public Sub setDispersionStrength(Value As Float)
	m_DispersionStrength = Max(0, Min(1, Value))
	Refresh
End Sub
Public Sub getDispersionStrength As Float
	Return m_DispersionStrength
End Sub
Public Sub setSaturation(Value As Float)
	m_Saturation = Max(0, Min(3, Value))
	Refresh
End Sub
Public Sub getSaturation As Float
	Return m_Saturation
End Sub
Public Sub setGlassTint(Value As Int)
	m_GlassTint = Value
	Refresh
End Sub
Public Sub getGlassTint As Int
	Return m_GlassTint
End Sub
Public Sub setHighlightOpacity(Value As Float)
	m_HighlightOpacity = Max(0, Min(1, Value))
	Refresh
End Sub
Public Sub getHighlightOpacity As Float
	Return m_HighlightOpacity
End Sub
Public Sub setRimOpacity(Value As Float)
	m_RimOpacity = Max(0, Min(1, Value))
	Refresh
End Sub
Public Sub getRimOpacity As Float
	Return m_RimOpacity
End Sub
Public Sub setRenderScale(Value As Float)
	m_RenderScale = Max(0.1, Min(1, Value))
	Refresh
End Sub
Public Sub getRenderScale As Float
	Return m_RenderScale
End Sub
