B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
#ModuleVisibility: B4XLib
'Code module
'HTMLBuilder - Reusable HTML generation functions for purchase screens
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

' Build HTML for a single feature card
' Returns empty string if title is blank (hides the feature)
' emoji: The emoji or bullet point to display
' title: The feature title (if blank, feature is hidden)
' description: The feature description
Public Sub BuildFeatureHTML(emoji As String, title As String, description As String) As String
	If title = "" Then
		Return ""
	End If
	
	' Use bullet point if emoji is empty
	If emoji = "" Then
		emoji = "✓"  ' Check mark - suggests included features
	End If
	
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("            <div class=""feature"">").Append(CRLF)
	sb.Append("                <div class=""feature-icon"">").Append(emoji).Append("</div>").Append(CRLF)
	sb.Append("                <div class=""feature-text"">").Append(CRLF)
	sb.Append("                    <h3>").Append(title).Append("</h3>").Append(CRLF)
	sb.Append("                    <p>").Append(description).Append("</p>").Append(CRLF)
	sb.Append("                </div>").Append(CRLF)
	sb.Append("            </div>").Append(CRLF)
	
	Return sb.ToString
End Sub

' Build HTML for all product cards (for multiple-product layout)
' products: List of product Maps (each with product_id, title, description, price)
' Returns HTML string with all product cards
Public Sub BuildProductsHTML(products As List) As String
	If products.IsInitialized = False Or products.Size = 0 Then
		Return ""
	End If
	
	Dim sb As StringBuilder
	sb.Initialize
	
	For Each product As Map In products
		Dim productId As String = product.Get("product_id")
		Dim title As String = product.Get("title")
		Dim description As String = product.Get("description")
		Dim price As String = product.GetDefault("price", "...")
		
		sb.Append("                <div class=""product-card"">").Append(CRLF)
		sb.Append("                    <div class=""product-header"">").Append(CRLF)
		sb.Append("                        <div class=""product-title"">").Append(title).Append("</div>").Append(CRLF)
		sb.Append("                        <div class=""product-description"">").Append(description).Append("</div>").Append(CRLF)
		sb.Append("                    </div>").Append(CRLF)
		sb.Append("                    <div class=""product-footer"">").Append(CRLF)
		sb.Append("                        <div class=""product-price"" id=""price-").Append(productId).Append(""">").Append(price).Append("</div>").Append(CRLF)
		sb.Append("                        <button class=""btn-buy"" onclick=""purchase('").Append(productId).Append("')"">Buy Now</button>").Append(CRLF)
		sb.Append("                    </div>").Append(CRLF)
		sb.Append("                </div>").Append(CRLF)
	Next
	
	Return sb.ToString
End Sub

' Convert hex color to rgba with alpha transparency
' Example: HexToRGBA("#00ffff", 0.2) returns "rgba(0, 255, 255, 0.2)"
' hexColor: Hex color string (with or without #)
' alpha: Alpha transparency (0.0 to 1.0)
Public Sub HexToRGBA(hexColor As String, alpha As Double) As String
	' Remove # if present
	If hexColor.StartsWith("#") Then
		hexColor = hexColor.SubString(1)
	End If
	
	' Parse RGB values
	Dim r As Int = Bit.ParseInt(hexColor.SubString2(0, 2), 16)
	Dim g As Int = Bit.ParseInt(hexColor.SubString2(2, 4), 16)
	Dim b As Int = Bit.ParseInt(hexColor.SubString2(4, 6), 16)
	
	Return $"rgba(${r}, ${g}, ${b}, ${alpha})"$
End Sub

' Convert hex color to B4X color integer
' hexColor: Hex color string (with or without #)
' Returns B4X color integer (ARGB format)
Public Sub HexToColor(hexColor As String) As Int
	' Remove # if present
	If hexColor.StartsWith("#") Then
		hexColor = hexColor.SubString(1)
	End If
	
	' Parse RGB values
	Dim r As Int = Bit.ParseInt(hexColor.SubString2(0, 2), 16)
	Dim g As Int = Bit.ParseInt(hexColor.SubString2(2, 4), 16)
	Dim b As Int = Bit.ParseInt(hexColor.SubString2(4, 6), 16)
	
	' Return ARGB color (fully opaque)
	Return Bit.Or(0xFF000000, Bit.Or(Bit.ShiftLeft(r, 16), Bit.Or(Bit.ShiftLeft(g, 8), b)))
End Sub

' Determine if a background color is dark or light
' Uses relative luminance formula (WCAG standard)
' hexColor: Hex color string (with or without #)
' Returns True if dark background, False if light background
Public Sub IsBackgroundDark(hexColor As String) As Boolean
	' Remove # if present
	If hexColor.StartsWith("#") Then
		hexColor = hexColor.SubString(1)
	End If
	
	' Parse RGB values
	Dim r As Int = Bit.ParseInt(hexColor.SubString2(0, 2), 16)
	Dim g As Int = Bit.ParseInt(hexColor.SubString2(2, 4), 16)
	Dim b As Int = Bit.ParseInt(hexColor.SubString2(4, 6), 16)
	
	' Calculate relative luminance (simplified)
	Dim luminance As Double = (0.299 * r + 0.587 * g + 0.114 * b) / 255
	
	' If luminance < 0.5, it's a dark background
	Return luminance < 0.5
End Sub

' Apply default theme colors if not set
' Returns Map with: primary, secondary, accent, bg1, bg2
' colorPrimary, colorSecondary, colorAccent, colorBg1, colorBg2: User-provided colors (can be empty)
' darkMode: If True, applies dark theme defaults
Public Sub ApplyDefaultTheme(colorPrimary As String, colorSecondary As String, colorAccent As String, colorBg1 As String, colorBg2 As String) As Map
	Return ApplyDefaultThemeWithDarkMode(colorPrimary, colorSecondary, colorAccent, colorBg1, colorBg2, False)
End Sub

' Apply default theme colors with dark mode support
' Returns Map with: primary, secondary, accent, bg1, bg2
' colorPrimary, colorSecondary, colorAccent, colorBg1, colorBg2: User-provided colors (can be empty)
' darkMode: If True, applies dark theme defaults (unless colors are explicitly set)
Public Sub ApplyDefaultThemeWithDarkMode(colorPrimary As String, colorSecondary As String, colorAccent As String, colorBg1 As String, colorBg2 As String, darkMode As Boolean) As Map
	Dim result As Map
	result.Initialize
	
	' Default theme colors based on dark mode
	Dim primary As String = colorPrimary
	Dim secondary As String = colorSecondary
	Dim accent As String = colorAccent
	Dim bg1 As String = colorBg1
	Dim bg2 As String = colorBg2
	
	If darkMode Then
		' Dark mode defaults - softer, more muted colors
		If primary = "" Then primary = "#0A84FF"  ' iOS dark mode blue (softer than bright cyan)
		If bg1 = "" Then bg1 = "#1C1C1E"  ' Dark gray (iOS dark mode background)
	Else
		' Light mode defaults
		If primary = "" Then primary = "#007AFF"  ' iOS/Standard blue
		If bg1 = "" Then bg1 = "#FFFFFF"  ' White background
	End If
	
	' Fallback logic: if secondary/accent not set, use primary
	If secondary = "" Then secondary = primary
	If accent = "" Then accent = primary
	If bg2 = "" Then bg2 = bg1
	
	result.Put("primary", primary)
	result.Put("secondary", secondary)
	result.Put("accent", accent)
	result.Put("bg1", bg1)
	result.Put("bg2", bg2)
	
	Return result
End Sub

' Get adaptive text colors based on background darkness
' Returns Map with: textColor, textColorAlpha, featureBg, featureBorder, featureHoverBg, dividerColor, overlayBg, buttonTextColor
' isDark: True if background is dark, False if light
Public Sub GetAdaptiveColors(isDark As Boolean) As Map
	Dim result As Map
	result.Initialize
	
	If isDark Then
		' Dark background - use light text
		result.Put("textColor", "#FFFFFF")
		result.Put("textColorAlpha", "rgba(255, 255, 255, 0.6)")
		result.Put("featureBg", "rgba(255, 255, 255, 0.03)")
		result.Put("featureBorder", "rgba(255, 255, 255, 0.1)")
		result.Put("featureHoverBg", "rgba(255, 255, 255, 0.05)")
		result.Put("dividerColor", "rgba(255, 255, 255, 0.15)")
		result.Put("overlayBg", "rgba(10, 14, 39, 0.85)")
		result.Put("buttonTextColor", "#FFFFFF")
	Else
		' Light background - use dark text
		result.Put("textColor", "#000000")
		result.Put("textColorAlpha", "rgba(0, 0, 0, 0.6)")
		result.Put("featureBg", "rgba(0, 0, 0, 0.03)")
		result.Put("featureBorder", "rgba(0, 0, 0, 0.1)")
		result.Put("featureHoverBg", "rgba(0, 0, 0, 0.05)")
		result.Put("dividerColor", "rgba(0, 0, 0, 0.1)")
		result.Put("overlayBg", "rgba(255, 255, 255, 0.9)")
		result.Put("buttonTextColor", "#FFFFFF")
	End If
	
	Return result
End Sub


' Build HTML for all subscription cards (for subscription screen)
' subscriptions: List of subscription Maps (each with product_id, base_plan_id, title, description, billing_period, price)
' Returns HTML string with all subscription cards
Public Sub BuildSubscriptionsHTML(subscriptions As List) As String
	If subscriptions.IsInitialized = False Or subscriptions.Size = 0 Then
		Return ""
	End If
	
	Dim sb As StringBuilder
	sb.Initialize
	
	For Each subscription As Map In subscriptions
		Dim productId As String = subscription.Get("product_id")
		Dim basePlanId As String = subscription.Get("base_plan_id")
		Dim title As String = subscription.Get("title")
		Dim description As String = subscription.Get("description")
		Dim price As String = subscription.GetDefault("price", "...")
		
		sb.Append("                <div class=""product-card"">").Append(CRLF)
		sb.Append("                    <div class=""product-header"">").Append(CRLF)
		sb.Append("                        <div class=""product-title"">").Append(title).Append("</div>").Append(CRLF)
		sb.Append("                        <div class=""product-description"">").Append(description).Append("</div>").Append(CRLF)
		sb.Append("                    </div>").Append(CRLF)
		sb.Append("                    <div class=""product-footer"">").Append(CRLF)
		sb.Append("                        <div class=""product-price"" id=""price-").Append(productId).Append(""">").Append(price).Append("</div>").Append(CRLF)
		sb.Append("                        <button class=""btn-buy"" onclick=""purchase('").Append(productId).Append("', '").Append(basePlanId).Append("')"">Subscribe</button>").Append(CRLF)
		sb.Append("                    </div>").Append(CRLF)
		sb.Append("                </div>").Append(CRLF)
	Next
	
	Return sb.ToString
End Sub
