B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
Sub Class_Globals
	Private fACtivity As Activity
	Private fModule As Object
	Private fEventName As String
	Private fMenu As String
	Private fPanelBackGround As Panel
	Private fPanelMenu As Panel
	Private fLabelTitle As Label
	Private fCustomListViewMenu As CustomListView
	Private fIsOpen As Boolean=False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aActivity As Activity,aModule As Object,aEventName As String)
	fACtivity=aActivity
	fModule=aModule
	fEventName=aEventName
End Sub

public Sub open(aMenu As String,aOptions As Map)
	fACtivity.LoadLayout("clsPopupMenu")
	fMenu=aMenu
	buildMenu(aOptions)
	fIsOpen=True
	CallSub2(fModule,fEventName & "_open",fMenu)
End Sub

private Sub buildMenu(aOptions As Map)
	fLabelTitle.Text=aOptions.GetDefault("title","")
	fCustomListViewMenu.Clear
	Dim l As List=aOptions.GetDefault("items",Null)
	If l.IsInitialized Then
		For Each i As Map In l
			fCustomListViewMenu.AddTextItem(i.Get("text"),i)
		Next
	End If
	fPanelMenu.Height=Min(fCustomListViewMenu.sv.ScrollViewContentHeight,fPanelMenu.Height)+fCustomListViewMenu.GetBase.Top
	fPanelMenu.Top=20dip
	fPanelMenu.SetLayoutAnimated(200,fPanelMenu.Left,(fPanelBackGround.Height-fPanelMenu.Height)/2,fPanelMenu.Width,fPanelMenu.Height)
End Sub

Sub openSubMenu(aOptions As Map)
	buildMenu(aOptions)
End Sub

Sub fCustomListViewMenu_ItemClick(Index As Int, Value As Object)
	Dim i As Map=Value
	Dim l As Map=i.GetDefault("popupMenu",Null)
	If l.IsInitialized Then
		Dim m As Map=i.Get("popupMenu")
		CallSubDelayed2(Me,"openSubMenu",m)
	Else
		close
		Dim s As String=i.Getdefault("value","")
		If s<>"" Then
			CallSubDelayed3(fModule,fEventName & "_click",fMenu,s)
		End If
	End If
End Sub

Sub fPanelBackGround_click
	close
End Sub

public Sub close
	If isOpen Then
		fPanelMenu.SetLayoutAnimated(50,fPanelMenu.Left,fPanelBackGround.Height,fPanelMenu.Width,fPanelMenu.Height)
		Sleep(50)
		CallSub2(fModule,fEventName & "_close",fMenu)
		fPanelBackGround.RemoveView
		fIsOpen=False
	End If
End Sub

public Sub isOpen As Boolean
	Return fIsOpen
End Sub


