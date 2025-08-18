B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Type TRadioButton(RBView As B4XView, RBViewTag As B4XView, Selected As Boolean, Enabled As Boolean)
	
	Private mSelected			As B4XBitmap
	Private mUnSelected			As B4XBitmap
	Private mDisabled			As B4XBitmap

	'--------------------------------------------------------
	'	Using List for RadioButtons because we need to 
	'		Process the whole list for any RB changes	
	'--------------------------------------------------------
	Private mRadioButtons		As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public  Sub Initialize(xSelected As B4XBitmap, xUnSelected As B4XBitmap, xDisabled As B4XBitmap)
	
			mSelected			= xSelected
			mUnSelected			= xUnSelected
			mDisabled			= xDisabled
			
			mRadioButtons.Initialize			
End Sub

Public  Sub ClearAll
			mRadioButtons.Clear
End Sub

Public  Sub AddRB(xSelected As Object, xRBViews() As B4XView)
			Add_RB(xRBViews, Array As B4XView())
			
			If  xSelected <> Null Then
				Click(xSelected)				
			End If
End Sub

Public  Sub AddRBLabels(xSelected As Object, xRBViews() As B4XView, xRBTags() As B4XView)
			Add_RB(xRBViews, xRBTags)
			
			If  xSelected <> Null Then
				Click(xSelected)				
			End If
End Sub

Private Sub Add_RB(xRBViews() As B4XView, xTags() As B4XView)	
			
			For i = 0 To xRBViews.Length-1
				Dim RadioButton As TRadioButton
				
				RadioButton.Initialize
				RadioButton.RBView		= xRBViews(i)
				RadioButton.Selected	= False
				RadioButton.Enabled		= True
				
				If  xTags.Length > i Then
					RadioButton.RBViewTag = xTags(i)
				End If
				
				mRadioButtons.Add(RadioButton)
			Next
			
			ShowRadioButtons
End Sub

Public  Sub GetRadioButtons As List
			Return mRadioButtons
End Sub

Public  Sub Click(xRBView As B4XView) As Boolean
	
			For Each RadioButton As TRadioButton In mRadioButtons
				If  RadioButton.Enabled = False Then 
					Continue
				End If

				If  RadioButton.RBView = xRBView Then
					RadioButton.Selected = True				
				Else
					If  RadioButton.RBViewTag.IsInitialized Then
						If  xRBView = RadioButton.RBViewTag Then
							RadioButton.Selected = True
							Continue
						End If
					Else
						If  xRBView Is Label Then
							Continue
						End If
					End If
					
					RadioButton.Selected = False
				End If
			Next

			ShowRadioButtons
			
			Return False
End Sub

Public  Sub Selected(xRBView As B4XView) As Boolean
			For Each RadioButton As TRadioButton In mRadioButtons
				If  RadioButton.RBView = xRBView Then
					Return RadioButton.Selected
				End If
			Next	
			
			Return False
End Sub

Public  Sub IsEnabled(xRBView As B4XView) As Boolean
			For Each RadioButton As TRadioButton In mRadioButtons
				If  RadioButton.RBView = xRBView Then
					Return RadioButton.Enabled
				End If
			Next	
			
			Return False
End Sub

Public  Sub Enable(xRBView As B4XView, xEnable As Boolean) 
			For Each RadioButton As TRadioButton In mRadioButtons
				If  RadioButton.RBView = xRBView Then
					RadioButton.Enabled = xEnable
				End If
			Next	
			
			ShowRadioButtons
End Sub

Private Sub ShowRadioButtons
	
			For Each RadioButton As TRadioButton In mRadioButtons
				If  RadioButton.Enabled Then
					If  RadioButton.Selected Then
						RadioButton.RBView.SetBitmap(mSelected)
					Else 
						RadioButton.RBView.SetBitmap(mUnSelected)
					End If
				Else
					RadioButton.RBView.SetBitmap(mDisabled)
				End If					
			Next
					
			Return
End Sub

