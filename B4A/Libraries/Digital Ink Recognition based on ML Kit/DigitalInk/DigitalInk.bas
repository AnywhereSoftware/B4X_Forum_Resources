B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.51
@EndOfDesignText@
'v1.10
Sub Class_Globals
	Type DigitalInkRecognizerResult (Success As Boolean, Texts As List)
	#if B4I
	Private recognizer As NativeObject
	Private model As NativeObject
	Private ModelManager As NativeObject
	#else if B4A
	Private recognizer As JavaObject
	Private ModelManager As JavaObject
	Private Model As JavaObject
	#end if
End Sub

'LanguageModel - one of the following values (case insensitive): Latin, Chinese, Devanagari, Japanese, Korean
'Make sure to add the required references and bundles (in B4i).
Public Sub Initialize (LanguageModel As String)
	
	#if B4I
	ModelManager = ModelManager.Initialize("MLKModelManager").RunMethod("modelManager", Null)
	Dim ModelIdentifier As NativeObject
	ModelIdentifier = ModelIdentifier.Initialize("MLKDigitalInkRecognitionModelIdentifier").RunMethod("modelIdentifierForLanguageTag:", Array("en"))
	model = model.Initialize("MLKDigitalInkRecognitionModel").RunMethod("alloc", Null).RunMethod("initWithModelIdentifier:", Array(ModelIdentifier))
	Dim options As NativeObject
	options = options.Initialize("MLKDigitalInkRecognizerOptions").RunMethod("alloc", Null).RunMethod("initWithModel:", Array(model))
	Dim recognizer As NativeObject
	recognizer = recognizer.Initialize("MLKDigitalInkRecognizer").RunMethod("digitalInkRecognizerWithOptions:", Array(options))
	Log(recognizer)
	#else if B4A
	ModelManager = ModelManager.InitializeStatic("com.google.mlkit.common.model.RemoteModelManager").RunMethod("getInstance", Null)
	Dim ModelIdentifier As JavaObject
	ModelIdentifier = ModelIdentifier.InitializeStatic("com.google.mlkit.vision.digitalink.DigitalInkRecognitionModelIdentifier").RunMethod("fromLanguageTag", Array(LanguageModel))
	Dim Model As JavaObject
	Model = Model.InitializeStatic("com.google.mlkit.vision.digitalink.DigitalInkRecognitionModel").RunMethodJO("builder", Array(ModelIdentifier)).RunMethod("build", Null)
	Dim options As JavaObject
	options = options.InitializeStatic("com.google.mlkit.vision.digitalink.DigitalInkRecognizerOptions").RunMethodJO("builder", Array(Model)).RunMethod("build", Null)
	recognizer = recognizer.InitializeStatic("com.google.mlkit.vision.digitalink.DigitalInkRecognition").RunMethod("getClient", Array(options))
	Log(recognizer)
	#end if
End Sub

Public Sub IsModelDownloaded As ResumableSub
	Wait For (WaitForTaskToComplete(ModelManager.RunMethod("isModelDownloaded", Array(Model)), False)) Complete (Result As Object)
	Return IIf(Result = Null, False, Result.As(Boolean))
End Sub

Public Sub DownloadModel As ResumableSub
	Dim DownloadConditions As JavaObject
	DownloadConditions = DownloadConditions.InitializeNewInstance("com.google.mlkit.common.model.DownloadConditions$Builder", Null).RunMethod("build", Null)
	Dim task As Object = ModelManager.RunMethod("download", Array(Model, DownloadConditions))
	Wait For (WaitForTaskToComplete(task, True)) Complete (Success As Boolean)
	Return Success
End Sub

Public Sub DeleteModel As ResumableSub
	Wait For (WaitForTaskToComplete(ModelManager.RunMethod("deleteDownloadedModel", Array(Model)), True)) Complete (Success As Boolean)
	Return Success
End Sub

Private Sub WaitForTaskToComplete (task As JavaObject, ReturnSuccess As Boolean) As ResumableSub
	Do While task.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	If task.RunMethod("isSuccessful", Null).As(Boolean) = False Then
		Log(task.RunMethod("getException", Null))
		Return IIf(ReturnSuccess, False, Null)
	Else
		Return IIf(ReturnSuccess, True, task.RunMethod("getResult", Null))
	End If
End Sub

Public Sub CreateInkPoint(x As Float, y As Float) As Object
	Dim p As JavaObject
	Return p.InitializeStatic("com.google.mlkit.vision.digitalink.Ink$Point").RunMethod("create", Array(x, y, DateTime.Now))
End Sub

Public Sub CreateStrokeFromPoints(Points As List) As Object
	Dim builder As JavaObject
	builder = builder.InitializeStatic("com.google.mlkit.vision.digitalink.Ink$Stroke").RunMethod("builder", Null)
	For Each p As Object In Points
		builder.RunMethod("addPoint", Array(p))
	Next
	Return builder.RunMethod("build", Null)
End Sub

Public Sub Recognize (WritingPanel As B4XView, Strokes As List) As ResumableSub
	Dim WritingArea As JavaObject
	WritingArea.InitializeNewInstance("com.google.mlkit.vision.digitalink.WritingArea", Array(WritingPanel.Width.As(Float), WritingPanel.Height.As(Float)))
	Dim RecContext As JavaObject
	RecContext = RecContext.InitializeStatic("com.google.mlkit.vision.digitalink.RecognitionContext").RunMethod("builder", Null)
	RecContext.RunMethodJO("setWritingArea", Array(WritingArea)).RunMethod("setPreContext", Array(""))
	
	RecContext = RecContext.RunMethod("build", Null)
	Dim res As DigitalInkRecognizerResult
	res.Initialize
	Dim InkBuilder As JavaObject
	InkBuilder = InkBuilder.InitializeStatic("com.google.mlkit.vision.digitalink.Ink").RunMethod("builder", Null)
	For Each stroke As Object In Strokes
		InkBuilder.RunMethod("addStroke", Array(stroke))
	Next
	Dim ink As Object = InkBuilder.RunMethod("build", Null)
	Wait For (WaitForTaskToComplete(recognizer.RunMethod("recognize", Array(ink, RecContext)), False)) Complete (Result As Object)
	Dim r As DigitalInkRecognizerResult
	r.Initialize
	r.Texts.Initialize
	If Result = Null Then Return r
	r.Success = True
	For Each cand As JavaObject In Result.As(JavaObject).RunMethod("getCandidates", Null).As(List)
		r.Texts.Add(cand.RunMethod("getText", Null))
	Next
	Return r
End Sub

