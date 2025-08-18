B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
    Private mCBChecked                  											    		As B4XBitmap
    Private mCBUnChecked									     		                		As B4XBitmap
	
    Private mCBCheckedFilled								               			    		As B4XBitmap
    Private mCBUnCheckedFilled     		                										As B4XBitmap

    Private mRBSelected										               			    		As B4XBitmap
    Private mRBUnSelected    	 		                										As B4XBitmap
    Private mRBDisabled     			                										As B4XBitmap
	
	Private mCheckBoxes																			As cCheckBox
	Private mRadioButtons1																		As cRadioButtons
	Private mRadioButtons2																		As cRadioButtons		
	Private Button1 As B4XView
	Private ImageView1 As B4XView
	Private ImageView10 As B4XView
	Private ImageView11 As B4XView
	Private ImageView12 As B4XView
	Private ImageView13 As B4XView
	Private ImageView14 As B4XView
	Private ImageView2 As B4XView
	Private ImageView3 As B4XView
	Private ImageView4 As B4XView
	Private ImageView5 As B4XView
	Private ImageView6 As B4XView
	Private ImageView7 As B4XView
	Private ImageView8 As B4XView
	Private ImageView9 As B4XView
	Private Label1 As B4XView
	Private Label10 As B4XView
	Private Label11 As B4XView
	Private Label12 As B4XView
	Private Label13 As B4XView
	Private Label14 As B4XView
	Private Label2 As B4XView
	Private Label3 As B4XView
	Private Label4 As B4XView
	Private Label5 As B4XView
	Private Label6 As B4XView
	Private Label7 As B4XView
	Private Label77 As B4XView
	Private Label8 As B4XView
	Private Label88 As B4XView
	Private Label9 As B4XView
End Sub

Public Sub Initialize
			LoadBitmaps	
			
			mCheckBoxes.Initialize(mCBCheckedFilled, mCBUnCheckedFilled)
			
			mRadioButtons1.Initialize(mRBSelected, mRBUnSelected, mRBDisabled)
			mRadioButtons2.Initialize(mRBSelected, mRBUnSelected, mRBDisabled)			
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Private Sub B4XPage_Resize(Width As Int, Height As Int)
	
			mCheckBoxes.ClearAll
			
			mCheckBoxes.AddCB_WithOptions(False, Array As B4XView(ImageView1,				_
																  ImageView2,			 	_
																  ImageView3))
																  
			mCheckBoxes.AddCBLabels_WithOptions(False, Array As B4XView(ImageView4,			_
																		ImageView5,			_
																		ImageView6),		_
													   Array As B4XView(Label4,				_
																		Label5,				_
																		Label6))
																		
			mCheckBoxes.Check(ImageView2, 					True)
			mCheckBoxes.Check(ImageView4, 					True)

			mRadioButtons1.AddRB(ImageView8,	Array As B4XView(ImageView7,			_	
																 ImageView8, 			_
																 ImageView9,			_
														 		 ImageView10))

			mRadioButtons2.AddRBLabels(ImageView13,	Array As B4XView(ImageView11,		_	
																	 ImageView12, 		_
																	 ImageView13,		_
															 		 ImageView14),		_																 
													Array As B4XView(Label11,			_
																	 Label12,			_
																	 Label13,			_
																	 Label14))
			
End Sub


Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub

Private Sub Options_CB_Click
			Log($"Was CB Checked: ${mCheckBoxes.Checked(Sender)}"$)
			
			Log($"Status After Clicking?  Is Checked:${mCheckBoxes.Click(Sender)}"$)			
End Sub

Private Sub Options_CB_WithLabels_Click
			Log($"Was CB Checked: ${mCheckBoxes.Checked(Sender)}"$)
			
			Log($"Status After Clicking?  Is Checked:${mCheckBoxes.Click(Sender)}"$)			
End Sub

Private Sub PickOne_RB_WithLabels_Click
			mRadioButtons2.Click(Sender)	
End Sub

Private Sub PickOne_RB_Click
			mRadioButtons1.Click(Sender)
End Sub

#Region LoadStateLists
Private Sub LoadBitmaps
			
    		mCBChecked		   					= LoadBitmap(File.DirAssets, "checkbox_checked_box.png")
    		mCBUnChecked 	   					= LoadBitmap(File.DirAssets, "checkbox_unchecked_box.png")
	
    		mCBCheckedFilled   					= LoadBitmap(File.DirAssets, "checkbox_checked_box_filled.png")
   			mCBUnCheckedFilled 					= LoadBitmap(File.DirAssets, "checkbox_unchecked_box_filled.png")
			
   			mRBSelected 						= LoadBitmap(File.DirAssets, "radiobutton_selected_blue_filled.png")
   			mRBUnSelected	 					= LoadBitmap(File.DirAssets, "radiobutton_unselected_filled.png")
   			mRBDisabled	 						= LoadBitmap(File.DirAssets, "radiobutton_unselected_disabled_filled.png")									
End Sub
#End Region
