B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Type TCheckBox(CBView As B4XView, CBViewTag As B4XView, Checked As Boolean)
	
	Private mChecked			As B4XBitmap
	Private mUnChecked			As B4XBitmap
	
	'----------------------------------------------------------------
	'	Using a Map for checkboxes because we can use view as key
	'----------------------------------------------------------------
	Private mCheckBoxes			As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public  Sub Initialize(xChecked As B4XBitmap, xUnChecked As B4XBitmap)
	
			mChecked 			= xChecked
			mUnChecked 			= xUnChecked
			
			mCheckBoxes.Initialize			
End Sub

Public  Sub ClearAll
			mCheckBoxes.Clear
End Sub

Public  Sub AddCB(CBViews() As B4XView)
			Add_CBViews(False, CBViews, Array As B4XView())
End Sub

Public  Sub AddCB_WithOptions(CheckAll As Boolean, CBViews() As B4XView)
			Add_CBViews(CheckAll, CBViews, Array As B4XView())
End Sub

Public  Sub AddCBLabels(CBViews() As B4XView, CBViewsTags() As B4XView)
			Add_CBViews(False, CBViews, CBViewsTags)
End Sub

Public  Sub AddCBLabels_WithOptions(CheckAll As Boolean, CBViews() As B4XView, CBViewsTags() As B4XView)
			Add_CBViews(CheckAll, CBViews, CBViewsTags)
End Sub

Private Sub Add_CBViews(xCheckAll As Boolean, xCBViews() As B4XView, xCBViewsTags() As B4XView)	
			For i = 0 To xCBViews.Length-1
				Dim CheckBox As TCheckBox
				
				CheckBox.Initialize
				CheckBox.CBView			= xCBViews(i)
				CheckBox.Checked		= xCheckAll

				If  i < xCBViewsTags.Length Then
					CheckBox.CBViewTag  = xCBViewsTags(i)
				End If
				
				ShowCheckBox(CheckBox)					
				
				mCheckBoxes.Put(CheckBox.CBView, CheckBox)
				
				If  CheckBox.CBViewTag.IsInitialized Then
					mCheckBoxes.Put(CheckBox.CBViewTag, CheckBox)
				End If
			Next
End Sub



Public  Sub Click(xCBView As B4XView) As Boolean
	
			If  mCheckBoxes.ContainsKey(xCBView)  Then
				Dim CheckBox As TCheckBox = mCheckBoxes.Get(xCBView)
				
				CheckBox.Checked = Not(CheckBox.Checked)
				
				ShowCheckBox(CheckBox)
				
				Return CheckBox.Checked
			End If
			
			Return False
End Sub

Public  Sub Checked(xCBView As B4XView) As Boolean

			If  mCheckBoxes.ContainsKey(xCBView)  Then
				Dim CheckBox As TCheckBox = mCheckBoxes.Get(xCBView)
				
				Return CheckBox.Checked
			End If
			
			Return False
End Sub

Public  Sub Check(xCBView As B4XView, xChecked As Boolean)
			If  mCheckBoxes.ContainsKey(xCBView)  Then
				Dim CheckBox As TCheckBox = mCheckBoxes.Get(xCBView)
				
				CheckBox.Checked = xChecked
				
				ShowCheckBox(CheckBox)
				
				Return
			End If
End Sub

Private Sub ShowCheckBox(xCheckBox As TCheckBox)
			If  xCheckBox.Checked Then
				xCheckBox.CBView.SetBitmap(mChecked)
			Else
				xCheckBox.CBView.SetBitmap(mUnChecked)
			End If						
					
			Return
End Sub

