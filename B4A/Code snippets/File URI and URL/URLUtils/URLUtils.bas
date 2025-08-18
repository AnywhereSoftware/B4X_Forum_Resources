B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Code module

Private Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub

'Returns a file URI. This can be used with WebView to access local resources.
'The URL depends on the compilation mode.
'The FileName parameter will be URL encoded.
'
'Note that this is the same as XUI.FileUri. You can use this if you do not plain to use XUI in your project.
'
'Example: <code>
'WebView1.LoadHtml($"<img src="${URLUtils.FileURI(File.DirAssets, "smiley.png")}" />"$)
''or:
'WebView1.LoadUrl($"${URLUtils.FileURI(File.DirAssets, "smiley.png")}"$)
'</code>
Public Sub FileURI(Dir As String, FileName As String) As String
	If Not(Dir = "AssetsDir") Then  ' AssetsDir = File.DirAssets
		Return "file://" & File.Combine(Dir, EncodeUrl(FileName, "UTF8"))
	End If
 
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
		
	If jo.GetField("virtualAssetsFolder") = Null Then
		Return "file:///android_asset/" & EncodeUrl(FileName.ToLowerCase, "UTF8")
	Else
		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
			EncodeUrl(jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)), "UTF8"))
	End If
End Sub


'Returns a file URL. This can be used with WebView to access local resources.
'The URL depends on the compilation mode.
'The FileName parameter need to be URL encoded if you pass it to a WebView.
'
'Example: <code>
'WebView1.LoadHtml($"<img src="${URLUtils.FileURL(File.DirAssets, "smiley.png")}" />"$)
''or:
'WebView1.LoadUrl($"${URLUtils.FileURL(File.DirAssets, "smiley.png")}"$)
'</code>
Public Sub FileURL(Dir As String, FileName As String) As String
	If Not(Dir = "AssetsDir") Then  ' AssetsDir = File.DirAssets
		Return "file://" & File.Combine(Dir, FileName)
	End If
 
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
		
	If jo.GetField("virtualAssetsFolder") = Null Then
		Return "file:///android_asset/" & FileName.ToLowerCase
	Else
		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
			jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))
	End If
End Sub

'Creates the URI of an asset file (The URI depends on the compilation mode).
'This can be used with WebView to access local resources, in this case FileName need to be URL encoded.
'
'Example:
'<code>Dim URI As String = $"<img src="${URLUtils.AssetFileURI("smiley.png")}"/>"$</code>
Public Sub AssetFileURI (FileName As String) As String
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
	If jo.GetField("virtualAssetsFolder") = Null Then
		Return "file:///android_asset/" & EncodeUrl(FileName.ToLowerCase, "UTF8")
	Else
		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
  			EncodeUrl(jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)), "UTF8"))
	End If
End Sub

'Creates the URL of an asset file (The URL depends on the compilation mode).
'This can be used with WebView to access local resources.
'
'Example:
'<code>Dim URL As String = $"<img src="${URLUtils.AssetFileURL("smiley.png")}"/>"$</code>
'
'This is code by Erel here: <link>link | https://www.b4x.com/android/forum/threads/printing-and-pdf-creation.76712/#content</link>
Public Sub AssetFileURL (FileName As String) As String 'Ignor
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")
	If jo.GetField("virtualAssetsFolder") = Null Then
		Return "file:///android_asset/" & FileName.ToLowerCase
	Else
		Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _
  			jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))
	End If
End Sub

Public Sub EncodeUrl(Url As String, CharSet As String) As String
	Dim su As StringUtils
	su.EncodeUrl(Url, CharSet)
	Return su.EncodeUrl(Url, CharSet).Replace("+", "%20")
End Sub