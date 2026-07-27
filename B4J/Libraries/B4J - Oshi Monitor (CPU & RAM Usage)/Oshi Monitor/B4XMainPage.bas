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

	Private TmrInformation As Timer

	Private Oshi As OshiMonitor
	Private GuaCPU, GuaRAM As Gauge

	Private Logging As Boolean = False

	Private Processes As List
	Private CmbProcesses As ComboBox
	Private LblMaxCPU, LblMaxRAM, LblBattWatts As B4XView
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
	B4XPages.SetTitle(Me, $" Oshi Monitor - ${Round2(Oshi.RamTotalGB, 2)} GB"$)
	
	'Setup guages
	SetGuageColorRange

	Private Processes As List
	Processes = Oshi.ListProcesses

	'Populate ComboBox
	CmbProcesses.Items.Add("All Processes")
	For Each p As String In Processes
		CmbProcesses.Items.Add(p)
	Next

	'Select first item
	If CmbProcesses.Items.Size > 0 Then
		CmbProcesses.SelectedIndex = 0
		Oshi.TargetProcessName = CmbProcesses.Value
	End If

	Oshi.IntervalMs = 1000
	Oshi.Start

	SystemInformation

	TmrInformation.Initialize("TmrInformation", 1000)
	TmrInformation.Enabled = False
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	If Oshi.IsInitialized Then Oshi.Stop
	Return True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub SystemInformation
	Log("Initial startup stats")

	'Basic system information

	Log($"Is Laptop (Battery Check): ${Oshi.IsLaptopByBattery}"$)
	Log($"System Model: ${Oshi.GetSystemModel}"$)

	Log($"RAM Total: ${Oshi.RamTotal} bytes"$)
	Log($"RAM Total: ${Round2(Oshi.RamTotalGB, 2)} GB"$)
	Log($"RAM Total: ${Round2(Oshi.RamTotalMB, 2)} MB"$)
	Log($"RAM Usage: ${Round2(Oshi.RamUsage, 2)}%"$)

	Log($"CPU Temperature Support: ${Oshi.HasCpuTemp}"$)

	Log($"Battery Charging: ${Oshi.GetBatteryCharging}"$)
	Log($"Battery Current Capacity: ${Oshi.GetBatteryCurrentCapacity} mAh"$)
	Log($"Battery Design Capacity: ${Oshi.GetBatteryDesignCapacity} mAh"$)
	Log($"Battery Power Usage: ${Round2(Oshi.GetBatteryWatts, 2)} W"$)
	Log($"Current Power Usage: ${Round2(Oshi.GetCurrentPowerWatts, 2)} W"$)

	Log($"System Uptime: ${Round2(Oshi.GetSystemUptimeSeconds, 2)} seconds"$)
	Log($"System Uptime: ${Round2(Oshi.GetSystemUptimeMinutes, 2)} minutes"$)
	Log($"System Uptime: ${Round2(Oshi.GetSystemUptimeHours, 2)} hours"$)

	Log($"Total Bytes Read: ${Oshi.GetTotalBytesRead} bytes"$)
	Log($"Total Bytes Written: ${Oshi.GetTotalBytesWritten} bytes"$)
	Log($"Total Bytes Received: ${Oshi.GetTotalBytesReceived} bytes"$)
	Log($"Total Bytes Sent: ${Oshi.GetTotalBytesSent} bytes"$)

	Log($"Motherboard Model: ${Oshi.GetMotherboardModel}"$)
	Log($"BIOS Version: ${Oshi.GetBiosVersion}"$)
	Log($"OS Name: ${Oshi.GetOSName}"$)
	Log($"OS Build Number: ${Oshi.GetOSBuild}"$)

	'All discovered graphics cards
	Dim GPUList As List = Oshi.GetGraphicsCards
	For Each GPU As String In GPUList
		Log($"Graphics Card: ${GPU}"$)
	Next

	'Cooling fan speeds if hardware reporting is supported
	Dim Fans() As Int = Oshi.GetFanSpeeds
	If Fans.Length > 0 Then
		For i = 0 To Fans.Length - 1
			Log($"Fan ${i} Speed: ${Fans(i)} RPM"$)
		Next
	Else
		Log("Fan Speed Support: false")
	End If

	'Logical drives
	Dim DrivesList As List = Oshi.GetLogicalDrives
	For Each Drive As String In DrivesList
		Log($"Logical Drive: ${Drive}"$)
	Next
	
	'Log current refresh rate
	Log($"Display Current Refresh Rate: ${Oshi.GetRefreshRate} Hz"$)

	'Connected displays
	Dim DisplaysList As List = Oshi.GetDisplays
	For Each Display As String In DisplaysList
		Log($"Display: ${Display}"$)
	Next

	'Cnnected USB devices
	Dim UsbList As List = Oshi.GetUsbDevices
	For Each UsbDevice As String In UsbList
		Log($"USB Device: ${UsbDevice}"$)
	Next

	'Active sound cards
	Dim SoundCardsList As List = Oshi.GetSoundCards
	For Each SoundCard As String In SoundCardsList
		Log($"Sound Card: ${SoundCard}"$)
	Next

	'CPU Voltage
	Log($"CPU Voltage: ${Round2(Oshi.GetCpuVoltage, 2)} V"$)

	'Log Virtual Memory and Swap
	Log($"Virtual Memory Total: ${Round2(Oshi.GetVirtualMemoryTotal / 1024 / 1024 / 1024, 2)} GB"$)
	Log($"Virtual Memory Used: ${Round2(Oshi.GetVirtualMemoryUsed / 1024 / 1024 / 1024, 2)} GB"$)
	Log($"Swap Total: ${Round2(Oshi.GetSwapTotal / 1024 / 1024 / 1024, 2)} GB"$)
	Log($"Swap Used: ${Round2(Oshi.GetSwapUsed / 1024 / 1024 / 1024, 2)} GB"$)

	'IPv4 Addresses
	Dim IPv4List As List = Oshi.GetNetworkIPv4Addresses
	For Each ip As String In IPv4List
		Log($"IPv4: ${ip}"$)
	Next

	'IPv6 Addresses
	Dim IPv6List As List = Oshi.GetNetworkIPv6Addresses
	For Each ip As String In IPv6List
		Log($"IPv6: ${ip}"$)
	Next
End Sub

Private Sub TmrInformation_Tick
	'CheckForNetworkErrors 'WARNING - MIGHT FREEZE THE GUI FOR ABOUT 100ms
	'Log("----------------------------------------")

	'MonitorNetworkStats 'WARNING - MIGHT FREEZE THE GUI FOR ABOUT 100ms
	'Log("----------------------------------------")

	MonitorDriveLatency(0)
	Log("----------------------------------------")

	CoresLogicalProcessors
	Log("----------------------------------------")
End Sub

Private Sub SetGuageColorRange
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

		If Value <> "All Processes" Then
			Dim Details As Map = Oshi.GetProcessDetails(Value)
			If Details.IsInitialized And Details.Size > 0 Then
				Log($"PID: ${Details.Get("PID")}, User: ${Details.Get("User")}, Threads: ${Details.Get("ThreadCount")}, Bitness: ${Details.Get("Bitness")}-bit"$)
			End If
		End If
	End If
End Sub

Private Sub Oshi_Updated(Stats As Map)
	If CmbProcesses.Value = "All Processes" Then
		If Logging Then Log("Proc CPU: " & Round2(Stats.Get("procCpu"), 2) & "%")
		If Logging Then Log("Proc RAM MB: " & Round2(Stats.Get("procRamMB"), 2))

		LblMaxCPU.Text = Round2(Oshi.MaxCpuUsage.As(Double), 0) & " %"
		LblMaxRAM.Text = Round2(Oshi.MaxRamUsage.As(Double), 0) & " %"
	Else
		Oshi.TargetProcessName = CmbProcesses.Value
		Dim CurrentCpuPct As Double = Oshi.ProcessCpuUsage
		Dim CurrentRamMB As Double = Oshi.ProcessRamUsageMB
		LblMaxCPU.Text = Round2(CurrentCpuPct, 1) & " %"
		LblMaxRAM.Text = IIf(CurrentRamMB >= 1024, Round2(CurrentRamMB / 1024, 2) & " GB", Round2(CurrentRamMB, 0) & " MB")

'		If Logging Then Log("CPU: " & Round2(Stats.Get("cpu"), 2) & "%")
'		If Logging Then Log("RAM: " & Round2(Stats.Get("ram"), 2) & "%")
'		If Logging Then Log("Temp: " & Round2(Stats.Get("temp"), 2) & "°C")
'		LblMaxCPU.Text = Round2(Oshi.MaxProcessCpuUsage.As(Double), 2) & " %"
'		'LblMaxRAM.Text = Round2(Oshi.GetTrackedPeakMemory(CmbProcesses.Value) / 1024 / 1024, 0) & " MB"
'		'LblMaxRAM.Text = NumberFormat(Oshi.GetTrackedPeakMemory(CmbProcesses.Value) / 1024 / 1024, 1, 0) & " MB"
'		LblMaxRAM.Text = IIf(Oshi.GetTrackedPeakMemory(CmbProcesses.Value) / 1024 / 1024 >= 1024, Round2(Oshi.GetTrackedPeakMemory(CmbProcesses.Value) / 1024 / 1024 / 1024, 3) & " GB", Round2(Oshi.GetTrackedPeakMemory(CmbProcesses.Value) / 1024 / 1024, 2) & " MB")
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

Private Sub Oshi_BatteryCharging (Value As Boolean)
	'Log(Value)
End Sub

private Sub Oshi_BatteryWatts (Value As Double)
	'Log(Value)
	LblBattWatts.Text = NumberFormat(Value, 1, 1) & "W"
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

	'Select first item
	If CmbProcesses.Items.Size > 0 Then
		CmbProcesses.SelectedIndex = 0
		Oshi.TargetProcessName = CmbProcesses.Value
	End If
End Sub

'FOR READING CORES AND LOGICAL PROCESSORS
Private Sub CoresLogicalProcessors
	Dim Loads() As Double = Oshi.GetProcessorLoad

	Log("Processor Name: " & Oshi.GetProcessorName)

	Dim PhysicalCores As Int = Oshi.GetPhysicalCoreCount
	Dim LogicalProcessors As Int = Oshi.GetLogicalProcessorCount
	Log("CPU Info: " & PhysicalCores & " Physical Cores, " & LogicalProcessors & " Logical Processors")
	For i = 0 To Loads.Length - 1
		Log("Core " & i & " Usage: " & NumberFormat(Loads(i), 1, 2) & "%")
	Next

	If Loads.Length > 0 Then
		Log("Core 0: " & NumberFormat(Loads(0), 1, 1) & "%")
	End If
End Sub

'CHECKING DIAGNOSTICS FOR ALL INTERFACES
Private Sub CheckForNetworkErrors 'ignore
	Dim Names As List = Oshi.GetNetworkInterfaceNames

	For i = 0 To Names.Size - 1
		Dim inErrors As Long = Oshi.GetNetworkInErrors(i)
		Dim outErrors As Long = Oshi.GetNetworkOutErrors(i)
		Dim inDrops As Long = Oshi.GetNetworkInDrops(i)

		If inErrors > 0 Or outErrors > 0 Or inDrops > 0 Then
			Log("Issue detected on " & Names.Get(i) & ":")
			Log("  Inbound Errors: " & inErrors)
			Log("  Outbound Errors: " & outErrors)
			Log("  Inbound Drops: " & inDrops)
		Else
			Log(Names.Get(i) & ": No errors or drop")
		End If
	Next
End Sub

'MONITOR THE FIRST INTERFACE (Usually index 0). I'm using 3 for my wlan2 interface
Private Sub MonitorNetworkStats 'ignore
	Dim Stats() As Double = Oshi.GetInterfaceTrafficSpeed(Oshi.GetMostActiveInterfaceIndex)

	Dim RecvBytesPerSec As Double = Stats(0)
	Dim SentBytesPerSec As Double = Stats(1)

	Log("Download Speed: " & NumberFormat(RecvBytesPerSec / 1024, 1, 2) & " KB/s")
	Log("Upload Speed: " & NumberFormat(SentBytesPerSec / 1024, 1, 2) & " KB/s")
End Sub

'LATENCY REPRESENTS THE AVERAGE TIME IN MS FOR AN I/O REQUEST TO BE PROCESSED
Private Sub MonitorDriveLatency (Drive As Int) 'ignore
	'Assuming you want to monitor the first drive (index 0)
	Dim Latency As Double = Oshi.GetDriveLatency(Drive)

	Log($"Disk ${Drive} Latency: "$ & NumberFormat(Latency, 1, 2) & " ms")

	'Basic threshold check for a performance warning
	If Latency > 50 Then
		Log($"WARNING: High disk latency detected on Disk ${Drive}!"$)
	End If
End Sub
