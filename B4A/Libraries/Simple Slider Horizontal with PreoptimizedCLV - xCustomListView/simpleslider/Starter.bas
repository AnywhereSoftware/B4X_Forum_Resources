B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private cache As Map
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	cache.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

public Sub DownloadFitimage(link As String, iv As ImageView)
	If cache.ContainsKey(link) Then
		Dim bmp As B4XBitmap = cache.Get(link)
		FitImageToView(bmp,iv) 'iv.SetBackgroundImage(bmp.Resize(iv.Width,iv.Height,True))
	Else
		Dim job As HttpJob
		job.Initialize("", Me)
		job.Download(link)
		Wait For (job) JobDone(job As HttpJob)
		If job.Success Then
			Dim bmp As B4XBitmap = job.GetBitmap 'Dim bmp As Bitmap = job.GetBitmap 'job.GetBitmapResize(170dip,170dip,False)
			cache.Put(link, bmp)
			FitImageToView(bmp,iv) 'iv.SetBackgroundImage(bmp.Resize(iv.Width,iv.Height,True))
		End If
		job.Release
	End If
End Sub
public Sub FitImageToView(bmp As B4XBitmap, ImageView As B4XView)
	'this sub is not really needed
	ImageView.SetBitmap(bmp.Resize(ImageView.Width, ImageView.Height, True))
End Sub