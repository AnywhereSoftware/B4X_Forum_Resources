B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ColorThemes - app-wide light/dark theming for B4J using AtlantaFX (MIT, JavaFX 17+).
' AtlantaFX is applied as the JavaFX *user-agent* stylesheet, so it themes the WHOLE app
' with one call. Switch families/modes at runtime; null restores the built-in Modena theme.
' The .css files must live in the Files folder (registered in the project).
' See DOCS/Light-Dark-ToDo.md.
'
' AtlantaFX (theme CSS source): https://github.com/mkpaz/atlantafx
'
' Custom families (gruvbox, solarized) are AtlantaFX themes with a swapped .root color
' palette - the component CSS below the palette is AtlantaFX's, unchanged.
' Gruvbox palette:   https://github.com/morhetz/gruvbox
' Solarized palette: https://github.com/altercation/solarized
Sub Class_Globals
	'theme families (AtlantaFX)
	Public Const PRIMER As String = "primer"
	Public Const NORD As String = "nord"
	Public Const CUPERTINO As String = "cupertino"
	Public Const DRACULA As String = "dracula"		'dark only
	Public Const GRUVBOX As String = "gruvbox"		'custom (light + dark)
	Public Const SOLARIZED As String = "solarized"	'custom (light + dark)

	'UI density (scales the root font size; control paddings are em-based so they follow)
	Public Const DENSITY_COMPACT As Int = 0
	Public Const DENSITY_NORMAL As Int = 1
	Public Const DENSITY_COMFORTABLE As Int = 2

	Private mFamily As String
	Private mDark As Boolean
	Private mListeners As List		'each item: Map with "target" and "event"
End Sub

Public Sub Initialize
	mFamily = PRIMER
	mDark = False
	mListeners.Initialize
End Sub

'Apply a theme family in light or dark. DRACULA is dark-only (DarkMode is ignored for it).
Public Sub Apply (Family As String, DarkMode As Boolean)
	mFamily = Family
	mDark = DarkMode
	Dim cssFile As String
	If Family = DRACULA Then
		mDark = True
		cssFile = "dracula.css"
	Else If DarkMode Then
		cssFile = $"${Family}-dark.css"$
	Else
		cssFile = $"${Family}-light.css"$
	End If
	ApplyCssFile(cssFile)
	Save				'persist the selection
	RaiseThemeChanged	'notify listeners
End Sub

'Apply a specific AtlantaFX css file by name (file must be in the Files folder).
Public Sub ApplyCssFile (CssFileName As String)
	SetUserAgentStylesheet(File.GetUri(File.DirAssets, CssFileName))
End Sub

'Restore JavaFX's built-in Modena look (removes AtlantaFX).
Public Sub UseModena
	SetUserAgentStylesheet(Null)
	RaiseThemeChanged
End Sub

'Convenience switches that keep the current family.
Public Sub SetLight
	Apply(mFamily, False)
End Sub

Public Sub SetDark
	Apply(mFamily, True)
End Sub

Public Sub Toggle
	Apply(mFamily, Not(mDark))
End Sub

Public Sub getIsDark As Boolean
	Return mDark
End Sub

Public Sub getFamily As String
	Return mFamily
End Sub

'===================== Theme-changed notifications =====================
' Other modules can react to theme changes (e.g. re-tint custom-drawn views or swap a logo).

'Register Target to receive: <EventName>_ThemeChanged (Family As String, Dark As Boolean)
Public Sub AddThemeListener (Target As Object, EventName As String)
	Dim m As Map : 	m.Initialize
	m.Put("target", Target)
	m.Put("event", EventName)
	mListeners.Add(m)
End Sub

'Stop notifying Target (best-effort; matches by reference).
Public Sub RemoveThemeListener (Target As Object)
	For i = mListeners.Size - 1 To 0 Step -1
		Dim m As Map = mListeners.Get(i)
		If m.Get("target") = Target Then mListeners.RemoveAt(i)
	Next
End Sub

'Fires <EventName>_ThemeChanged on every listener via CallSubDelayed (runs on a clean tick).
Private Sub RaiseThemeChanged
	If mListeners.IsInitialized = False Then Return
	For Each m As Map In mListeners
		Dim target As Object = m.Get("target")
		Dim ev As String = $"${m.Get("event")}_ThemeChanged"$
		If SubExists(target, ev) Then
			CallSubDelayed3(target, ev, mFamily, mDark)
		End If
	Next
End Sub

'===================== Persistence =====================
' Remembers the selected family + mode between runs (saved under File.DirData).

'Apply the saved theme, or the provided default if nothing has been saved yet.
Public Sub LoadOrDefault (DefaultFamily As String, DefaultDark As Boolean)
	If File.Exists(SettingsDir, "theme.txt") Then
		Dim m As Map = File.ReadMap(SettingsDir, "theme.txt")
		Dim fam As String = m.GetDefault("family", DefaultFamily)
		Dim darkStr As String = m.GetDefault("dark", "false")
		Apply(fam, darkStr = "true")
	Else
		Apply(DefaultFamily, DefaultDark)
	End If
End Sub

'Persist the current family + mode (called automatically by Apply).
Public Sub Save
	Dim m As Map
	m.Initialize
	m.Put("family", mFamily)
	m.Put("dark", mDark)
	File.WriteMap(SettingsDir, "theme.txt", m)
End Sub

Private Sub SettingsDir As String
	Return File.DirData("GUIHelpers")
End Sub

'setUserAgentStylesheet is static and themes the entire application. Null = default (Modena).
Private Sub SetUserAgentStylesheet (Uri As String)
	Dim app As JavaObject
	app.InitializeStatic("javafx.application.Application")
	app.RunMethod("setUserAgentStylesheet", Array(Uri))
End Sub

'===================== Per-form accent color =====================
' Overrides the accent color for ONE window (layered on top of the global theme) by setting
' AtlantaFX's accent CSS variables on that form's root node. Cascades to all controls in the form.

'Set the accent color of a single form (focus rings, default buttons, selections, links...).
Public Sub SetAccent (TargetForm As Form, Clr As Int)
	Dim hex As String = ColorToHex(Clr)
	Dim style As String = $"-color-accent-fg: ${hex}; -color-accent-emphasis: ${hex}; "$ _
		& $"-color-accent-muted: derive(${hex}, 40%); -color-accent-subtle: derive(${hex}, 80%);"$
	Dim joRoot As JavaObject = TargetForm.RootPane
	Dim existing As String = joRoot.RunMethod("getStyle", Null)
	joRoot.RunMethod("setStyle", Array($"${existing} ${style}"$))
End Sub

'Remove a per-form accent override (clears the root node's inline style).
Public Sub ClearAccent (TargetForm As Form)
	Dim joRoot As JavaObject = TargetForm.RootPane
	joRoot.RunMethod("setStyle", Array(""))
End Sub

'Set UI density on a container by scaling its root font size; cascades to all child controls
'(AtlantaFX paddings are em-based, so compact/comfortable changes the whole layout's tightness).
Public Sub SetDensity (Target As B4XView, Level As Int)
	Dim px As Int
	Select Level
		Case DENSITY_COMPACT
			px = 11
		Case DENSITY_COMFORTABLE
			px = 17
		Case Else 'DENSITY_NORMAL
			px = 14
	End Select
	Dim jo As JavaObject = Target
	jo.RunMethod("setStyle", Array($"-fx-font-size: ${px}px;"$))
End Sub

'B4J color Int -> CSS "#RRGGBB" (alpha ignored).
Private Sub ColorToHex (Clr As Int) As String
	Dim r As Int = Bit.And(Bit.ShiftRight(Clr, 16), 0xFF)
	Dim g As Int = Bit.And(Bit.ShiftRight(Clr, 8), 0xFF)
	Dim b As Int = Bit.And(Clr, 0xFF)
	Return $"#${Nibbles(r)}${Nibbles(g)}${Nibbles(b)}"$
End Sub

'A 0-255 value as two lowercase hex digits.
Private Sub Nibbles (Value As Int) As String
	Dim digits As String = "0123456789abcdef"
	Dim hi As Int = Bit.And(Bit.ShiftRight(Value, 4), 0x0F)
	Dim lo As Int = Bit.And(Value, 0x0F)
	Return digits.CharAt(hi) & digits.CharAt(lo)
End Sub

'===================== OS dark-mode detection =====================
' JavaFX 17 has no Platform Preferences API, so we query the OS directly.
' Detection is a one-time read (no live OS-change listener on JavaFX 17).

'Apply the current family, picking light/dark from the OS preference.
Public Sub ApplyAuto (Family As String)
	Apply(Family, IsOsDark)
End Sub

'True if the OS is currently in dark mode (Windows + Linux; best-effort, False on failure).
Public Sub IsOsDark As Boolean
	Dim os As String = ReadSystemProperty("os.name").ToLowerCase
	If os.Contains("win") Then Return IsWindowsDark
	If os.Contains("nux") Or os.Contains("nix") Then Return IsLinuxDark
	If os.Contains("mac") Then Return RunCommand(Array As String("defaults", "read", "-g", "AppleInterfaceStyle")).ToLowerCase.Contains("dark")
	Return False
End Sub

Private Sub IsWindowsDark As Boolean
	'https://www.b4x.com/android/forum/threads/windows-registry-jregistry.147602/
	'AppsUseLightTheme: 0x0 = dark, 0x1 = light
	Dim out As String = RunCommand(Array As String("reg", "query", _
		"HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", _
		"/v", "AppsUseLightTheme"))
	Return out.Contains("0x0")
End Sub

Private Sub IsLinuxDark As Boolean
	'GNOME 42+: color-scheme returns 'prefer-dark' / 'prefer-light' / 'default'
	Dim cs As String = RunCommand(Array As String("gsettings", "get", _
		"org.gnome.desktop.interface", "color-scheme")).ToLowerCase
	If cs.Contains("dark") Then Return True
	If cs.Contains("light") Then Return False
	'KDE Plasma: active color scheme name in kdeglobals, e.g. "BreezeDark" (Plasma 6 then 5)
	Dim kde As String = RunCommand(Array As String("kreadconfig6", "--file", "kdeglobals", _
		"--group", "General", "--key", "ColorScheme")).ToLowerCase
	If kde.Trim = "" Then kde = RunCommand(Array As String("kreadconfig5", "--file", "kdeglobals", _
		"--group", "General", "--key", "ColorScheme")).ToLowerCase
	If kde.Trim <> "" Then Return kde.Contains("dark")
	'fallback for older GTK desktops (and GNOME 'default'): inspect the GTK theme name
	Dim gtk As String = RunCommand(Array As String("gsettings", "get", _
		"org.gnome.desktop.interface", "gtk-theme")).ToLowerCase
	Return gtk.Contains("dark")
End Sub

Private Sub ReadSystemProperty (Key As String) As String
	Dim sys As JavaObject
	sys.InitializeStatic("java.lang.System")
	Dim v As Object = sys.RunMethod("getProperty", Array(Key))
	If v = Null Then Return ""
	Return v
End Sub

'Runs a command and returns its stdout (best-effort; "" on any failure).
'https://www.b4x.com/android/forum/threads/windows-registry-jregistry.147602/
Private Sub RunCommand (Command() As String) As String
	Try
		Dim rt As JavaObject
		rt.InitializeStatic("java.lang.Runtime")
		Dim runtime As JavaObject = rt.RunMethodJO("getRuntime", Null)
		Dim proc As JavaObject = runtime.RunMethodJO("exec", Array(Command))
		Dim isr As JavaObject
		isr.InitializeNewInstance("java.io.InputStreamReader", Array(proc.RunMethodJO("getInputStream", Null)))
		Dim br As JavaObject
		br.InitializeNewInstance("java.io.BufferedReader", Array(isr))
		Dim sb As StringBuilder
		sb.Initialize
		Dim lineObj As Object = br.RunMethod("readLine", Null)
		Do While lineObj <> Null
			sb.Append(lineObj).Append(" ")
			lineObj = br.RunMethod("readLine", Null)
		Loop
		br.RunMethod("close", Null)
		Return sb.ToString
	Catch
		Log($"RunCommand failed: ${LastException}"$)
		Return ""
	End Try
End Sub
