B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
'Version 1.04
#Event: Click
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public ZoomOutImageView As B4XView
	Private pnl As B4XView
	Public pnlBackground As B4XView
	Private IVOffsetX, IVOffsetY As Float
	Private ImageRatio As Float
	#if B4A
	Private ScaleDetector As JavaObject
	Private PrevSpan As Float
	Private BitmapDecoder As JavaObject
	#else if B4i
	Private PreNumberOfTouches As Int
	Private FullImage As B4XBitmap
	#Else If B4J
	Private FullImage As B4XBitmap
	Private TilesCache As Map
	#end if
	
	Private TouchDown As Boolean
	Private StartLeft, StartTop, StartX, StartY As Int
	Public ClickThreshold As Int = 200
	Private ClickStart As Long
	Private DisableClickEvent As Boolean 'ignore
	Type HugeTile (SrcRect As B4XRect, Image As B4XBitmap, ImageView As B4XView, Description As String, RSIndex As Int, Loading As Boolean)
	Private EmptyImage As B4XBitmap 'ignore
	Private Tiles As List
	Public ImageWidth, ImageHeight As Int
	Private TileSize = 500 As Int
	Private Const ZoomOutSize As Int = 1000dip
	Private DisplayScale As Float
	Private TilesThatNeedToBeFilled As List
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	TilesThatNeedToBeFilled.Initialize
	Tiles.Initialize
	#if B4J
	TileSize = 2000
	#End If
	FillImages
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	pnlBackground = xui.CreatePanel("")
	mBase.SetColorAndBorder(mBase.Color, 0, 0, 0)
	Dim IV As ImageView
	IV.Initialize("")
	ZoomOutImageView = IV
	pnl = xui.CreatePanel("pnl")
	mBase.AddView(pnl, 0, 0, mBase.Width, mBase.Height)
	pnl.AddView(pnlBackground, 0, 0, mBase.Width, mBase.Height)
	pnlBackground.AddView(ZoomOutImageView, 0, 0, mBase.Width, mBase.Height)
	#if B4J
	Dim jo As JavaObject = pnl
	Dim ScrollEvent As JavaObject = jo.CreateEventFromUI("javafx.event.EventHandler", "ScrollChanged", Null)
	jo.RunMethod("setOnScroll", Array(ScrollEvent))
	
	#Else If B4A
	Dim jo As JavaObject = pnl
	Dim TouchListener As Object = jo.CreateEvent("android.view.View$OnTouchListener", "TouchListener", False)
	jo.RunMethod("setOnTouchListener", Array(TouchListener))
	Dim ScaleListener As Object = jo.CreateEventFromUI("android.view.ScaleGestureDetector$OnScaleGestureListener", "ScaleListener", True)
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	ScaleDetector.InitializeNewInstance("android.view.ScaleGestureDetector", Array(ctxt, ScaleListener))
	Dim version As JavaObject
	Dim sdk As Int = version.InitializeStatic("android.os.Build$VERSION").GetField("SDK_INT")
	If sdk >= 19 Then
		ScaleDetector.RunMethod("setQuickScaleEnabled", Array(False))
	End If
	#Else If B4i
	Dim nme As NativeObject = Me
	Dim no As NativeObject = pnl
	no.RunMethod("addGestureRecognizer:", Array(nme.RunMethod("CreateRecognizer", Null)))
	#end if
End Sub

#if B4J
Private Sub ScrollChanged_Event (MethodName As String, Args() As Object) As Object
	If MethodName = "handle" Then
		Dim ev As JavaObject = Args(0)
		Dim delta As Float = ev.RunMethod("getDeltaY", Null)
		Dim Zoom As Float
		If delta > 0 Then
			Zoom = 1.1
		Else
			Zoom = 0.9
		End If
		ZoomChanged(ev.RunMethod("getX", Null), ev.RunMethod("getY", Null), Zoom)
	End If
	Return Null
End Sub
#end if


Public Sub SetBitmap(Dir As String, Filename As String)
	TilesThatNeedToBeFilled.Clear
	For Each Tile As HugeTile In Tiles
		Tile.ImageView.RemoveViewFromParent
		If Tile.Image.IsInitialized Then ClearImage(Tile)
	Next
	#if B4A
	Dim decoderstatic As JavaObject
	decoderstatic.InitializeStatic("android.graphics.BitmapRegionDecoder")
	If BitmapDecoder.IsInitialized And BitmapDecoder.RunMethod("isRecycled", Null) = False Then
		BitmapDecoder.RunMethod("recycle", Null)
	End If
	Dim in As InputStream = File.OpenInput(Dir, Filename)
	BitmapDecoder = decoderstatic.RunMethod("newInstance", Array(in, False))
	in.Close
	ImageWidth = BitmapDecoder.RunMethod("getWidth", Null)
	ImageHeight = BitmapDecoder.RunMethod("getHeight", Null)
	#else if B4i
	FullImage = LoadBitmap(Dir, Filename)
	ImageWidth = FullImage.Width
	ImageHeight = FullImage.Height
	#else if B4J
	FullImage = xui.LoadBitmap(Dir, Filename)
	
	ImageWidth = FullImage.Width
	ImageHeight = FullImage.Height
	TilesCache.Initialize
	#end if
	
	Log($"Image size: ${ImageWidth}x${ImageHeight}"$)
	ImageRatio = ImageWidth / ImageHeight
	XUIViewsUtils.SetBitmapAndFill(ZoomOutImageView, xui.LoadBitmapResize(Dir, Filename, ZoomOutSize, ZoomOutSize, True))
	Tiles.Initialize
	CreateTiles
	
	Reset
	ZoomChanged(0, 0, 0)
End Sub

Private Sub CreateTiles
	For x = 0 To ImageWidth - 1 Step TileSize
		For y = 0 To ImageHeight - 1 Step TileSize
			Dim tile As HugeTile
			tile.Initialize
			tile.SrcRect.Initialize(x, y, Min(ImageWidth, x + TileSize), Min(ImageHeight, y + TileSize))
			Dim iv As ImageView
			iv.Initialize("")
			tile.ImageView = iv
			tile.Description = $"(${x},${y})"$
'			tile.ImageView.SetColorAndBorder(0, 1dip, xui.Color_Blue, 2dip)
			Tiles.Add(tile)
			pnlBackground.AddView(iv, 0, 0, 0, 0)
		Next
	Next
End Sub

Private Sub ZoomChanged (x As Int, y As Int, ZoomDelta As Float)
	Dim ivx As Float = x - pnlBackground.Left
	Dim ivy As Float = y - pnlBackground.Top
	ZoomDelta = Max(ZoomDelta, mBase.Width / pnlBackground.Width)
	Dim NewWidth As Int = Round(pnlBackground.Width * ZoomDelta)
	Dim NewHeight As Int = Round(pnlBackground.Height * ZoomDelta)
	DisplayScale = Max(ImageWidth / NewWidth, ImageHeight / NewHeight)
	pnlBackground.SetLayoutAnimated(0, x - Round(ivx * ZoomDelta), y - Round(ivy * ZoomDelta), NewWidth, NewHeight)
	SetImageViewLayout
End Sub

Private Sub SetImageViewLayout
	Dim ivleft As Int = pnlBackground.Width * IVOffsetX
	Dim ivtop As Int = pnlBackground.Height * IVOffsetY
	ZoomOutImageView.SetLayoutAnimated(0, ivleft, ivtop, pnlBackground.Width - 2 * ivleft, pnlBackground.Height - 2 * ivtop)
	Dim VisibleRect As B4XRect
	VisibleRect.Initialize((-pnlBackground.Left - ivleft) * DisplayScale, (-pnlBackground.Top - ivtop) * DisplayScale, 0, 0)
	VisibleRect.Width = mBase.Width * DisplayScale
	VisibleRect.Height = mBase.Height * DisplayScale
	Dim ShouldShowSmallTiles As Boolean = ZoomOutImageView.Width > ZoomOutSize * 2
	Dim CurrentTileSize As Int = Round(TileSize / DisplayScale)
	For Each Tile As HugeTile In Tiles
		If ShouldShowSmallTiles And IsIntersect(Tile.SrcRect, VisibleRect) Then
			Tile.ImageView.SetLayoutAnimated(0, ivleft + Tile.SrcRect.Left / TileSize * CurrentTileSize, ivtop + Tile.SrcRect.Top / TileSize * CurrentTileSize, _
				Tile.SrcRect.Width / TileSize * CurrentTileSize, Tile.SrcRect.Height / TileSize * CurrentTileSize)
			If Tile.Image.IsInitialized = False And Tile.Loading = False Then
				TilesThatNeedToBeFilled.Add(Tile)
				Tile.Loading = True
			End If
		Else
			Tile.RSIndex = Tile.RSIndex + 1
			Tile.ImageView.Visible = False
			Tile.Loading = False
			If Tile.Image.IsInitialized Then ClearImage(Tile)
		End If
	Next
End Sub

Private Sub ClearImage(Tile As HugeTile)
	
	Tile.ImageView.SetBitmap(Null)
	#if B4A
	Tile.Image.As(JavaObject).RunMethod("recycle", Null)
	#End If
	Tile.Image = EmptyImage
End Sub

Private Sub FillImages
	Do While True
		If TilesThatNeedToBeFilled.Size > 0 Then
			Dim Tile As HugeTile = TilesThatNeedToBeFilled.Get(0)
			TilesThatNeedToBeFilled.RemoveAt(0)
			If Tile.Loading = False Then Continue
			#if B4J
			Dim r As B4XRect
			#else
			Dim r As Rect
			#end if
			r.Initialize(Tile.SrcRect.Left, Tile.SrcRect.Top, Tile.SrcRect.Right, Tile.SrcRect.Bottom)
			Tile.RSIndex = Tile.RSIndex + 1
			Dim index As Int = Tile.RSIndex 'ignore
			#if B4A
			Wait For (Me.As(JavaObject).RunMethod("loadBitmap", Array(BitmapDecoder, r))) bitmap_loaded(Success As Boolean, Result As Object)
			#Else If B4i
			Wait For (Me.As(NativeObject).RunMethod("loadBitmap::", Array(FullImage, r))) bitmap_loaded(Success As Boolean, Result As Object)
			#else if B4J
			If TilesCache.ContainsKey(Tile) = False Then
				Wait For (Me.As(JavaObject).RunMethod("loadBitmap", Array(FullImage, r))) bitmap_loaded(Success As Boolean, Result As Object)
				If Success = True Then
					TilesCache.Put(Tile, Result)
				End If
			Else
				Success = True
				Result = TilesCache.Get(Tile)
			End If
			#end if
			If Tile.RSIndex = index Then
				Tile.Loading = False
				If Success Then
					Tile.Image = Result
					XUIViewsUtils.SetBitmapAndFill(Tile.ImageView, Tile.Image)
					Tile.ImageView.Visible = True
				End If
			End If
			
		End If
		Sleep(IIf(TilesThatNeedToBeFilled.Size > 0, 10, 100))
	Loop
End Sub



Private Sub IsIntersect(Rect1 As B4XRect, Rect2 As B4XRect) As Boolean
	If Rect1.Right < Rect2.Left Or Rect1.Left > Rect2.Right Or Rect1.Bottom < Rect2.Top Or Rect1.Top > Rect2.Bottom Then
		Return False
	Else
		Return True
	End If
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
	pnl.SetLayoutAnimated(0, 0, 0, Width, Height)
	Reset
End Sub

Private Sub Reset
	pnlBackground.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
	If ZoomOutImageView.GetBitmap.IsInitialized Then
		Dim ContainerWidth As Int = mBase.Width
		Dim ContainerHeight As Int = mBase.Height
		Dim ivr As Float = ContainerWidth / ContainerHeight
		If ImageRatio > ivr Then
			IVOffsetX = 0
			IVOffsetY = (ContainerHeight - 1 / ImageRatio * ContainerWidth) / 2 / ContainerHeight
		Else
			IVOffsetY = 0
			IVOffsetX = (ContainerWidth - ImageRatio * ContainerHeight) / 2 / ContainerWidth
		End If
		Dim left As Int = pnlBackground.Width * IVOffsetX
		Dim top As Int = pnlBackground.Height * IVOffsetY
		ZoomOutImageView.SetLayoutAnimated(0, left, top, pnlBackground.Width - 2 * left, pnlBackground.Height - 2 * top)
	Else
		ZoomOutImageView.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Width)
	End If
End Sub
#if B4A
Private Sub TouchListener_Event (MethodName As String, Args() As Object) As Object
	if MethodName <> "onTouch" Then Return Null
	Dim MotionEvent As JavaObject = Args(1)
	If 1 = MotionEvent.RunMethod("getPointerCount", Null) Then
		Dim action As Int = MotionEvent.RunMethod("getAction", Null)
		If action = 0 Then ClickStart = DateTime.Now
		pnl_Touch(action, MotionEvent.RunMethod("getX", Null), MotionEvent.RunMethod("getY", Null))
	End If
	ScaleDetector.RunMethod("onTouchEvent", Array(MotionEvent))
	Return True
End Sub

Private Sub ScaleListener_Event (MethodName As String, Args() As Object) As Object
	Dim ScaleGestureDetector As JavaObject = Args(0)
	If ScaleGestureDetector.RunMethod("isInProgress", Null) = False Then
		Return True
	End If
	TouchDown = False
	Dim x As Float = ScaleGestureDetector.RunMethod("getFocusX", Null)
	Dim y As Float = ScaleGestureDetector.RunMethod("getFocusY", Null)
	Dim currentspan As Float = ScaleGestureDetector.RunMethod("getCurrentSpan", Null)
	If MethodName = "onScaleBegin" Then
		PrevSpan = currentspan
		pnl_Touch(pnl.TOUCH_ACTION_DOWN, x, y)
		Return True
	Else If MethodName = "onScaleEnd" Or currentspan = 0 Then
		Return True
	End If
	Dim delta As Float = Power(currentspan / PrevSpan, 2)
	PrevSpan = currentspan
	ZoomChanged(x, y, delta)
	Return True
End Sub
#else if B4i
Private Sub Pinch_Event (Pinch As Object)
	Dim rec As NativeObject = Pinch
	Dim points() As Float = rec.ArrayFromPoint(rec.RunMethod("locationInView:", Array(pnl)))
	Dim x As Float = points(0)
	Dim y As Float = points(1)
	Dim scale As Float = rec.GetField("scale").AsNumber
	Dim NumberOfTouches As Int = rec.GetField("numberOfTouches").AsNumber
	rec.SetField("scale", 1)
	Dim state As Int = rec.GetField("state").AsNumber
	Select state
		Case 1 'began
			DisableClickEvent = True
		Case 2 'changed
			If Round(scale * 50) <> 50 Then
				Log(scale)
				ZoomChanged(x, y, scale)
			Else if NumberOfTouches = 1 Then
				If PreNumberOfTouches <> 1 Then
					pnl_Touch(pnl.TOUCH_ACTION_DOWN, x, y)
				Else
					pnl_Touch(pnl.TOUCH_ACTION_MOVE, x, y)
				End If
			End If
		Case 3
			DisableClickEvent = False
	End Select
	PreNumberOfTouches = NumberOfTouches
End Sub
#End If


Private Sub pnl_Touch (Action As Int, X1 As Float, Y1 As Float)
	If Action = pnl.TOUCH_ACTION_DOWN Or TouchDown = False Then
		StartLeft = pnlBackground.Left
		StartTop = pnlBackground.Top
		StartX = X1
		StartY = Y1
		TouchDown = True
		If xui.IsB4A = False Then ClickStart = DateTime.Now
	Else If Action = pnl.TOUCH_ACTION_MOVE And TouchDown Then
		pnlBackground.Left = Min(0.5 * mBase.Width, StartLeft + 1.2 * (X1 - StartX))
		pnlBackground.Left = Max(-(pnlBackground.Width - 0.5 * mBase.Width), pnlBackground.Left)
		pnlBackground.Top = Min(0.5 * mBase.Height, StartTop + 1.2 * (Y1 - StartY))
		pnlBackground.Top = Max(-(pnlBackground.Height - 0.5 * mBase.Height), pnlBackground.Top)
		SetImageViewLayout
	Else if Action = pnl.TOUCH_ACTION_UP Then
		TouchDown = False
		If DateTime.Now - ClickStart < ClickThreshold And DisableClickEvent = False Then
			If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
				CallSub(mCallBack, mEventName & "_Click")
			End If
		End If
	Else
		'Log("touch cancelled")
	End If
End Sub

#if B4J
Private Sub GetImage(tile As HugeTile, r As B4XRect) As B4XBitmap
	If TilesCache.ContainsKey(tile) = False Then
		TilesCache.Put(tile, FullImage.Crop(r.Left, r.Top, r.Width, r.Height))
	End If
	Return TilesCache.Get(tile)
End Sub
#End If


#if B4A
#if Java
import android.graphics.Rect;
import android.graphics.Bitmap;
import android.graphics.BitmapRegionDecoder;
import android.graphics.BitmapFactory.*;
import android.graphics.BitmapFactory;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.concurrent.Callable;
public Object loadBitmap(final BitmapRegionDecoder decoder, final Rect rect) {
	Object sender = new Object();
	BA.runAsync(getBA(), sender, "bitmap_loaded", new Object[] {false, null}, 
		new Callable<Object[]>() {
			public Object[] call() throws Exception {
				try {
					Bitmap b = decoder.decodeRegion(rect, null);
					return new Object[] {true, b};
				} catch (Exception e) {
					BA.Log("" + e);
					throw e;
				}
			}
		}
	);
	return sender;
}
#End If
#end if
#if B4J
#if Java
import anywheresoftware.b4a.objects.B4XViewWrapper;
import anywheresoftware.b4a.objects.B4XViewWrapper.*;
import javafx.scene.image.Image;
import anywheresoftware.b4a.objects.B4XCanvas.B4XRect;
import java.util.concurrent.Callable;
public Object loadBitmap(final Image img, final B4XRect rect) {
	Object sender = new Object();
	BA.runAsync(getBA(), sender, "bitmap_loaded", new Object[] {false, null}, 
		new Callable<Object[]>() {
			public Object[] call() throws Exception {
				try {
					B4XBitmapWrapper bw = new B4XBitmapWrapper();
					bw.setObject(img);
					
					return new Object[] {true, bw.Crop((int)rect.getLeft(), (int)rect.getTop(), (int)rect.getWidth(), (int)rect.getHeight()).getObject()};
				} catch (Exception e) {
					BA.Log("" + e);
					throw e;
				}
			}
		}
	);
	return sender;
}

#End If
#end if

#if OBJC
- (NSObject*) CreateRecognizer{
 	 UIPinchGestureRecognizer  *rec = [[UIPinchGestureRecognizer  alloc] initWithTarget:self action:@selector(action:)];
	return rec;
}
-(void) action:(UIPanGestureRecognizer*)rec {
	[self.bi raiseEvent:nil event:@"pinch_event:" params:@[rec]];
}
- (NSObject*) loadBitmap:(UIImage*)image :(B4IRect*)rect{
 NSObject *senderFilter = [NSObject new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
			CGImageRef cutImageRef = CGImageCreateWithImageInRect(image.CGImage, rect.ToCGRect);
			UIImage* croppedImage = [UIImage imageWithCGImage:cutImageRef];
	    	CGImageRelease(cutImageRef);
            [self.bi raiseEventFromDifferentThread:senderFilter event:@"bitmap_loaded::" params:@[@(true), croppedImage]];
        }  @catch (NSException *e) {
            [B4I SetException:e];
			
            [self.bi raiseEventFromDifferentThread:senderFilter event:@"bitmap_loaded::" params:@[@(false), [NSNull null]]];
        }
    });
    return senderFilter;
}
#End If
