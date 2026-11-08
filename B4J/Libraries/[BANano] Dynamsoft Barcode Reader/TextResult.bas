B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	Private mTextResult As BANanoObject
	Private mText As String
	Private mResultPoints(4) As Point2D
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(result As Object)
	mTextResult=result
	Parse
End Sub

Private Sub Parse
	mText=mTextResult.GetField("barcodeText")
	Dim localizationResult As BANanoObject=mTextResult.GetField("localizationResult")
	For i=0 To 3
		Dim p As Point2D
		p.Initialize
		p.x=localizationResult.GetField("x"&(i+1))
		p.y=localizationResult.GetField("y"&(i+1))
		mResultPoints(i)=p
	Next
End Sub

Public Sub getObject As Object
	Return mTextResult
End Sub

Public Sub getText As String
	Return mText
End Sub

'bug of BANano, unable to return Point2D()
Public Sub getResultPoints As Object
	Return mResultPoints
End Sub
