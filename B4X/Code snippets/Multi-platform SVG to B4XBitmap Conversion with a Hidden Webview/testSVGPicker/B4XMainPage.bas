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

'Source of  material
'https://openmoji.org/

'All emojis are free to use under the CC BY-SA 4.0 license
'https://creativecommons.org/licenses/by-sa/4.0/

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Button1 As Button
	Private Cv As B4XCanvas
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Cv.Initialize(Root)
End Sub

Private Sub Button1_Click
	Button1.Visible = False
	Dim hatchling As String = getSVGImage
	wait for (SVG2Bitmap(hatchling)) complete (bm As B4XBitmap)
	Dim r As B4XRect
	r.Initialize(0, 0, bm.Width, bm.Height)
	Cv.DrawBitmap(bm, r)
	Cv.DrawRect(r, xui.Color_RGB(200, 200, 200), False, 2)
	Cv.Invalidate
End Sub

Private Sub SVG2Bitmap(contents As String) As ResumableSub
	Dim wv As WebView
	wv.Initialize("wv")
	Root.AddView(wv, -2 * Root.Width, 0, Root.Width, Root.Height)
	wv.LoadHtml(contents)
	wait for wv_Ready
	
#if B4J						'Only difference between B4J and B4A in this example
	Dim bm As B4XBitmap = wv.Snapshot
#else if B4A
	Sleep(100)
	Dim bm As B4XBitmap = wv.CaptureBitmap
#End If
	Return bm
End Sub

Private Sub wv_PageFinished (Url As String)
	CallSubDelayed(Me, "wv_Ready")
End Sub

Private Sub getSVGImage As String
	'If SVGHtml is picked with SVGPicker then replace contents in smart string below with clipboard contents (i.e. select and paste)
	Dim SVGHtml As String = $"
<svg id="emoji" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <g id="line">
    <circle cx="30.908" cy="26.3629" r="2.3682" fill="#000000" stroke="none"/>
    <circle cx="40.3807" cy="26.3629" r="2.3682" fill="#000000" stroke="none"/>
    <line x1="34.7963" x2="33.4334" y1="14.9035" y2="9.7857" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/>
    <line x1="36.8284" x2="36.8284" y1="15.7062" y2="12.1539" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/>
    <line x1="38.9992" x2="40.3807" y1="15.9035" y2="9.7857" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2"/>
    <path fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M35.3719,30.6032c0,0,5.9251-0.2907,0,5.2324C35.3719,35.8356,29.4468,30.6032,35.3719,30.6032z"/>
    <path fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M49.7637,33.4191c0.0286-2.6167-0.8175-5.8717-2.9865-9.9204c0,0-2.8449-7.8235-10.6684-7.8235 c-2.2075,0-4.0187,0.5096-5.4973,1.2733c-3.7618,1.9427-5.3718,5.5292-5.8823,6.5502c-0.3479,0.6959-3.0787,5.3065-3.1133,10.0017"/>
    <path fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2" d="M61.6942,37.9501C61.6942,52.3371,50.0313,64,35.6443,64S9.5944,52.3371,9.5944,37.9501l7.4428,3.7214l6.5125-4.6518l8.3732,5.5821 l6.2024-5.5821l8.1758,4.7364l7.0199-5.6667L61.6942,37.9501z"/>
  </g>
</svg>
"$
	Return SVGHtml
End Sub