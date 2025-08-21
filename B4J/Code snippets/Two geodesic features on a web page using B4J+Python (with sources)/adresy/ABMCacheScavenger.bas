B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'CacheScavenger
Sub Class_Globals
     Private scavengeTimer As Timer
     Private ABM As ABMaterial
End Sub

Public Sub Initialize
	 scavengeTimer.Initialize("ScavengeTimer", ABMShared.CacheScavengePeriodSeconds * 1000)
	 scavengeTimer.Enabled = True
	 StartMessageLoop '<- don't forget!
End Sub

Sub ScavengeTimer_Tick
  	'do the work required		
  	ABM.ScavengeCache(ABMShared.CachedPages)
End Sub