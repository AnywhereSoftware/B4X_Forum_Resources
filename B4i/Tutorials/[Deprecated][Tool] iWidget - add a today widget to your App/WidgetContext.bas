B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.81
@EndOfDesignText@
'Code module

Sub Process_Globals
	Type WidgetSize (Width As Float, Height As Float)
	
	Dim Mode_Compact As Int = 0
	Dim Mode_Expanded As Int = 1
	
	Dim Result_NewData As Int = 0
	Dim Result_NoData As Int = 1
	Dim Result_Failed As Int = 2
	
	Private No As NativeObject = Me
End Sub

Sub OpenURL (Url As String) As Boolean
	Dim R As Int = No.RunMethod("OpenURL:",Array(Url)).AsNumber
	Return Not(r = -1)
End Sub


Sub GetWidgetLargestAvailableDisplayMode As Int
	Return No.RunMethod("GetLargest",Null).AsNumber
End Sub

Sub SetWidgetLargestAvailableDisplayMode (Mode As Int)
	No.RunMethod("SetLargest:",Array(Mode))
End Sub

Sub GetWidgetMaximumSize (Mode As String) As WidgetSize
	Dim WS As WidgetSize
	WS.Height = No.RunMethod("GetMaxH:",Array(Mode)).Asnumber
	WS.Width = No.RunMethod("GetMaxW:",Array(Mode)).Asnumber
	
	Return WS
End Sub

Sub GetWidgetActiveDisplayMode As Int
	Return No.RunMethod("GetActive",Null).AsNumber
End Sub

Sub SetPreferredWidgetSize (Height As Float, Width As Float)
	No.RunMethod("SetPrefSize::",Array(Width,Height))
End Sub


Private Sub SetNative (N As Object)
	No.RunMethod("SetTVC:",Array(N))
End Sub
#If OBJC

#import "TodayViewController.h"
TodayViewController* TVC;

-(void)SetTVC:(TodayViewController*)T{
	TVC = T;
}

-(int)OpenURL:(NSString*) Url{
	return [TVC OpenURL:Url];
}

-(int)GetLargest{
	return [TVC GetLargest];
}

-(void)SetLargest:(int)M{
	[TVC SetLargest:M];
}

-(float)GetMaxW: (int)Mode{
	return [TVC GetMaxW:Mode];
}

-(float)GetMaxH: (int)Mode{
	return [TVC GetMaxH:Mode];
}

-(int)GetActive{
	return [TVC GetActive];
}

-(void)SetPrefSize: (float)W :(float)H{
	[TVC SetPrefSize:W :H];
}

#End If

