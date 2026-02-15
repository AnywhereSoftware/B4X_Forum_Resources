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

'https://github.com/Oshi/Oshi

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private Oshi As OshiMonitor
	Private GuaCPU, GuaRAM As Gauge

	Private Logging As Boolean = False

	Private Processes As List
	Private CmbProcesses As ComboBox
	Private LblMaxCPU, LblMaxGPU As Label
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	Oshi.Initialize("Oshi")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.GetNativeParent(Me).Resizable = False
	B4XPages.GetNativeParent(Me).AlwaysOnTop = True
	B4XPages.GetNativeParent(Me).Icon = XUI.LoadBitmap(File.DirAssets, "guage.png")
	B4XPages.SetTitle(Me, " Oshi Monitor - " & "RAM: " & Round2(Oshi.RamTotalGB, 2)  & " GB")

	'Setup guages 
	SetGuageCColorRange

	Private Processes As List
	Processes = Oshi.ListProcesses 

	'Populate ComboBox
	CmbProcesses.Items.Add("All Processes")
	For Each p As String In Processes 
		CmbProcesses.Items.Add(p) 
	Next

	'Auto-select first item
	If CmbProcesses.Items.Size > 0 Then
		CmbProcesses.SelectedIndex = 0
		Oshi.TargetProcessName = CmbProcesses.Value
	End If

	Oshi.IntervalMs = 1000
	Oshi.Start

	Log("Initial startup stats")
	Log("RAM Total: " & Oshi.RamTotal & " bytes")
	Log("RAM Total: " & Round2(Oshi.RamTotalGB, 2) & " GB")
	Log("RAM Total: " & Round2(Oshi.RamTotalMB, 2) & " MB")
	Log("RAM Usage: " & Round2(Oshi.RamUsage, 2) & "%")

	Log("CPU Temperature Support: " & Oshi.hasCpuTemp)
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	If Oshi.IsInitialized Then Oshi.Stop
	Return True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub SetGuageCColorRange
	'CPU
	GuaCPU.AddSection(0, 20, Main.FX.Colors.Green)
	GuaCPU.AddSection(21, 80, Main.FX.Colors.Yellow)
	GuaCPU.AddSection(81, 100, Main.FX.Colors.Red)

	'RAM
	GuaRAM.AddSection(0, 20, Main.FX.Colors.Green)
	GuaRAM.AddSection(21, 80, Main.FX.Colors.Yellow)
	GuaRAM.AddSection(81, 100, Main.FX.Colors.Red)	
End Sub

Private Sub CmbProcesses_SelectedIndexChanged(Index As Int, Value As Object)
	Oshi.ResetMaximums
	
	If Value <> Null Then
		Oshi.TargetProcessName = Value
	End If
End Sub

Private Sub Oshi_Updated(Stats As Map)
	If CmbProcesses.Value <> "All Processes" Then
		'System-wide stats
		If Logging Then Log("CPU: " & Round2(Stats.Get("cpu"), 2) & "%")
		If Logging Then Log("RAM: " & Round2(Stats.Get("ram"), 2) & "%")
		If Logging Then Log("Temp: " & Round2(Stats.Get("temp"), 2) & "°C")
		
		LblMaxCPU.Text = Oshi.MaxProcessCpuUsage.As(Int) & " %"
		LblMaxGPU.Text = Oshi.MaxProcessRamUsage.As(Int) & " %"
	Else
		'Selected process stats
		If Logging Then Log("Proc CPU: " & Round2(Stats.Get("procCpu"), 2) & "%")
		If Logging Then Log("Proc RAM MB: " & Round2(Stats.Get("procRamMB"), 2))

		LblMaxCPU.Text = Oshi.MaxCpuUsage.As(Int) & " %"
		LblMaxGPU.Text = Oshi.MaxRamUsage.As(Int) & " %"		
	End If
End Sub

Private Sub Oshi_CpuUsage(Value As Double)
	If Logging Then Log("CPU Usage: " & Round2((Value), 2) & "%")
	'If Logging Then Log("CPU Usage: " & NumberFormat((Value), 1, 2) & "%")
	If CmbProcesses.Value = "All Processes" Then GuaCPU.Value = Round2((Value), 2)
End Sub

Private Sub Oshi_CpuTemp(Value As Double)
	If Logging Then Log("CPU Temp Event: " & Round2((Value), 2) & "°C")
End Sub

Private Sub	Oshi_RamUsageMB (Value As Double)
	If Logging Then Log("RAM Usage MB: " & Round2(Value, 2))
End Sub

Private Sub Oshi_RamUsage(Value As Double)
	If Logging Then Log("RAM Usage: " & Round2((Value), 2) & "%")
	If CmbProcesses.Value = "All Processes" Then GuaRAM.Value = Round2((Value), 2)
End Sub

Private Sub Oshi_ProcessFound(Name As String)
	Log("FOUND: " & Name)
End Sub

Private Sub Oshi_ProcessTerminated(Name As String)
	Log("TERMINITED: " & Name)
	ReloadProcesses
End Sub

Private Sub Oshi_ProcessCpuUsage(Value As Double)
	If Logging Then Log("CPU: " & Round2(Value, 2) & "%")
	If CmbProcesses.Value <> "All Processes" Then GuaCPU.Value = Round2(Value, 2)
	'If CmbProcesses.Value <> "All Processes" Then GuaCPU.Value = NumberFormat(Value, 1, 2)
End Sub

Private Sub Oshi_ProcessRamUsageMB(Value As Double)
	If Logging Then Log("RAM MB: " & Round2(Value, 2))
End Sub

Private Sub Oshi_ProcessRamUsage (Value As Double)
	If Logging Then Log("RAM: " & Round2(Value, 2) & "%")
	If CmbProcesses.Value <> "All Processes" Then GuaRAM.Value = Round2(Value, 2)
End Sub

Private Sub ImgRefresh_MouseClicked (EventData As MouseEvent)
	ReloadProcesses
End Sub

Private Sub ReloadProcesses
	Oshi.ResetMaximums
	CmbProcesses.Items.Clear

	Processes = Oshi.ListProcesses

	'Populate ComboBox
	CmbProcesses.Items.Add("All Processes")
	For Each p As String In Processes
		CmbProcesses.Items.Add(p)
	Next

	'Optional: auto-select first item
	If CmbProcesses.Items.Size > 0 Then
		CmbProcesses.SelectedIndex = 0
		Oshi.TargetProcessName = CmbProcesses.Value
	End If		
End Sub
