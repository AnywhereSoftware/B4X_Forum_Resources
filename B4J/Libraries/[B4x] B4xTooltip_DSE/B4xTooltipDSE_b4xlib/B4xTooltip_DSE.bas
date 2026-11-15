B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
Sub Class_Globals
	#If B4j
	Private fx As JFX
	#End if
	Private xui As XUI
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

#If B4a
'Parameters: Text As String, 1 view
'Code in DesignerScript:{class}.SetTooltip("Tooltip", Button1)
Public Sub SetTooltip(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim p As Phone
		If p.SdkVersion >= 26 Then
			Dim Text As String = DesignerArgs.Arguments.Get(0)
			Dim viewJO As JavaObject = DesignerArgs.GetViewFromArgs(1)
			viewJO.RunMethod("setOnLongClickListener", Array As Object(Null))   'remove any longClick listener
			viewJO.RunMethod("setTooltip", Array As Object(Text))
		End If
	End If
End Sub
#End if
#if B4J
'Parameters: any number of views. If you are adding a graphic from the layout, each view should have it's own graphic node specified in the JSON.
'Code in DesignerScript:{class}.SetTooltip(Button1, Button2)
Public Sub SetTooltipFromJson(DesignerArgs As DesignerArgs)
	Dim GraphicNodes As List
	GraphicNodes.Initialize
	
	If DesignerArgs.FirstRun Then
		For i = 0 To DesignerArgs.Arguments.Size - 1
			Dim Target As JavaObject = DesignerArgs.GetViewFromArgs(i)
			Dim SourceTT As JavaObject = Target.RunMethod("getTooltip")
			Dim JSonStr As String = SourceTT.RunMethod("getText")
			If JSonStr.Length = 0 Then
				LogColor($"DSE Error (${DesignerArgs.Arguments.Get(i)}): JSON String not found. Cannot continue"$, xui.Color_Red)
				Return
			End If
		
			Dim JSon As JSONParser
			JSon.Initialize(JSonStr)
						
			Dim Root As Map = JSon.NextObject
			

			If Root.ContainsKey("Tooltip") Then
				Dim TTMap As Map = Root.Get("Tooltip")
			
				If TTMap.ContainsKey("Graphic") Then
					Dim Graphic As Map = TTMap.Get("Graphic")
					Dim GraphicName As String = Graphic.Get("Graphic").As(String).ToLowerCase
					If GraphicNodes.IndexOf(GraphicName) > -1 Then
						LogColor($"DSE Error (${DesignerArgs.Arguments.Get(i)}): You can only set the same graphic node to 1 tooltip. Cannot continue"$, xui.Color_Red)
						Return
					End If
					GraphicNodes.Add(GraphicName)
				End If
			
				Dim TT As JavaObject
				TT.InitializeNewInstance("javafx.scene.control.Tooltip")
			
				Dim Text As String
				For Each Key As String In TTMap.Keys
					Select Key
						Case "Text"
							Text = TTMap.Get("Text")
							TT.RunMethod("setText",Array(Text))
						Case "Font"
							Dim FontMap As Map = TTMap.Get("Font")
							
							For Each FKey As String In FontMap.keys
								Select FKey
									Case "FontFamily"
										Dim Font As Font = fx.CreateFont( _
										FontMap.Get("FontFamily"), _
										FontMap.GetDefault("FontSize",15), _
										FontMap.GetDefault("Bold",False) = "True", _
										FontMap.GetDefault("Italic",False) = "True" _
										)
										TT.RunMethod("setFont",Array(Font))
									Case "FontSize"
										If Not(FontMap.ContainsKey("FontFamily")) Then
											SetTTExistingFontSize(TT,FontMap.Get("FontSize"))
										End If
									Case "Bold","Italic"
										'Dealt with in FontFamily, remove from error reporting.
									Case "_Comment"
										'Do nothing
									Case Else
										LogColor($"DSE Error (${DesignerArgs.Arguments.Get(i)}): unrecognised key ${FKey} found in Font"$, xui.Color_Magenta)
								End Select
							Next
							
						Case "ShowDelay"
							TT.RunMethod("setShowDelay",Array(NewDuration(TTMap.Get("ShowDelay"))))
							
						Case "HideDelay"
							TT.RunMethod("setHideDelay",Array(NewDuration(TTMap.Get("HideDelay"))))
								
						Case "ShowDuration"
							TT.RunMethod("setShowDuration",Array(NewDuration(TTMap.Get("ShowDuration"))))
							
						Case "TextAlignment"
							TT.RunMethod("setTextAlignment",Array(TTMap.Get("TextAlignment")))
							
						Case "ContentDisplay"
							TT.RunMethod("setContentDisplay",Array(TTMap.Get("ContentDisplay")))
							
						Case "TextOverrun"
							TT.RunMethod("setTextOverrun",Array(TTMap.Get("TextOverrun")))
							
						Case "Graphic"
							Dim GraphicMap As Map = TTMap.Get("Graphic")
							For Each GKey As String In GraphicMap.Keys
								Select GKey
									Case "Graphic"
										Dim GraphicView As B4XView = DesignerArgs.GetViewByName(Graphic.Get("Graphic").As(String).ToLowerCase)
										TT.RunMethod("setGraphic",Array(GraphicView))
										GraphicView.RemoveViewFromParent
									Case "GraphicTextGap"
										TT.RunMethod("setGraphicTextGap",Array(Graphic.Get("GraphicTextGap").as(Double)))
									Case Else
										LogColor($"DSE Error (${DesignerArgs.Arguments.Get(i)}): unrecognised key ${GKey} found in Graphic element"$, xui.Color_Magenta)
									Case "_Comment"
										'Do nothing
								End Select
							Next
			
						Case "Height"
							TT.RunMethod("setPrefHeight",Array(TTMap.Get("Height").As(Double)))
						Case "Width"
							TT.RunMethod("setPrefWidth",Array(TTMap.Get("Width").As(Double)))
						Case "WrapText"
							TT.RunMethod("setWrapText",Array(TTMap.Get("WrapText") = "True"))
						Case "Style"
							TT.RunMethod("setStyle",Array(TTMap.Get("Style")))
						Case "_Comment"
							'Do nothing
						Case Else
							LogColor($"DSE Error (${DesignerArgs.Arguments.Get(i)}): unrecognised key ${Key} found in main body"$, xui.Color_Magenta)
					End Select
				Next
			
				Target.As(JavaObject).RunMethod("setTooltip",Array(TT))
			End If
		Next
	End If
End Sub

Private Sub NewDuration(Duration As Double) As JavaObject
	Dim Dur As JavaObject
	Return Dur.InitializeNewInstance("javafx.util.Duration",Array(Duration))
End Sub
'Parameters: Size As Int, 1 or more Views (Comma delimited)
'Designer Script : {Class}.SetTooltipTextSize(14,btn1,btn2)
Public Sub SetTooltipTextSize(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim Size As Double = DesignerArgs.Arguments.Get(0)
		Dim F As B4XFont = xui.CreateFont(DesignerArgs.GetViewFromArgs(1).As(B4XView).Font,Size)
      
		For i = 1 To DesignerArgs.Arguments.Size - 1
			Dim V As B4XView = DesignerArgs.GetViewFromArgs(i)
			Dim TT As JavaObject = V.As(JavaObject).RunMethod("getTooltip",Null)
			TT.Runmethod("setFont",Array(F))
		Next
	End If
End Sub

Private Sub SetTTExistingFontSize(TT As JavaObject, FontSize As Double)
	Dim OrigFont As Font = TT.RunMethod("getFont")
	Dim NewFont As Font = xui.CreateFont(OrigFont,FontSize)
	TT.RunMethod("setFont",Array(NewFont))
End Sub
#End If

