B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private mDark As Boolean
    Private mSeedColor As Int
End Sub

' Creates a light theme with the default teal seed color.
Public Sub Initialize As UITheme
    mDark = False
    mSeedColor = 0xFF00A896
    Return Me
End Sub

' Creates a light theme from a seed color in one declarative call.
' Use a normal B4A ARGB color, for example 0xFF6750A4.
Public Sub InitializeWithScheme(SeedColor As Int) As UITheme
    mDark = False
    mSeedColor = NormalizeColor(SeedColor)
    Return Me
End Sub

' Creates a dark theme with the default teal seed color.
' This is the explicit counterpart to Initialize for callers that prefer
' declaring the mode at construction time.
Public Sub InitializeDark As UITheme
    mDark = True
    mSeedColor = 0xFF00A896
    Return Me
End Sub

' Creates a theme from a seed color and an explicit light/dark mode.
Public Sub InitializeWithSchemeAndMode(SeedColor As Int, Dark As Boolean) As UITheme
    mDark = Dark
    mSeedColor = NormalizeColor(SeedColor)
    Return Me
End Sub

' Selects the seed color used to derive the active palette.
' This is the library equivalent of a Flutter ColorScheme seed color.
Public Sub Scheme(SeedColor As Int) As UITheme
    mSeedColor = NormalizeColor(SeedColor)
    Return Me
End Sub

' Returns the current seed color.
Public Sub GetScheme As Int
    Return mSeedColor
End Sub

' Selects the active color scheme and returns the same theme instance.
Public Sub DarkMode(Value As Boolean) As UITheme
    mDark = Value
    Return Me
End Sub

' Toggles the active color scheme and returns the new state.
Public Sub Toggle As Boolean
    mDark = Not(mDark)
    Return mDark
End Sub

' Returns True when the dark color scheme is active.
Public Sub IsDark As Boolean
    Return mDark
End Sub

' Returns the main application background color.
Public Sub Background As Int
    If mDark Then Return MixColors(mSeedColor, Colors.Black, 0.88)
    Return MixColors(Colors.White, mSeedColor, 0.03)
End Sub

' Returns the default card and surface color.
Public Sub Surface As Int
    If mDark Then Return MixColors(mSeedColor, Colors.Black, 0.72)
    Return MixColors(Colors.White, mSeedColor, 0.01)
End Sub

' Returns a secondary surface color for controls and muted buttons.
Public Sub SurfaceVariant As Int
    If mDark Then Return MixColors(mSeedColor, Colors.Black, 0.52)
    Return MixColors(Colors.White, mSeedColor, 0.14)
End Sub

' Returns the primary readable text color.
Public Sub PrimaryText As Int
    If mDark Then Return EnsureContrast(MixColors(Colors.White, mSeedColor, 0.08), Surface, True)
    Return EnsureContrast(MixColors(0xFF132238, mSeedColor, 0.08), Surface, False)
End Sub

' Returns the secondary readable text color.
Public Sub SecondaryText As Int
    If mDark Then Return EnsureContrast(MixColors(0xFFCBD5E1, mSeedColor, 0.12), Surface, True)
    Return EnsureContrast(MixColors(0xFF6B7B91, mSeedColor, 0.10), Surface, False)
End Sub

' Returns the low-emphasis text color.
Public Sub MutedText As Int
    If mDark Then Return EnsureContrast(MixColors(0xFF94A3B8, mSeedColor, 0.16), Surface, True)
    Return EnsureContrast(MixColors(0xFF7D8CA1, mSeedColor, 0.08), Surface, False)
End Sub

' Returns the default hint/placeholder color for inputs.
Public Sub HintText As Int
    Return MutedText
End Sub

' Returns the dashboard app bar color.
Public Sub DashboardBar As Int
    If mDark Then Return MixColors(mSeedColor, Colors.Black, 0.55)
    Return mSeedColor
End Sub

' Returns a readable foreground for the dashboard app bar.
Public Sub DashboardBarText As Int
    Return OnColor(DashboardBar)
End Sub

' Returns the secondary app bar color.
Public Sub SecondaryBar As Int
    If mDark Then Return MixColors(mSeedColor, Colors.Black, 0.82)
    Return MixColors(mSeedColor, Colors.Black, 0.64)
End Sub

' Returns the scrim color used behind modal dialogs.
Public Sub DialogOverlay As Int
    Return 0x66000000
End Sub

' Returns the default snackbar background.
' Keep light and dark schemes intentionally different, following the
' Material inverse-surface idea: dark in light mode and light in dark mode.
Public Sub SnackbarBackground As Int
    If mDark Then Return MixColors(0xFFE6E1E9, mSeedColor, 0.08)
    Return MixColors(0xFF302F33, mSeedColor, 0.10)
End Sub

' Returns a readable snackbar message color.
Public Sub SnackbarText As Int
    Return OnColor(SnackbarBackground)
End Sub

' Returns a readable snackbar action color.
Public Sub SnackbarAction As Int
    ' The action is text on the snackbar surface, so guarantee readable
    ' contrast independently of the selected seed color.
    Return EnsureContrast(mSeedColor, SnackbarBackground, Not(mDark))
End Sub

' Returns the highlighted dashboard hero surface.
Public Sub HeroSurface As Int
    If mDark Then Return MixColors(mSeedColor, Colors.Black, 0.60)
    Return MixColors(Colors.White, mSeedColor, 0.12)
End Sub

' Returns the primary teal accent color.
Public Sub Accent As Int
    ' Accent is used as a filled background by FABs and progress indicators,
    ' and as a foreground by navigation. Keep it readable in both roles.
    If mDark Then Return EnsureContrast(MixColors(mSeedColor, Colors.White, 0.08), Surface, True)
    Return EnsureContrast(mSeedColor, Surface, False)
End Sub

' Returns the blue informational accent color.
Public Sub Info As Int
    Return MixColors(0xFF3D6FE8, mSeedColor, 0.12)
End Sub

' Returns the destructive action color.
Public Sub Negative As Int
    Return MixColors(0xFFE45757, mSeedColor, 0.06)
End Sub

' Returns the divider color.
Public Sub Divider As Int
    If mDark Then Return MixColors(mSeedColor, Colors.White, 0.24)
    Return MixColors(Colors.White, mSeedColor, 0.12)
End Sub

' Returns the card border color.
Public Sub Border As Int
    If mDark Then Return MixColors(mSeedColor, Colors.White, 0.16)
    Return MixColors(Colors.White, mSeedColor, 0.18)
End Sub

' Returns the readable text color for buttons placed on variant surfaces.
Public Sub ButtonText As Int
    Return OnColor(SurfaceVariant)
End Sub

' Returns the background used by the theme action button.
Public Sub ThemeAction As Int
    Return MixColors(mSeedColor, Colors.Black, 0.74)
End Sub

' Returns a readable foreground for the theme action button.
Public Sub ThemeActionText As Int
    Return OnColor(ThemeAction)
End Sub

' Returns a readable foreground for the primary accent.
Public Sub AccentText As Int
    Return OnColor(Accent)
End Sub

' Returns a readable foreground for the informational accent.
Public Sub InfoText As Int
    Return OnColor(Info)
End Sub

' Returns a readable foreground for the destructive accent.
Public Sub NegativeText As Int
    Return OnColor(Negative)
End Sub

' ===== Material 3-like typography tokens =====
' These values are defaults. Individual widgets can override them explicitly.
Public Sub DisplayLarge As Int
    Return 32
End Sub

Public Sub HeadlineSmall As Int
    Return 24
End Sub

Public Sub TitleLarge As Int
    Return 22
End Sub

Public Sub TitleMedium As Int
    Return 16
End Sub

Public Sub BodyLarge As Int
    Return 16
End Sub

Public Sub BodyMedium As Int
    Return 14
End Sub

Public Sub BodySmall As Int
    Return 12
End Sub

Public Sub LabelLarge As Int
    Return 14
End Sub

Public Sub LabelMedium As Int
    Return 12
End Sub

Public Sub AppBarTitleSize As Int
    Return 20
End Sub

Public Sub ButtonTextSize As Int
    Return LabelLarge
End Sub

Public Sub InputTextSize As Int
    Return BodyLarge
End Sub

Public Sub NavigationIconSize As Int
    Return 24
End Sub

Public Sub NavigationTextSize As Int
    Return LabelMedium
End Sub

Public Sub FabTextSize As Int
    Return 24
End Sub

Public Sub SnackbarTextSize As Int
    Return BodyMedium
End Sub

Public Sub SnackbarActionTextSize As Int
    Return LabelLarge
End Sub

' ===== Material 3-like shape tokens =====
Public Sub RadiusNone As Int
    Return 0
End Sub

Public Sub RadiusSmall As Int
    Return 8dip
End Sub

Public Sub RadiusMedium As Int
    Return 12dip
End Sub

Public Sub RadiusLarge As Int
    Return 16dip
End Sub

Public Sub RadiusExtraLarge As Int
    Return 28dip
End Sub

Public Sub ButtonRadius As Int
    Return 20dip
End Sub

Public Sub CardRadius As Int
    Return RadiusMedium
End Sub

Public Sub InputRadius As Int
    Return RadiusMedium
End Sub

Public Sub FabRadius As Int
    Return RadiusExtraLarge
End Sub

Public Sub SnackbarRadius As Int
    Return RadiusSmall
End Sub

' ===== Material 3-like layout tokens =====
Public Sub AppBarHeight As Int
    Return 56dip
End Sub

Public Sub BottomNavigationHeight As Int
    Return 64dip
End Sub

Public Sub FabSize As Int
    Return 56dip
End Sub

Public Sub ControlHeight As Int
    Return 48dip
End Sub

Public Sub HorizontalPadding As Int
    Return 16dip
End Sub

Public Sub CardPadding As Int
    Return 16dip
End Sub

Public Sub ButtonHorizontalPadding As Int
    Return 32dip
End Sub

Public Sub InputHorizontalPadding As Int
    Return 12dip
End Sub

Public Sub InputVerticalPadding As Int
    Return 8dip
End Sub

Public Sub NavigationIconHeight As Int
    Return 30dip
End Sub

Public Sub NavigationCaptionTop As Int
    Return 34dip
End Sub

Public Sub NavigationIndicatorHeight As Int
    Return 3dip
End Sub

Public Sub NavigationHorizontalPadding As Int
    Return 4dip
End Sub

Public Sub NavigationDividerHeight As Int
    Return 1dip
End Sub

Public Sub SnackbarHeight As Int
    Return 56dip
End Sub

Public Sub SnackbarMargin As Int
    Return 16dip
End Sub

' Default visual height for determinate and indeterminate progress bars.
Public Sub ProgressBarHeight As Int
    Return 6dip
End Sub

' Default progress-bar corner radius. The widget clamps it to half its height.
Public Sub ProgressBarRadius As Int
    Return 3dip
End Sub

' ===== Dialog layout tokens =====
Public Sub DialogMaxWidth As Int
    Return 420dip
End Sub

Public Sub DialogTitleHeight As Int
    Return 48dip
End Sub

Public Sub DialogMessageHeight As Int
    Return 64dip
End Sub

Public Sub DialogMaxContentHeight As Int
    Return 180dip
End Sub

Public Sub DialogButtonWidth As Int
    Return 96dip
End Sub

Public Sub DialogOuterMargin As Int
    Return 16dip
End Sub

Public Sub DialogButtonSpacing As Int
    Return 4dip
End Sub

' ===== Snackbar layout tokens =====
Public Sub SnackbarActionWidth As Int
    Return 88dip
End Sub

Public Sub SnackbarContentPadding As Int
    Return 16dip
End Sub

Public Sub SnackbarActionSpacing As Int
    Return 8dip
End Sub

' ===== Navigation layout tokens =====
Public Sub NavigationIndicatorInset As Int
    Return 6dip
End Sub

Public Sub NavigationLabelBottomInset As Int
    Return 6dip
End Sub

Public Sub BorderWidth As Int
    Return 1dip
End Sub

' Returns either a dark or light foreground with useful contrast against Value.
Private Sub OnColor(Value As Int) As Int
    Dim lightContrast As Float = ContrastRatio(Value, Colors.White)
    Dim darkContrast As Float = ContrastRatio(Value, 0xFF132238)
    If lightContrast >= darkContrast Then Return Colors.White
    Return 0xFF132238
End Sub

' Blends two opaque colors. Amount 0 returns First and 1 returns Second.
Private Sub MixColors(First As Int, Second As Int, Amount As Float) As Int
    Dim safeAmount As Float = Amount
    If safeAmount < 0 Then safeAmount = 0
    If safeAmount > 1 Then safeAmount = 1
    Dim red As Int = MixChannel(ChannelRed(First), ChannelRed(Second), safeAmount)
    Dim green As Int = MixChannel(ChannelGreen(First), ChannelGreen(Second), safeAmount)
    Dim blue As Int = MixChannel(ChannelBlue(First), ChannelBlue(Second), safeAmount)
    Return ComposeColor(255, red, green, blue)
End Sub

Private Sub MixChannel(First As Int, Second As Int, Amount As Float) As Int
    Dim value As Int = Round(First + (Second - First) * Amount)
    If value < 0 Then value = 0
    If value > 255 Then value = 255
    Return value
End Sub

Private Sub ChannelRed(Value As Int) As Int
    Return Bit.And(Bit.ShiftRight(Value, 16), 0xFF)
End Sub

Private Sub ChannelGreen(Value As Int) As Int
    Return Bit.And(Bit.ShiftRight(Value, 8), 0xFF)
End Sub

Private Sub ChannelBlue(Value As Int) As Int
    Return Bit.And(Value, 0xFF)
End Sub

Private Sub ComposeColor(Alpha As Int, Red As Int, Green As Int, Blue As Int) As Int
    Return Bit.Or(Bit.Or(Bit.Or(Bit.ShiftLeft(Alpha, 24), Bit.ShiftLeft(Red, 16)), Bit.ShiftLeft(Green, 8)), Blue)
End Sub

Private Sub RelativeLuminance(Value As Int) As Float
    Return 0.2126 * LinearChannel(ChannelRed(Value)) _
        + 0.7152 * LinearChannel(ChannelGreen(Value)) _
        + 0.0722 * LinearChannel(ChannelBlue(Value))
End Sub

Private Sub LinearChannel(Value As Int) As Float
    Dim normalized As Float = Value / 255.0
    If normalized <= 0.03928 Then Return normalized / 12.92
    Return Power((normalized + 0.055) / 1.055, 2.4)
End Sub

' Compares two colors using WCAG-style relative luminance.
Private Sub ContrastRatio(Value As Int, Foreground As Int) As Float
    Dim backgroundLuminance As Float = RelativeLuminance(Value)
    Dim foregroundLuminance As Float = RelativeLuminance(Foreground)
    Dim lighter As Float = Max(backgroundLuminance, foregroundLuminance) + 0.05
    Dim darker As Float = Min(backgroundLuminance, foregroundLuminance) + 0.05
    Return lighter / darker
End Sub

' Moves a foreground toward white or black until it is readable over Background.
' This keeps arbitrary Scheme colors safe without changing the public API.
Private Sub EnsureContrast(Foreground As Int, SurfaceColor As Int, TowardWhite As Boolean) As Int
    Dim result As Int = Foreground
    If ContrastRatio(SurfaceColor, result) >= 4.5 Then Return result
    For i = 1 To 20
        If TowardWhite Then
            result = MixColors(result, Colors.White, 0.08)
        Else
            result = MixColors(result, Colors.Black, 0.08)
        End If
        If ContrastRatio(SurfaceColor, result) >= 4.5 Then Return result
    Next
    ' An extreme seed can already be white or black. Choose the better of
    ' the two deterministic foregrounds instead of returning a failed mix.
    Dim whiteContrast As Float = ContrastRatio(SurfaceColor, Colors.White)
    Dim darkContrast As Float = ContrastRatio(SurfaceColor, 0xFF132238)
    If whiteContrast >= darkContrast Then Return Colors.White
    Return 0xFF132238
End Sub

' Treat colors without an explicit alpha channel as opaque for predictable themes.
Private Sub NormalizeColor(Value As Int) As Int
    Dim alpha As Int = Bit.And(Bit.ShiftRight(Value, 24), 0xFF)
    If alpha = 0 Then alpha = 255
    Return ComposeColor(alpha, ChannelRed(Value), ChannelGreen(Value), ChannelBlue(Value))
End Sub