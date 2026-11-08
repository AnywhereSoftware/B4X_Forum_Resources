B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#Event: AnimationStart
#Event: AnimationEnd
#Event: AnimationCancel
#Event: AnimationRepeat
'mcLottie wraps Airbnb Lottie Android 6.7.x through JavaObject.
'Add the Lottie AAR and its required dependencies with #AdditionalJar.
'Add the R8 keep rules below to the B4A manifest editor when using R8.
'=====================================================================
'R8 keep rules (needed because every call above goes through reflection,
'so R8 sees no direct references and strips/renames them).
'Add to the manifest editor:
'
'  AddProguardText(
'
'    -keep class com.airbnb.lottie.** { *; }
'    -dontwarn com.airbnb.lottie.**
'    -dontwarn okio.**
'    -dontwarn kotlin.**
'
'  )
'=====================================================================
'
'Example:
'  Private lot As mcLottie
'  lot.Initialize(Me, "lot")
'  Panel1.AddView(lot.GetView, 0, 0, 200dip, 200dip)
'  lot.LoadAsset("loading.json")
'  lot.AutoRepeat = True
'  lot.Play
'Events: lot_AnimationStart, lot_AnimationEnd, lot_AnimationCancel, lot_AnimationRepeat

Sub Class_Globals
	Private mCallBack As Object
	Private mEventName As String
	Private lv As JavaObject
	Private iv As ImageView
End Sub

Public Sub Initialize(Callback As Object, EventName As String)
	mCallBack = Callback
	mEventName = EventName
	Dim ctx As JavaObject
	ctx.InitializeContext
	lv.InitializeNewInstance("com.airbnb.lottie.LottieAnimationView", Array(ctx))
	iv = lv 'LottieAnimationView extends ImageView; B4A converts the wrapper
	Dim l As Object = lv.CreateEvent("android.animation.Animator.AnimatorListener", "Anim", Null)
	lv.RunMethod("addAnimatorListener", Array(l))
End Sub

'Add this to a Panel/Activity with AddView
Public Sub GetView As View
	Return iv
End Sub

'--- Loading ---------------------------------------------------------

'Load from the Files tab (assets). Use a lowercase file name.
Public Sub LoadAsset(FileName As String)
	lv.RunMethod("setAnimation", Array As Object(FileName))
End Sub

'Load a JSON animation from a B4A directory, such as File.DirInternal.
'External image files are read from their JSON-relative folders and inlined.
'Missing images are replaced with a transparent pixel, matching Flutter Lottie's
'behavior for the supplied career1.json, whose image file is not bundled.
Public Sub LoadFile(Directory As String, FileName As String)
	Dim Json As String = File.ReadString(Directory, FileName)
	Dim Parser As JSONParser
	Parser.Initialize(Json)
	Dim Root As Map = Parser.NextObject
	If Root.ContainsKey("assets") Then
		Dim Assets As List = Root.Get("assets")
		For Each ImageAsset As Map In Assets
			If ImageAsset.ContainsKey("p") And ImageAsset.ContainsKey("u") And 1 <> ImageAsset.GetDefault("e", 0) Then
				Dim ImageFolder As String = ImageAsset.Get("u")
				If ImageFolder.EndsWith("/") Then ImageFolder = ImageFolder.SubString2(0, ImageFolder.Length - 1)
				Dim ImageName As String = ImageAsset.Get("p")
				If File.Exists(Directory & "/" & ImageFolder, ImageName) Then
					Dim ImageBytes() As Byte = File.ReadBytes(Directory & "/" & ImageFolder, ImageName)
					Dim Base64 As JavaObject
					Base64.InitializeStatic("android.util.Base64")
					Dim Encoded As String = Base64.RunMethod("encodeToString", Array(ImageBytes, 2)) 'NO_WRAP
					ImageAsset.Put("p", "data:image/png;base64," & Encoded)
				Else
					'Transparent 1x1 PNG. The Lottie JSON references an image, but
					'the supplied Flutter project does not include that image file.
					ImageAsset.Put("p", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+j2ioAAAAASUVORK5CYII=")
				End If
				ImageAsset.Put("e", 1)
			End If
		Next
	End If
	Dim Generator As JSONGenerator
	Generator.Initialize(Root)
	LoadJson(Generator.ToString, Directory & "/" & FileName)
End Sub

'Load JSON from a content:// or file:// URI.
Public Sub LoadUri(Uri As String)
	Dim ctx As JavaObject
	ctx.InitializeContext
	Dim UriClass As JavaObject
	UriClass.InitializeStatic("android.net.Uri")
	Dim ParsedUri As JavaObject = UriClass.RunMethod("parse", Array(Uri))
	Dim UriPath As String = ParsedUri.RunMethod("getPath", Null)
	If UriPath.StartsWith("/android_asset/") Then
		'ContentResolver cannot open file:///android_asset URIs; read from B4A Files/Assets.
		Dim AssetPath As String = UriPath.SubString(15)
		LoadJson(File.ReadString(File.DirAssets, AssetPath), Uri)
		Return
	End If
	Dim Resolver As JavaObject = ctx.RunMethod("getContentResolver", Null)
	Dim Stream As InputStream = Resolver.RunMethod("openInputStream", Array(ParsedUri))
	Dim Reader As TextReader
	Reader.Initialize2(Stream, "UTF8")
	Dim Json As String = Reader.ReadAll
	Reader.Close
	LoadJson(Json, Uri)
End Sub

'Set the folder inside the app's Assets that contains image assets.
'This is needed when an animation loaded from Assets refers to image files.
Public Sub SetImageAssetsFolder(Folder As String)
	lv.RunMethod("setImageAssetsFolder", Array As Object(Folder))
End Sub

'Override a fill color on the specified Lottie key path.
'Separate key path segments with /. Example: SetColor("Layer/Shape/Fill", Colors.Red)
Public Sub SetColor(KeyPath As String, Color As Int)
	SetColorProperty(KeyPath, Color, 1) 'LottieProperty.COLOR
End Sub

'Override fill colors belonging to a layer. The layer and its descendants are matched.
Public Sub SetLayerColor(LayerName As String, Color As Int)
	SetColorProperty(LayerName & "/**", Color, 1) 'LottieProperty.COLOR
End Sub

'Override fill colors belonging to a shape and its descendants in a layer.
Public Sub SetShapeColor(LayerName As String, ShapeName As String, Color As Int)
	SetColorProperty(LayerName & "/" & ShapeName & "/**", Color, 1) 'LottieProperty.COLOR
End Sub

'Override the color of a specific fill in a layer and shape.
Public Sub SetFillColor(LayerName As String, ShapeName As String, FillName As String, Color As Int)
	SetColorProperty(LayerName & "/" & ShapeName & "/" & FillName, Color, 1) 'LottieProperty.COLOR
End Sub

'Override a stroke color on the specified Lottie key path.
Public Sub SetStrokeColor(KeyPath As String, Color As Int)
	SetColorProperty(KeyPath, Color, 2) 'LottieProperty.STROKE_COLOR
End Sub

Private Sub SetColorProperty(KeyPath As String, Color As Int, Property As Int)
	Dim KeyNames() As String = Regex.Split("/", KeyPath)
	Dim LottieKeyPath As JavaObject
	LottieKeyPath.InitializeNewInstance("com.airbnb.lottie.model.KeyPath", Array(KeyNames))
	Dim ValueCallback As JavaObject
	ValueCallback.InitializeNewInstance("com.airbnb.lottie.value.LottieValueCallback", Array(Color))
	lv.RunMethod("addValueCallback", Array(LottieKeyPath, Property, ValueCallback))
End Sub

Public Sub LoadJson(Json As String, CacheKey As String)
	lv.RunMethod("setAnimationFromJson", Array As Object(Json, CacheKey))
End Sub

Public Sub LoadUrl(Url As String)
	lv.RunMethod("setAnimationFromUrl", Array As Object(Url))
End Sub

'--- Playback --------------------------------------------------------

Public Sub Play
	lv.RunMethod("playAnimation", Null)
End Sub

Public Sub Pause
	lv.RunMethod("pauseAnimation", Null)
End Sub

Public Sub Resume
	lv.RunMethod("resumeAnimation", Null)
End Sub

Public Sub Cancel
	lv.RunMethod("cancelAnimation", Null)
End Sub

Public Sub IsPlaying As Boolean
	Return lv.RunMethod("isAnimating", Null)
End Sub

'-1 = infinite
Public Sub setRepeatCount(Count As Int)
	lv.RunMethod("setRepeatCount", Array As Object(Count))
End Sub

Public Sub setAutoRepeat(Enabled As Boolean)
	If Enabled Then setRepeatCount(-1) Else setRepeatCount(0)
End Sub

Public Sub getAutoRepeat As Boolean
	Dim c As Int = lv.RunMethod("getRepeatCount", Null)
	Return c = -1
End Sub

Public Sub setSpeed(Speed As Float)
	lv.RunMethod("setSpeed", Array As Object(AsFloat(Speed)))
End Sub

'0 to 1
Public Sub setProgress(Progress As Float)
	lv.RunMethod("setProgress", Array As Object(AsFloat(Progress)))
End Sub

Public Sub getProgress As Float
	Return lv.RunMethod("getProgress", Null)
End Sub

'Duration in ms
Public Sub getDuration As Long
	Return lv.RunMethod("getDuration", Null)
End Sub

Public Sub SetMinMaxProgress(MinP As Float, MaxP As Float)
	lv.RunMethod("setMinAndMaxProgress", Array As Object(AsFloat(MinP), AsFloat(MaxP)))
End Sub

'--- Events ----------------------------------------------------------

Private Sub Anim_AnimationStart(a As Object)
	CallEvent("_AnimationStart")
End Sub

Private Sub Anim_AnimationEnd(a As Object)
	CallEvent("_AnimationEnd")
End Sub

Private Sub Anim_AnimationCancel(a As Object)
	CallEvent("_AnimationCancel")
End Sub

Private Sub Anim_AnimationRepeat(a As Object)
	CallEvent("_AnimationRepeat")
End Sub

Private Sub CallEvent(Suffix As String)
	If SubExists(mCallBack, mEventName & Suffix) Then
		CallSubDelayed(mCallBack, mEventName & Suffix)
	End If
End Sub

'--- Helpers ---------------------------------------------------------

Private Sub AsFloat(v As Double) As Object
	Dim j As JavaObject
	j.InitializeNewInstance("java.lang.Float", Array As Object(v))
	Return j
End Sub

