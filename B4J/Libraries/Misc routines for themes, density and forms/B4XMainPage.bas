B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private helper As formHelpers
	Private mTitleCount As Int
	Private theme As ColorThemes
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'wrap the main form with the .NET-style helper
	helper.Initialize(Main.MainForm)
	BuildTestButtons
	
	'apply the saved theme; first run defaults to the OS light/dark preference
	theme.Initialize
	theme.AddThemeListener(Me, "appTheme")
	theme.LoadOrDefault(theme.PRIMER, theme.IsOsDark)
End Sub

'Fired whenever the app theme changes (registered via AddThemeListener).
Private Sub appTheme_ThemeChanged (Family As String, Dark As Boolean)
	Log($"ThemeChanged callback: ${Family} dark=${Dark}"$)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'===================== formHelpers test harness =====================

Private Sub BuildTestButtons
	'TabPane filling the page
	Dim tp As TabPane
	tp.Initialize("tp")
	Root.AddView(tp, 0, 0, Root.Width, Root.Height)

	Dim paneForm As Pane
	paneForm.Initialize("")
	AddTab(tp, "Form Testing", paneForm)

	Dim paneTheme As Pane
	paneTheme.Initialize("")
	AddTab(tp, "Theme Testing", paneTheme)

	BuildFormTab(paneForm)
	BuildThemeTab(paneTheme)
End Sub

'formHelpers tests, laid out in three columns on the Form Testing tab.
Private Sub BuildFormTab (Parent As Pane)
	Dim w As Double = 240dip
	Dim h As Double = 36dip
	Dim gap As Double = 8dip

	'--- column 1: window state & style ---
	Dim left As Double = 10dip
	Dim top As Double = 10dip
	AddButton(Parent, "btnMaximize", "WindowState: Maximize", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnMinimize", "WindowState: Minimize", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnNormal", "WindowState: Normal", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnTopMost", "Toggle TopMost", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnOpacity", "Toggle Opacity (1.0 / 0.7)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnCenter", "StartPosition: Center On Screen", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnTitle", "Set Title (Text)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnFixed", "Border: Fixed (no resize)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnSizable", "Border: Sizable", left, top, w, h) : top = top + h + gap

	'--- column 2: size & position ---
	Dim left2 As Double = left + w + 12dip
	Dim top2 As Double = 10dip
	AddButton(Parent, "btnMove", "Move to (50,50)", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnResize", "Resize to 800x500", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnBounds", "SetBounds (100,100,700,450)", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnMinSize", "Min size 400x300", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnMaxSize", "Max size 900x600", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnCenter2", "CenterToScreen", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnLogSize", "Log size/pos", left2, top2, w, h) : top2 = top2 + h + gap

	'--- column 3: appearance + behavior/dialog ---
	Dim left3 As Double = left2 + w + 12dip
	Dim top3 As Double = 10dip
	AddButton(Parent, "btnBackColor", "BackColor: random", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnCursorWait", "Cursor: Wait", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnCursorHand", "Cursor: Hand", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnCursorDefault", "Cursor: Default", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnIcon", "Set Icon (from Files)", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnFront", "BringToFront", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnFocus", "Focus", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnHideShow", "Hide then Show (1s)", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnDialog", "ShowDialog (modal)", left3, top3, w, h) : top3 = top3 + h + gap
	AddButton(Parent, "btnDialogTwice", "ShowDialog on shown form (throws)", left3, top3, w, h) : top3 = top3 + h + gap
End Sub

'ColorThemes tests on the Theme Testing tab.
Private Sub BuildThemeTab (Parent As Pane)
	Dim w As Double = 240dip
	Dim h As Double = 36dip
	Dim gap As Double = 8dip
	Dim left As Double = 10dip
	Dim top As Double = 10dip
	AddButton(Parent, "btnThemeToggle", "Theme: Toggle Light/Dark", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemePrimer", "Theme: Primer", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeNord", "Theme: Nord", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeCupertino", "Theme: Cupertino", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeDracula", "Theme: Dracula (dark)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeGruvbox", "Theme: Gruvbox", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeSolarized", "Theme: Solarized", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeAuto", "Theme: Auto (follow OS)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeModena", "Theme: Modena (default)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnThemeReload", "Theme: Reload Saved", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnAccentRandom", "Accent: random (this form)", left, top, w, h) : top = top + h + gap
	AddButton(Parent, "btnAccentClear", "Accent: clear", left, top, w, h) : top = top + h + gap

	'--- column 2: windows + density ---
	Dim left2 As Double = left + w + 12dip
	Dim top2 As Double = 10dip
	AddButton(Parent, "btnCustomWindow", "Open Custom Title Bar Window", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnTestLayout", "test layout", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnDensityCompact", "Density: Compact", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnDensityNormal", "Density: Normal", left2, top2, w, h) : top2 = top2 + h + gap
	AddButton(Parent, "btnDensityComfortable", "Density: Comfortable", left2, top2, w, h) : top2 = top2 + h + gap
End Sub

'Adds a tab with a code-built Pane as its content (B4J TabPane has no native add-tab-with-pane).
Private Sub AddTab (tp As TabPane, Title As String, Content As Pane)
	Dim jTab As JavaObject
	jTab.InitializeNewInstance("javafx.scene.control.Tab", Array(Title))
	Dim joContent As JavaObject = Content
	jTab.RunMethod("setContent", Array(joContent))
	Dim joTp As JavaObject = tp
	joTp.RunMethodJO("getTabs", Null).RunMethod("add", Array(jTab))
End Sub

Private Sub AddButton (Parent As Pane, EventName As String, Caption As String, Left As Double, Top As Double, Width As Double, Height As Double)
	Dim b As Button
	b.Initialize(EventName)
	b.Text = Caption
	Parent.AddNode(b, Left, Top, Width, Height)
End Sub

Private Sub btnMaximize_Click
	helper.WindowState = helper.STATE_MAXIMIZED
End Sub

Private Sub btnMinimize_Click
	helper.WindowState = helper.STATE_MINIMIZED		'restore from the taskbar
End Sub

Private Sub btnNormal_Click
	helper.WindowState = helper.STATE_NORMAL
End Sub

Private Sub btnTopMost_Click
	helper.TopMost = Not(helper.TopMost)
	Log($"TopMost = ${helper.TopMost}"$)
End Sub

Private Sub btnOpacity_Click
	If helper.Opacity < 1 Then
		helper.Opacity = 1
	Else
		helper.Opacity = 0.7
	End If
End Sub

Private Sub btnCenter_Click
	helper.StartPosition = helper.POS_CENTERSCREEN
End Sub

Private Sub btnTitle_Click
	mTitleCount = mTitleCount + 1
	helper.Text = $"Title changed (${mTitleCount})"$
End Sub

Private Sub btnFixed_Click
	helper.FormBorderStyle = helper.BORDER_FIXED	'Resizable applies live; decorations only before Show
End Sub

Private Sub btnSizable_Click
	helper.FormBorderStyle = helper.BORDER_SIZABLE
End Sub

'--- Phase 2 handlers ---

Private Sub btnMove_Click
	helper.SetLocation(50, 50)
End Sub

Private Sub btnResize_Click
	helper.SetSize(800, 500)
End Sub

Private Sub btnBounds_Click
	helper.SetBounds(100, 100, 700, 450)
End Sub

Private Sub btnMinSize_Click
	helper.SetMinimumSize(400, 300)
End Sub

Private Sub btnMaxSize_Click
	helper.SetMaximumSize(900, 600)
End Sub

Private Sub btnCenter2_Click
	helper.CenterToScreen
End Sub

Private Sub btnLogSize_Click
	Log($"Left=${helper.Left} Top=${helper.Top} Width=${helper.Width} Height=${helper.Height} Client=${helper.ClientWidth}x${helper.ClientHeight}"$)
End Sub

'--- Phase 3 handlers ---

Private Sub btnBackColor_Click
	helper.BackColor = xui.Color_RGB(Rnd(0, 256), Rnd(0, 256), Rnd(0, 256))
End Sub

Private Sub btnCursorWait_Click
	helper.Cursor = helper.CURSOR_WAIT
End Sub

Private Sub btnCursorHand_Click
	helper.Cursor = helper.CURSOR_HAND
End Sub

Private Sub btnCursorDefault_Click
	helper.Cursor = helper.CURSOR_DEFAULT
End Sub

Private Sub btnIcon_Click
	Try
		helper.SetIconFromFile(File.DirAssets, "icon.png")
	Catch
		Log("Icon load failed (add an 'icon.png' to the Files folder to test): " & LastException)
	End Try
End Sub

'--- Phase 4 handlers ---

Private Sub btnFront_Click
	helper.BringToFront
End Sub

Private Sub btnFocus_Click
	helper.Focus
End Sub

Private Sub btnHideShow_Click
	helper.Hide
	Sleep(1000)
	helper.Show
End Sub

Private Sub btnDialog_Click
	Dim dlg As frmDialog
	dlg.Initialize
	Wait For (dlg.ShowDialog("Modal Dialog")) Complete (result As Int)
	Log($"Dialog result = ${result}"$)
End Sub

Private Sub btnDialogTwice_Click
	'Demonstrates the guard: calling ShowDialog on the already-shown MAIN form throws.
	Try
		Wait For (helper.ShowDialog) Complete (result As Int)
	Catch
		Log("Expected throw: " & LastException)
	End Try
End Sub

'--- ColorThemes handlers ---

Private Sub btnThemeToggle_Click
	theme.Toggle
	Log($"Theme: ${theme.Family} dark=${theme.IsDark}"$)
End Sub

Private Sub btnThemePrimer_Click
	theme.Apply(theme.PRIMER, theme.IsDark)
End Sub

Private Sub btnThemeNord_Click
	theme.Apply(theme.NORD, theme.IsDark)
End Sub

Private Sub btnThemeCupertino_Click
	theme.Apply(theme.CUPERTINO, theme.IsDark)
End Sub

Private Sub btnThemeDracula_Click
	theme.Apply(theme.DRACULA, True)
End Sub

Private Sub btnThemeGruvbox_Click
	theme.Apply(theme.GRUVBOX, theme.IsDark)
End Sub

Private Sub btnThemeSolarized_Click
	theme.Apply(theme.SOLARIZED, theme.IsDark)
End Sub

Private Sub btnThemeAuto_Click
	theme.ApplyAuto(theme.Family)
	Log($"Auto theme: OS dark=${theme.IsOsDark}"$)
End Sub

Private Sub btnThemeModena_Click
	theme.UseModena
End Sub

Private Sub btnThemeReload_Click
	theme.LoadOrDefault(theme.PRIMER, theme.IsOsDark)
	Log($"Loaded saved theme: ${theme.Family} dark=${theme.IsDark}"$)
End Sub

Private Sub btnAccentRandom_Click
	theme.SetAccent(Main.MainForm, xui.Color_RGB(Rnd(0, 256), Rnd(0, 256), Rnd(0, 256)))
End Sub

Private Sub btnAccentClear_Click
	theme.ClearAccent(Main.MainForm)
End Sub

Private Sub btnDensityCompact_Click
	theme.SetDensity(Root, theme.DENSITY_COMPACT)
End Sub

Private Sub btnDensityNormal_Click
	theme.SetDensity(Root, theme.DENSITY_NORMAL)
End Sub

Private Sub btnDensityComfortable_Click
	theme.SetDensity(Root, theme.DENSITY_COMFORTABLE)
End Sub

Private Sub btnTestLayout_Click
	Dim f As frmTestLayout
	f.Initialize
	f.Show
End Sub

Private Sub btnCustomWindow_Click
	'--- TESTING .....
	Dim tb As frmTitleBar
	tb.Initialize("Custom Window (drag me)", 480dip, 320dip)
	tb.RoundedShadow = True		'rounded corners + drop shadow (must be before Show)
	tb.FocusBorder = True		'accent border when focused, neutral when not
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Text = "Undecorated window with a themed custom title bar." & CRLF & _
		"Drag the bar to move, double-click to maximize."
	tb.ContentPane.AddView(lbl, 20dip, 20dip, 420dip, 60dip)
	tb.Show
End Sub
