B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
#region public fileds
	Public const cPhoto As Int=0
	Public const cVideo As Int=1
	Public const cAudio As Int=2
	Public const cNew As Int=0
	Public const cChoose As Int=1
#end region

#region private fields
	Private const fMimeType(3) As String=Array As String("image/*","video/*","audio/*")
	Private const fIntent(3) As String=Array As String("android.media.action.IMAGE_CAPTURE","android.media.action.VIDEO_CAPTURE","android.provider.MediaStore.RECORD_SOUND")
	Private fActivity As Object
	Private fSharedFolder As String
	Private fUseFileProvider As Boolean
	Private fIOn As Object
	Private fWhat As Int
	Private fDirName As String
	Private fFileName As String
#end region
End Sub

#region manifest
'add this lines to your manifest
'AddApplicationText(
'  <provider
'  android:name="android.support.v4.content.FileProvider"
'  android:authorities="$PACKAGE$.provider"
'  android:exported="false"
'  android:grantUriPermissions="true">
'  <meta-data
'  android:name="android.support.FILE_PROVIDER_PATHS"
'  android:resource="@xml/provider_paths"/>
'  </provider>
')
'CreateResource(xml, provider_paths,
'   <files-path name="name" path="shared" />
')
#end region

#region public methods
'initialize class
'aactivity is the activity which initializes the instance
'<code>
'	Dim mi As clMediaIntent
'	mi.Initialize(Me)
'</code>
Public Sub Initialize(aactivity As Object)
	fActivity=getActivity(aactivity)
	initProvider
End Sub

'return dir name which contains media file
public Sub getDirName As String
	Return fDirName
End Sub

'return media file name
public Sub getFileName As String
	Return fFileName
End Sub

'get a media
'awhat is the type (cPhoto,cVideo,cAudio)
'afrom the origin (cNew,cChoose)
'return true if successfull, otherwise false
'<code>
'	Dim m As clMedia
'	m.Initialize(Me)
'	wait for (m.media(m.cphoto,m.cNew)) complete (aresult As Boolean)
'	If aresult Then
'		File.Copy(m.DirName,m.FileName,File.DirInternal,"file")
'	End If
'</code>
public Sub media(awhat As Int,afrom As Int) As ResumableSub
	wait for (CallSub2(Me,"media_" & afrom,awhat)) complete (aresult As Boolean)
	Return aresult
End Sub
#end region

#region private methods
private Sub initProvider
	Dim folder As String="shared"
	Dim p As Phone
	If (p.SdkVersion>=24) Or (Not(File.ExternalWritable)) Then
		fUseFileProvider = True
		fSharedFolder = File.Combine(File.DirInternal,folder)
		File.MakeDir("", fSharedFolder)
	Else
		Dim rp As RuntimePermissions
		fUseFileProvider = False
		fSharedFolder=rp.GetSafeDirDefaultExternal(folder)
	End If
End Sub

private Sub GetFileUri (FileName As String) As Object
	If Not(fUseFileProvider) Then
		Dim uri As JavaObject
		Return uri.InitializeStatic("android.net.Uri").RunMethod("parse", Array("file://" & File.Combine(fSharedFolder, FileName)))
	Else
		Dim f As JavaObject
		f.InitializeNewInstance("java.io.File", Array(fSharedFolder, FileName))
		Dim fp As JavaObject
		Dim context As JavaObject
		context.InitializeContext
		fp.InitializeStatic("android.support.v4.content.FileProvider")
		Return fp.RunMethod("getUriForFile", Array(context, Application.PackageName & ".provider", f))
	End If
End Sub

private Sub media_0(awhat As Int) As ResumableSub
	fWhat=awhat
	Dim i As Intent
	i.Initialize(fIntent(fWhat),"")
	If fWhat<>cAudio Then
		Dim u As Object=GetFileUri("media")
		i.PutExtra("output",u)
	End If
	Try
		StartActivityForResult(i)
		Wait For ion_Event(MethodName As String,Args() As Object)
		If -1=Args(0) Then
			If fWhat=cAudio Then
				Dim i As Intent=Args(1)
				fDirName="ContentDir"
				fFileName=i.GetData
			Else
				fDirName=fSharedFolder
				fFileName="media"
			End If
			Return True
		End If
	Catch
		Log(LastException)
	End Try
	Return False
End Sub

private Sub media_1(awhat As Int) As ResumableSub
	fWhat=awhat
	Dim cc As ContentChooser
	cc.Initialize("cc")
	cc.Show(fMimeType(fWhat),"Select a media")
	wait for cc_result(aSuccess As Boolean, aDirName As String, aFileName As String)
	If aSuccess Then
		fDirName=aDirName
		fFileName=aFileName
		Return True
	End If
	Return False
End Sub

private Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = fActivity
	fIOn = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array As Object(fIOn, i))
End Sub

private Sub getActivity(aActivity As Object) As Object
	Dim jo As JavaObject
	Dim cls As String = aActivity
	cls = cls.SubString("class ".Length)
	jo.InitializeStatic(cls)
	Return jo.GetField("processBA")
End Sub
#end region
