B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.5
@EndOfDesignText@
Sub Process_Globals
	Type  TLedStripCmd(CmdData(4) As Byte)

	Public const DEFINE_BobsCheck(4) 		As Byte = Array As Byte(0x42, 0x4F, 0x42, 0x73)
	
	Public const DEFINE_CMD_ToggleButton 	As Byte = 0
	Public const DEFINE_CMD_ChangeTo	 	As Byte = 1
	
	Public const DEFINE_CMD_RGBLed		 	As Byte = 2
End Sub

#if B4A
Private Sub ChangeCmd(Cmd As Byte, Theme As Byte) As TLedStripCmd
			Dim LedStripCmd As TLedStripCmd	
			
			LedStripCmd.Initialize
			LedStripCmd.CmdData	= Array As Byte(Cmd, Theme, 0, 0)
			
			Return LedStripCmd	
End Sub

Public  Sub SendChangeCmd As TLedStripCmd
			
			Return(ChangeCmd(DEFINE_CMD_ToggleButton, 0))
End Sub

Public  Sub SendChangeToCmd(WhichTheme As Int) As TLedStripCmd

			Return(ChangeCmd(DEFINE_CMD_ChangeTo, WhichTheme))			
End Sub

Public  Sub SendRGBLedCmd(RLed As Byte, GLed As Byte, BLed As Byte) As TLedStripCmd
			Dim LedStripCmd As TLedStripCmd	
			
			LedStripCmd.Initialize
		
			LedStripCmd.CmdData	= Array As Byte(DEFINE_CMD_RGBLed, RLed, GLed, BLed)
			
			Return LedStripCmd	
			
End Sub
#end if


