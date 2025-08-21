B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region
#Extends: com.tillekesoft.accessibilityservices.AccessibilityEventsListenerWrapper 


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public acs As AccessibilityEventsListener
	Private AccServConstants As AccessibilityConstants
	Private ShallWeSendWhatsApp As Boolean
	Private ShallWeSendWhatsAppGroup As Boolean
	Private success As Boolean = False
	Private lastbackout As Boolean = False
	Private strMessage As String
End Sub

Sub Service_Create
	Log("service was created")
	acs.initialize("acs")
	
End Sub

Sub Service_Start (StartingIntent As Intent)
	Log("service was started")
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub


Sub CheckIfServiceIsEnabled
	If acs.IsAccessibilityServiceEnabled("com.mytest/.accservice")  = False Then 'insert package-name and name of your service
		CallSub2(Main,"IsTheAccessibilityServiceEnabled", False)
		CallSub2(Main,"SetCheckbox", False)
	Else
		CallSub2(Main,"IsTheAccessibilityServiceEnabled", True)
		CallSub2(Main,"SetCheckbox", True)
	End If
End Sub

Sub acs_OnAccessibilityEvent (Event As Object, node As Object) 'ignore
	'just some logging.....
	Log("my event: " & Event)
	Log("my node: " & node)
	Dim mylist As List
	mylist.Initialize2(node)
	Log(mylist.Size)
	
	If ShallWeSendWhatsApp = True Then
		For Each item As String In mylist
			If success = False Then
				success = acs.PerformNodeActionOnViewWithArgs(True, "com.whatsapp:id/send",AccServConstants.ACTION_CLICK, Null)
			Else if success = True And lastbackout = False Then
				acs.delay(500)
				acs.PerformGlobalAction(AccServConstants.GLOBAL_ACTION_BACK)
				acs.delay(500)
				lastbackout = True
			else if success = True And lastbackout = True Then
				acs.PerformGlobalAction(AccServConstants.GLOBAL_ACTION_BACK)
				ShallWeSendWhatsApp = False
				success = False
				lastbackout = False
			End If
		Next
	End If
	
	If ShallWeSendWhatsAppGroup = True Then
		For Each item As String In mylist
			If success = False Then
				Dim MsgMap As Map
				MsgMap.Initialize
				MsgMap.Put("msg",strMessage)
				success = acs.PerformNodeActionOnViewWithArgs(True,"com.whatsapp:id/entry",AccServConstants.ACTION_SET_TEXT,MsgMap)
				acs.delay(100)
				success = acs.PerformNodeActionOnViewWithArgs(True, "com.whatsapp:id/send",AccServConstants.ACTION_CLICK, Null)
				
			else if success = True And lastbackout = False Then
				acs.delay(500)
				acs.PerformGlobalAction(AccServConstants.GLOBAL_ACTION_BACK)
				acs.delay(500)
				lastbackout = True
			else if success = True And lastbackout = True Then
				acs.PerformGlobalAction(AccServConstants.GLOBAL_ACTION_BACK)
				ShallWeSendWhatsAppGroup = False
				success = False
				lastbackout = False
				strMessage = ""
			End If
		Next
	End If
	
End Sub

Sub SendWhatsAppMsg
	ShallWeSendWhatsApp = True
End Sub

Sub SendWhatsAppMsgToGroup (text As String)
	ShallWeSendWhatsAppGroup = True
	strMessage = text.Trim
End Sub




