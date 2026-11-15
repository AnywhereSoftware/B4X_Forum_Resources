B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
    Private Const ShowDemoBackground As Boolean = True
    Private Tabs As AS_LiquidGlassTabBar
    Private xui As XUI
    Private DemoBackground As GlassTabBarDemoBackground
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created(Root As B4XView)
    Root.Color = 0xFFF2F2F7
    Tabs.Initialize(Me, "Tabs")
    Tabs.CreateNavigation(Root)
    Tabs.AddTab("Home", "house.fill")
    Tabs.AddTab("Favorites", "heart.fill")
    Tabs.AddTab("Settings", "gearshape.fill")
    Dim addLabel As Label
    addLabel.Initialize("")
    Dim addButton As B4XView = addLabel
    addButton.Text = "+"
    addButton.TextSize = 32
    addButton.TextColor = 0xFF007AFF
    addButton.SetTextAlignment("CENTER", "CENTER")
    addButton.SetColorAndBorder(xui.Color_ARGB(34, 255, 255, 255), 1dip, 0x44FFFFFF, 32dip)
    Tabs.SetCustomButton(addButton, 64dip)
    Tabs.SetBadge(1, "3")
    Tabs.MinimizeBehavior = "OnScrollDown"
    Tabs.BlurStrength = 25 '0 = clear, 100 = completely opaque
    Tabs.DisplayMode = "TabSidebar"
    If ShowDemoBackground Then DemoBackground.Initialize(Tabs)
    'Tabs.GetContentPanel(0).LoadLayout("Home")
    'Tabs.BindScrollView(YourScrollView) 'B4A/B4J; native iOS handles descendant scroll views.
End Sub

Private Sub Tabs_CustomButtonClick
    Log("Add")
End Sub

Private Sub Tabs_TabChanged(Index As Int)
    Log("Tab: " & Index)
End Sub

Private Sub B4XPage_Disappear
    Tabs.CancelGesture
    If ShowDemoBackground Then DemoBackground.Pause
End Sub

Private Sub B4XPage_Appear
    If ShowDemoBackground Then DemoBackground.Resume
End Sub
