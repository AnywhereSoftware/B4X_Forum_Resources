B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.9
@EndOfDesignText@
Sub Class_Globals
			
			Public  DEFINE_Horziontal_Half_Flip_Botton_Up				As Int		=  0
			Public  DEFINE_Horziontal_Half_Flip_Top_Down				As Int		=  1
			Public  DEFINE_Vertical_Half_Flip_Left_To_Right				As Int		=  2
			Public  DEFINE_Vertical_Half_Flip_Right_To_Left				As Int		=  3
			Public  DEFINE_Horziontal_Door_Hinge_Right_To_Left			As Int		=  4
			Public  DEFINE_Horziontal_Door_Hinge_Left_To_Right			As Int		=  5
			Public  DEFINE_Vertical_Door_Hinge_Button_Up	  			As Int		=  6
			Public  DEFINE_Vertical_Door_Hinge_Top_Down	    			As Int		=  7
			Public  DEFINE_Spiral_Gets_Smaller_Clockwise   				As Int		=  8
			Public  DEFINE_Spiral_Gets_Smaller_CounterClockwise			As Int		=  9
			Public  DEFINE_Spiral_Gets_Larger_Clockwise   				As Int		= 10
			Public  DEFINE_Spiral_Gets_Larger_CounterClockwise			As Int		= 11
			Public  DEFINE_Swing_Top_Left_Down							As Int		= 12
			Public  DEFINE_Swing_Top_Left_Up							As Int		= 13			
			Public  DEFINE_Swing_Top_Right_Down							As Int		= 14
			Public  DEFINE_Swing_Top_Right_Up							As Int		= 15
			Public  DEFINE_Swing_Bottom_Left_Down						As Int		= 16
			Public  DEFINE_Swing_Bottom_Left_Up							As Int		= 17			
			Public  DEFINE_Swing_Bottom_Right_Down						As Int		= 18
			Public  DEFINE_Swing_Bottom_Right_Up						As Int		= 19			
						
			
			Public  DEFINE_Max_Rotations								As Int		= 19
			
			Private mRotateNames										As Map		= CreateMap(DEFINE_Horziontal_Half_Flip_Botton_Up		: "Horziontal - Half Flip    Botton Up",			_
																								DEFINE_Horziontal_Half_Flip_Top_Down		: "Horziontal - Half Flip    Top Down",				_
																								DEFINE_Vertical_Half_Flip_Left_To_Right		: "Vertical   - Half Flip    Left to Right",		_
																								DEFINE_Vertical_Half_Flip_Right_To_Left		: "Vertical   - Half Flip    Right to Left",		_
																								DEFINE_Horziontal_Door_Hinge_Right_To_Left	: "Horziontal - Door Hinge   Right to Left",		_
																								DEFINE_Horziontal_Door_Hinge_Left_To_Right	: "Horziontal - Door Hinge   Left  to Right",		_
																								DEFINE_Vertical_Door_Hinge_Button_Up	  	: "Vertical   - Door Hinge   Button Up",	    	_
																								DEFINE_Vertical_Door_Hinge_Top_Down	    	: "Vertical   - Door Hinge   Top Down",	    		_
																								DEFINE_Spiral_Gets_Smaller_Clockwise   		: "Spiral     - Gets Smaller Clockwise",   			_
																								DEFINE_Spiral_Gets_Smaller_CounterClockwise	: "Spiral     - Gets Smaller CounterClockwise",   	_
																								DEFINE_Spiral_Gets_Larger_Clockwise   		: "Spiral     - Gets Larger  Clockwise",   			_
																								DEFINE_Spiral_Gets_Larger_CounterClockwise	: "Spiral     - Gets Larger  CounterClockwise",		_
																								DEFINE_Swing_Top_Left_Down					: "Swing      - Top Left     Down",         		_
																								DEFINE_Swing_Top_Left_Up					: "Swing      - Top Left     Up",            		_
																								DEFINE_Swing_Top_Right_Down					: "Swing      - Top Right    Down",          		_
																								DEFINE_Swing_Top_Right_Up					: "Swing      - Top Right    Up",       	    	_
																								DEFINE_Swing_Bottom_Left_Down				: "Swing      - Bottom Left  Down",    	    		_
																								DEFINE_Swing_Bottom_Left_Up					: "Swing      - Bottom Left  Up",          			_
																								DEFINE_Swing_Bottom_Right_Down				: "Swing      - Bottom Right Down",               	_
																								DEFINE_Swing_Bottom_Right_Up				: "Swing      - Bottom Right Up") 
			
			Private mWhich_Rotation										As Int		= -1
			Private mWhich_Previous_Rotation							As Int		=  0

			Private mInRotation											As Boolean  =  False	

			Private mLastCoverArt										As Bitmap
			
			Private mCoverArt_Background								As ImageView
			Private mCoverArt											As ImageView
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public 	Sub Initialize(CoverArtBackground As ImageView, CoverArt As ImageView)
	
			mCoverArt_Background 	= CoverArtBackground
			mCoverArt				= CoverArt			
End Sub

Public  Sub WhatRotation As Int
			Return mWhich_Previous_Rotation
End Sub

Public  Sub RotateNames As Map
			Return mRotateNames
End Sub

Public	Sub NamesAsList As List
			Dim Names As List
			
			Names.Initialize
			
			For Each Name As String In mRotateNames.Values
				Names.Add(Name)
			Next
			
			Return Names
End Sub

Public 	Sub Rotate(ShowCover As Bitmap) As ResumableSub

			Wait for (Rotate_CoverArt(ShowCover)) Complete(RC As Boolean)
			
			Return RC				
End Sub

Public 	Sub RotateNext(ShowCover As Bitmap) As ResumableSub

			If  mWhich_Rotation < 0  Then 
				mWhich_Rotation = 0
			Else 
				mWhich_Rotation = mWhich_Rotation + 1
				
				If  mWhich_Rotation > DEFINE_Max_Rotations Then
					mWhich_Rotation = 0
				End If
			End If

			Wait for (Rotate_CoverArt(ShowCover)) Complete(RC As Boolean)
			
			Return RC				
End Sub

Public 	Sub RotateUsing(Rotation_Type As Int, ShowCover As Bitmap) As ResumableSub
	
			If  Rotation_Type >= 0 And Rotation_Type <= DEFINE_Max_Rotations Then
				mWhich_Rotation = Rotation_Type
			Else
				Return False
			End If

			Wait for (Rotate_CoverArt(ShowCover)) Complete(RC As Boolean)
			
			Return RC				
End Sub

Public 	Sub RotateRandom(ShowCover As Bitmap) As ResumableSub
	
			do  While(mWhich_Rotation = mWhich_Previous_Rotation Or mWhich_Rotation = -1)
				mWhich_Rotation = Rnd(0, DEFINE_Max_Rotations + 1)				
			Loop
	
'			LogColor("Using Rotation - " &mWhich_Rotation, Colors.Blue)
				
			Wait for (Rotate_CoverArt(ShowCover)) Complete(RC As Boolean)
			
			Return RC				
End Sub

#Region Rotate_CoverArt
Private Sub Rotate_CoverArt(ShowCover As Bitmap) As ResumableSub	

			Dim Offset				As Int		=  0
			Dim StepBy				As Int		=  5
			Dim StepTo				As Int 		= 90
			Dim Rotation_Delay		As Int		= 85
			
			Dim Rotation 			As Int 		=  0			
			Dim PivotX				As Float 	=  0
			Dim PivotY				As Float 	=  0
			Dim RotateX				As Float 	=  0
			Dim RotateY				As Float 	=  0
						
			Dim SpiralIn			As Boolean  =  False
			Dim SpiralOut			As Boolean  =  False
			
			Dim Swing				As Boolean  =  False
			
			Dim SpiralWSize			As Int
			Dim SpiralHSize			As Int
						
			Dim Rotation_UseX		As Boolean  =  True
			Dim Rotation_Forward	As Boolean  =  True	
			
			
			If  mInRotation	Then
				#if Debug
				Log($"Rotate_CoverArt 1a - Already In"$)
				#end if
				
				Return False
			End If

			mInRotation = True
									
																		
			Try
				#if Debug
				Log($"Rotate_CoverArt -  Rotation Axis:${mWhich_Rotation}"$)
				#end if
				
				
				'-----------------------------------------------------------------------------
				'	Always set to middle we will overide if routine calls for it
				'-----------------------------------------------------------------------------
				PivotX	= mCoverArt.Width 	/ 2
				PivotY	= mCoverArt.Height  / 2			
				
				RotateX	= mCoverArt.Width 	/ 2
				RotateY	= mCoverArt.Height  / 2			
				
				
				Select 	mWhich_Rotation
						'---------------------------------------------------------------------
						'	Flip on X or Y using Middle as Turning Point
						'---------------------------------------------------------------------
#Region                 Flip																														
						Case 	DEFINE_Horziontal_Half_Flip_Botton_Up,		_	
								DEFINE_Horziontal_Half_Flip_Top_Down,		_
								DEFINE_Vertical_Half_Flip_Left_To_Right,	_
								DEFINE_Vertical_Half_Flip_Right_To_Left
								StepTo	 		= 90
								StepBy			=  5
								
								RotateX   		= 0
								RotateY			= 0
								
								Rotation_Delay	= 85							
								
								SpiralIn		= False
								SpiralOut		= False
								
								mCoverArt_Background.Bitmap = ShowCover
								
								Select 	mWhich_Rotation
										Case	DEFINE_Horziontal_Half_Flip_Botton_Up
												Rotation_UseX 			= True
												Rotation_Forward 		= True

										Case	DEFINE_Horziontal_Half_Flip_Top_Down
												Rotation_UseX 			= True
												Rotation_Forward 		= False
											
										Case	DEFINE_Vertical_Half_Flip_Left_To_Right
												Rotation_UseX 			= False
												Rotation_Forward 		= True
											
										Case	DEFINE_Vertical_Half_Flip_Right_To_Left						
												Rotation_UseX 			= False
												Rotation_Forward 		= False														
								End Select				
#end Region
								
						'---------------------------------------------------------------------
						'	Flip on X or Y using Either End as Turning Point
						'---------------------------------------------------------------------		
#Region                 Hinge											
						Case	DEFINE_Horziontal_Door_Hinge_Right_To_Left,			_
							    DEFINE_Horziontal_Door_Hinge_Left_To_Right,			_
							    DEFINE_Vertical_Door_Hinge_Button_Up,				_	  	
							    DEFINE_Vertical_Door_Hinge_Top_Down	    	
														
								StepTo	 		= 90
								StepBy			=  5

								RotateX   		= 0
								RotateY			= 0
							
								Rotation_Delay = 85							
								
								SpiralIn		= False
								SpiralOut		= False
							
								mCoverArt_Background.Bitmap = ShowCover
			
							
								Select 	mWhich_Rotation
										'-----------------------------------------------------
										'	Pivot Y using X - Works like a Door Hinge
										'-----------------------------------------------------
										Case	DEFINE_Horziontal_Door_Hinge_Right_To_Left, 	_
												DEFINE_Horziontal_Door_Hinge_Left_To_Right
												
												Rotation_UseX = False
												
												Select 	mWhich_Rotation
														Case 	DEFINE_Horziontal_Door_Hinge_Right_To_Left
																PivotX			  	= 0															
																Rotation_Forward 	= True
																
														Case 	DEFINE_Horziontal_Door_Hinge_Left_To_Right
																PivotX 			  	= mCoverArt.Width															
																Rotation_Forward	= False
												End Select

										'-----------------------------------------------------
										'	Pivot X using Y - Fall Down or Flip Up
										'-----------------------------------------------------
										Case	DEFINE_Vertical_Door_Hinge_Button_Up, 		_
												DEFINE_Vertical_Door_Hinge_Top_Down
												
												Rotation_UseX 	= True												
																								
												Select 	mWhich_Rotation
														Case 	DEFINE_Vertical_Door_Hinge_Button_Up
																PivotY			  	= 0															
																Rotation_Forward 	= False
																
														Case 	DEFINE_Vertical_Door_Hinge_Top_Down
																PivotY			  	= mCoverArt.Height															
																Rotation_Forward 	= True
												End Select												
								End Select			
#end Region
								
						'---------------------------------------------------------------------
						'	Spiral - Spin in while getting smaller or Spin out while getting larger
						'---------------------------------------------------------------------	
#Region                 Spiral
						Case 	DEFINE_Spiral_Gets_Smaller_Clockwise,			_
							    DEFINE_Spiral_Gets_Smaller_CounterClockwise,	_	
							    DEFINE_Spiral_Gets_Larger_Clockwise,			_   		
							    DEFINE_Spiral_Gets_Larger_CounterClockwise	
							
								StepTo	 		= 360
								StepBy			=  10
								
								PivotY			= mCoverArt.Height 	/ 2
								PivotX			= mCoverArt.Width 	/ 2
								
								RotateY			= 0
								RotateX			= 0
								
								Rotation_Delay	= 65							
								
								SpiralIn		= False
								SpiralOut		= False
								
								SpiralWSize		= (mCoverArt.Width  / StepTo) * StepBy
								SpiralHSize		= (mCoverArt.Height / StepTo) * StepBy
								
								#if Debug							
								Log($"    Width:${mCoverArt.Width}    Height:${mCoverArt.Height}"$)								
								Log($"SpiralWSize:${SpiralWSize}  SpiralHSize:${SpiralHSize}"$)
								#end if
																							
								'-----------------------------------------------------
								'	Pivot Y using X - Works like a Twisting Effect
								'-----------------------------------------------------
								Select 	mWhich_Rotation																	
										'---------------------------------------------
										'	SpinIn Left to Right or Right to Left
										'---------------------------------------------
										Case	DEFINE_Spiral_Gets_Smaller_Clockwise,	_
												DEFINE_Spiral_Gets_Smaller_CounterClockwise
												
												SpiralIn		= True
												Rotation_UseX 	= False
												
												mCoverArt_Background.Bitmap = ShowCover
												
												
												Select 	mWhich_Rotation
														Case 	DEFINE_Spiral_Gets_Smaller_Clockwise
																Rotation_Forward = True
																
														Case 	DEFINE_Spiral_Gets_Smaller_CounterClockwise
																Rotation_Forward = False
												End Select

										'---------------------------------------------
										'	SpinOut Left to Right or Right to Left
										'---------------------------------------------
										Case	DEFINE_Spiral_Gets_Larger_Clockwise,		_
												DEFINE_Spiral_Gets_Larger_CounterClockwise
												'---------------------------------------------
												'	When spinning out we need to set the 
												'		backgound to the last image
												'---------------------------------------------											
												If  mLastCoverArt.IsInitialized Then
													mCoverArt_Background.Bitmap = mLastCoverArt											
												End If
											
												mCoverArt.Bitmap	= ShowCover
												
												SpiralOut			= True
												Rotation_UseX 		= False
												
												mCoverArt.Height 	= SpiralHSize
												mCoverArt.Width	 	= SpiralWSize
						
												mCoverArt.Top  		= (mCoverArt_Background.Width 	- mCoverArt.Width) 	/ 2
												mCoverArt.Left 		= (mCoverArt_Background.Height 	- mCoverArt.Height) / 2
												
												PivotY			  	= mCoverArt.Height 	/ 2								
												PivotX			  	= mCoverArt.Width 	/ 2																																												
																								
												Select 	mWhich_Rotation
														Case 	DEFINE_Spiral_Gets_Larger_Clockwise
																Rotation_Forward = True
																
														Case 	DEFINE_Spiral_Gets_Larger_CounterClockwise
																Rotation_Forward = False
												End Select
												
								End Select
#end Region
								
						'---------------------------------------------------------------------
						'	Swing from corners
						'---------------------------------------------------------------------									
#region                 Swing						
						Case	DEFINE_Swing_Top_Left_Down,			_		
							    DEFINE_Swing_Top_Left_Up,			_		
							    DEFINE_Swing_Top_Right_Down,		_		
							    DEFINE_Swing_Top_Right_Up,			_		
							    DEFINE_Swing_Bottom_Left_Down,		_	
							    DEFINE_Swing_Bottom_Left_Up,		_		
							    DEFINE_Swing_Bottom_Right_Down,		_	
							    DEFINE_Swing_Bottom_Right_Up	
							
								StepTo	 			= 90
								StepBy				=  5
																
								Rotation_Delay		= 85							

								RotateX				= 0	
								RotateY				= 0	
								
								Swing				= True																

								mCoverArt_Background.Bitmap = ShowCover

								Select	mWhich_Rotation
										Case 	DEFINE_Swing_Top_Left_Down, DEFINE_Swing_Top_Left_Up
												PivotX	= 0
												PivotY	= 0
				
												If  mWhich_Rotation = DEFINE_Swing_Top_Left_Down Then
													Rotation_Forward = True
												Else
													Rotation_Forward = False
												End If
											
										Case	DEFINE_Swing_Top_Right_Down, DEFINE_Swing_Top_Right_Up
												PivotX	= mCoverArt.Width
												PivotY	= 0				
								
												If  mWhich_Rotation = DEFINE_Swing_Top_Right_Up Then
													Rotation_Forward = True
												Else
													Rotation_Forward = False
												End If
											
										Case	DEFINE_Swing_Bottom_Left_Down, DEFINE_Swing_Bottom_Left_Up
												PivotX	= 0
												PivotY	= mCoverArt.Height
				
												If  mWhich_Rotation = DEFINE_Swing_Bottom_Left_Down Then								
													Rotation_Forward = True
												Else
													Rotation_Forward = False
												End If
											
										Case	DEFINE_Swing_Bottom_Right_Down, DEFINE_Swing_Bottom_Right_Up
												PivotX	= mCoverArt.Width
												PivotY	= mCoverArt.Height
				
												If  mWhich_Rotation = DEFINE_Swing_Bottom_Right_Down Then								
													Rotation_Forward = False
												Else
													Rotation_Forward = True
												End If
								End Select
#end region								
				End Select												
				
				mWhich_Previous_Rotation = mWhich_Rotation				
				
				For i = 0 To StepTo Step StepBy
					If  Rotation_Forward Then
						Offset = i				'  	If we are going forward just use i
					Else
						Offset = 360 - i		'	If we are going backward need to offset from 360
					End If

					If	SpiralIn Or SpiralOut Or Swing Then
#region                 SpiralIn / SpiralOut / Swing
						RotateImageJava(PivotX, PivotY, RotateX, RotateY, Offset)		
						
						'-----------------------------------------------------------------------------------------------------------------
						'	Only when doing Spiral (In or Out) do we need to chage the box size
						'-----------------------------------------------------------------------------------------------------------------
						If  SpiralIn Then
							mCoverArt.Height 	= mCoverArt.Height 	- SpiralHSize
							mCoverArt.Width	 	= mCoverArt.Width  	- SpiralWSize
						
							mCoverArt.Top  		= (mCoverArt_Background.Width 	- mCoverArt.Width) 	/ 2
							mCoverArt.Left 		= (mCoverArt_Background.Height 	- mCoverArt.Height) / 2
												
							PivotY			  	= mCoverArt.Height 	/ 2								
							PivotX			  	= mCoverArt.Width 	/ 2																																												
												
'							Log($"Width:${mCoverArt.Width}  SpinWSize:${mSpinWSize}  Height:${mCoverArt.Height}  SpinHSize:${mSpinHSize}"$)
							
							'--------------------------------------------------------------------------------------
							'	Dividing may lead to non equal SpinHSize and SpinWSize
							'--------------------------------------------------------------------------------------
							If  mCoverArt.Width < SpiralWSize Or mCoverArt.Height < SpiralHSize Then
								Sleep(Rotation_Delay) 											'  Sleep before done																				
								Exit
							End If
						Else if SpiralOut Then							
								mCoverArt.Height 	= mCoverArt.Height 	+ SpiralHSize
								mCoverArt.Width	 	= mCoverArt.Width  	+ SpiralWSize
						
								mCoverArt.Top  		= (mCoverArt_Background.Width 	- mCoverArt.Width) 	/ 2
								mCoverArt.Left 		= (mCoverArt_Background.Height 	- mCoverArt.Height) / 2
													
								PivotY			  	= mCoverArt.Height 	/ 2								
								PivotX			  	= mCoverArt.Width 	/ 2																																												

'								Log($"Width:${mCoverArt.Width}  CoverArtWidth:${mCoverArt_Background.Width}  Height:${mCoverArt.Height}  CoverArtHeight:${mCoverArt_Background.Height}"$)

								'--------------------------------------------------------------------------------------
								'	Dividing may lead to non equal SpinHSize and SpinWSize
								'--------------------------------------------------------------------------------------						
								If  mCoverArt.Width > mCoverArt_Background.Width Or mCoverArt.Height > mCoverArt_Background.Height Then
									Sleep(Rotation_Delay) 											'  Sleep before done												
									Exit
								End If							
						End If		
#end Region											
					Else
#Region                 Flip / Hinge						
						If  Rotation_UseX Then
							RotateImageJava(PivotX, PivotY, Offset,  RotateY, 	Rotation)		'	Rotate X forward
						Else
							RotateImageJava(PivotX, PivotY, RotateX, Offset, 	Rotation)		'	Rotate Y forward											
						End If
#end region						
					End If
										
					Sleep(Rotation_Delay) 														'  Sleep before next
				Next

				mCoverArt.Top 		= mCoverArt_Background.Top
				mCoverArt.Left		= mCoverArt_Background.Left
				mCoverArt.Width		= mCoverArt_Background.Width
				mCoverArt.Height	= mCoverArt_Background.Height
				mCoverArt.Bitmap 	= ShowCover			 										'	Set coverat image																		
				mCoverArt.BringToFront

				mLastCoverArt.Initialize3(ShowCover)													
				
				RotateImageJava((mCoverArt.Width / 2), (mCoverArt.Height / 2), 0, 0, 0)		'	Reset Rotation/Image		
			Catch
				Log($"Rotate_CoverArt - Rotation Error:${LastException.Message}"$)
			End Try
			
			mInRotation = False
			
			Return True
End Sub

#Region RotateImageJava
private Sub RotateImageJava(PivotX As Float, PivotY As Float, RotationX As Float, RotationY As Float, Rotation As Float)
			Dim jo As JavaObject = Me
			
			#if Debug
			Log($"RotateImageJava: PivotX(${PivotX})  PivotY(${PivotY})  X(${RotationX})  Y(${RotationY})  Rotation:${Rotation}"$)
			#end if
			
			jo.RunMethod("rotateImage", Array As Object(mCoverArt, PivotX, PivotY, RotationX, RotationY, Rotation, 1280.0f * Density))
End Sub
#end Region


#if Java
public void rotateImage(ImageView imageView, float PivotX, float PivotY, float RotationX, float RotationY, float Rotation, float CameraDistance)
{
	import android.widget.ImageView;
	import android.util.DisplayMetrics;
	
	//BA.LogInfo("flipImage: In");

	/*---------------------------------------------------------------------------------------
	//Better to use parameter CameraDistance as B4A already provides the information required.
	//However, here's a way to do it:
	DisplayMetrics metrics = getResources().getDisplayMetrics();
	float CameraDistance = 1280.0f * (metrics.density * 160f);
	----------------------------------------------------------------------------------------
	*/
	
	imageView.setPivotX(PivotX);
	imageView.setPivotY(PivotY);
	imageView.setRotationX(RotationX);
	imageView.setRotationY(RotationY);
	imageView.setRotation(Rotation);
	imageView.setCameraDistance(CameraDistance);
	
	//BA.LogInfo("flipImage: Out");
}
#End If

