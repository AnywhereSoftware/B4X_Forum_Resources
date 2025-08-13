B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False	
#End Region

Sub Process_Globals
End Sub

Sub Service_Create
End Sub

Sub Service_Start (StartingIntent As Intent)
	If StartingIntent.IsInitialized Then
		Dim cs As CSBuilder
		cs.Initialize.Bold.Size(20).Append($"Action: ${StartingIntent.Action}"$).PopAll
		
		If StartingIntent.Action = "stop" Then					
			Dim page As B4XMainPage = B4XPages.GetPage("MainPage")
			page.ClearAll
			StopService(ServicePlayer)
			StopService(Me)
			Return
		End If		
	End If
	Service.StopAutomaticForeground
End Sub

Sub Service_Destroy
End Sub
