B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@


Private Sub Class_Globals
	#If B4J
	Private fx As JFX
	#End If
	Private xui As XUI
	
	Private cvs As B4XCanvas
	Private pnl As B4XView
	Private DrawList As List  ' List of all drawings
	Private mAutoInvalidate As Boolean
	Private count As Long
	Private CurX As Float = 0
	Private CurY As Float = 0
End Sub

'----------------------------------- PUBLIC SUBS ------------------------------------------

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As B4XView, Left As Double, Top As Double, Width As Double, Height As Double)
	DrawList.Initialize
	
	pnl = xui.CreatePanel("pnl")
	Parent.AddView(pnl, Left, Top, Width, Height)
	cvs.Initialize(pnl)
	
	mAutoInvalidate = False
	
'	Log(CurX)
'	Log(CurY)
	
'	Clear
End Sub

'Get the drawing counter.
'NOTE: GetDrawingCount, ClearDrawingCount, Repaint, AutoRepaint and any getter command will be excluded from count.
Public Sub GetDrawingCount As Long
	Return count
End Sub

'Clear the drawing counter.
Public Sub ClearDrawingCount
	count = 0
End Sub

' CLEAR

'Clear the full canvas with the black color.
'This is a short hand to clear the screen black.
Public Sub Cls
	CommitCommand(Array("Clear", xui.Color_Black))
End Sub

'Clear the full canvas with the given color.
Public Sub Clear(Color As Int)
	CommitCommand(Array("Clear", Color))
End Sub

'This is a short hand of cvs.ClearRect(cvs.TargetRect)
Public Sub ClearTargetRect
	ClearRect(cvs.TargetRect)
End Sub

'Clears the given rectangle. Does not work with clipped paths.
Public Sub ClearRect (Rect As B4XRect)
	CommitCommand(Array("ClearRect", Rect))
End Sub

' PATH

'Clips the drawings to a closed path.
Public Sub ClipPath (Path As B4XPath)
	CommitCommand(Array("ClipPath", Array As B4XPath(Path)))
End Sub
		
'Removes a previously set clip region.
Public Sub RemoveClip
	cvs.RemoveClip
End Sub

'Draws the given path.
Public Sub DrawPath (Path As B4XPath, Color As Int, Filled As Boolean, StrokeWidth As Float)
	CommitCommand(Array("DrawPath", Array As B4XPath(Path), Color, Filled, StrokeWidth))
End Sub

'Similar to DrawPath. Rotates the path based on the degrees and center parameters.
Public Sub DrawPathRotated (Path As B4XPath, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float, CenterX As Float, CenterY As Float)
	CommitCommand(Array("DrawPathRotated", Array As B4XPath(Path), Color, Filled, StrokeWidth, Degrees, CenterX, CenterY))
End Sub

' BITMAP

#If B4J
'Draws the bitmap in the given destination.
'Use B4XBitmap.Crop To draw part of a bitmap.
Public Sub DrawBitmap (Bitmap As Image, Dest As B4XRect)
	CommitCommand(Array("DrawBitmap", Bitmap, Dest))
End Sub

'Similar to DrawBitmap. Draws a rotated bitmap.
Public Sub DrawBitmapRotated (Bitmap As Image, Dest As B4XRect, Degrees As Float)
	CommitCommand(Array("DrawBitmapRotated", Bitmap, Dest, Degrees))
End Sub
#Else If B4A
'Draws the bitmap in the given destination.
'Use B4XBitmap.Crop To draw part of a bitmap.
Public Sub DrawBitmap (Bitmap As Bitmap, Dest As B4XRect)
	CommitCommand(Array("DrawBitmap", Bitmap, Dest))
End Sub

'Similar to DrawBitmap. Draws a rotated bitmap.
Public Sub DrawBitmapRotated (Bitmap As Bitmap, Dest As B4XRect, Degrees As Float)
	CommitCommand(Array("DrawBitmapRotated", Bitmap, Dest, Degrees))
End Sub
#End If

' PIXEL

'Draws a single pixel.
Public Sub DrawPixel (x As Float, y As Float, Color As Int)
	CommitCommand(Array("DrawPixel", x+0.5, y+0.5, Color))
	CurX = x : CurY = y
End Sub

'Similar to DrawPixel but permits to specify the pixel Radius.
Public Sub DrawPixel2 (x As Float, y As Float, Color As Int, Radius As Float)
	CommitCommand(Array("DrawPixel2", x+0.5, y+0.5, Color, Radius))
	CurX = x : CurY = y
End Sub

' LINE

'Draws a line from x1,y1 to x2,y2.
Public Sub DrawLine (x1 As Float, y1 As Float, x2 As Float, y2 As Float, Color As Int, StrokeWidth As Float)
	CommitCommand(Array("DrawLine", x1+0.5, y1+0.5, x2+0.5, y2+0.5, Color, StrokeWidth))
	CurX = x2 : CurY = y2
End Sub

'Draws a line from last position (from DrawLine, DrawLineTo, DrawPixel, DrawPixel2 commands) to x,y.
Public Sub DrawLineTo (x As Float, y As Float, Color As Int, StrokeWidth As Float)
	CommitCommand(Array("DrawLine", x+0.5, y+0.5, Color, StrokeWidth))
	CurX = x : CurY = y
End Sub

' RECTANGLE

'Draws a rectangle.
Public Sub DrawRect (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float)
	CommitCommand(Array("DrawRect", Rect, Color, Filled, StrokeWidth))
End Sub

'Similar to DrawRect. Draw a rotated rectangle.
Public Sub DrawRectRotated (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float)
	CommitCommand(Array("DrawRectRotated", Rect, Color, Filled, StrokeWidth, Degrees))
End Sub

' ROUND RECTANGLE

'Draws a rectangle with round corners specified by CornerRadius.
Public Sub DrawRoundRect(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, CornerRadius As Float)
	CommitCommand(Array("DrawRoundRect", Rect, Color, Filled, StrokeWidth, CornerRadius))
End Sub

'Similar to DrawRoundRect. Draw a rectangle with round corners and rotated by Degrees angle.
Public Sub DrawRoundRectRotated(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, CornerRadius As Float, Degrees As Float)
	CommitCommand(Array("DrawRoundRectRotated", Rect, Color, Filled, StrokeWidth, CornerRadius, Degrees))
End Sub

' CIRCLE

'Draws a circle.
Public Sub DrawCircle (x As Float, y As Float, Radius As Float, Color As Int, Filled As Boolean, StrokeWidth As Float)
	CommitCommand(Array("DrawCircle", x, y, Radius, Color, Filled, StrokeWidth))
End Sub

' OVAL

'Draws an oval.
Public Sub DrawOval(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float)
	CommitCommand(Array("DrawOval", Rect, Color, Filled, StrokeWidth))
End Sub

'Similar to DrawOval. Draw the oval rotated by Degrees angle.
Public Sub DrawOvalRotated(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float)
	CommitCommand(Array("DrawOvalRotated", Rect, Color, Filled, StrokeWidth, Degrees))
End Sub

' TEXT

'Draws the text at the given position. For alignment use one of following values "LEFT", "CENTER", "RIGHT".
Public Sub DrawText (Text As String, x As Double, y As Double, Font As B4XFont, Color As Int, Alignment As Object)
	CommitCommand(Array("DrawText", Text, x, y, Font, Color, Alignment))
End Sub

'Similar to DrawText. Rotates the text before it is drawn.
Public Sub DrawTextRotated (Text As String, x As Double, y As Double, Font As B4XFont, Color As Int, Alignment As Object, Degrees As Float)
	CommitCommand(Array("DrawTextRotated", Text, x, y, Font, Color, Alignment, Degrees))
End Sub

' //////////// COMMANDS Not IN DRAWING LIST //////////

'Commits the drawings. 
' If AutoInvalidate is False this must be called for the drawings to be updated.
Public Sub Invalidate	
	If mAutoInvalidate = False Then
		#If B4J
			ExecuteDrawList(DrawList)
		#Else If B4A
		   ExecuteDrawList(DrawList)
		   cvs.Invalidate
'		   Log(DateTime.Now & " - AutoInvalidate by user")
		#End If
	End If	
End Sub

'Sets or gets AutoInvalidate property.
'By default AutoInvalidate is False, you will need to call Invalidate to update the drawings.
'If you set AutoInvalidate to True, then the drawings will be auto updated every command.
Public Sub setAutoInvalidate(Val As Boolean)
	mAutoInvalidate = Val
End Sub
Public Sub getAutoInvalidate As Boolean
	Return mAutoInvalidate
End Sub

'Measures single line texts and returns their width, height and the height above the baseline.
'Rect.Top returns the height above the baseline.
Public Sub MeasureText(Text As String, Font As B4XFont) As B4XRect
	Return cvs.MeasureText(Text, Font)
End Sub

'Releases native resources related to the canvas.
'
'Only B4i, does nothing on B4 and B4J. 
'Just mantained for code compatibility.
Public Sub Release
	#If B4i
		cvs.Release	
	#End If
End Sub

'Resizes the canvas.
Public Sub Resize (Width As Double, Height As Double)
	'Log("RESIZE")
	pnl.SetLayoutAnimated(0, pnl.Left, pnl.Top, Width, Height)
	cvs.Resize(Width, Height)
End Sub

' GETTERS, SETTERS

'Returns a copy of B4XBitmap.
Public Sub CreateBitmap As B4XBitmap
	Return cvs.CreateBitmap
End Sub

'Returns a B4XRect by passing position, width and height.
Public Sub CreateRect (Left As Float, Top As Float, Width As Float, Height As Float) As B4XRect
	Dim r As B4XRect
	r.Initialize(Left, Top, Left+Width, Top+Height)
	Return r
End Sub

'Returns the native B4XCanvas.
Public Sub Canvas As B4XCanvas
	Return cvs
End Sub

'Returns the native Canvas.
Sub GetNativeCanvas As Canvas
   Dim jo As JavaObject = cvs
   jo = jo.GetFieldJO("cvs")
   #If B4J
      Return jo.RunMethod("getObject", Null)
   #End If
   Return jo
End Sub

'Returns the canvas panel.
Public Sub Panel As B4XView
	Return pnl
End Sub

'Returns a B4XRect with the same dimensions as the target view.
Public Sub TargetRect As B4XRect
	Return cvs.TargetRect
End Sub

'Returns a target view.
Public Sub TargetView As B4XView
	Return cvs.TargetView
End Sub

'Gets or sets the canvas Width (You can use Resize instead to resize it).
Public Sub getWidth As Double
	Return pnl.Width
End Sub
Public Sub setWidth(Width As Double)
	Resize (Width, pnl.Height)
End Sub

'Gets or sets the canvas Height (You can use Resize instead to resize it).
Public Sub getHeight As Double
	Return pnl.Height
End Sub
Public Sub setHeight(Height As Double)
	Resize (pnl.Width, Height)
End Sub

'----------------------------------- END OF PUBLIC SUBS ------------------------------------------

Private Sub CommitCommand(Args As List)
	Try
		If mAutoInvalidate Then
			ParseCommand(Args)
		Else
			DrawList.Add(Args)
		End If
	Catch
		Log("CommitCommand: ERROR: " & LastException)
	End Try
End Sub

Private Sub ExecuteDrawList(cmdList As List)
'	Log("DrawList")
	
'	For cnt = 0 To cmdList.Size-1 ' For all draw commands
'		ParseCommand(cmdList.Get(cnt))
'	Next
	
	For Each o As Object In cmdList ' For all draw commands
		ParseCommand(o)
	Next
	
	DrawList.Clear
End Sub

Private Sub ParseCommand(Args As List)
	
	count = count + 1
'	Log("ParseCommand [" & count "]: " & cmd & "    ARGS: " & Args)

	Try

		Dim cmd As String = Args.Get(0) ' With LIST      Args.Get(0) is the command, from Args.Get(1) there are arguments
		'   Dim cmd As String = Args(0) ' With ARRAY     Args(0) is the command, from Args(1) there are arguments
	
		Select cmd
			Case "Clear"
				Dim rect As B4XRect
				rect.Initialize(0, 0, pnl.Width, pnl.Height)
				cvs.DrawRect(rect, Args.Get(1), True, 0)
			Case "ClearRect"
				cvs.ClearRect(Args.Get(1))
			
				' BITMAP
			Case "DrawBitmap"
				cvs.DrawBitmap(Args.Get(1), Args.Get(2))
			Case "DrawBitmapRotated"
				cvs.DrawBitmapRotated(Args.Get(1), Args.Get(2), Args.Get(3))
			
				' PIXELS
			Case "DrawPixel"
'			    cvs.DrawLine(Args.Get(1), Args.Get(2), Args.Get(1)+1.0, Args.Get(2)+1.0, Args.Get(3), 1)			
				#If B4J
					cvs.DrawCircle(Args.Get(1), Args.Get(2), .5, Args.Get(3), True, 0) '.5
				#Else If B4A
				   cvs.DrawCircle(Args.Get(1), Args.Get(2), 1.0, Args.Get(3), True, 0) '1.0
				#End If
			Case "DrawPixel2"
'		    	cvs.DrawLine(Args.Get(1), Args.Get(2), Args.Get(1)+1.0, Args.Get(2)+1.0, Args.Get(3), (Args.Get(4)*2))
				
            #If B4J
					cvs.DrawCircle(Args.Get(1), Args.Get(2), Args.Get(4), Args.Get(3), True, 0) 
				#Else If B4A
				cvs.DrawCircle(Args.Get(1), Args.Get(2), Args.Get(4)*2, Args.Get(3), True, 0) ' RADDOPPIATO IL RAGGIO, DA CONTROLLARE
				#End If
				
				' LINES
			Case "DrawLine"
				cvs.DrawLine(Args.Get(1), Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), Args.Get(6))
			Case "DrawLineTo"
				'''''''	cvs.DrawLine(CurX, CurY, Args.Get(1), Args.Get(2), Args.Get(3), Args.Get(4)) ' To be implemented
            
				' PATH
			Case "ClipPath"  ' ClipPath (Path As B4XPath)
				Dim t() As B4XPath = Args.Get(1)			' Reading the B4XPath array back
'			   Log( t(0) )      ' The B4XPath we really want in t(0)
				cvs.ClipPath(t(0))
			Case "DrawPath"  ' DrawPath (Path As B4XPath, Color As Int, Filled As Boolean, StrokeWidth As Float)
				Dim t() As B4XPath = Args.Get(1)	' Reading the B4XPath array back
'			   Log( t(0) )      ' The B4XPath we really want in t(0)
				cvs.DrawPath(t(0), Args.Get(2), Args.Get(3), Args.Get(4))
			Case "DrawPathRotated"  ' DrawPathRotated (path As B4XPath, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float, CenterX As Float, CenterY As Float)
				Dim t() As B4XPath = Args.Get(1)	' Reading the B4XPath array back
'			   Log( t(0) )      ' The B4XPath we really want in t(0)
				cvs.DrawPathRotated(t(0), Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), Args.Get(6), Args.Get(7))
		
				' RECT
			Case "DrawRect"  ' DrawRect (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float)
				cvs.DrawRect(Args.Get(1), Args.Get(2), Args.Get(3), Args.Get(4))
			Case "DrawRectRotated"  ' DrawRectRotated (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float)
				Dim path As B4XPath
				Dim rect As B4XRect = Args.Get(1)
				rect.Initialize(rect.Left, rect.Top, rect.Right, rect.Bottom)
				path.InitializeRoundedRect(rect, 0)
				cvs.DrawPathRotated(path, Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), rect.CenterX, rect.CenterY)

				' ROUND RECT
			Case "DrawRoundRect"   ' DrawRoundRect(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, CornerRadius As Float)
				Dim path As B4XPath
				Dim rect As B4XRect = Args.Get(1)
				path.InitializeRoundedRect(rect, Args.Get(5))
				cvs.DrawPathRotated(path, Args.Get(2), Args.Get(3), Args.Get(4), 0, rect.CenterX, rect.CenterY) ' 0 degrees
			Case "DrawRoundRectRotated" '	DrawRoundRectRotated(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, CornerRadius As Float, Degrees As Float)
				Dim path As B4XPath
				Dim rect As B4XRect = Args.Get(1)
				path.InitializeRoundedRect(rect, Args.Get(5))
				cvs.DrawPathRotated(path, Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(6), rect.CenterX, rect.CenterY)
			
				' CIRCLE
			Case "DrawCircle"
				cvs.DrawCircle(Args.Get(1), Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), Args.Get(6))
				
				' OVAL
			Case "DrawOval"  ' DrawOval(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float)
				Dim path As B4XPath
				path.InitializeOval(Args.Get(1))
				cvs.DrawPath(path, Args.Get(2), Args.Get(3), Args.Get(4))
			Case "DrawOvalRotated" ' DrawOvalRotated(Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float)
				Dim path As B4XPath
				path.InitializeOval(Args.Get(1))
				cvs.DrawPathRotated(path, Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), Args.Get(1).As(B4XRect).CenterX, Args.Get(1).As(B4XRect).CenterY)
			
				' TEXT
			Case "DrawText"  ' DrawTextRotated (Text As String, x As Double, y As Double, Font As B4XFont, Color As Int, Alignment As Object)
				Dim tAlign As JavaObject
				Dim alignString As String = Args.Get(6).As(String).toUpperCase
				#If B4J
					tAlign.InitializeStatic("javafx.scene.text.TextAlignment")
				#Else If B4A
					tAlign.InitializeStatic("android.graphics.Paint.Align")
				#End If
				cvs.DrawText(Args.Get(1), Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), tAlign.GetField(alignString))
			Case "DrawTextRotated"  ' DrawTextRotated (Text As String, x As Double, y As Double, Font As B4XFont, Color As Int, Alignment As Object, Degrees As Float)
				Dim tAlign As JavaObject
				Dim alignString As String = Args.Get(6).As(String).toUpperCase
				#If B4J
					tAlign.InitializeStatic("javafx.scene.text.TextAlignment")
				#Else If B4A
					tAlign.InitializeStatic("android.graphics.Paint.Align")
				#End If
				cvs.DrawTextRotated(Args.Get(1), Args.Get(2), Args.Get(3), Args.Get(4), Args.Get(5), tAlign.GetField(alignString), Args.Get(7))
			
			Case Else
				Log("Unknow command: " & cmd)
							
		End Select
		
		#If B4A
			If mAutoInvalidate Then
'			   Log("AutoInvalidate on command " & cmd)
				cvs.Invalidate
			End If
		#End If
		
	Catch
		Log("ERROR -> " & LastException)
	End Try
	
End Sub