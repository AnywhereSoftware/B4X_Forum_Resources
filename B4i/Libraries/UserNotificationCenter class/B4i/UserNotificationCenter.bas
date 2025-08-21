B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.5
@EndOfDesignText@
'Version 1.00
Sub Class_Globals
	Private NotificationCenter As NativeObject
End Sub

Public Sub Initialize
	NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)
	NotificationCenter.SetField("delegate", Me)
End Sub

Public Sub RemovePendingNotifications (Identifiers As List)
	NotificationCenter.RunMethod("removePendingNotificationRequestsWithIdentifiers:", Array(Identifiers))
End Sub

Public Sub CreateNotificationWithContent(Title As String, Body As String, Identifier As String, Category As String, MillisecondsFromNow As Long)
	Dim ln As NativeObject
	ln = ln.Initialize("UNMutableNotificationContent").RunMethod("new", Null)
	ln.SetField("title", Title)
	ln.SetField("body", Body)
	Dim n As NativeObject
	ln.SetField("sound", n.Initialize("UNNotificationSound").RunMethod("defaultSound", Null))
	If Category <> "" Then ln.SetField("categoryIdentifier", Category)
	Dim trigger As NativeObject
	trigger = trigger.Initialize("UNTimeIntervalNotificationTrigger").RunMethod("triggerWithTimeInterval:repeats:", Array(MillisecondsFromNow / 1000, False))
	Dim request As NativeObject
	request = request.Initialize("UNNotificationRequest").RunMethod("requestWithIdentifier:content:trigger:", _
       Array(Identifier, ln, trigger))
	Dim NotificationCenter As NativeObject
	NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)
	NotificationCenter.RunMethod("addNotificationRequest:", Array(request))
End Sub

'Ties the list of actions with a specific category. 
Public Sub SetCategoryActions (CategoryId As String, Actions As List)
	Dim Category As NativeObject
	Category = Category.Initialize("UNNotificationCategory")
	Dim NativeActions As List
	NativeActions.Initialize
	For Each action As String In Actions
		NativeActions.Add(CreateAction(action, action))	
	Next
	Dim intentIdentifiers As List = Array()
	Category = Category.RunMethod("categoryWithIdentifier:actions:intentIdentifiers:options:", _
       Array(CategoryId, NativeActions, intentIdentifiers, 1))
	Dim NotificationCenter As NativeObject
	NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)
	Dim set As NativeObject
	set = set.Initialize("NSSet").RunMethod("setWithObject:", Array(Category))
	NotificationCenter.RunMethod("setNotificationCategories:", Array(set))
End Sub

Private Sub CreateAction (Identifier As String, Title As String) As Object
	Dim acceptAction As NativeObject
	acceptAction.Initialize("UNNotificationAction")
	'5 = AuthenticationRequired + Foreground
	acceptAction = acceptAction.RunMethod("actionWithIdentifier:title:options:", Array(Identifier, Title, 5))
	Return acceptAction
End Sub

#if OBJC
#import <UserNotifications/UserNotifications.h>
@end
@interface b4i_usernotificationcenter (notification) <UNUserNotificationCenterDelegate>
@end
@implementation b4i_usernotificationcenter (notification)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
        completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound );
   }
 - (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler {
       B4I* bi = [b4i_main new].bi;
[bi raiseEvent:nil event:@"usernotification_action:" params:@[response]];
completionHandler();
   }
#End If