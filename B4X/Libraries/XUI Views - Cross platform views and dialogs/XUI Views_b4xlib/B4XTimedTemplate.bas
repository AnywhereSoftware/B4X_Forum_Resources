B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Private AnotherProgressBar1 As AnotherProgressBar
	Private mTemplate As Object
	Public TimeoutMilliseconds As Int = 10000
	Private Index As Int
End Sub

Public Sub Initialize (InnerTemplate As Object)
	mBase = xui.CreatePanel("mBase")
	mTemplate = InnerTemplate
	
End Sub

Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	If mBase.NumberOfViews = 0 Then
		Dim InnerPanel As B4XView = CallSub2(mTemplate, "GetPanel", Dialog)
		If InnerPanel.Parent.IsInitialized Then InnerPanel.RemoveViewFromParent
		mBase.SetLayoutAnimated(0, 0, 0, InnerPanel.Width, InnerPanel.Height + 19dip)
		mBase.LoadLayout("TimedDialogTemplate")
		mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
		mBase.AddView(InnerPanel, 0, 19dip, InnerPanel.Width, InnerPanel.Height)
	End If
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog)
	CallSub2(mTemplate, "Show", Dialog)
	AnotherProgressBar1.SetValueNoAnimation(0)
	AnotherProgressBar1.ValueChangePerSecond = 100 / (TimeoutMilliseconds / 1000)
	AnotherProgressBar1.Value = 100
	Index = Index + 1
	Dim MyIndex As Int = Index
	Sleep(TimeoutMilliseconds)
	If MyIndex = Index Then
		Dialog.Close(xui.DialogResponse_Cancel)
	End If
End Sub

Private Sub DialogClosed(Result As Int)
	Index = Index + 1
	CallSub2(mTemplate, "DialogClosed", Result)
End Sub