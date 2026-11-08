B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
Sub Class_Globals
	Private Camera As Camera2
	Private cameraManager As JavaObject
	Private sjoCameraCharacteristics As JavaObject
	Private frontID As String
	Private rearID As String
End Sub

'Note:
'setTorchMode requires API 23 and above

'Uses following libraries:
'Camera2

'Might need these Manifest entries:
'AddPermission("android.permission.FLASHLIGHT")
'AddManifestText(<uses-feature android:name="android.hardware.camera.flash" />)
'Not required (while side-loading app) on:
' Pixel 7 running Android 13
' Chinese phone running Android 11
' Chinese phone running Android 6

Public Sub Initialize
	Camera.Initialize("Camera")
	sjoCameraCharacteristics.InitializeStatic("android.hardware.camera2.CameraCharacteristics")
	Dim jo As JavaObject = Camera
	cameraManager = jo.GetField("cameraManager")
	
	'Find cameras and determine if they hava a flash
	frontID = Camera.FindCameraId(True)
	If frontID <> "" Then
		If Not(HasFlash(frontID)) Then frontID = ""
	End If
	rearID = Camera.FindCameraId(False)
	If rearID <> "" Then
		If Not(HasFlash(rearID)) Then rearID = ""
	End If
	If frontID = "" Then Log("WARNING: Camera2Torch did not find a front camera with flash capability")
	If rearID = "" Then Log ("WARNING: Camera2Torch did not find a rear camera with flash capability")
End Sub

Private Sub HasFlash(Id As String) As Boolean
	Dim retVal As Boolean
	Dim cameraCharacteristics As JavaObject
	Try
		cameraCharacteristics =Camera.GetCameraCharacteristics(Id)
		retVal = cameraCharacteristics.RunMethod("get", Array(sjoCameraCharacteristics.GetField("FLASH_INFO_AVAILABLE")))
	Catch
		Log(LastException)
	End Try
	Return retVal
End Sub

'Set the torch mode of the front / rear camera
'Will return true if successful
Public Sub TorchMode(Front As Boolean, On As Boolean) As Boolean
	Dim retVal As Boolean
	Dim cameraId As String = frontID
	If Not(Front) Then cameraId = rearID
	If cameraId <> "" Then
		Try
			cameraManager.RunMethod("setTorchMode", Array(cameraId, On))
			retVal = True
		Catch
			Log(LastException)
		End Try
	Else
		Log($"ERROR (Camera2Torch): ${IIf(Front, "Front", "Rear")} camera with flash capability not present"$)
	End If

	Return retVal
End Sub


