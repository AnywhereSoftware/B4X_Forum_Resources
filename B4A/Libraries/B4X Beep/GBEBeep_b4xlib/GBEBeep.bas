B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	#if B4A
		Dim beeper As Beeper
	#End If
End Sub

#if B4A
	Sub Initialize(Duration As Int, Frequency As Int)
		beeper.Initialize(300,300)
	End Sub

	Sub Beep
		beeper.beep
	End Sub
#else if B4J
	Sub Beep
		Dim jo As JavaObject = Me
		jo.RunMethod("beep", Null)
	End Sub

	#if Java
	public static void beep() {
	    java.awt.Toolkit.getDefaultToolkit().beep();
	}
	#End If
#else if B4i
	Sub Beep
	    Dim NativeMe As NativeObject = Me
	    NativeMe.RunMethod("beep", Null)
	End Sub

	#If ObjC
	#import <AVFoundation/AVAudioPlayer.h>
	- (void) beep {
	  AudioServicesPlaySystemSound(1302);
	}
	#End If
#end if