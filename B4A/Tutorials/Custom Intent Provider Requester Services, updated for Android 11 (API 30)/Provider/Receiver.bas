B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11.2
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	LogColor("P.R.SS " & StartingIntent,Colors.Magenta)
	If StartingIntent <> Null Then
		Log("P.R.SS extras " & StartingIntent.ExtrasToString)
		If 	StartingIntent.Action.Contains("b4a.Provider.REQUEST") And _ ' filter if you like
			StartingIntent.HasExtra("Callback") Then				 	 ' and has Callback
			LookupAndSendResult(StartingIntent)
		End If
	End If
	
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub

Sub LookupAndSendResult(in As Intent)
	Dim receivedtext As String = in.GetExtra("SomeIdentifier")
	LogColor("P.R.LASR requested " & receivedtext,Colors.Green)
	If in.HasExtra("Some Context") Then	 			 ' has desired content, like City,Brooklyn for the Uri's Firstname Lastname
		Log(" also use Some Context of " & in.GetExtra("Some Context") & " when doing lookup")
	End If
	Dim someResult As String = "perform/ed some lookup for " & receivedtext & " identifier"
	LogColor(someResult,Colors.Green)
	
	Dim returnIntent As Intent
	Dim sCB As String = in.GetExtra("Callback")
	Log("P.R.LASR CB " & sCB)
	returnIntent.Initialize(sCB,"") ' Only some actions need a URI
	Dim sComp As String = sCB.replace(".CALLBACK","")
	Log("P.R.LASR comp " & sComp)
	returnIntent.SetComponent(sComp)
	returnIntent.AddCategory("android.intent.category.DEFAULT")
	returnIntent.setpackage(sComp)
	returnIntent.setType("text/plain") 'mime types ex: text/plain
	returnIntent.PutExtra("Identifier",	receivedtext)
	returnIntent.PutExtra("Result", someResult)
	returnIntent.PutExtra("Successful", "True")
	StartService(returnIntent)
End Sub