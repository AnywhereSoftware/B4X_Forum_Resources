B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
'Version 1.20
'Nathan Segaloff
Sub Class_Globals
	Private xui As XUI		
	#If b4a
		Private su As StringUtils	
	#End If
	Private tmrDisplay As Timer

	Private ParentPanel As B4XView 'Ignore
	Private pnlBG As B4XView 'Ignore
	Private pnlHintContainer As B4XView 'Ignore
	Private lblHint As B4XView 'Ignore
	Private pnlTargetHighlighter As B4XView	 'Ignore
	
	Private lstHints As List 'Ignore
	
	Type instructor_info(xView As B4XView, Instruction As String) 'Ignore
	Type area_info(TopHalf As Boolean, LeftHalf As Boolean) 'Ignore
	
	Private NavHeight As Int=0'b4i navigation bar height	
	Private bActive As Boolean
	
	Private cvs As B4XCanvas 'Ignore
	#If b4j
		Private pnlCanvas As Pane 'Ignore
	#Else
		Private pnlCanvas As Panel 'Ignore
	#End If
		
	Public BackgroundAlpha As Int=50
	Public CaptionColor As Int=xui.Color_Blue
	Public OutlineColor As Int=xui.Color_Cyan	
	Public TextColor As Int=xui.Color_White
	Public HighlightTargetView As Boolean=True
	Public DisplayConnectorLine As Boolean=True
	Public ClearTargetView As Boolean=True
	Public MaxDisplayTime As Int=0 '0=disabled
	
	#If b4a
		Public TextSize As Int=15
	#Else if b4i
		Public TextSize As Int=20
	#Else if b4j
		Public TextSize As Int=16
	#End If
End Sub

Public Sub Initialize (Parent As B4XView)
	ParentPanel = Parent
	ParentPanel.LoadLayout("HintOverlayPanel")

	lstHints.Initialize
	tmrDisplay.Initialize("tmrDisplay", 0)

	pnlCanvas.Initialize("")
	pnlBG.AddView(pnlCanvas, 0,0,pnlBG.Width,pnlBG.Height)
	pnlCanvas.As(B4XView).Color=xui.Color_Transparent
	cvs.Initialize(pnlCanvas)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	If pnlBG.IsInitialized Then
		Dim iTop As Int= 0
			#if b4i
				NavHeight=ParentPanel.Top
				iTop = IIf(Main.NavControl.NavigationBarVisible,0,0-NavHeight)
				Height = IIf(Main.NavControl.NavigationBarVisible,Height,Height+NavHeight)
			#End If
		pnlBG.SetLayoutAnimated(0,0,iTop,Width,Height)
		pnlCanvas.As(B4XView).SetLayoutAnimated(0,0,iTop,Width,Height)
		cvs.ClearRect(cvs.TargetRect)
		cvs.Invalidate
		cvs.Release
		cvs.Initialize(pnlCanvas)
		pnlHintContainer.Left=Width*0.15
		pnlHintContainer.Width=Width*0.7
		pnlHintContainer.Top=(Height/2)-(pnlHintContainer.Height/2)
		lblHint.Left=10dip
		lblHint.Width=pnlHintContainer.Width-20dip
		pnlTargetHighlighter.Visible=False
	End If
End Sub

Public Sub Show(TargetView As B4XView, Instruction As String) As ResumableSub
'Add to queue
Dim inst As instructor_info
	inst.xView=TargetView
	inst.Instruction=Instruction
	lstHints.Add(inst)
	Do While bActive
		Sleep(50)
	Loop
	Wait For(DisplayInstruction) Complete (b As Boolean)
	Return b
End Sub

Private Sub DisplayInstruction As ResumableSub
	If MaxDisplayTime<>0 Then
		tmrDisplay.Interval=MaxDisplayTime
		tmrDisplay.Enabled=True
	End If
	bActive=True
	Dim Instruction As instructor_info=lstHints.Get(0)
	lblHint.Text=Instruction.Instruction
	SetHintContainerHeight

#if b4i	
	cvs.ClearRect(cvs.TargetRect)
	cvs.Invalidate
	cvs.Release
	cvs.Initialize(pnlCanvas)
#end if
	cvs.ClearRect(cvs.TargetRect) 'Clear the drawings
	cvs.DrawRect(cvs.TargetRect,xui.Color_ARGB(BackgroundAlpha,0,0,0),True,0) 'dimm the background
	
	'Determine if instruction panel should be positioned above or below the target view
	Dim vTop As Int = Instruction.xView.Top
	Dim xParentView As B4XView= Instruction.xView.Parent
	
	Dim vTop2 As Int=0
	If xParentView.IsInitialized Then
		vTop2=xParentView.Top
		vTop2=vTop2-NavHeight 'affects b4i only
		vTop=vTop+vTop2
	End If
	
	If vTop2=0 Then
		Dim vHalf As Int=Instruction.xView.Height/2
		Dim bTopHalf As Boolean=vTop+vHalf<(ParentPanel.Height/2)
		pnlHintContainer.Top=IIf(bTopHalf,Instruction.xView.Top+Instruction.xView.Height+40dip,Instruction.xView.Top-pnlHintContainer.Height-40dip)
	Else 'VIEW IS INSIDE PARENT
		Dim vHalf As Int=xParentView.Top+(Instruction.xView.Top+(Instruction.xView.Height/2))
		Dim bTopHalf As Boolean=vHalf<(ParentPanel.Height/2)
		pnlHintContainer.Top=IIf(bTopHalf, xParentView.Top+Instruction.xView.Top+Instruction.xView.Height+40dip,vTop-pnlHintContainer.Height-40dip)
	End If
	pnlHintContainer.Top=pnlHintContainer.Top+NavHeight 'affects b4i only
	
	'Set the target highlighter size and postion
	If vTop2=0 Then'REGULAR VIEW
		pnlTargetHighlighter.SetLayoutAnimated(0,Instruction.xView.Left,xParentView.Top+Instruction.xView.Top,Instruction.xView.Width,Instruction.xView.Height)
	Else'VIEW IS INSIDE PARENT
		pnlTargetHighlighter.SetLayoutAnimated(0, xParentView.left+Instruction.xView.Left,xParentView.Top+Instruction.xView.Top,Instruction.xView.Width,Instruction.xView.Height)
		pnlTargetHighlighter.Top=pnlTargetHighlighter.Top+NavHeight 'affects b4i only
	End If
	pnlTargetHighlighter.Visible=HighlightTargetView


	If DisplayConnectorLine Then
		'Get the connector line start/end points
		Dim iSection As Int=GetViewQuadSection(Instruction.xView)
		Dim xFromPoint As Int=pnlHintContainer.Left+GetLineStart(iSection)
		Dim yFromPoint As Int=IIf(bTopHalf ,pnlHintContainer.Top+2dip, pnlHintContainer.Top+pnlHintContainer.Height-2dip)
		Dim xToPoint As Int=pnlTargetHighlighter.Left+(pnlTargetHighlighter.Width/2)
		Dim yToPoint As Int=IIf(bTopHalf, pnlTargetHighlighter.Top+pnlTargetHighlighter.Height-2dip, pnlTargetHighlighter.Top+2dip)
			yFromPoint=yFromPoint+NavHeight'affects b4i only
			yToPoint=yToPoint+NavHeight'affects b4i only
		
		'Draw the connector line
		If cvs.TargetView<>pnlCanvas Then cvs.Initialize(pnlCanvas)'b4i only - required after calling cvs.Release
		cvs.DrawLine(xFromPoint, yFromPoint, xToPoint, yToPoint, OutlineColor, 3dip)
	End If
	
	If ClearTargetView Then 'Thanks to Blueforcer
		Dim rect As B4XRect
		rect.Initialize(pnlTargetHighlighter.Left+3dip,pnlTargetHighlighter.Top+NavHeight+3dip,pnlTargetHighlighter.Left+pnlTargetHighlighter.Width-3dip,pnlTargetHighlighter.Top+pnlTargetHighlighter.Height+NavHeight-3dip)
		cvs.ClearRect(rect) 'cut out the Target
	End If
	
'Display correct colors	
	pnlHintContainer.SetColorAndBorder(CaptionColor,3dip,OutlineColor,8dip)
	pnlTargetHighlighter.SetColorAndBorder(xui.Color_Transparent,3dip,OutlineColor,3dip)
	
	'Display the instruction text
	lblHint.Text=Instruction.Instruction
	lblHint.TextColor=TextColor
	pnlBG.BringToFront
	pnlHintContainer.BringToFront
	pnlTargetHighlighter.BringToFront
	pnlBG.SetVisibleAnimated(200, True)
	
	cvs.Invalidate
	Do While bActive
		Sleep(50)
	Loop
	cvs.Release
	Return True
End Sub


Private Sub GetViewQuadSection(xView As B4XView) As Int
	Dim xQuarter As Int = ParentPanel.Width/4
	Dim centerPos As Int = xView.Left+(xView.Width/2)
	If centerPos<xQuarter Then Return 1
	If centerPos<(xQuarter*2) Then Return 2
	If centerPos<(xQuarter*3) Then Return 3
	Return 4
End Sub

Private Sub GetLineStart(iSection As Int) As Int
Dim iPos As Int=pnlHintContainer.Width/7
	Select iSection
		Case 1
			Return iPos*1
		Case 2
			Return iPos*3
		Case 3
			Return iPos*5
		Case Else
			Return iPos*6
	End Select
End Sub

Private Sub SetHintContainerHeight
	#If b4a
		lblHint.TextSize=TextSize+GetDeviceLayoutValues.Scale 'Autoscale estimate
		Dim iTextHeight As Int = su.MeasureMultilineTextHeight(lblHint,lblHint.Text) 'measure the HEIGHT depending on the textsize and length
		lblHint.Left=10dip
		lblHint.Width=pnlHintContainer.Width-20dip
	#Else if b4i
		lblHint.TextSize=TextSize
		lblHint.As(Label).SizeToFit
		lblHint.Width=pnlHintContainer.Width-12
		lblHint.Left=6
		Dim iTextHeight As Int=lblHint.Height-2
	#Else If b4j
		lblHint.TextSize=TextSize
		Dim iTextHeight As Int=MeasureMultilineTextHeight(lblHint.Font, lblHint.Width, lblHint.Text)+10dip
		Dim jo As JavaObject = lblHint
		jo.RunMethod("setTextAlignment", Array("CENTER"))
	#End If
	lblHint.Height=iTextHeight
	pnlHintContainer.Height=lblHint.Top+lblHint.Height+15dip
End Sub

Private Sub pnlBG_Click
	tmrDisplay.Enabled=False
	If lstHints.Size>0 Then lstHints.RemoveAt(0)
		bActive=False
		Sleep(100)
	If lstHints.Size=0 Then
		Sleep (100)
		If Not(bActive) Then pnlBG.SetVisibleAnimated(200,False)
	End If

End Sub

Sub tmrDisplay_Tick
	pnlBG_Click
End Sub

#If B4J
Private Sub pnlBG_MouseClicked (EventData As MouseEvent)
	pnlBG_Click
End Sub



'https://www.b4x.com/android/forum/threads/measure-multiline-text-height.84331/#content
Private Sub MeasureMultilineTextHeight (Font As Font, Width As Double, Text As String) As Double
	Dim jo As JavaObject = Me
	Return jo.RunMethod("MeasureMultilineTextHeight", Array(Font, Text, Width))
End Sub

#If Java
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javafx.scene.text.Font;
import javafx.scene.text.TextBoundsType;
public static double MeasureMultilineTextHeight(Font f, String text, double width) throws Exception {
  Method m = Class.forName("com.sun.javafx.scene.control.skin.Utils").getDeclaredMethod("computeTextHeight",
  Font.class, String.class, double.class, TextBoundsType.class);
  m.setAccessible(true);
  return (Double)m.invoke(null, f, text, width, TextBoundsType.LOGICAL_VERTICAL_CENTER);
  }
#End If
#End If

