B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub ShakeButton(btn As B4XView, Zoom As Boolean, Shake As Boolean)
	Dim iSideY As Int = btn.Height
	Dim iSideX As Int = btn.Width
	Dim iTop As Int = btn.Top
	Dim iLeft As Int = btn.Left
	
	btn.BringToFront
	
	Dim iStep As Int = btn.Width/4
	Dim nfltDumpingRatio As Float = 1
	'nfltDumpingRatio,
	
	If Zoom Then
		#if b4a or b4j
		btn.SetLayoutAnimated(100, iLeft - 25, iTop - 25, iSideX + 50, iSideY + 50)
		Sleep(100)
		btn.SetLayoutAnimated(100, iLeft , iTop , iSideX , iSideY )
		Sleep(100)	
		#else if b4i
		btn.SetLayoutAnimated(100, iLeft - iStep, iTop - iStep, iSideX + (2 * iStep), iSideY + (2 * iStep))
		Sleep(100)
		btn.SetLayoutAnimated(100, iLeft , iTop , iSideX , iSideY )
		Sleep(100)
		#End If
	End If


	If Shake = False Then Return

	For ii=1 To 4
		Dim iMove As Int = Rnd(btn.Width/5, btn.Width/4)
		Dim iPos As Int = Rnd(1, 8)
		Dim iDelay As Int = 15
		Select Case iPos
			Case 1
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#else
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If
				
			Case 2
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft , iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft , iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			Case 3
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			Case 4
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			Case 5
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			Case 6
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft , iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft , iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			Case 7
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft - iMove, iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft + iMove, iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			Case 8
				#if b4a or b4j
				btn.SetLayoutAnimated(iDelay, iLeft , iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)				
				#Else
				btn.SetLayoutAnimated(iDelay, iLeft , iTop - iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop + iMove, iSideX , iSideY )
				Sleep(iDelay)
				btn.SetLayoutAnimated(iDelay, iLeft , iTop , iSideX , iSideY )
				Sleep(iDelay)
				#End If

			
		End Select
	Next
End Sub