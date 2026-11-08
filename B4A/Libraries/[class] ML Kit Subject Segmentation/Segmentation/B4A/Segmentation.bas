B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Type SegmentationResult (Success As Boolean, ForegroundBitmap As B4XBitmap)
	Private segmenter As JavaObject
End Sub

Public Sub Initialize
	Dim options As JavaObject
	options.InitializeNewInstance("com.google.mlkit.vision.segmentation.subject.SubjectSegmenterOptions.Builder", Null)
	options = options.RunMethodJO("enableForegroundBitmap", Null).RunMethod("build", Null)
	Dim SubjectSegmentation As JavaObject
	SubjectSegmentation.InitializeStatic("com.google.mlkit.vision.segmentation.subject.SubjectSegmentation")
	segmenter = SubjectSegmentation.RunMethod("getClient", Array(options))
End Sub

Private Sub CreateInputImage(bmp As B4XBitmap) As Object
	Dim InputImage As JavaObject
	InputImage.InitializeStatic("com.google.mlkit.vision.common.InputImage")
	Return InputImage.RunMethod("fromBitmap", Array(bmp, 0))
End Sub

Public Sub Process (bmp As B4XBitmap) As ResumableSub
	Dim task As JavaObject = segmenter.RunMethod("process", Array(CreateInputImage(bmp)))
	Do While task.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	Dim res As SegmentationResult
	res.Initialize
	If task.RunMethod("isSuccessful", Null) Then
		res.Success = True
		Dim SubjectSegmentationResult As JavaObject = task.RunMethod("getResult", Null)
		res.ForegroundBitmap = SubjectSegmentationResult.RunMethod("getForegroundBitmap", Null)
	End If
	Return res
End Sub