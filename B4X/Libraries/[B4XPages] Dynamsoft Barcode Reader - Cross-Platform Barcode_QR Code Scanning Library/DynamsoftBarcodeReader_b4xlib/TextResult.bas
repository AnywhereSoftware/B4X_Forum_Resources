B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	#if b4i
	Private mTextResult As NativeObject
	#else
	Private mTextResult As JavaObject
	#End If	
	Private mText As String
	Private mResultPoints(4) As Point2D
	Type Point2D(x As Int,y As Int)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(result As Object)
	mTextResult=result	
	Parse
End Sub

#if b4i

private Sub Parse
	mText=mTextResult.GetField("barcodeText").AsString
	Dim localizationResult As NativeObject=mTextResult.GetField("localizationResult")	
	Dim resultPoints As List=localizationResult.GetField("resultPoints")	
	For i=0 To 3	
		Dim NSPoint As NativeObject = resultPoints.Get(i)		
		Dim CGPoint As NativeObject = asNO(Me).RunMethod("convert:",Array(NSPoint))
		Dim values() As Float=CGPoint.ArrayFromPoint(CGPoint)
		Dim p As Point2D
		p.Initialize
		p.x=values(0)
		p.y=values(1)
		mResultPoints(i)=p
	Next
End Sub

#Else

Private Sub Parse
	mText=mTextResult.GetField("barcodeText")
	Dim points() As Object=mTextResult.GetFieldJO("localizationResult").GetField("resultPoints")
	For i=0 To 3
		Dim point As JavaObject=points(i)	
		Dim p As Point2D
		p.Initialize
		p.x=point.GetField("x")
		p.y=point.GetField("y")
		mResultPoints(i)=p
	Next
End Sub

#End If

Public Sub getObject As Object
	Return mTextResult
End Sub

Public Sub getText As String
	Return mText
End Sub

Public Sub getResultPoints As Point2D()
	Return mResultPoints
End Sub

#if b4i
private Sub asNO(o As Object) As NativeObject
	Dim no As NativeObject
	no=o
	Return no
End Sub

#if objc

- (CGPoint) convert: (NSValue*) x {
    CGPoint point = [(NSValue *)x CGPointValue];
	return point;
}

#End If

#End If
