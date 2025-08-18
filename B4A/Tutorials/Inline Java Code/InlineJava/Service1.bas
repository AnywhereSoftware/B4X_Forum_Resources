Type=Service
Version=4.1
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	Private nativeMe As JavaObject
End Sub
Sub Service_Create
	nativeMe.InitializeContext
	nativeMe.RunMethod("Test", Null)
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_Destroy

End Sub

#If JAVA
import android.content.Context;
import android.content.Intent;
public void Test() {
	BA.Log("" + this.getMainLooper());
	stopSelf();
}

public void _onCreate() {
	BA.Log("OnCreate");
}

public void _onStartCommand(Intent intent, int flags, int startId) {
	BA.Log("onStartCommand: " + intent + " " + flags + " " + startId);
}
public void _onDestroy() {
	BA.Log("OnDestroy");
}

#End If