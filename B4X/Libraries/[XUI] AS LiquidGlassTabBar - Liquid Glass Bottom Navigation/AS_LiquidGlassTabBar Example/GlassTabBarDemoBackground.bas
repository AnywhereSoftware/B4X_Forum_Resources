B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Optional example scenery for screenshots and recordings. Not part of the library.
Sub Class_Globals
    Private xui As XUI
    Private Tabs As AS_LiquidGlassTabBar
    Private Scrolls, Panels, Cards, Positioned As List
    Private Clock As Timer
    Private ActiveIndex As Int = -1
    Private LastWidth As Float = -1
    Private LastHeight As Float = -1
    Private BindDelay As Int
End Sub

Public Sub Initialize(TabBar As AS_LiquidGlassTabBar)
    Tabs = TabBar
    Scrolls.Initialize
    Panels.Initialize
    Cards.Initialize
    Positioned.Initialize
    Dim palette() As Int = Array As Int(0xFFDDE9FA, 0xFFE7DEF4, 0xFFD4EDE4, 0xFFF6DCCB)
    For tabIndex = 0 To Tabs.TabCount - 1
        Dim page As B4XView = Tabs.GetContentPanel(tabIndex)
        Dim content As B4XView
        #If B4A
        Dim scroll As ScrollView
        scroll.Initialize(1dip)
        content = scroll.Panel
        Dim native As JavaObject = scroll
        native.RunMethod("setVerticalScrollBarEnabled", Array(False))
        #Else If B4i
        Dim scroll As ScrollView
        scroll.Initialize("", Max(1, page.Width), 1dip)
        content = scroll.Panel
        #Else
        Dim scroll As ScrollPane
        scroll.Initialize("")
        scroll.FitToWidth = True
        scroll.SetVScrollVisibility("NEVER")
        scroll.SetHScrollVisibility("NEVER")
        scroll.Style = "-fx-background-color: transparent; -fx-background: #f2f2f7; -fx-padding: 0;"
        content = xui.CreatePanel("")
        scroll.InnerNode = content
        #End If
        Dim viewport As B4XView = scroll
        page.AddView(viewport, 0, 0, Max(1, page.Width), Max(1, page.Height))
        Scrolls.Add(viewport)
        Panels.Add(content)
        Dim items As List
        items.Initialize
        For itemIndex = 0 To 19
            Dim label As Label
            label.Initialize("")
            Dim card As B4XView = label
            card.Text = "Item " & (itemIndex + 1)
            card.TextSize = 20
            card.TextColor = 0xFF202024
            card.SetTextAlignment("CENTER", "CENTER")
            card.SetColorAndBorder(palette((itemIndex + tabIndex) Mod palette.Length), 0, 0, 18dip)
            content.AddView(card, 20dip, 0, 1dip, 130dip)
            items.Add(card)
        Next
        Cards.Add(items)
        Positioned.Add(False)
    Next
    Clock.Initialize("Clock", 150)
    Clock.Enabled = True
    Update
End Sub

Private Sub Clock_Tick
    Update
End Sub

Private Sub Update
    If Tabs.TabCount = 0 Then Return
    Dim page As B4XView = Tabs.GetContentPanel(0)
    If page.Width <> LastWidth Or page.Height <> LastHeight Then
        LastWidth = page.Width
        LastHeight = page.Height
        For tabIndex = 0 To Scrolls.Size - 1
            Dim viewport As B4XView = Scrolls.Get(tabIndex)
            Dim content As B4XView = Panels.Get(tabIndex)
            Dim items As List = Cards.Get(tabIndex)
            Dim height As Float = 20dip + items.Size * 144dip + Tabs.ContentBottomInset
            viewport.SetLayoutAnimated(0, 0, 0, Max(1, LastWidth), Max(1, LastHeight))
            #If B4i
            Dim iosScroll As ScrollView = viewport
            iosScroll.ContentWidth = Max(1, LastWidth)
            iosScroll.ContentHeight = height
            #Else If B4A
            Dim androidScroll As ScrollView = viewport
            androidScroll.Panel.Width = Max(1, LastWidth)
            androidScroll.Panel.Height = height
            #Else
            content.SetLayoutAnimated(0, 0, 0, Max(1, LastWidth), height)
            #End If
            For itemIndex = 0 To items.Size - 1
                Dim card As B4XView = items.Get(itemIndex)
                card.SetLayoutAnimated(0, 20dip, 20dip + itemIndex * 144dip, Max(1, LastWidth - 40dip), 130dip)
            Next
        Next
    End If
    If Tabs.Index >= 0 And Tabs.Index < Scrolls.Size And Tabs.Index <> ActiveIndex Then
        Tabs.UnbindScrollView
        ActiveIndex = Tabs.Index
        BindDelay = 2
        Return
    End If
    If ActiveIndex >= 0 And BindDelay > 0 And LastHeight > 1 Then
        BindDelay = BindDelay - 1
        If BindDelay = 1 And Positioned.Get(ActiveIndex) = False Then
            AlignForCapture(ActiveIndex)
            Positioned.Set(ActiveIndex, True)
        Else If BindDelay = 0 Then
            Tabs.BindScrollView(Scrolls.Get(ActiveIndex))
        End If
    End If
End Sub

'Place real list text underneath the replica bar so its material is visible at startup.
'This scroll happens before binding, so it does not minimize the bar.
Private Sub AlignForCapture(Index As Int)
    #If Not(B4i)
    Dim center As Float = LastHeight - 40dip
    Dim row As Int = Ceil(Max(0, center - 85dip) / 144dip)
    Dim offset As Float = 85dip + row * 144dip - center
    If offset < 32dip Then offset = offset + 144dip
    #If B4A
    Dim scroll As ScrollView = Scrolls.Get(Index)
    scroll.ScrollPosition = offset
    #Else
    Dim scroll As ScrollPane = Scrolls.Get(Index)
    Dim content As B4XView = Panels.Get(Index)
    scroll.VPosition = offset / Max(1, content.Height - LastHeight)
    #End If
    #End If
End Sub

Public Sub Pause
    If Clock.IsInitialized Then Clock.Enabled = False
End Sub

Public Sub Resume
    If Clock.IsInitialized Then
        Clock.Enabled = True
        Update
    End If
End Sub
