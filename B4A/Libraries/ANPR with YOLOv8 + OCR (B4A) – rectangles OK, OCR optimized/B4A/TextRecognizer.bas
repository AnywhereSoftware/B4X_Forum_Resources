B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.51
@EndOfDesignText@
'v1.11
Sub Class_Globals
	Type TextRecognizerResult (Success As Boolean, Text As String)
	#if B4I
	Private recognizer As NativeObject
	#else if B4A
	Private recognizer As JavaObject
	#end if
End Sub

'LanguageModel - one of the following values (case insensitive): Latin, Chinese, Devanagari, Japanese, Korean
'Make sure to add the required references and bundles (in B4i).
Public Sub Initialize (LanguageModel As String)
	LanguageModel = LanguageModel.ToLowerCase
	Dim lm As Map = CreateMap("latin": "", "chinese": "Chinese", "devanagari": "Devanagari", "japanese": "Japanese", "korean": "Korean")
	If lm.ContainsKey(LanguageModel) = False Then
		Log("error: language model not found: " & LanguageModel)
		Return
	End If
	#if B4I
	Dim options As NativeObject
	options = options.Initialize("MLK" & lm.Get(LanguageModel) & "TextRecognizerOptions").RunMethod("new", Null)
	Dim recognizer As NativeObject
	recognizer = recognizer.Initialize("MLKTextRecognizer").RunMethod("textRecognizerWithOptions:", Array(options))
	#else if B4A
	Dim options As JavaObject
	options = options.InitializeNewInstance($"com.google.mlkit.vision.text.${LanguageModel}.${lm.Get(LanguageModel)}TextRecognizerOptions.Builder"$, Null).RunMethod("build", Null)
	recognizer = recognizer.InitializeStatic("com.google.mlkit.vision.text.TextRecognition").RunMethod("getClient", Array(options))
	Log(recognizer)
	#end if
End Sub

Public Sub Recognize (bmp As B4XBitmap) As ResumableSub
	Dim res As TextRecognizerResult
	res.Initialize
	#if B4I
	recognizer.RunMethod("processImage:completion:", Array(ImageToMLImage(bmp), Me.as(NativeObject).RunMethod("createBlock", Null)))
	Wait For Process_Result(Success As Boolean, MLKText As Object)
	res.Success = Success
	If Success Then
		#if B4I
		res.Text = MLKText.As(NativeObject).GetField("text").AsString
		#else if B4A
		#end if
	End If
	#else if B4A
	Dim task As JavaObject = recognizer.RunMethod("process", Array(ImageToMLImage(bmp)))
	Do While task.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	If task.RunMethod("isSuccessful", Null) Then
		res.Success = True
		Dim Text As JavaObject = task.RunMethod("getResult", Null)
		res.Text = Text.RunMethod("getText", Null)
	Else
		Log(task.RunMethod("getException", Null))
	End If
	#End If
	Return res
End Sub

Private Sub ImageToMLImage(bmp As B4XBitmap) As Object
	#if B4I
	Dim image As NativeObject
	image = image.Initialize("MLKVisionImage").RunMethod("alloc", Null).RunMethod("initWithImage:", Array(bmp))
	#else if B4A
	Dim image As JavaObject
	image = image.InitializeStatic("com.google.mlkit.vision.common.InputImage").RunMethod("fromBitmap", Array(bmp, 0))
	#end if
	Return image
End Sub

#if OBJC
-(void (^)(id, id)) createBlock {
	void (^block)(id result, id error) = ^void (id result, id error){
		if (error != nil || result == nil) {
			[B4I shared].lastError = error;
			[self.bi raiseUIEvent:nil event:@"process_result::" params:@[@(false), [NSNull null]]];
		} else {
			[self.bi raiseUIEvent:nil event:@"process_result::" params:@[@(true), result]];
		}
	};
	return block;
}
#End If