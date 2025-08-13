B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	#if B4J
	Private GradientOrientations As Map
	#End If
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	#if B4J
	GradientOrientations.Initialize
	GradientOrientations.put("TOP_BOTTOM", "from 50% 0% to 50% 100%")
	GradientOrientations.put("TR_BL", "from 100% 0% to 0% 100%")
	GradientOrientations.put("RIGHT_LEFT", "from 100% 50% to 0% 50%")
	GradientOrientations.put("BR_TL", "from 100% 100% to 0% 0%")
	GradientOrientations.put("BOTTOM_TOP", "from 50% 100% to 50% 0%")
	GradientOrientations.put("BL_TR", "from 0% 100% to 100% 0%")
	GradientOrientations.put("LEFT_RIGHT", "from 0% 50% to 100% 50%")
	GradientOrientations.put("TL_BR", "from 0% 0% to 100% 100%")
	#End If
End Sub

Public Sub SetGradient(View As B4XView, Orientation As String, Colors_ As List)
	#if B4i
	Dim NaObj As NativeObject = Me
	NaObj.RunMethod("SetGradient:::",Array(View, Colors_, Orientation))
	#else if B4A
	Dim gd As GradientDrawable
	Dim cc(Colors_.Size) As Int
	For i = 0 To Colors_.Size - 1
		cc(i) = Colors_.Get(i)
	Next
	gd.Initialize(Orientation, cc)
	View.As(View).Background = gd
	#else if B4J
	Dim lg As StringBuilder
	lg.Initialize
	lg.Append("linear-gradient(").Append(GradientOrientations.Get(Orientation))
	Dim GradStep As Int = 100 / Colors_.Size
	Dim grad As Int
	Dim fx As JFX
	For i = 0 To Colors_.Size - 1
		Dim clr As String = CSSUtils.ColorToHex(fx.Colors.From32Bit(Colors_.Get(i)))
		lg.Append(",").Append(clr).Append(" ")
		If i > 0 And i < Colors_.Size - 1 Then
			lg.Append(grad).Append("%")
		End If
		grad = grad + GradStep
	Next
	lg.Append(")")
	CSSUtils.SetStyleProperty(View, "-fx-background-color", lg.ToString)
	#end if
End Sub

#If OBJC
- (void)SetGradient: (UIView*) View :(NSArray*) Colors :(NSString*)Orientation{
	NSMutableArray* cc = [NSMutableArray new];
	for (NSNumber* clr in Colors) {
		[cc addObject:(id)[[B4I shared] ColorToUIColor:clr.intValue].CGColor];
	}
   CAGradientLayer *gradient = [CAGradientLayer layer];
   gradient.colors = cc;
   gradient.frame = View.bounds;
   CGPoint start, stop;
   if ([Orientation isEqualToString:@"BOTTOM_TOP"]) {
   	start = CGPointMake(0.5, 1.0);
	stop = CGPointMake(0.5, 0);
   } 
    else if ([Orientation isEqualToString:@"TR_BL"]) {
   	start = CGPointMake(1, 0);
	stop = CGPointMake(0, 1);
   } 
    else if ([Orientation isEqualToString:@"RIGHT_LEFT"]) {
   	start = CGPointMake(1, 0.5);
	stop = CGPointMake(0, 0.5);
   } 
    else if ([Orientation isEqualToString:@"BR_TL"]) {
   	start = CGPointMake(1, 1.0);
	stop = CGPointMake(0, 0);
   } 
    else if ([Orientation isEqualToString:@"BL_TR"]) {
   	start = CGPointMake(0, 1.0);
	stop = CGPointMake(1, 0);
   } 
    else if ([Orientation isEqualToString:@"TL_BR"]) {
   	start = CGPointMake(0, 0);
	stop = CGPointMake(1, 1);
   } 
    else if ([Orientation isEqualToString:@"BOTTOM_TOP"]) {
   	start = CGPointMake(0.5, 1.0);
	stop = CGPointMake(0.5, 0);
   } 
   else {
   start = CGPointMake(0.5, 0.0);
	stop = CGPointMake(0.5, 1.0);
   }
   
   gradient.startPoint = start;
   gradient.endPoint  = stop;
   if ([View.layer.sublayers[0] isKindOfClass:[CAGradientLayer class]]) 
     [View.layer replaceSublayer:View.layer.sublayers[0] with:gradient];
   else
     [View.layer insertSublayer:gradient atIndex:0];
}
#end if