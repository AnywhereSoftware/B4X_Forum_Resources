B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private BANano As BANano
	Private mElement As BANanoElement
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As BANanoFiles
	Return Me
End Sub

'create an invisible file input
Sub AddFileSelect(eventHandler As Object, parentID As String, fid As String)
	fid = fid.tolowercase
	Dim methodName As String = $"${fid}_change"$
	'define the control
	Dim fu As String = $"<input id="${fid}" name="${fid}" type="file" style="display:none !important"></input>"$
	'define the element
	mElement = BANano.GetElement($"#${parentID}"$).Append(fu).Get($"#${fid}"$)
	'add the event
	mElement.HandleEvents("change", eventHandler, methodName)
	'
	If SubExists(eventHandler, methodName) = False Then
		Log($"BANanoFIles.AddFileSelect - '${fid}' you need to add the change event"$)
	End If
End Sub

'file file list from target
Sub GetFileListFromTarget(e As BANanoEvent) As List
	Dim files As List = e.OtherField("target").GetField("files").Result
	Return files
End Sub

'ensure we can select the same file again
Sub Nullify
	mElement.SetField("value", Null)
End Sub

'execute the click event to show the file
Sub ShowFileSelect(fid As String)
	fid.ToLowerCase
	mElement.RunMethod("click", Null)
End Sub

'read file as text
public Sub readAsText(fr As String) As BANanoPromise
	Dim promise As BANanoPromise 'ignore
		
	' calling a single upload
	promise.CallSub(Me, "ReadFile", Array(fr, "readAsText"))
	Return promise
End Sub

'read file as binary string
Sub readAsBinaryString(fr As String) As BANanoPromise
	Dim promise As BANanoPromise 'ignore
		
	' calling a single upload
	promise.CallSub(Me, "ReadFile", Array(fr, "readAsBinaryString"))
	Return promise
End Sub

'read file as data url
Sub readAsDataURL(fr As String) As BANanoPromise
	Dim promise As BANanoPromise 'ignore
		
	' calling a single upload
	promise.CallSub(Me, "ReadFile", Array(fr, "readAsDataURL"))
	Return promise
End Sub

'read data as array buffer
Sub readAsArrayBuffer(fr As String) As BANanoPromise
	Dim promise As BANanoPromise 'ignore
		
	' calling a single upload
	promise.CallSub(Me, "ReadFile", Array(fr, "readAsArrayBuffer"))
	Return promise
End Sub

'read the file
private Sub ReadFile(FileToRead As Object, MethodName As String)
	' make a filereader
	Dim FileReader As BANanoObject
	FileReader.Initialize2("FileReader", Null)
	' attach the file (to get the name later)
	FileReader.SetField("file", FileToRead)
	
	' make a callback for the onload event
	' an onload of a FileReader requires a 'event' param
	Dim event As Map
	FileReader.SetField("onload", BANano.CallBack(Me, "OnLoad", Array(event)))
	FileReader.SetField("onerror", BANano.CallBack(Me, "OnError", Array(event)))
	' start reading the DataURL
	FileReader.RunMethod(MethodName, FileToRead)
End Sub

private Sub OnLoad(event As Map) As String 'ignore
	' getting our file again (set in UploadFileAndGetDataURL)
	Dim FileReader As BANanoObject = event.Get("target")
	Dim UploadedFile As BANanoObject = FileReader.GetField("file")
	' return to the then of the UploadFileAndGetDataURL
	BANano.ReturnThen(CreateMap("name": UploadedFile.GetField("name"), "result": FileReader.Getfield("result")))
End Sub

private Sub OnError(event As Map) As String 'ignore
	Dim FileReader As BANanoObject = event.Get("target")
	Dim UploadedFile As BANanoObject = FileReader.GetField("file")
	Dim Abort As Boolean = False
	' uncomment this if you want to abort the whole operatio
	' Abort = true
	' FileReader.RunMethod("abort", Null)
	
	BANano.ReturnElse(CreateMap("name": UploadedFile.GetField("name"), "result": FileReader.GetField("error"), "abort": Abort))
End Sub

'upload a file
Sub UploadFile(EventHandler As Object, MethodName As String, fName As String, data As Object)
	Dim formData As BANanoObject
	formData.Initialize2("FormData",Null)
	formData.RunMethod("append", Array("upload", data, fName))
	BANano.CallSub(EventHandler, MethodName, formData)
End Sub
