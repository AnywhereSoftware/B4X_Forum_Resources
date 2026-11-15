B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
    Private Root As B4XView
    Private Menu As AS_GlassMenu
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created(Root1 As B4XView)
    Root = Root1
    Root.Color = 0xFF16233B
    Menu.Initialize(Me, "Menu")
    Menu.CreateViewPerCode(Root, 24dip, 24dip, 120dip, 44dip)
    Menu.Theme = "Dark"
    Menu.TriggerText = "Options"
    Menu.AddLabel("View as")
    Menu.AddRadioItem("grid", "Grid", "grid", "layout", True)
    Menu.AddRadioItem("list", "List", "list", "layout", False)
    Menu.AddSeparator
    Menu.AddCheckItem("favorite", "Favorite", "heart", False)
    Menu.AddAction("share", "Share", "share")
    Menu.AddAction("copy", "Copy link", "copy")
    Menu.AddSeparator
    Menu.AddDestructiveAction("delete", "Delete", "trash")
End Sub

Private Sub Menu_ItemClick(Index As Int, Item As AS_GlassMenu_Item)
    Log(Item.Id & ": " & Item.Checked)
End Sub

Private Sub B4XPage_Disappear
    Menu.CloseImmediately
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
    Return Not(Menu.HandleBack)
End Sub