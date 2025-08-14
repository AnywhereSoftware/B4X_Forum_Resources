B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Information

#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'See the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Class_Globals
	
	' Constants
	Private Const APP_TITLE As String = "RGB LED Strip Control"
	Private Const APP_VERSION As String = "20250530"
	Private Const APP_INFO As String = "Example controlling an RGB LED strip using the rIRRemoteEx library ESP32 with B4R."	'ignore

	' UI	
	Private Root As B4XView
	Private xui As XUI
	Private ButtonConnect As B4XView
	Private ButtonPreferences As B4XView
	Private LabelConnectStatus As B4XView
	Private LabelInfo As B4XView
	
	' Communication
	Private Sock As Socket
	Private AStream As AsyncStreams
	Private isConnected As Boolean
   
	Private HOST_IP_DEFAULT As String = "192.168.1.90"
	Private HOST_PORT_DEFAULT As Int = 80

	Private ICON_CONNECT As String = Chr(0xF0C1)		'Connect to the controller
	Private ICON_DISCONNECT As String = Chr(0xF127)		'Disconnect from the controller
	
	' Remote Control
	#if B4A
	Private PaneRemoteControl As Panel
	#end if
	#if B4J
	Private PaneRemoteControl As Pane
	#end if
	Private MAX_BUTTONS As Int = 24
	Private BUTTON_WIDTH As Int = 80dip
	Private BUTTON_HEIGHT As Int = 60dip
	Private BUTTON_RADIUS As Int = 20dip
	Private BUTTON_MARGIN As Int = 10dip

	Private BUTTONS_PER_ROW As Int = 4
	Private MAX_ROWS As Int = 6			'ignore max 6 rows as defined by number of buttons 6 and columns 4

	Private BUTTON_TEXT() As String = Array As String("B+","B-","OFF","ON", _
												      "","","","", _
													  "","","","FLASH", _
													  "","","","STROBE", _
													  "","","","FADE", _
													  "","","","SMOOTH")
	Private Buttons(24) As Button

	' Preferences
	Private PrefDialog As PreferencesDialog
	Private PrefDialogFile As String = "Preferences.json"
	Private PrefData As Map
	Private PrefDataFile As String = "Preferences.json"
	Private PrefIPAddress As String
	Private PrefModuleAddress As Int
	Private MODULE_ADDRESS_DEFAULT As Int = 61184
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	' Set mainpage properties
	B4XPages.SetTitle(Me, $"${APP_TITLE} - ${APP_VERSION}"$)
	#If B4J
	B4XPages.GetNativeParent(Me).WindowWidth = 420
	' Disable resize
	B4XPages.GetNativeParent(Me).Resizable = False    
	#End If
	' Note: The customlistview label properties are set in the designer, like alignment and textsize

	' Init the preferences dialog
	PrefData.Initialize
	xui.SetDataFolder ("preferences")
	PrefDialog.Initialize(Root, "Preferences Dialog", 300dip, 300dip)
	PrefDialog.LoadFromJson(File.ReadString(File.DirAssets, PrefDialogFile))
	PrefDialog.SetEventsListener(Me, "PrefDialog")
	PrefLoadData
	
	' Set defaults
	ButtonConnect.Text = ICON_CONNECT
	LabelConnectStatus.Text = "Disconnected"

	CreateRemoteControl

	'Connect the socket 
	'sock_Connect
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	sock_Close
	If xui.IsB4A Then
		' Back key in Android
		If PrefDialog.BackKeyPressed Then Return False
	End If
	Return True
End Sub

'Don't miss the code in the Main module + manifest editor.
Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	PrefDialog.KeyboardHeightChanged(NewHeight)
End Sub

#Region Preferences
Private Sub ButtonPreferences_Click
	Wait For (PrefDialog.ShowDialog(PrefData, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		' Save the global map PrefData as being updated by the dialog
		PrefSaveData
	End If
End Sub

Private Sub PrefLoadData
	Try
		If File.Exists(xui.DefaultFolder, PrefDataFile) Then
			' Read the map
			PrefData = File.ReadMap(xui.DefaultFolder, PrefDataFile)

			' Get the fields and assign to the globals
			PrefIPAddress = PrefData.GetDefault("ipaddress", HOST_IP_DEFAULT)
			PrefModuleAddress = PrefData.GetDefault("moduleaddress", MODULE_ADDRESS_DEFAULT)

			ToLog($"[PrefLoadData]: ipaddress=${PrefIPAddress}, moduleaddress=${PrefModuleAddress}, folder=${xui.DefaultFolder}"$)
		End If
	Catch
		ToLog($"[ERROR][PrefLoadData] ${LastException}"$)
	End Try
End Sub

Private Sub PrefSaveData
	Try
		' Set the fields
		File.WriteMap(xui.DefaultFolder, PrefDataFile, PrefData)

		' Update the globals
		PrefIPAddress = PrefData.GetDefault("ipaddress", HOST_IP_DEFAULT)
		PrefModuleAddress = PrefData.GetDefault("moduleaddress", MODULE_ADDRESS_DEFAULT)
		
		' Log
		ToLog($"[PrefSaveData] ipaddress=${PrefIPAddress}, moduleaddress=${PrefModuleAddress}, folder=${xui.DefaultFolder}"$)
	Catch
		ToLog($"[ERROR][PrefSaveData] ${LastException}"$)
	End Try
End Sub

Private Sub PrefDialog_IsValid (TempData As Map) As Boolean
	Dim number As Int = TempData.GetDefault("NumberToValidate", 0)
	If number < 0 Then
		PrefDialog.ScrollToItemWithError("NumberToValidate")
		Return False
	End If
	Return True
End Sub
#End Region

#Region RemoteControl

' Create the remote control in a pane
Private Sub CreateRemoteControl
	Dim left As Double = 0
	Dim top As Double = 0
	Dim buttonnr As Int = 1
	Dim rownr As Int = 0
	Dim bgcolor As Int
	Dim fnt As B4XFont = xui.CreateDefaultBoldFont(16)
	
	For i = 0 To MAX_BUTTONS - 1
		' Set the bgcolor
		bgcolor = SetButtonColor(i)
		
		' Init the button as Button View
		Buttons(i).Initialize("ButtonControl")
		' Buttons(i).TooltipText = $"Color=${ColorXUIToHexRGB(bgcolor)}"$

		' Create Button as B4XView and assign the previous created Button View
		Dim btn As B4XView = Buttons(i)
		
		' Set the properties
		' Button index used to place the command, like:
		' 3=ON,2=OFF,4=RED,5=GREEN,6=BLUE etc.
		btn.Tag = i

		' Hide the first two buttons because not used (brightness +/-)
		If i == 0 Or i == 1 Then
			btn.Visible = False
		End If

		' Set button text font
		btn.Font = fnt

		' Assign button text from array
		btn.Text = BUTTON_TEXT(i)

		' Button 2 & 3 (index) = Set textcolor white instead default black
		If i == 2 Or i == 3 Then btn.TextColor = xui.color_white

		' Remove the button internal text padding
		SetPadding(btn, 0, 0, 0, 0)

		' Set the background color and corner radius
		btn.SetColorAndBorder(bgcolor, 0, 0, BUTTON_RADIUS)

		' For the white button show border
		If i == 7 Then
			btn.SetColorAndBorder(bgcolor, 1dip, xui.Color_LightGray, BUTTON_RADIUS)
		End If

		' Set button size
		btn.Height = BUTTON_HEIGHT
		btn.Width = BUTTON_WIDTH
	
		' Calculate pos
		' Top

		' CheckNext Row
		If i Mod BUTTONS_PER_ROW == 0 Then
			rownr = rownr + 1
			buttonnr = 1
			If rownr == 1 Then
				top = top + BUTTON_MARGIN
			Else
				top = top + BUTTON_HEIGHT + BUTTON_MARGIN
			End If
		End If
		
		' Example buttonnr 3 = (3 * 40) + (3 * 10) = 150
		left = ( (buttonnr - 1) * BUTTON_WIDTH) + (buttonnr * BUTTON_MARGIN)

		'Log($"i=${i}, l=${left}, t=${top}"$)

		#If B4J
		PaneRemoteControl.AddNode(Buttons(i), left, top, BUTTON_WIDTH, BUTTON_HEIGHT)
		#End If
		
		#If B4A
		PaneRemoteControl.AddView(Buttons(i), left, top, BUTTON_WIDTH, BUTTON_HEIGHT)
		#End If
		
		buttonnr = buttonnr + 1
	Next

	Log($"RemoteControl created left=${left}, top=${top + BUTTON_HEIGHT + BUTTON_MARGIN}"$)

End Sub

Private Sub SetButtonColor(id As Int) As Int
	Select id
		
		' Button 0
		Case 0: Return xui.Color_RGB(255,255,255)
			' Button 1
		Case 1: Return xui.Color_RGB(255,255,255)
			' Button 2 (OFF)
		Case 2: Return xui.Color_RGB(0,0,0)
			' Button 3 (ON)
		Case 3: Return xui.Color_RGB(255,0,0)
			' Button 4 (R)
		Case 4: Return xui.Color_RGB(255,0,0)
			' Button 5 (G)
		Case 5: Return xui.Color_RGB(0,255,0)
			' Button 6 (B)
		Case 6: Return xui.Color_RGB(0,0,255)
			' Button 7 (W)
		Case 7: Return xui.Color_RGB(255,250,250)
			' Button 8
		Case 8: Return xui.Color_RGB(255,128,0)
			' Button 9
		Case 9: Return xui.Color_RGB(0,255,128)
			' Button 10
		Case 10: Return xui.Color_RGB(0,128,255)
			' Button 11 (FLASH)
		Case 11: Return xui.Color_RGB(192,192,192)
			' Button 12
		Case 12: Return xui.Color_RGB(255,64,0)
			' Button 13
		Case 13: Return xui.Color_RGB(0,255,255)
			' Button 14
		Case 14: Return xui.Color_RGB(128,0,128)
			' Button 15 (STROBE)
		Case 15: Return xui.Color_RGB(192,192,192)
			' Button 16
		Case 16: Return xui.Color_RGB(255,200,0)  
			' Button 17
		Case 17: Return xui.Color_RGB(0,128,175)
			' Button 18
		Case 18: Return xui.Color_RGB(200,112,214)
			' Button 19 (FADE)
		Case 19: Return xui.Color_RGB(192,192,192)
			' Button 20
		Case 20: Return xui.Color_RGB(255,255,0)  
			' Button 21
		Case 21: Return xui.Color_RGB(0,128,128)
			' Button 22
		Case 22: Return xui.Color_RGB(238,130,238)
			' Button 23 (SMOOTH)
		Case 23: Return xui.Color_RGB(192,192,192)

		Case Else: Return xui.color_white
	End Select
End Sub

Private Sub ButtonControl_Click
	Dim btn As B4XView = Sender

	If Not(isConnected) Then
		ToLog($"[ERROR] Not connected."$)
		Return
	End If

	AStream.Write($"/address=${PrefModuleAddress}&command=${btn.Tag}&disconnect=0"$.GetBytes("UTF8"))

	ToLog($"Clicked button ${btn.Tag}, moduleaddress=${PrefModuleAddress}, color=${ColorXUIToHexRGB(btn.Color)}, text=${btn.text}"$)
	
	Sleep(1000)
End Sub
#End Region

Private Sub ButtonConnect_Click
	If Not(isConnected) Then
		sock_Connect
	Else
		sock_Close
	End If
End Sub

Private Sub TextFieldModuleAddress_TextChanged (Old As String, New As String)
	
End Sub

#Region Communication
Sub sock_Connect
	ToLog("[sock_Connect] Connecting...")
	Sock.Initialize("sock")
	Sock.Connect(PrefIPAddress, HOST_PORT_DEFAULT, 10000)
End Sub

'Handle socket connection
Sub sock_Connected (Successful As Boolean)
	ToLog("[sock_Connected] " & Successful)
	isConnected = Successful
	If Successful Then
		AStream.Initialize(Sock.InputStream, Sock.OutputStream, "astream")
		LabelConnectStatus.Text = "Connected"
		ButtonConnect.Text = ICON_DISCONNECT
	Else
		ToLog("[ERROR] Can not connect to the controller.")
		LabelConnectStatus.Text = "Disconnected"
		ButtonConnect.Text = ICON_CONNECT
	End If
End Sub

Sub sock_Close
	AStream.Close
	Sock.Close
	isConnected = False
	LabelConnectStatus.Text = "Disconnected"
	ButtonConnect.Text = ICON_CONNECT
	ToLog("[sock_Close] Closed")
End Sub

'Log data received from the Arduino RESTFul server.
'The data comes in as chunks.
'Logging is NOT used.
Sub AStream_NewData (Buffer() As Byte)
	'Dim bc As ByteConverter	'Lib ByteConverter
	'Log($"[astream_NewData]${bc.StringFromBytes(Buffer,"UTF-8")}"$)
End Sub
#End Region

#Region Helpers

' Log to the customview log
' For time: msg = $"${DateTime.Time(DateTime.Now)} ${msg}"$
Public Sub ToLog(msg As String)
	msg = $"${msg}"$
	LabelInfo.Text = msg
	Log(msg)
End Sub

Public Sub MapRange(Value As Int, FromLow As Int, FromHigh As Int, ToLow As Int, ToHigh As Int) As Int
	Return ToLow + (ToHigh - ToLow) * ((Value - FromLow) / (FromHigh - FromLow))
End Sub

'Convert the xui color value to hex string RRGGBB (length 6)
'clr - (int) XUI color value.
'Example: xui.color_red converted to FF0000.
Public Sub ColorXUIToHexRGB(value As Int) As String
	Dim bc As ByteConverter
	Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(value))).SubString(2)
End Sub

#If B4A
Public Sub SetPadding(v As View, Left As Int, Top As Int, Right As Int, Bottom As Int)
	Dim jo As JavaObject = v
	jo.RunMethod("setPadding", Array As Object(Left, Top, Right, Bottom))
End Sub
#End If
#If B4J
' Set internal content padding.
Public Sub SetPadding(v As Node, Left As Double, Top As Double, Right As Double, Bottom As Double)
	Dim jo As JavaObject
	Dim joInsets As JavaObject

	joInsets = jo.InitializeNewInstance("javafx.geometry.Insets", Array As Object(Left,Top,Right,Bottom))

	Dim jo As JavaObject = v
	jo.RunMethod("setPadding", Array As Object(joInsets))
End Sub
#End If
#End Region
