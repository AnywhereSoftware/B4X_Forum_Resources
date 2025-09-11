B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@

Sub Process_Globals
	Public javaExe As String
'	Public WorkingDirectory As String ="C:\jrdcinterface"
	Public WorkingDirectory As String = File.DirApp
	Public IsPaused As Int = 0
	Public mpLogs As Map
	Public mpTotalRequests As Map
	Public mpTotalConnections As Map
	Public mpBlockConnection As Map
End Sub