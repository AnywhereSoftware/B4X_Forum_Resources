B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: Event(EventName as String)
Sub Class_Globals
	Public Const EVENT_START As String = "Start"
	Public Const EVENT_FAIL As String = "Fail"
	Public Const EVENT_COMPLETE As String = "Complete"
	
	Private fx As JFX
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mEvent_Callback As Object
	Private mEvent_EventName As String
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private lblCmdTwainPath As B4XView
	Private CT As CmdTwain
	
	Private OutputFullPath As String
	
	
	Private lblFilePath As B4XView
	Private btnFullPath As B4XView
	Private cbPaper As B4XComboBox
	Private cbMode As B4XComboBox
	Private cbResolution As B4XComboBox
	Private cbFormat As B4XComboBox
	
	
	Private Dialog As B4XDialog
	Private mForm As Form
	Private Scanning, Selecting As Boolean
	
	Private Options As Map
	
	Private mModifyRootPath As Boolean = True
	Private tfResolution As B4XView
	Private lbldip As B4XView
	
	Private ListenerActive As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Options.Initialize
	
	CT.Initialize
	
	If File.Exists(xui.DefaultFolder,"CmdTwain.opts") Then Options = File.ReadMap(xui.DefaultFolder,"CmdTwain.opts")

End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	mBase.LoadLayout("cmdtwain_cv")

	lblCmdTwainPath.Text = Options.GetDefault("CmdTwainPath","C:\Program Files (x86)\GssEziSoft\CmdTwain")
	If File.Exists(lblCmdTwainPath.Text,"") = False Then lblCmdTwainPath.Text = "Path to CmdTwain.exe"
	
	mForm = Props.Get("Form")
	Dialog.Initialize(mForm.RootPane)
	
	cbPaper.SetItems(Array("A3","A4","A5","A6","B3","B4","B5","B6","C4","C5","C6","LEGAL","LETTER"))
	cbPaper.SelectedIndex = 1
	
	cbMode.SetItems(Array("Default","Black And White","Color","Grayscale"))
	cbMode.SelectedIndex = 0
	
	cbResolution.SetItems(Array("Default","Custom","100 dpi","200 dpi","300 dpi"))
	cbResolution.SelectedIndex = 0
	
	cbFormat.SetItems(Array("Default","BMP","JPG 25%","JPG 50%","JPG 75%","JPG 100%","PDF A4","PDF A4","PDF LETTER","PDF LEGAL"))
	cbFormat.SelectedIndex = 0
	
'  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub GetCmdTwain As CmdTwain
	Return CT
End Sub

Public Sub AddEventListener(Callback As Object, EventName As String)
	mEvent_Callback = Callback
	mEvent_EventName = EventName
	ListenerActive = SubExists(mEvent_Callback,mEvent_EventName & "_Event")
End Sub

Public Sub SetCmdTwainPath(Path As String)
	lblCmdTwainPath.Text = Path
	Options.Put("CmdTwainPath",Path)
End Sub

Public Sub setModifyRootPath(Modify As Boolean)
	mModifyRootPath = Modify
End Sub
'Get/Set the modify root path flag.
'To save to the root of a drive a double backslash may be required. i.e. D:\\test.jpg
'This option will automate that.  Default: Modify = True
Public Sub getModifyRootPath As Boolean
	Return mModifyRootPath
End Sub

Public Sub ResetOptions
	CT.Initialize
End Sub

Sub btnSelectScanner_Click
	If Selecting Then 
		Dialog.Title = "Selecting Scanner"
		Wait For (Dialog.Show("Please wait. Selection in progress","","","OK")) Complete (Resp As Int)
		Return
	End If
	Selecting = True
	Wait For (CT.SelectScanner) Complete (Success As Boolean)
	Selecting = False
	'Testing
End Sub

Sub btnScan_Click
	If Scanning Then
		Dialog.Title = "Scanning"
		Wait For (Dialog.Show("Please wait. Scan in progress","","","OK")) Complete (Resp As Int)
		Return
	End If
	
	OutputFullPath = lblFilePath.Text
	
	If OutputFullPath = "" Then
		Dialog.Title = "Scanning"
		Wait For (Dialog.Show("Please select an output file","","","OK")) Complete (Resp As Int)
		Return
	End If
	
	Scanning = True

	CT.ScanTwainPath = lblCmdTwainPath.Text
	If cbResolution.SelectedItem = "Default" Then 
		CT.DPI = ""
	Else If cbResolution.SelectedItem = "Custom" Then
		If tfResolution.Text = "" Then
			CT.DPI = ""
		Else
			CT.DPI = tfResolution.Text
		End If
	Else
		CT.DPI = cbResolution.SelectedItem.Replace(" dpi","")
	End If
	
	Dim Mode As String = cbMode.SelectedItem
	
	CT.Paper = cbPaper.SelectedItem
	
	Select Mode
		Case "Black And White"
			Mode = CT.COLOR_BW
		Case "Color", "Default"
			Mode = CT.COLOR_RGB
		Case "Grayscale"
			Mode = CT.COLOR_GRAYSCALE
	End Select
	
	CT.Color = Mode
	
	Dim Format As String = cbFormat.SelectedItem
	Select True
		Case Format = "Default"
			Format = CT.OUTPUT_JPG_75
		Case Format = "PDF A4"
			Format = "PDF"
		Case Format = "PDF LETTER"
			Format = "PDF2"
		Case Format = "PDF LEGAL"
			Format = "PDF3"
		Case Else
			Format = Format.Replace("%","").Replace("JPG ","")
	End Select

	CT.Output = Format
	

	
	Dim FilePath As String = OutputFullPath
	If mModifyRootPath And StringCount(FilePath,"\",False) = 1 Then
		FilePath = FilePath.Replace("\","\\")
	End If
	
	CT.OutputFullPath = FilePath
	
	'Delete an existing file if it exists and it won't be shown after the scan (if requested) if the scan fails
	File.Delete(CT.OutputFullPath,"")
	
	If ListenerActive Then CallSub2(mEvent_Callback,mEvent_EventName & "_Event",EVENT_START)
	
	Wait For (CT.Scan) Complete (Success As Boolean)
	
	If File.Exists(CT.OutputFullPath,"") = False Then
		If ListenerActive Then CallSub2(mEvent_Callback,mEvent_EventName & "_Event",EVENT_FAIL)
		Scanning = False
		Return
	End If
	
	If Success And ListenerActive Then CallSub2(mEvent_Callback,mEvent_EventName & "_Event",EVENT_COMPLETE)
	Scanning = False
End Sub

Private Sub btnCmdTwainPath_Click
	Dim FC As FileChooser
	FC.Initialize
	FC.SetExtensionFilter("Exe File",Array("*.exe"))
	FC.Title = "Path to CmdTwain.exe"
	FC.InitialDirectory = Options.GetDefault("InitialDirectory",GetSystemProperty("user.home","C:\"))
	Dim FileName As String = FC.ShowOpen(mForm)
	If FileName = "" Then Return
	lblCmdTwainPath.Text = File.GetFileParent(FileName)
	Options.Put("CmdTwainPath",File.GetFileParent(FileName))
End Sub

Private Sub btnFullPath_Click
	Do While True
		Dim FC As FileChooser
		FC.Initialize
		FC.SetExtensionFilter("Image files",Array("*.jpg","*.bmp","*.pdf"))
		FC.Title = "Save XML documentation file"
		FC.InitialDirectory = Options.GetDefault("InitialDirectory",GetSystemProperty("user.home","C:\"))
		FC.InitialFileName = File.GetName(lblFilePath.Text)
		Dim FileName As String = FC.ShowSave(mForm)
		If FileName = "" Then Return
	
		If File.IsDirectory(FileName,"") = False Then Exit
	Loop
	Options.Put("InitialDirectory",File.GetFileParent(FileName))
	OutputFullPath = FileName
	lblFilePath.Text = OutputFullPath
End Sub

Private Sub tfResolution_Action
	If tfResolution.Text = "" Then Return
	If IsNumber(tfResolution.Text) Then
		Dim pos As Int = tfResolution.SelectionStart
		tfResolution.Text = Floor(tfResolution.Text)
		tfResolution.SelectionStart = pos
		CSSUtils.SetBorder(tfResolution,0,fx.Colors.Red,0)
	Else
		CSSUtils.SetBorder(tfResolution,1,fx.Colors.Red,0)
	End If
End Sub

Private Sub tfResolution_FocusChanged (HasFocus As Boolean)
	If tfResolution.Text = "" Then Return
	If HasFocus = False Then
		If IsNumber(tfResolution.Text) Then
			tfResolution.Text = Floor(tfResolution.Text)
			CSSUtils.SetBorder(tfResolution,0,fx.Colors.Red,0)
		Else
			CSSUtils.SetBorder(tfResolution,1,fx.Colors.Red,0)
			tfResolution.RequestFocus
		End If
		
	End If
End Sub

#Region Utils

Public Sub StringCount(StringToSearch As String,TargetStr As String,IgnoreCase As Boolean) As Int
	If IgnoreCase Then
		StringToSearch = StringToSearch.ToLowerCase
		TargetStr = TargetStr.ToLowerCase
	End If
	Return (StringToSearch.Length - StringToSearch.Replace(TargetStr,"").Length) / TargetStr.Length
End Sub

Public Sub SaveOptions
	File.WriteMap(xui.DefaultFolder,"CmdTwain.opts",Options)
End Sub

Public Sub SaveFormMetrics(F As Form, Delim As String)
	If F.Title = "Form" Then
		Log(F.Title & " Cannot set for metrics for a form with an unmodified title")
		Return
	End If
	Dim FormName As String = F.Title
	If FormName.Contains(Delim) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(Delim)).Trim
	End If
	Options.Put("FormPos" & FormName & "Left",F.WindowLeft)
	Options.Put("FormPos" & FormName & "Top",F.WindowTop)
	Options.Put("FormPos" & FormName & "Width",F.WindowWidth)
	Options.Put("FormPos" & FormName & "Height",F.WindowHeight)
End Sub

Public Sub SetFormMetrics(F As Form,Delim As String)
	Dim FormName As String = F.Title
	If FormName.Contains(Delim) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(Delim)).Trim
	End If
	If Options.ContainsKey("FormPos" & FormName & "Left") Then
		F.WindowLeft = Options.Get("FormPos" & FormName & "Left")
		F.WindowTop = Options.Get("FormPos" & FormName & "Top")
		F.WindowWidth = Options.Get("FormPos" & FormName & "Width")
		F.WindowHeight = Options.Get("FormPos" & FormName & "Height")
	End If
End Sub

#End Region Utils

Private Sub cbResolution_SelectedIndexChanged (Index As Int)
	If cbResolution.SelectedItem = "Custom" Then
		tfResolution.Enabled = True
		tfResolution.As(TextField).Alpha = 1
		lbldip.As(Label).Alpha = 1		
	Else
		tfResolution.Enabled = False
		tfResolution.As(TextField).Alpha = 0.3
		lbldip.As(Label).Alpha = 0.3
	End If
End Sub