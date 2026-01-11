B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			HMITileLabel
' Brief:		Example B4J program for the HMITiles B4X library.
' Description:	Show usage of the HMITileLabel.
' Date:			2025-01-02
' Author:		Robert W.B. Linn (c) 2026 MIT
' ================================================================

Sub Class_Globals
	Private xui As XUI
	Private Root As B4XView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "HMITiles Library Get Started - HMITileLabel")
	
	' ===================================================
	' HMITiles
	' ===================================================
	' Sleep must be set to enable customviews load designer layouts
	Sleep(1)	
End Sub

' ===================================================
' EVENTS
' ===================================================

Private Sub TileLabelNormal_Click
	Log($"[TileLabelNormal_Click]"$)
End Sub

Private Sub TileLabelWarning_Click
	Log($"[TileLabelWarning_Click]"$)
End Sub

Private Sub TileLabelAlarm_Click
	Log($"[TileLabelAlarm_Click]"$)
End Sub

Private Sub TileLabelDimmed_Click
	Log($"[TileLabelDimmed_Click]"$)
End Sub
