B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' ComputerInfo Class
' Description: Gathers hardware and software info via WMI and returns B4J Types.

Sub Class_Globals
	Public ComputerName As String
	
	' --------------------------------------------------------------------------
	' WMI TYPE DECLARATIONS
	' --------------------------------------------------------------------------
	
	Type CompInfo_BootConfiguration (Name As String, BootDirectory As String, ConfigurationPath As String, _
	                              LastDrive As String, Description As String, ScratchDirectory As String, _
	                              SettingID As String, TempDirectory As String, AsMap As Map)
	
	Type CompInfo_DependentService (Antecedent As String, Dependent As String, TypeOfDependency As String, AsMap As Map)
	
	Type CompInfo_Desktop (Name As String, BorderWidth As String, CoolSwitch As String, CursorBlinkRate As String, _
	                    Description As String, DragFullWindows As String, GridGranularity As String, IconSpacing As String, _
	                    IconTitleFaceName As String, IconTitleSize As String, IconTitleWrap As String, Pattern As String, _
	                    ScreenSaverActive As String, ScreenSaverExecutable As String, ScreenSaverSecure As String, _
	                    ScreenSaverTimeout As String, SettingID As String, Wallpaper As String, WallpaperStretched As String, _
	                    WallpaperTiled As String, AsMap As Map)
	
	Type CompInfo_NTEventLogFile (Name As String, AccessMask As String, Archive As String, Compressed As String, _
	                           Description As String, CompressionMethod As String, CreationClassName As String, _
	                           CreationDate As String, CSCreationClassName As String, CSName As String, Drive As String, _
	                           EightDotThreeFileName As String, Encrypted As String, EncryptionMethod As String, _
	                           Extension As String, FileName As String, FileSize As Long, FileType As String, _
	                           FSCreationClassName As String, FSName As String, Hidden As String, InstallDate As String, _
	                           InUseCount As String, LastAccessed As String, LastModified As String, LogfileName As String, _
	                           Manufacturer As String, MaxFileSize As Long, NumberOfRecords As String, OverwriteOutDated As String, _
	                           OverWritePolicy As String, Path As String, Readable As String, Sources As String, _
	                           Status As String, System As String, Version As String, Writeable As String, AsMap As Map)
	
	Type CompInfo_Group (Name As String, Domain As String, Status As String, LocalAccount As String, Description As String, _
	                  SID As String, SIDType As String, AsMap As Map)
	
	Type CompInfo_LoggedOnUser (Antecedent As String, Dependent As String, AsMap As Map)
	
	Type CompInfo_OperatingSystem (Name As String, BootDevice As String, BuildNumber As String, BuildType As String, _
	                            Description As String, CodeSet As String, CountryCode As String, CreationClassName As String, _
	                            CSCreationClassName As String, CSDVersion As String, CSName As String, CurrentTimeZone As String, _
	                            DataExecutionPrevention_32BitApplications As String, DataExecutionPrevention_Available As String, _
	                            DataExecutionPrevention_Drivers As String, DataExecutionPrevention_SupportPolicy As String, _
	                            Debug As String, Distributed As String, EncryptionLevel As String, ForegroundApplicationBoost As String, _
	                            FreePhysicalMemory As Long, FreeSpaceInPagingFiles As Long, FreeVirtualMemory As Long, _
	                            InstallDate As String, LargeSystemCache As String, LastBootUpTime As String, LocalDateTime As String, _
	                            Locale As String, Manufacturer As String, MaxNumberOfProcesses As String, MaxProcessMemorySize As Long, _
	                            NumberOfLicensedUsers As String, NumberOfProcesses As String, NumberOfUsers As String, _
	                            Organization As String, OSLanguage As String, OSProductSuite As String, OSType As String, _
	                            OtherTypeDescription As String, PlusProductID As String, PlusVersionNumber As String, _
	                            Primary As String, ProductType As String, RegisteredUser As String, SerialNumber As String, _
	                            ServicePackMajorVersion As String, ServicePackMinorVersion As String, SizeStoredInPagingFiles As Long, _
	                            Status As String, SuiteMask As String, SystemDevice As String, SystemDirectory As String, _
	                            SystemDrive As String, TotalSwapSpaceSize As Long, TotalVirtualMemorySize As Long, _
	                            TotalVisibleMemorySize As Long, Version As String, WindowsDirectory As String, AsMap As Map)
	
	Type CompInfo_PrintJob (Name As String, DataType As String, Document As String, DriverName As String, Description As String, _
	                     ElapsedTime As String, HostPrintQueue As String, JobId As String, JobStatus As String, Notify As String, _
	                     Owner As String, PagesPrinted As String, Parameters As String, PrintProcessor As String, Priority As String, _
	                     Size As Long, StartTime As String, Status As String, StatusMask As String, TimeSubmitted As String, _
	                     TotalPages As String, UntilTime As String, AsMap As Map)
	
	Type CompInfo_Process (Name As String, CommandLine As String, CreationClassName As String, CreationDate As String, _
	                    Description As String, CSCreationClassName As String, CSName As String, ExecutablePath As String, _
	                    ExecutionState As String, Handle As String, HandleCount As String, KernelModeTime As String, _
	                    MaximumWorkingSetSize As String, MinimumWorkingSetSize As String, OSCreationClassName As String, _
	                    OSName As String, OtherOperationCount As String, OtherTransferCount As String, PageFaults As String, _
	                    PageFileUsage As String, ParentProcessId As String, PeakPageFileUsage As String, PeakVirtualSize As String, _
	                    PeakWorkingSetSize As String, Priority As String, PrivatePageCount As String, ProcessId As String, _
	                    QuotaNonPagedPoolUsage As String, QuotaPagedPoolUsage As String, QuotaPeakNonPagedPoolUsage As String, _
	                    QuotaPeakPagedPoolUsage As String, ReadOperationCount As String, ReadTransferCount As String, _
	                    SessionId As String, Status As String, ThreadCount As String, UserModeTime As String, _
	                    VirtualSize As String, WindowsVersion As String, WorkingSetSize As String, WriteOperationCount As String, _
	                    WriteTransferCount As String, AsMap As Map)
	
	Type CompInfo_Service (Name As String, AcceptPause As String, AcceptStop As String, CheckPoint As String, Description As String, _
	                    CreationClassName As String, DesktopInteract As String, DisplayName As String, ErrorControl As String, _
	                    ExitCode As String, PathName As String, ProcessId As String, ServiceSpecificExitCode As String, _
	                    ServiceType As String, Started As String, StartMode As String, StartName As String, State As String, _
	                    Status As String, SystemCreationClassName As String, SystemName As String, TagId As String, WaitHint As String, _
						AsMap As Map)
	
	Type CompInfo_Share (Name As String, AccessMask As String, AllowMaximum As String, MaximumAllowed As String, Description As String, _
	                  Path As String, Status As String, Type As String, AsMap As Map)
	
	Type CompInfo_StartupCommand (Name As String, User As String, Location As String, Command As String, Description As String, SettingID As String, _
						AsMap As Map)
	
	Type CompInfo_Thread (Name As String, CreationClassName As String, CSCreationClassName As String, CSName As String, Description As String, _
	                   ElapsedTime As String, ExecutionState As String, Handle As String, KernelModeTime As String, OSCreationClassName As String, _
	                   OSName As String, Priority As String, PriorityBase As String, ProcessCreationClassName As String, ProcessHandle As String, _
	                   StartAddress As String, Status As String, ThreadState As String, ThreadWaitReason As String, UserModeTime As String, _
					   AsMap As Map)
	
	Type CompInfo_UserAccount (Name As String, Domain As String, Status As String, LocalAccount As String, Description As String, _
	                        SIDType As String, SID As String, FullName As String, Disabled As String, Lockout As String, _
	                        PasswordChangeable As String, PasswordExpires As String, PasswordRequired As String, AccountType As String, _
							AsMap As Map)
	
	Type CompInfo_InstalledSoftware (DisplayName As String, DisplayVersion As String, Publisher As String, UninstallString As String, AsMap As Map)
	
	Type CompInfo_Battery (Name As String, Availability As String, BatteryRechargeTime As String, BatteryStatus As String, _
	                    Description As String, Chemistry As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                    CreationClassName As String, DesignCapacity As String, DesignVoltage As String, DeviceID As String, _
	                    ErrorCleared As String, ErrorDescription As String, EstimatedChargeRemaining As String, EstimatedRunTime As String, _
	                    ExpectedBatteryLife As String, ExpectedLife As String, FullChargeCapacity As String, LastErrorCode As String, _
	                    MaxRechargeTime As String, PNPDeviceID As String, PowerManagementCapabilities As String, PowerManagementSupported As String, _
	                    SmartBatteryVersion As String, Status As String, StatusInfo As String, SystemCreationClassName As String, _
	                    SystemName As String, TimeOnBattery As String, TimeToFullCharge As String, AsMap As Map)
	
	Type CompInfo_BIOS (Name As String, Status As String, BiosCharacteristics As String, BIOSVersion As String, Description As String, _
	                 BuildNumber As String, CodeSet As String, CurrentLanguage As String, IdentificationCode As String, _
	                 InstallableLanguages As String, LanguageEdition As String, ListOfLanguages As String, Manufacturer As String, _
	                 OtherTargetOS As String, PrimaryBIOS As String, ReleaseDate As String, SerialNumber As String, _
	                 SMBIOSBIOSVersion As String, SMBIOSMajorVersion As String, SMBIOSMinorVersion As String, SMBIOSPresent As String, _
	                 SoftwareElementID As String, SoftwareElementState As String, TargetOperatingSystem As String, Version As String, _
					 AsMap As Map)
	
	Type CompInfo_LogicalDisk (DeviceID As String, FileSystem As String, VolumeName As String, VolumeSerialNumber As String, _
	                        FreeSpace As Long, Size As Long, DriveType As Int, AsMap As Map)
	
	Type CompInfo_Keyboard (Name As String, Availability As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                     Description As String, CreationClassName As String, DeviceID As String, ErrorCleared As String, _
	                     ErrorDescription As String, IsLocked As String, LastErrorCode As String, Layout As String, _
	                     NumberOfFunctionKeys As String, Password As String, PNPDeviceID As String, PowerManagementCapabilities As String, _
	                     PowerManagementSupported As String, Status As String, StatusInfo As String, SystemCreationClassName As String, _
	                     SystemName As String, AsMap As Map)
	
	Type CompInfo_PhysicalMemory (Name As String, BankLabel As String, Capacity As Long, DataWidth As Int, DeviceLocator As String, _
	                           FormFactor As Int, Manufacturer As String, MemoryType As Int, PartNumber As String, SerialNumber As String, Speed As Int, _
							   AsMap As Map)
	
	Type CompInfo_DesktopMonitor (Name As String, Availability As String, Bandwidth As String, ConfigManagerErrorCode As String, _
	                           Description As String, ConfigManagerUserConfig As String, CreationClassName As String, DeviceID As String, _
	                           DisplayType As String, ErrorCleared As String, ErrorDescription As String, IsLocked As String, _
	                           LastErrorCode As String, MonitorManufacturer As String, MonitorType As String, PixelsPerXLogicalInch As String, _
	                           PixelsPerYLogicalInch As String, PNPDeviceID As String, PowerManagementCapabilities As String, _
	                           PowerManagementSupported As String, ScreenHeight As String, ScreenWidth As String, Status As String, _
	                           StatusInfo As String, SystemCreationClassName As String, SystemName As String, AsMap As Map)
	
	Type CompInfo_MotherboardDevice (Name As String, Availability As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                              Description As String, CreationClassName As String, DeviceID As String, ErrorCleared As String, _
	                              ErrorDescription As String, LastErrorCode As String, PNPDeviceID As String, PowerManagementCapabilities As String, _
	                              PowerManagementSupported As String, PrimaryBusType As String, RevisionNumber As String, SecondaryBusType As String, _
	                              Status As String, StatusInfo As String, SystemCreationClassName As String, SystemName As String, AsMap As Map)
	
	Type CompInfo_PointingDevice (Name As String, Availability As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                           Description As String, CreationClassName As String, DeviceID As String, DeviceInterface As String, _
	                           DoubleSpeedThreshold As String, ErrorCleared As String, ErrorDescription As String, Handedness As String, _
	                           HardwareType As String, InfFileName As String, InfSection As String, IsLocked As String, LastErrorCode As String, _
	                           Manufacturer As String, NumberOfButtons As String, PNPDeviceID As String, PointingType As String, _
	                           PowerManagementCapabilities As String, PowerManagementSupported As String, QuadSpeedThreshold As String, _
	                           Resolution As String, SampleRate As String, Status As String, StatusInfo As String, Synch As String, _
	                           SystemCreationClassName As String, SystemName As String, AsMap As Map)
	
	Type CompInfo_NetworkAdapter (Name As String, AdapterType As String, AdapterTypeId As String, AutoSense As String, Description As String, _
	                           Availability As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                           CreationClassName As String, DeviceID As String, ErrorCleared As String, ErrorDescription As String, _
	                           Index As String, Installed As String, LastErrorCode As String, MACAddress As String, Manufacturer As String, _
	                           MaxNumberControlled As String, MaxSpeed As String, NetConnectionID As String, NetConnectionStatus As String, _
	                           NetworkAddresses As String, PermanentAddress As String, PNPDeviceID As String, PowerManagementCapabilities As String, _
	                           PowerManagementSupported As String, ProductName As String, ServiceName As String, Speed As String, _
	                           Status As String, StatusInfo As String, SystemCreationClassName As String, SystemName As String, TimeOfLastReset As String, _
							   AsMap As Map)
	
	Type CompInfo_Printer (Name As String, Attributes As String, Availability As String, AvailableJobSheets As String, Description As String, _
	                    AveragePagesPerMinute As String, Capabilities As String, CapabilityDescriptions As String, CharSetsSupported As String, _
	                    Comment As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, CreationClassName As String, _
	                    CurrentCapabilities As String, CurrentCharSet As String, CurrentLanguage As String, CurrentMimeType As String, _
	                    CurrentNaturalLanguage As String, CurrentPaperType As String, Default As String, DefaultCapabilities As String, _
	                    DefaultCopies As String, DefaultLanguage As String, DefaultMimeType As String, DefaultNumberUp As String, _
	                    DefaultPaperType As String, DefaultPriority As String, DetectedErrorState As String, DeviceID As String, _
	                    Direct As String, DoCompleteFirst As String, DriverName As String, EnableBIDI As String, EnableDevQueryPrint As String, _
	                    ErrorCleared As String, ErrorDescription As String, ErrorInformation As String, ExtendedDetectedErrorState As String, _
	                    ExtendedPrinterStatus As String, Hidden As String, HorizontalResolution As String, InstallDate As String, _
	                    JobCountSinceLastReset As String, KeepPrintedJobs As String, LanguagesSupported As String, LastErrorCode As String, _
	                    Local As String, Location As String, MarkingTechnology As String, MaxCopies As String, MaxNumberUp As String, _
	                    MaxSizeSupported As String, MimeTypesSupported As String, NaturalLanguagesSupported As String, Network As String, _
	                    PaperSizesSupported As String, PaperTypesAvailable As String, Parameters As String, PNPDeviceID As String, _
	                    PortName As String, PowerManagementCapabilities As String, PowerManagementSupported As String, PrinterPaperNames As String, _
	                    PrinterState As String, PrinterStatus As String, PrintJobDataType As String, PrintProcessor As String, Priority As String, _
	                    Published As String, Queued As String, RawOnly As String, SeparatorFile As String, ServerName As String, Shared As String, _
	                    ShareName As String, SpoolEnabled As String, StartTime As String, Status As String, StatusInfo As String, _
	                    SystemCreationClassName As String, SystemName As String, TimeOfLastReset As String, UntilTime As String, _
	                    VerticalResolution As String, WorkOffline As String, AsMap As Map)
	
	Type CompInfo_Processor (Name As String, AddressWidth As String, Architecture As Int, Availability As String, Description As String, _
	                      ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, CpuStatus As String, CreationClassName As String, _
	                      CurrentClockSpeed As Int, CurrentVoltage As String, DataWidth As String, DeviceID As String, ErrorCleared As String, _
	                      ErrorDescription As String, ExtClock As String, Family As String, L2CacheSize As Int, L2CacheSpeed As String, _
	                      LastErrorCode As String, Level As String, LoadPercentage As String, Manufacturer As String, MaxClockSpeed As Int, _
	                      OtherFamilyDescription As String, PNPDeviceID As String, PowerManagementCapabilities As String, _
	                      PowerManagementSupported As String, ProcessorId As String, ProcessorType As String, Revision As String, _
	                      Role As String, SocketDesignation As String, Status As String, StatusInfo As String, Stepping As String, _
	                      SystemCreationClassName As String, SystemName As String, UniqueId As String, UpgradeMethod As String, _
	                      Version As String, VoltageCaps As String, NumberOfCores As Int, NumberOfLogicalProcessors As Int, AsMap As Map)
	
	Type CompInfo_SoundDevice (Name As String, Availability As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                        Description As String, CreationClassName As String, DeviceID As String, DMABufferSize As String, ErrorCleared As String, _
	                        ErrorDescription As String, LastErrorCode As String, Manufacturer As String, MPU401Address As String, PNPDeviceID As String, _
	                        PowerManagementCapabilities As String, PowerManagementSupported As String, ProductName As String, Status As String, _
	                        StatusInfo As String, SystemCreationClassName As String, SystemName As String, AsMap As Map)
	
	Type CompInfo_ComputerSystem (Name As String, AdminPasswordStatus As String, AutomaticResetBootOption As String, AutomaticResetCapability As String, _
	                           Description As String, BootOptionOnLimit As String, BootOptionOnWatchDog As String, BootROMSupported As String, _
	                           BootupState As String, ChassisBootupState As String, CreationClassName As String, CurrentTimeZone As String, _
	                           DaylightInEffect As String, Domain As String, DomainRole As String, EnableDaylightSavingsTime As String, _
	                           FrontPanelResetStatus As String, InfraredSupported As String, InitialLoadInfo As String, KeyboardPasswordStatus As String, _
	                           LastLoadInfo As String, Manufacturer As String, Model As String, NameFormat As String, NetworkServerModeEnabled As String, _
	                           NumberOfProcessors As Int, OEMLogoBitmap As String, OEMStringArray As String, PartOfDomain As String, _
	                           PauseAfterReset As String, PowerManagementCapabilities As String, PowerManagementSupported As String, _
	                           PowerOnPasswordStatus As String, PowerState As String, PowerSupplyState As String, PrimaryOwnerContact As String, _
	                           PrimaryOwnerName As String, ResetCapability As String, ResetCount As String, ResetLimit As String, Roles As String, _
	                           Status As String, SupportContactDescription As String, SystemStartupDelay As String, SystemStartupOptions As String, _
	                           SystemStartupSetting As String, SystemType As String, ThermalState As String, TotalPhysicalMemory As Long, _
	                           UserName As String, WakeUpType As String, Workgroup As String, AsMap As Map)
	
	Type CompInfo_ComputerSystemProduct (Name As String, IdentifyingNumber As String, SKUNumber As String, UUID As String, Description As String, _
	                                  Vendor As String, Version As String, AsMap As Map)
	
	Type CompInfo_VideoController (Name As String, AcceleratorCapabilities As String, AdapterCompatibility As String, AdapterDACType As String, _
	                            Description As String, AdapterRAM As Long, Availability As String, CapabilityDescriptions As String, _
	                            ColorTableEntries As String, ConfigManagerErrorCode As String, ConfigManagerUserConfig As String, _
	                            CreationClassName As String, CurrentBitsPerPixel As Int, CurrentHorizontalResolution As Int, _
	                            CurrentNumberOfColors As String, CurrentNumberOfColumns As String, CurrentNumberOfRows As String, _
	                            CurrentRefreshRate As Int, CurrentScanMode As String, CurrentVerticalResolution As Int, DeviceID As String, _
	                            DeviceSpecificPens As String, DitherType As String, DriverDate As String, DriverVersion As String, _
	                            ErrorCleared As String, ErrorDescription As String, ICMIntent As String, ICMMethod As String, _
	                            InfFilename As String, InfSection As String, InstalledDisplayDrivers As String, LastErrorCode As String, _
	                            MaxMemorySupported As String, MaxNumberControlled As String, MaxRefreshRate As String, MinRefreshRate As String, _
	                            Monochrome As String, NumberOfColorPlanes As String, NumberOfVideoPages As String, PNPDeviceID As String, _
	                            PowerManagementCapabilities As String, PowerManagementSupported As String, ProtocolSupported As String, _
	                            ReservedSystemPaletteEntries As String, SpecificationVersion As String, Status As String, StatusInfo As String, _
	                            SystemCreationClassName As String, SystemName As String, SystemPaletteEntries As String, TimeOfLastReset As String, _
	                            VideoArchitecture As String, VideoMemoryType As String, VideoMode As String, VideoModeDescription As String, _
	                            VideoProcessor As String, AsMap As Map)
								
	Type GPUInfo (Name As String, DriverVersion As String, ProviderName As String, VRAMBytes As Long, AsMap As Map)

End Sub

' Initializes the object. You can pass a specific computer name, or leave it empty for localhost.
' Note:
' For the remote execution to work across a network, the following conditions must be met:
' 1. Network/Domain: Both computers generally need To be on the same network, And ideally on the same Active Directory Domain.
' 2. Permissions: The Windows account running your B4J app must have Administrator Or WMI-access privileges on the target remote computer.
' 3. WinRM Enabled: The target computer must have Windows Remote Management (WinRM) And PowerShell remoting enabled
' (usually done by running <b>Enable-PSRemoting -Force</b> in an admin PowerShell prompt on the target PC).
' 4. Firewall: The target PC's firewall must allow incoming WMI and WinRM traffic.
Public Sub Initialize (TargetComputerName As String)
	If TargetComputerName = "" Then
		ComputerName = "localhost"
	Else
		ComputerName = TargetComputerName
	End If
End Sub

' ------------------------------------------------------------------------------
' HELPER FUNCTIONS (Safe Type Casting from JSON Maps)
' ------------------------------------------------------------------------------
Private Sub GetStr(m As Map, Key As String) As String
	Dim res As Object = m.GetDefault(Key, "")
	If res = Null Then Return ""
	Return res
End Sub

Private Sub GetLng(m As Map, Key As String) As Long
	Dim res As Object = m.GetDefault(Key, 0)
	If res = Null Then Return 0
	If IsNumber(res) Then Return res
	Return 0
End Sub

Private Sub GetInt(m As Map, Key As String) As Int
	Dim res As Object = m.GetDefault(Key, 0)
	If res = Null Then Return 0
	If IsNumber(res) Then Return res
	Return 0
End Sub

' ------------------------------------------------------------------------------
' CORE WMI FETCHER
' ------------------------------------------------------------------------------
Private Sub GetWmiData(WMIClass As String) As List
	Dim resList As List
	resList.Initialize
	
	Dim psCommand As String
	If ComputerName = "localhost" Or ComputerName = "127.0.0.1" Then
		psCommand = $"Get-CimInstance -ClassName ${WMIClass} | ConvertTo-Json -Compress"$
	Else
		psCommand = $"Get-CimInstance -ComputerName ${ComputerName} -ClassName ${WMIClass} | ConvertTo-Json -Compress"$
	End If
	
	Dim shl As Shell
	shl.Initialize("shl", "powershell.exe", Array As String("-Command", psCommand))
	Dim res As ShellSyncResult = shl.RunSynchronous(15000)
	
	If res.Success Then
		Dim jsonStr As String = res.StdOut.Trim
		If jsonStr <> "" Then
			Dim jp As JSONParser
			jp.Initialize(jsonStr)
			Try
				Dim rootList As List = jp.NextArray
				For Each m As Map In rootList
					resList.Add(m)
				Next
			Catch
				Try
					jp.Initialize(jsonStr)
					resList.Add(jp.NextObject)
				Catch
					Log("Error parsing JSON for " & WMIClass & ": " & LastException.Message)
				End Try
			End Try
		End If
	Else
		Log($"Error fetching WMI class ${WMIClass}: ${res.StdErr}"$)
	End If
	
	Return resList
End Sub

' ------------------------------------------------------------------------------
' TYPED FUNCTIONS
' ------------------------------------------------------------------------------

' Retrieves the Boot Configuration information.
' Example:
' <code>
' For Each BootConfig As CompInfo_BootConfiguration In CI.ComputerGetBootConfiguration
'     Log("Name: " & BootConfig.Name)
'     Log("BootDirectory: " & BootConfig.BootDirectory)
'     Log("ConfigurationPath: " & BootConfig.ConfigurationPath)
'     Log("LastDrive: " & BootConfig.LastDrive)
'     Log("Description: " & BootConfig.Description)
'     Log("ScratchDirectory: " & BootConfig.ScratchDirectory)
'     Log("SettingID: " & BootConfig.SettingID)
'     Log("TempDirectory: " & BootConfig.TempDirectory)
' Next
' </code>
Public Sub ComputerGetBootConfiguration As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_BootConfiguration")
		Dim t As CompInfo_BootConfiguration
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.BootDirectory = GetStr(m, "BootDirectory")
		t.ConfigurationPath = GetStr(m, "ConfigurationPath")
		t.LastDrive = GetStr(m, "LastDrive")
		t.Description = GetStr(m, "Description")
		t.ScratchDirectory = GetStr(m, "ScratchDirectory")
		t.SettingID = GetStr(m, "SettingID")
		t.TempDirectory = GetStr(m, "TempDirectory")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves information about Dependent Services.
' Example:
' <code>
' For Each Svc As CompInfo_DependentService In CI.ComputerGetDependentServices
'     Log("Antecedent: " & Svc.Antecedent)
'     Log("Dependent: " & Svc.Dependent)
'     Log("TypeOfDependency: " & Svc.TypeOfDependency)
' Next
' </code>
Public Sub ComputerGetDependentServices As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_DependentService")
		Dim t As CompInfo_DependentService
		t.Initialize
		t.Antecedent = GetStr(m, "Antecedent")
		t.Dependent = GetStr(m, "Dependent")
		t.TypeOfDependency = GetStr(m, "TypeOfDependency")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Desktop configuration and settings.
' Example:
' <code>
' For Each Desktop As CompInfo_Desktop In CI.ComputerGetDesktops
'     Log("Name: " & Desktop.Name)
'     Log("BorderWidth: " & Desktop.BorderWidth)
'     Log("CoolSwitch: " & Desktop.CoolSwitch)
'     Log("CursorBlinkRate: " & Desktop.CursorBlinkRate)
'     Log("Description: " & Desktop.Description)
'     Log("DragFullWindows: " & Desktop.DragFullWindows)
'     Log("GridGranularity: " & Desktop.GridGranularity)
'     Log("IconSpacing: " & Desktop.IconSpacing)
'     Log("IconTitleFaceName: " & Desktop.IconTitleFaceName)
'     Log("IconTitleSize: " & Desktop.IconTitleSize)
'     Log("IconTitleWrap: " & Desktop.IconTitleWrap)
'     Log("Pattern: " & Desktop.Pattern)
'     Log("ScreenSaverActive: " & Desktop.ScreenSaverActive)
'     Log("ScreenSaverExecutable: " & Desktop.ScreenSaverExecutable)
'     Log("ScreenSaverSecure: " & Desktop.ScreenSaverSecure)
'     Log("ScreenSaverTimeout: " & Desktop.ScreenSaverTimeout)
'     Log("SettingID: " & Desktop.SettingID)
'     Log("Wallpaper: " & Desktop.Wallpaper)
'     Log("WallpaperStretched: " & Desktop.WallpaperStretched)
'     Log("WallpaperTiled: " & Desktop.WallpaperTiled)
' Next
' </code>
Public Sub ComputerGetDesktops As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Desktop")
		Dim t As CompInfo_Desktop
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.BorderWidth = GetStr(m, "BorderWidth")
		t.CoolSwitch = GetStr(m, "CoolSwitch")
		t.CursorBlinkRate = GetStr(m, "CursorBlinkRate")
		t.Description = GetStr(m, "Description")
		t.DragFullWindows = GetStr(m, "DragFullWindows")
		t.GridGranularity = GetStr(m, "GridGranularity")
		t.IconSpacing = GetStr(m, "IconSpacing")
		t.IconTitleFaceName = GetStr(m, "IconTitleFaceName")
		t.IconTitleSize = GetStr(m, "IconTitleSize")
		t.IconTitleWrap = GetStr(m, "IconTitleWrap")
		t.Pattern = GetStr(m, "Pattern")
		t.ScreenSaverActive = GetStr(m, "ScreenSaverActive")
		t.ScreenSaverExecutable = GetStr(m, "ScreenSaverExecutable")
		t.ScreenSaverSecure = GetStr(m, "ScreenSaverSecure")
		t.ScreenSaverTimeout = GetStr(m, "ScreenSaverTimeout")
		t.SettingID = GetStr(m, "SettingID")
		t.Wallpaper = GetStr(m, "Wallpaper")
		t.WallpaperStretched = GetStr(m, "WallpaperStretched")
		t.WallpaperTiled = GetStr(m, "WallpaperTiled")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Event Log file properties.
' Example:
' <code>
' For Each EvtLog As CompInfo_NTEventLogFile In CI.ComputerGetNTEventLogs
'     Log("Name: " & EvtLog.Name)
'     Log("AccessMask: " & EvtLog.AccessMask)
'     Log("Archive: " & EvtLog.Archive)
'     Log("Compressed: " & EvtLog.Compressed)
'     Log("Description: " & EvtLog.Description)
'     Log("CompressionMethod: " & EvtLog.CompressionMethod)
'     Log("CreationClassName: " & EvtLog.CreationClassName)
'     Log("CreationDate: " & EvtLog.CreationDate)
'     Log("CSCreationClassName: " & EvtLog.CSCreationClassName)
'     Log("CSName: " & EvtLog.CSName)
'     Log("Drive: " & EvtLog.Drive)
'     Log("EightDotThreeFileName: " & EvtLog.EightDotThreeFileName)
'     Log("Encrypted: " & EvtLog.Encrypted)
'     Log("EncryptionMethod: " & EvtLog.EncryptionMethod)
'     Log("Extension: " & EvtLog.Extension)
'     Log("FileName: " & EvtLog.FileName)
'     Log("FileSize: " & EvtLog.FileSize)
'     Log("FileType: " & EvtLog.FileType)
'     Log("FSCreationClassName: " & EvtLog.FSCreationClassName)
'     Log("FSName: " & EvtLog.FSName)
'     Log("Hidden: " & EvtLog.Hidden)
'     Log("InstallDate: " & EvtLog.InstallDate)
'     Log("InUseCount: " & EvtLog.InUseCount)
'     Log("LastAccessed: " & EvtLog.LastAccessed)
'     Log("LastModified: " & EvtLog.LastModified)
'     Log("LogfileName: " & EvtLog.LogfileName)
'     Log("Manufacturer: " & EvtLog.Manufacturer)
'     Log("MaxFileSize: " & EvtLog.MaxFileSize)
'     Log("NumberOfRecords: " & EvtLog.NumberOfRecords)
'     Log("OverwriteOutDated: " & EvtLog.OverwriteOutDated)
'     Log("OverWritePolicy: " & EvtLog.OverWritePolicy)
'     Log("Path: " & EvtLog.Path)
'     Log("Readable: " & EvtLog.Readable)
'     Log("Sources: " & EvtLog.Sources)
'     Log("Status: " & EvtLog.Status)
'     Log("System: " & EvtLog.System)
'     Log("Version: " & EvtLog.Version)
'     Log("Writeable: " & EvtLog.Writeable)
' Next
' </code>
Public Sub ComputerGetNTEventLogs As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_NTEventLogFile")
		Dim t As CompInfo_NTEventLogFile
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AccessMask = GetStr(m, "AccessMask")
		t.Archive = GetStr(m, "Archive")
		t.Compressed = GetStr(m, "Compressed")
		t.Description = GetStr(m, "Description")
		t.CompressionMethod = GetStr(m, "CompressionMethod")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CreationDate = GetStr(m, "CreationDate")
		t.CSCreationClassName = GetStr(m, "CSCreationClassName")
		t.CSName = GetStr(m, "CSName")
		t.Drive = GetStr(m, "Drive")
		t.EightDotThreeFileName = GetStr(m, "EightDotThreeFileName")
		t.Encrypted = GetStr(m, "Encrypted")
		t.EncryptionMethod = GetStr(m, "EncryptionMethod")
		t.Extension = GetStr(m, "Extension")
		t.FileName = GetStr(m, "FileName")
		t.FileSize = GetLng(m, "FileSize")
		t.FileType = GetStr(m, "FileType")
		t.FSCreationClassName = GetStr(m, "FSCreationClassName")
		t.FSName = GetStr(m, "FSName")
		t.Hidden = GetStr(m, "Hidden")
		t.InstallDate = GetStr(m, "InstallDate")
		t.InUseCount = GetStr(m, "InUseCount")
		t.LastAccessed = GetStr(m, "LastAccessed")
		t.LastModified = GetStr(m, "LastModified")
		t.LogfileName = GetStr(m, "LogfileName")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.MaxFileSize = GetLng(m, "MaxFileSize")
		t.NumberOfRecords = GetStr(m, "NumberOfRecords")
		t.OverwriteOutDated = GetStr(m, "OverwriteOutDated")
		t.OverWritePolicy = GetStr(m, "OverWritePolicy")
		t.Path = GetStr(m, "Path")
		t.Readable = GetStr(m, "Readable")
		t.Sources = GetStr(m, "Sources")
		t.Status = GetStr(m, "Status")
		t.System = GetStr(m, "System")
		t.Version = GetStr(m, "Version")
		t.Writeable = GetStr(m, "Writeable")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves local User Groups.
' Example:
' <code>
' For Each Grp As CompInfo_Group In CI.ComputerGetGroups
'     Log("Name: " & Grp.Name)
'     Log("Domain: " & Grp.Domain)
'     Log("Status: " & Grp.Status)
'     Log("LocalAccount: " & Grp.LocalAccount)
'     Log("Description: " & Grp.Description)
'     Log("SID: " & Grp.SID)
'     Log("SIDType: " & Grp.SIDType)
' Next
' </code>
Public Sub ComputerGetGroups As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Group")
		Dim t As CompInfo_Group
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Domain = GetStr(m, "Domain")
		t.Status = GetStr(m, "Status")
		t.LocalAccount = GetStr(m, "LocalAccount")
		t.Description = GetStr(m, "Description")
		t.SID = GetStr(m, "SID")
		t.SIDType = GetStr(m, "SIDType")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves information about currently Logged On Users.
' Example:
' <code>
' For Each Usr As CompInfo_LoggedOnUser In CI.ComputerGetLoggedOnUsers
'     Log("Antecedent: " & Usr.Antecedent)
'     Log("Dependent: " & Usr.Dependent)
' Next
' </code>
Public Sub ComputerGetLoggedOnUsers As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_LoggedOnUser")
		Dim t As CompInfo_LoggedOnUser
		t.Initialize
		t.Antecedent = GetStr(m, "Antecedent")
		t.Dependent = GetStr(m, "Dependent")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Operating System information.
' Example:
' <code>
' For Each OS As CompInfo_OperatingSystem In CI.ComputerGetOperatingSytems
'     Log("Name: " & OS.Name)
'     Log("BootDevice: " & OS.BootDevice)
'     Log("BuildNumber: " & OS.BuildNumber)
'     Log("BuildType: " & OS.BuildType)
'     Log("Description: " & OS.Description)
'     Log("CodeSet: " & OS.CodeSet)
'     Log("CountryCode: " & OS.CountryCode)
'     Log("CreationClassName: " & OS.CreationClassName)
'     Log("CSCreationClassName: " & OS.CSCreationClassName)
'     Log("CSDVersion: " & OS.CSDVersion)
'     Log("CSName: " & OS.CSName)
'     Log("CurrentTimeZone: " & OS.CurrentTimeZone)
'     Log("DataExecutionPrevention_32BitApplications: " & OS.DataExecutionPrevention_32BitApplications)
'     Log("DataExecutionPrevention_Available: " & OS.DataExecutionPrevention_Available)
'     Log("DataExecutionPrevention_Drivers: " & OS.DataExecutionPrevention_Drivers)
'     Log("DataExecutionPrevention_SupportPolicy: " & OS.DataExecutionPrevention_SupportPolicy)
'     Log("Debug: " & OS.Debug)
'     Log("Distributed: " & OS.Distributed)
'     Log("EncryptionLevel: " & OS.EncryptionLevel)
'     Log("ForegroundApplicationBoost: " & OS.ForegroundApplicationBoost)
'     Log("FreePhysicalMemory: " & OS.FreePhysicalMemory)
'     Log("FreeSpaceInPagingFiles: " & OS.FreeSpaceInPagingFiles)
'     Log("FreeVirtualMemory: " & OS.FreeVirtualMemory)
'     Log("InstallDate: " & OS.InstallDate)
'     Log("LargeSystemCache: " & OS.LargeSystemCache)
'     Log("LastBootUpTime: " & OS.LastBootUpTime)
'     Log("LocalDateTime: " & OS.LocalDateTime)
'     Log("Locale: " & OS.Locale)
'     Log("Manufacturer: " & OS.Manufacturer)
'     Log("MaxNumberOfProcesses: " & OS.MaxNumberOfProcesses)
'     Log("MaxProcessMemorySize: " & OS.MaxProcessMemorySize)
'     Log("NumberOfLicensedUsers: " & OS.NumberOfLicensedUsers)
'     Log("NumberOfProcesses: " & OS.NumberOfProcesses)
'     Log("NumberOfUsers: " & OS.NumberOfUsers)
'     Log("Organization: " & OS.Organization)
'     Log("OSLanguage: " & OS.OSLanguage)
'     Log("OSProductSuite: " & OS.OSProductSuite)
'     Log("OSType: " & OS.OSType)
'     Log("OtherTypeDescription: " & OS.OtherTypeDescription)
'     Log("PlusProductID: " & OS.PlusProductID)
'     Log("PlusVersionNumber: " & OS.PlusVersionNumber)
'     Log("Primary: " & OS.Primary)
'     Log("ProductType: " & OS.ProductType)
'     Log("RegisteredUser: " & OS.RegisteredUser)
'     Log("SerialNumber: " & OS.SerialNumber)
'     Log("ServicePackMajorVersion: " & OS.ServicePackMajorVersion)
'     Log("ServicePackMinorVersion: " & OS.ServicePackMinorVersion)
'     Log("SizeStoredInPagingFiles: " & OS.SizeStoredInPagingFiles)
'     Log("Status: " & OS.Status)
'     Log("SuiteMask: " & OS.SuiteMask)
'     Log("SystemDevice: " & OS.SystemDevice)
'     Log("SystemDirectory: " & OS.SystemDirectory)
'     Log("SystemDrive: " & OS.SystemDrive)
'     Log("TotalSwapSpaceSize: " & OS.TotalSwapSpaceSize)
'     Log("TotalVirtualMemorySize: " & OS.TotalVirtualMemorySize)
'     Log("TotalVisibleMemorySize: " & OS.TotalVisibleMemorySize)
'     Log("Version: " & OS.Version)
'     Log("WindowsDirectory: " & OS.WindowsDirectory)
' Next
' </code>
Public Sub ComputerGetOperatingSytems As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_OperatingSystem")
		Dim t As CompInfo_OperatingSystem
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.BootDevice = GetStr(m, "BootDevice")
		t.BuildNumber = GetStr(m, "BuildNumber")
		t.BuildType = GetStr(m, "BuildType")
		t.Description = GetStr(m, "Description")
		t.CodeSet = GetStr(m, "CodeSet")
		t.CountryCode = GetStr(m, "CountryCode")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CSCreationClassName = GetStr(m, "CSCreationClassName")
		t.CSDVersion = GetStr(m, "CSDVersion")
		t.CSName = GetStr(m, "CSName")
		t.CurrentTimeZone = GetStr(m, "CurrentTimeZone")
		t.DataExecutionPrevention_32BitApplications = GetStr(m, "DataExecutionPrevention_32BitApplications")
		t.DataExecutionPrevention_Available = GetStr(m, "DataExecutionPrevention_Available")
		t.DataExecutionPrevention_Drivers = GetStr(m, "DataExecutionPrevention_Drivers")
		t.DataExecutionPrevention_SupportPolicy = GetStr(m, "DataExecutionPrevention_SupportPolicy")
		t.Debug = GetStr(m, "Debug")
		t.Distributed = GetStr(m, "Distributed")
		t.EncryptionLevel = GetStr(m, "EncryptionLevel")
		t.ForegroundApplicationBoost = GetStr(m, "ForegroundApplicationBoost")
		t.FreePhysicalMemory = GetLng(m, "FreePhysicalMemory")
		t.FreeSpaceInPagingFiles = GetLng(m, "FreeSpaceInPagingFiles")
		t.FreeVirtualMemory = GetLng(m, "FreeVirtualMemory")
		t.InstallDate = GetStr(m, "InstallDate")
		t.LargeSystemCache = GetStr(m, "LargeSystemCache")
		t.LastBootUpTime = GetStr(m, "LastBootUpTime")
		t.LocalDateTime = GetStr(m, "LocalDateTime")
		t.Locale = GetStr(m, "Locale")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.MaxNumberOfProcesses = GetStr(m, "MaxNumberOfProcesses")
		t.MaxProcessMemorySize = GetLng(m, "MaxProcessMemorySize")
		t.NumberOfLicensedUsers = GetStr(m, "NumberOfLicensedUsers")
		t.NumberOfProcesses = GetStr(m, "NumberOfProcesses")
		t.NumberOfUsers = GetStr(m, "NumberOfUsers")
		t.Organization = GetStr(m, "Organization")
		t.OSLanguage = GetStr(m, "OSLanguage")
		t.OSProductSuite = GetStr(m, "OSProductSuite")
		t.OSType = GetStr(m, "OSType")
		t.OtherTypeDescription = GetStr(m, "OtherTypeDescription")
		t.PlusProductID = GetStr(m, "PlusProductID")
		t.PlusVersionNumber = GetStr(m, "PlusVersionNumber")
		t.Primary = GetStr(m, "Primary")
		t.ProductType = GetStr(m, "ProductType")
		t.RegisteredUser = GetStr(m, "RegisteredUser")
		t.SerialNumber = GetStr(m, "SerialNumber")
		t.ServicePackMajorVersion = GetStr(m, "ServicePackMajorVersion")
		t.ServicePackMinorVersion = GetStr(m, "ServicePackMinorVersion")
		t.SizeStoredInPagingFiles = GetLng(m, "SizeStoredInPagingFiles")
		t.Status = GetStr(m, "Status")
		t.SuiteMask = GetStr(m, "SuiteMask")
		t.SystemDevice = GetStr(m, "SystemDevice")
		t.SystemDirectory = GetStr(m, "SystemDirectory")
		t.SystemDrive = GetStr(m, "SystemDrive")
		t.TotalSwapSpaceSize = GetLng(m, "TotalSwapSpaceSize")
		t.TotalVirtualMemorySize = GetLng(m, "TotalVirtualMemorySize")
		t.TotalVisibleMemorySize = GetLng(m, "TotalVisibleMemorySize")
		t.Version = GetStr(m, "Version")
		t.WindowsDirectory = GetStr(m, "WindowsDirectory")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Print Job information.
' Example:
' <code>
' For Each Job As CompInfo_PrintJob In CI.ComputerGetPrintJobs
'     Log("Name: " & Job.Name)
'     Log("DataType: " & Job.DataType)
'     Log("Document: " & Job.Document)
'     Log("DriverName: " & Job.DriverName)
'     Log("Description: " & Job.Description)
'     Log("ElapsedTime: " & Job.ElapsedTime)
'     Log("HostPrintQueue: " & Job.HostPrintQueue)
'     Log("JobId: " & Job.JobId)
'     Log("JobStatus: " & Job.JobStatus)
'     Log("Notify: " & Job.Notify)
'     Log("Owner: " & Job.Owner)
'     Log("PagesPrinted: " & Job.PagesPrinted)
'     Log("Parameters: " & Job.Parameters)
'     Log("PrintProcessor: " & Job.PrintProcessor)
'     Log("Priority: " & Job.Priority)
'     Log("Size: " & Job.Size)
'     Log("StartTime: " & Job.StartTime)
'     Log("Status: " & Job.Status)
'     Log("StatusMask: " & Job.StatusMask)
'     Log("TimeSubmitted: " & Job.TimeSubmitted)
'     Log("TotalPages: " & Job.TotalPages)
'     Log("UntilTime: " & Job.UntilTime)
' Next
' </code>
Public Sub ComputerGetPrintJobs As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_PrintJob")
		Dim t As CompInfo_PrintJob
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.DataType = GetStr(m, "DataType")
		t.Document = GetStr(m, "Document")
		t.DriverName = GetStr(m, "DriverName")
		t.Description = GetStr(m, "Description")
		t.ElapsedTime = GetStr(m, "ElapsedTime")
		t.HostPrintQueue = GetStr(m, "HostPrintQueue")
		t.JobId = GetStr(m, "JobId")
		t.JobStatus = GetStr(m, "JobStatus")
		t.Notify = GetStr(m, "Notify")
		t.Owner = GetStr(m, "Owner")
		t.PagesPrinted = GetStr(m, "PagesPrinted")
		t.Parameters = GetStr(m, "Parameters")
		t.PrintProcessor = GetStr(m, "PrintProcessor")
		t.Priority = GetStr(m, "Priority")
		t.Size = GetLng(m, "Size")
		t.StartTime = GetStr(m, "StartTime")
		t.Status = GetStr(m, "Status")
		t.StatusMask = GetStr(m, "StatusMask")
		t.TimeSubmitted = GetStr(m, "TimeSubmitted")
		t.TotalPages = GetStr(m, "TotalPages")
		t.UntilTime = GetStr(m, "UntilTime")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves currently running Processes.
' Example:
' <code>
' For Each Prc As CompInfo_Process In CI.ComputerGetProcesses
'     Log("Name: " & Prc.Name)
'     Log("CommandLine: " & Prc.CommandLine)
'     Log("CreationClassName: " & Prc.CreationClassName)
'     Log("CreationDate: " & Prc.CreationDate)
'     Log("Description: " & Prc.Description)
'     Log("CSCreationClassName: " & Prc.CSCreationClassName)
'     Log("CSName: " & Prc.CSName)
'     Log("ExecutablePath: " & Prc.ExecutablePath)
'     Log("ExecutionState: " & Prc.ExecutionState)
'     Log("Handle: " & Prc.Handle)
'     Log("HandleCount: " & Prc.HandleCount)
'     Log("KernelModeTime: " & Prc.KernelModeTime)
'     Log("MaximumWorkingSetSize: " & Prc.MaximumWorkingSetSize)
'     Log("MinimumWorkingSetSize: " & Prc.MinimumWorkingSetSize)
'     Log("OSCreationClassName: " & Prc.OSCreationClassName)
'     Log("OSName: " & Prc.OSName)
'     Log("OtherOperationCount: " & Prc.OtherOperationCount)
'     Log("OtherTransferCount: " & Prc.OtherTransferCount)
'     Log("PageFaults: " & Prc.PageFaults)
'     Log("PageFileUsage: " & Prc.PageFileUsage)
'     Log("ParentProcessId: " & Prc.ParentProcessId)
'     Log("PeakPageFileUsage: " & Prc.PeakPageFileUsage)
'     Log("PeakVirtualSize: " & Prc.PeakVirtualSize)
'     Log("PeakWorkingSetSize: " & Prc.PeakWorkingSetSize)
'     Log("Priority: " & Prc.Priority)
'     Log("PrivatePageCount: " & Prc.PrivatePageCount)
'     Log("ProcessId: " & Prc.ProcessId)
'     Log("QuotaNonPagedPoolUsage: " & Prc.QuotaNonPagedPoolUsage)
'     Log("QuotaPagedPoolUsage: " & Prc.QuotaPagedPoolUsage)
'     Log("QuotaPeakNonPagedPoolUsage: " & Prc.QuotaPeakNonPagedPoolUsage)
'     Log("QuotaPeakPagedPoolUsage: " & Prc.QuotaPeakPagedPoolUsage)
'     Log("ReadOperationCount: " & Prc.ReadOperationCount)
'     Log("ReadTransferCount: " & Prc.ReadTransferCount)
'     Log("SessionId: " & Prc.SessionId)
'     Log("Status: " & Prc.Status)
'     Log("ThreadCount: " & Prc.ThreadCount)
'     Log("UserModeTime: " & Prc.UserModeTime)
'     Log("VirtualSize: " & Prc.VirtualSize)
'     Log("WindowsVersion: " & Prc.WindowsVersion)
'     Log("WorkingSetSize: " & Prc.WorkingSetSize)
'     Log("WriteOperationCount: " & Prc.WriteOperationCount)
'     Log("WriteTransferCount: " & Prc.WriteTransferCount)
' Next
' </code>
Public Sub ComputerGetProcesses As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Process")
		Dim t As CompInfo_Process
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.CommandLine = GetStr(m, "CommandLine")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CreationDate = GetStr(m, "CreationDate")
		t.Description = GetStr(m, "Description")
		t.CSCreationClassName = GetStr(m, "CSCreationClassName")
		t.CSName = GetStr(m, "CSName")
		t.ExecutablePath = GetStr(m, "ExecutablePath")
		t.ExecutionState = GetStr(m, "ExecutionState")
		t.Handle = GetStr(m, "Handle")
		t.HandleCount = GetStr(m, "HandleCount")
		t.KernelModeTime = GetStr(m, "KernelModeTime")
		t.MaximumWorkingSetSize = GetStr(m, "MaximumWorkingSetSize")
		t.MinimumWorkingSetSize = GetStr(m, "MinimumWorkingSetSize")
		t.OSCreationClassName = GetStr(m, "OSCreationClassName")
		t.OSName = GetStr(m, "OSName")
		t.OtherOperationCount = GetStr(m, "OtherOperationCount")
		t.OtherTransferCount = GetStr(m, "OtherTransferCount")
		t.PageFaults = GetStr(m, "PageFaults")
		t.PageFileUsage = GetStr(m, "PageFileUsage")
		t.ParentProcessId = GetStr(m, "ParentProcessId")
		t.PeakPageFileUsage = GetStr(m, "PeakPageFileUsage")
		t.PeakVirtualSize = GetStr(m, "PeakVirtualSize")
		t.PeakWorkingSetSize = GetStr(m, "PeakWorkingSetSize")
		t.Priority = GetStr(m, "Priority")
		t.PrivatePageCount = GetStr(m, "PrivatePageCount")
		t.ProcessId = GetStr(m, "ProcessId")
		t.QuotaNonPagedPoolUsage = GetStr(m, "QuotaNonPagedPoolUsage")
		t.QuotaPagedPoolUsage = GetStr(m, "QuotaPagedPoolUsage")
		t.QuotaPeakNonPagedPoolUsage = GetStr(m, "QuotaPeakNonPagedPoolUsage")
		t.QuotaPeakPagedPoolUsage = GetStr(m, "QuotaPeakPagedPoolUsage")
		t.ReadOperationCount = GetStr(m, "ReadOperationCount")
		t.ReadTransferCount = GetStr(m, "ReadTransferCount")
		t.SessionId = GetStr(m, "SessionId")
		t.Status = GetStr(m, "Status")
		t.ThreadCount = GetStr(m, "ThreadCount")
		t.UserModeTime = GetStr(m, "UserModeTime")
		t.VirtualSize = GetStr(m, "VirtualSize")
		t.WindowsVersion = GetStr(m, "WindowsVersion")
		t.WorkingSetSize = GetStr(m, "WorkingSetSize")
		t.WriteOperationCount = GetStr(m, "WriteOperationCount")
		t.WriteTransferCount = GetStr(m, "WriteTransferCount")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Services configuration and state.
' Example:
' <code>
' For Each Svc As CompInfo_Service In CI.ComputerGetServices
'     Log("Name: " & Svc.Name)
'     Log("AcceptPause: " & Svc.AcceptPause)
'     Log("AcceptStop: " & Svc.AcceptStop)
'     Log("CheckPoint: " & Svc.CheckPoint)
'     Log("Description: " & Svc.Description)
'     Log("CreationClassName: " & Svc.CreationClassName)
'     Log("DesktopInteract: " & Svc.DesktopInteract)
'     Log("DisplayName: " & Svc.DisplayName)
'     Log("ErrorControl: " & Svc.ErrorControl)
'     Log("ExitCode: " & Svc.ExitCode)
'     Log("PathName: " & Svc.PathName)
'     Log("ProcessId: " & Svc.ProcessId)
'     Log("ServiceSpecificExitCode: " & Svc.ServiceSpecificExitCode)
'     Log("ServiceType: " & Svc.ServiceType)
'     Log("Started: " & Svc.Started)
'     Log("StartMode: " & Svc.StartMode)
'     Log("StartName: " & Svc.StartName)
'     Log("State: " & Svc.State)
'     Log("Status: " & Svc.Status)
'     Log("SystemCreationClassName: " & Svc.SystemCreationClassName)
'     Log("SystemName: " & Svc.SystemName)
'     Log("TagId: " & Svc.TagId)
'     Log("WaitHint: " & Svc.WaitHint)
' Next
' </code>
Public Sub ComputerGetServices As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Service")
		Dim t As CompInfo_Service
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AcceptPause = GetStr(m, "AcceptPause")
		t.AcceptStop = GetStr(m, "AcceptStop")
		t.CheckPoint = GetStr(m, "CheckPoint")
		t.Description = GetStr(m, "Description")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DesktopInteract = GetStr(m, "DesktopInteract")
		t.DisplayName = GetStr(m, "DisplayName")
		t.ErrorControl = GetStr(m, "ErrorControl")
		t.ExitCode = GetStr(m, "ExitCode")
		t.PathName = GetStr(m, "PathName")
		t.ProcessId = GetStr(m, "ProcessId")
		t.ServiceSpecificExitCode = GetStr(m, "ServiceSpecificExitCode")
		t.ServiceType = GetStr(m, "ServiceType")
		t.Started = GetStr(m, "Started")
		t.StartMode = GetStr(m, "StartMode")
		t.StartName = GetStr(m, "StartName")
		t.State = GetStr(m, "State")
		t.Status = GetStr(m, "Status")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.TagId = GetStr(m, "TagId")
		t.WaitHint = GetStr(m, "WaitHint")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves information about network Shares.
' Example:
' <code>
' For Each Shr As CompInfo_Share In CI.ComputerGetShares
'     Log("Name: " & Shr.Name)
'     Log("AccessMask: " & Shr.AccessMask)
'     Log("AllowMaximum: " & Shr.AllowMaximum)
'     Log("MaximumAllowed: " & Shr.MaximumAllowed)
'     Log("Description: " & Shr.Description)
'     Log("Path: " & Shr.Path)
'     Log("Status: " & Shr.Status)
'     Log("Type: " & Shr.Type)
' Next
' </code>
Public Sub ComputerGetShares As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Share")
		Dim t As CompInfo_Share
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AccessMask = GetStr(m, "AccessMask")
		t.AllowMaximum = GetStr(m, "AllowMaximum")
		t.MaximumAllowed = GetStr(m, "MaximumAllowed")
		t.Description = GetStr(m, "Description")
		t.Path = GetStr(m, "Path")
		t.Status = GetStr(m, "Status")
		t.Type = GetStr(m, "Type")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Startup commands and locations.
' Example:
' <code>
' For Each Str As CompInfo_StartupCommand In CI.ComputerGetStartupCommands
'     Log("Name: " & Str.Name)
'     Log("User: " & Str.User)
'     Log("Location: " & Str.Location)
'     Log("Command: " & Str.Command)
'     Log("Description: " & Str.Description)
'     Log("SettingID: " & Str.SettingID)
' Next
' </code>
Public Sub ComputerGetStartupCommands As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_StartupCommand")
		Dim t As CompInfo_StartupCommand
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.User = GetStr(m, "User")
		t.Location = GetStr(m, "Location")
		t.Command = GetStr(m, "Command")
		t.Description = GetStr(m, "Description")
		t.SettingID = GetStr(m, "SettingID")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves active system Threads.
' Example:
' <code>
' For Each Thr As CompInfo_Thread In CI.ComputerGetThreads
'     Log("Name: " & Thr.Name)
'     Log("CreationClassName: " & Thr.CreationClassName)
'     Log("CSCreationClassName: " & Thr.CSCreationClassName)
'     Log("CSName: " & Thr.CSName)
'     Log("Description: " & Thr.Description)
'     Log("ElapsedTime: " & Thr.ElapsedTime)
'     Log("ExecutionState: " & Thr.ExecutionState)
'     Log("Handle: " & Thr.Handle)
'     Log("KernelModeTime: " & Thr.KernelModeTime)
'     Log("OSCreationClassName: " & Thr.OSCreationClassName)
'     Log("OSName: " & Thr.OSName)
'     Log("Priority: " & Thr.Priority)
'     Log("PriorityBase: " & Thr.PriorityBase)
'     Log("ProcessCreationClassName: " & Thr.ProcessCreationClassName)
'     Log("ProcessHandle: " & Thr.ProcessHandle)
'     Log("StartAddress: " & Thr.StartAddress)
'     Log("Status: " & Thr.Status)
'     Log("ThreadState: " & Thr.ThreadState)
'     Log("ThreadWaitReason: " & Thr.ThreadWaitReason)
'     Log("UserModeTime: " & Thr.UserModeTime)
' Next
' </code>
Public Sub ComputerGetThreads As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Thread")
		Dim t As CompInfo_Thread
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CSCreationClassName = GetStr(m, "CSCreationClassName")
		t.CSName = GetStr(m, "CSName")
		t.Description = GetStr(m, "Description")
		t.ElapsedTime = GetStr(m, "ElapsedTime")
		t.ExecutionState = GetStr(m, "ExecutionState")
		t.Handle = GetStr(m, "Handle")
		t.KernelModeTime = GetStr(m, "KernelModeTime")
		t.OSCreationClassName = GetStr(m, "OSCreationClassName")
		t.OSName = GetStr(m, "OSName")
		t.Priority = GetStr(m, "Priority")
		t.PriorityBase = GetStr(m, "PriorityBase")
		t.ProcessCreationClassName = GetStr(m, "ProcessCreationClassName")
		t.ProcessHandle = GetStr(m, "ProcessHandle")
		t.StartAddress = GetStr(m, "StartAddress")
		t.Status = GetStr(m, "Status")
		t.ThreadState = GetStr(m, "ThreadState")
		t.ThreadWaitReason = GetStr(m, "ThreadWaitReason")
		t.UserModeTime = GetStr(m, "UserModeTime")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves local User Accounts.
' Example:
' <code>
' For Each Usr As CompInfo_UserAccount In CI.ComputerGetUserAccounts
'     Log("Name: " & Usr.Name)
'     Log("Domain: " & Usr.Domain)
'     Log("Status: " & Usr.Status)
'     Log("LocalAccount: " & Usr.LocalAccount)
'     Log("Description: " & Usr.Description)
'     Log("SIDType: " & Usr.SIDType)
'     Log("SID: " & Usr.SID)
'     Log("FullName: " & Usr.FullName)
'     Log("Disabled: " & Usr.Disabled)
'     Log("Lockout: " & Usr.Lockout)
'     Log("PasswordChangeable: " & Usr.PasswordChangeable)
'     Log("PasswordExpires: " & Usr.PasswordExpires)
'     Log("PasswordRequired: " & Usr.PasswordRequired)
'     Log("AccountType: " & Usr.AccountType)
' Next
' </code>
Public Sub ComputerGetUserAccounts As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_UserAccount")
		Dim t As CompInfo_UserAccount
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Domain = GetStr(m, "Domain")
		t.Status = GetStr(m, "Status")
		t.LocalAccount = GetStr(m, "LocalAccount")
		t.Description = GetStr(m, "Description")
		t.SIDType = GetStr(m, "SIDType")
		t.SID = GetStr(m, "SID")
		t.FullName = GetStr(m, "FullName")
		t.Disabled = GetStr(m, "Disabled")
		t.Lockout = GetStr(m, "Lockout")
		t.PasswordChangeable = GetStr(m, "PasswordChangeable")
		t.PasswordExpires = GetStr(m, "PasswordExpires")
		t.PasswordRequired = GetStr(m, "PasswordRequired")
		t.AccountType = GetStr(m, "AccountType")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves installed software.
' Example:
' <code>
' For Each App As Installed_Software In CI.ComputerGetInstalledSoftwares
'     Log("DisplayName: " & App.DisplayName)
'     Log("DisplayVersion: " & App.DisplayVersion)
'     Log("Publisher: " & App.Publisher)
'     Log("UninstallString: " & App.UninstallString)
' Next
' </code>
Public Sub ComputerGetInstalledSoftwares As List
	Dim res As List
	res.Initialize
	
	Dim psCommand As String
	Dim localScript As String = "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, UninstallString"
	
	If ComputerName = "localhost" Or ComputerName = "127.0.0.1" Then
		psCommand = localScript & " | ConvertTo-Json -Compress"
	Else
		psCommand = $"Invoke-Command -ComputerName ${ComputerName} -ScriptBlock { ${localScript} } | ConvertTo-Json -Compress"$
	End If
	
	Dim shl As Shell
	shl.Initialize("shl", "powershell.exe", Array As String("-Command", psCommand))
	Dim shlRes As ShellSyncResult = shl.RunSynchronous(20000) ' Gave this 20s as remote software scans take a bit longer
	
	If shlRes.Success And shlRes.StdOut.Trim <> "" Then
		Dim jp As JSONParser
		jp.Initialize(shlRes.StdOut.Trim)
		Try
			Dim rootList As List = jp.NextArray
			For Each m As Map In rootList
				If GetStr(m, "DisplayName") <> "" Then
					Dim t As CompInfo_InstalledSoftware
					t.Initialize
					t.DisplayName = GetStr(m, "DisplayName")
					t.DisplayVersion = GetStr(m, "DisplayVersion")
					t.Publisher = GetStr(m, "Publisher")
					t.UninstallString = GetStr(m, "UninstallString")
					t.AsMap = m
					res.Add(t)
				End If
			Next
		Catch
			Log("Error parsing software JSON: " & LastException.Message)
		End Try
	End If
	Return res
End Sub

' ------------------------------------------------------------------------------
' HARDWARE FUNCTIONS
' ------------------------------------------------------------------------------

' Retrieves Battery status and specifications.
' Example:
' <code>
' For Each Bat As CompInfo_Battery In CI.ComputerGetBatteries
'     Log("Name: " & Bat.Name)
'     Log("Availability: " & Bat.Availability)
'     Log("BatteryRechargeTime: " & Bat.BatteryRechargeTime)
'     Log("BatteryStatus: " & Bat.BatteryStatus)
'     Log("Description: " & Bat.Description)
'     Log("Chemistry: " & Bat.Chemistry)
'     Log("ConfigManagerErrorCode: " & Bat.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Bat.ConfigManagerUserConfig)
'     Log("CreationClassName: " & Bat.CreationClassName)
'     Log("DesignCapacity: " & Bat.DesignCapacity)
'     Log("DesignVoltage: " & Bat.DesignVoltage)
'     Log("DeviceID: " & Bat.DeviceID)
'     Log("ErrorCleared: " & Bat.ErrorCleared)
'     Log("ErrorDescription: " & Bat.ErrorDescription)
'     Log("EstimatedChargeRemaining: " & Bat.EstimatedChargeRemaining)
'     Log("EstimatedRunTime: " & Bat.EstimatedRunTime)
'     Log("ExpectedBatteryLife: " & Bat.ExpectedBatteryLife)
'     Log("ExpectedLife: " & Bat.ExpectedLife)
'     Log("FullChargeCapacity: " & Bat.FullChargeCapacity)
'     Log("LastErrorCode: " & Bat.LastErrorCode)
'     Log("MaxRechargeTime: " & Bat.MaxRechargeTime)
'     Log("PNPDeviceID: " & Bat.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & Bat.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Bat.PowerManagementSupported)
'     Log("SmartBatteryVersion: " & Bat.SmartBatteryVersion)
'     Log("Status: " & Bat.Status)
'     Log("StatusInfo: " & Bat.StatusInfo)
'     Log("SystemCreationClassName: " & Bat.SystemCreationClassName)
'     Log("SystemName: " & Bat.SystemName)
'     Log("TimeOnBattery: " & Bat.TimeOnBattery)
'     Log("TimeToFullCharge: " & Bat.TimeToFullCharge)
' Next
' </code>
Public Sub ComputerGetBatteries As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Battery")
		Dim t As CompInfo_Battery
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Availability = GetStr(m, "Availability")
		t.BatteryRechargeTime = GetStr(m, "BatteryRechargeTime")
		t.BatteryStatus = GetStr(m, "BatteryStatus")
		t.Description = GetStr(m, "Description")
		t.Chemistry = GetStr(m, "Chemistry")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DesignCapacity = GetStr(m, "DesignCapacity")
		t.DesignVoltage = GetStr(m, "DesignVoltage")
		t.DeviceID = GetStr(m, "DeviceID")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.EstimatedChargeRemaining = GetStr(m, "EstimatedChargeRemaining")
		t.EstimatedRunTime = GetStr(m, "EstimatedRunTime")
		t.ExpectedBatteryLife = GetStr(m, "ExpectedBatteryLife")
		t.ExpectedLife = GetStr(m, "ExpectedLife")
		t.FullChargeCapacity = GetStr(m, "FullChargeCapacity")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.MaxRechargeTime = GetStr(m, "MaxRechargeTime")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.SmartBatteryVersion = GetStr(m, "SmartBatteryVersion")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.TimeOnBattery = GetStr(m, "TimeOnBattery")
		t.TimeToFullCharge = GetStr(m, "TimeToFullCharge")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves BIOS information.
' Example:
' <code>
' For Each Bios As CompInfo_BIOS In CI.ComputerGetBIOS
'     Log("Name: " & Bios.Name)
'     Log("Status: " & Bios.Status)
'     Log("BiosCharacteristics: " & Bios.BiosCharacteristics)
'     Log("BIOSVersion: " & Bios.BIOSVersion)
'     Log("Description: " & Bios.Description)
'     Log("BuildNumber: " & Bios.BuildNumber)
'     Log("CodeSet: " & Bios.CodeSet)
'     Log("CurrentLanguage: " & Bios.CurrentLanguage)
'     Log("IdentificationCode: " & Bios.IdentificationCode)
'     Log("InstallableLanguages: " & Bios.InstallableLanguages)
'     Log("LanguageEdition: " & Bios.LanguageEdition)
'     Log("ListOfLanguages: " & Bios.ListOfLanguages)
'     Log("Manufacturer: " & Bios.Manufacturer)
'     Log("OtherTargetOS: " & Bios.OtherTargetOS)
'     Log("PrimaryBIOS: " & Bios.PrimaryBIOS)
'     Log("ReleaseDate: " & Bios.ReleaseDate)
'     Log("SerialNumber: " & Bios.SerialNumber)
'     Log("SMBIOSBIOSVersion: " & Bios.SMBIOSBIOSVersion)
'     Log("SMBIOSMajorVersion: " & Bios.SMBIOSMajorVersion)
'     Log("SMBIOSMinorVersion: " & Bios.SMBIOSMinorVersion)
'     Log("SMBIOSPresent: " & Bios.SMBIOSPresent)
'     Log("SoftwareElementID: " & Bios.SoftwareElementID)
'     Log("SoftwareElementState: " & Bios.SoftwareElementState)
'     Log("TargetOperatingSystem: " & Bios.TargetOperatingSystem)
'     Log("Version: " & Bios.Version)
' Next
' </code>
Public Sub ComputerGetBIOS As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_BIOS")
		Dim t As CompInfo_BIOS
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Status = GetStr(m, "Status")
		t.BiosCharacteristics = GetStr(m, "BiosCharacteristics")
		t.BIOSVersion = GetStr(m, "BIOSVersion")
		t.Description = GetStr(m, "Description")
		t.BuildNumber = GetStr(m, "BuildNumber")
		t.CodeSet = GetStr(m, "CodeSet")
		t.CurrentLanguage = GetStr(m, "CurrentLanguage")
		t.IdentificationCode = GetStr(m, "IdentificationCode")
		t.InstallableLanguages = GetStr(m, "InstallableLanguages")
		t.LanguageEdition = GetStr(m, "LanguageEdition")
		t.ListOfLanguages = GetStr(m, "ListOfLanguages")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.OtherTargetOS = GetStr(m, "OtherTargetOS")
		t.PrimaryBIOS = GetStr(m, "PrimaryBIOS")
		t.ReleaseDate = GetStr(m, "ReleaseDate")
		t.SerialNumber = GetStr(m, "SerialNumber")
		t.SMBIOSBIOSVersion = GetStr(m, "SMBIOSBIOSVersion")
		t.SMBIOSMajorVersion = GetStr(m, "SMBIOSMajorVersion")
		t.SMBIOSMinorVersion = GetStr(m, "SMBIOSMinorVersion")
		t.SMBIOSPresent = GetStr(m, "SMBIOSPresent")
		t.SoftwareElementID = GetStr(m, "SoftwareElementID")
		t.SoftwareElementState = GetStr(m, "SoftwareElementState")
		t.TargetOperatingSystem = GetStr(m, "TargetOperatingSystem")
		t.Version = GetStr(m, "Version")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Logical Disk/Drive info.
' Example:
' <code>
' For Each LogicalDisk As CompInfo_LogicalDisk In CI.ComputerGetLogicalDisks
'     Log("DeviceID: " & LogicalDisk.DeviceID)
'     Log("FileSystem: " & LogicalDisk.FileSystem)
'     Log("VolumeName: " & LogicalDisk.VolumeName)
'     Log("VolumeSerialNumber: " & LogicalDisk.VolumeSerialNumber)
'     Log("FreeSpace: " & LogicalDisk.FreeSpace)
'     Log("Size: " & LogicalDisk.Size)
'     Log("DriveType: " & LogicalDisk.DriveType)
' Next
' </code>
Public Sub ComputerGetLogicalDisks As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_LogicalDisk")
		Dim t As CompInfo_LogicalDisk
		t.Initialize
		t.DeviceID = GetStr(m, "DeviceID")
		t.FileSystem = GetStr(m, "FileSystem")
		t.VolumeName = GetStr(m, "VolumeName")
		t.VolumeSerialNumber = GetStr(m, "VolumeSerialNumber")
		t.FreeSpace = GetLng(m, "FreeSpace")
		t.Size = GetLng(m, "Size")
		t.DriveType = GetInt(m, "DriveType")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves connected Keyboard devices.
' Example:
' <code>
' For Each Kb As CompInfo_Keyboard In CI.ComputerGetKeyboards
'     Log("Name: " & Kb.Name)
'     Log("Availability: " & Kb.Availability)
'     Log("ConfigManagerErrorCode: " & Kb.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Kb.ConfigManagerUserConfig)
'     Log("Description: " & Kb.Description)
'     Log("CreationClassName: " & Kb.CreationClassName)
'     Log("DeviceID: " & Kb.DeviceID)
'     Log("ErrorCleared: " & Kb.ErrorCleared)
'     Log("ErrorDescription: " & Kb.ErrorDescription)
'     Log("IsLocked: " & Kb.IsLocked)
'     Log("LastErrorCode: " & Kb.LastErrorCode)
'     Log("Layout: " & Kb.Layout)
'     Log("NumberOfFunctionKeys: " & Kb.NumberOfFunctionKeys)
'     Log("Password: " & Kb.Password)
'     Log("PNPDeviceID: " & Kb.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & Kb.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Kb.PowerManagementSupported)
'     Log("Status: " & Kb.Status)
'     Log("StatusInfo: " & Kb.StatusInfo)
'     Log("SystemCreationClassName: " & Kb.SystemCreationClassName)
'     Log("SystemName: " & Kb.SystemName)
' Next
' </code>
Public Sub ComputerGetKeyboards As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Keyboard")
		Dim t As CompInfo_Keyboard
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Availability = GetStr(m, "Availability")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.Description = GetStr(m, "Description")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DeviceID = GetStr(m, "DeviceID")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.IsLocked = GetStr(m, "IsLocked")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.Layout = GetStr(m, "Layout")
		t.NumberOfFunctionKeys = GetStr(m, "NumberOfFunctionKeys")
		t.Password = GetStr(m, "Password")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves installed Physical Memory properties.
' Example:
' <code>
' For Each RamStick As CompInfo_PhysicalMemory In CI.ComputerGetPhysicalMemory
'     Log("Name: " & RamStick.Name)
'     Log("BankLabel: " & RamStick.BankLabel)
'     Log("Capacity: " & RamStick.Capacity)
'     Log("DataWidth: " & RamStick.DataWidth)
'     Log("DeviceLocator: " & RamStick.DeviceLocator)
'     Log("FormFactor: " & RamStick.FormFactor)
'     Log("Manufacturer: " & RamStick.Manufacturer)
'     Log("MemoryType: " & RamStick.MemoryType)
'     Log("PartNumber: " & RamStick.PartNumber)
'     Log("SerialNumber: " & RamStick.SerialNumber)
'     Log("Speed: " & RamStick.Speed)
' Next
' </code>
Public Sub ComputerGetPhysicalMemory As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_PhysicalMemory")
		Dim t As CompInfo_PhysicalMemory
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.BankLabel = GetStr(m, "BankLabel")
		t.Capacity = GetLng(m, "Capacity")
		t.DataWidth = GetInt(m, "DataWidth")
		t.DeviceLocator = GetStr(m, "DeviceLocator")
		t.FormFactor = GetInt(m, "FormFactor")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.MemoryType = GetInt(m, "MemoryType")
		t.PartNumber = GetStr(m, "PartNumber")
		t.SerialNumber = GetStr(m, "SerialNumber")
		t.Speed = GetInt(m, "Speed")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Desktop Monitors connected to the system.
' Example:
' <code>
' For Each Mon As CompInfo_DesktopMonitor In CI.ComputerGetDesktopMonitors
'     Log("Name: " & Mon.Name)
'     Log("Availability: " & Mon.Availability)
'     Log("Bandwidth: " & Mon.Bandwidth)
'     Log("ConfigManagerErrorCode: " & Mon.ConfigManagerErrorCode)
'     Log("Description: " & Mon.Description)
'     Log("ConfigManagerUserConfig: " & Mon.ConfigManagerUserConfig)
'     Log("CreationClassName: " & Mon.CreationClassName)
'     Log("DeviceID: " & Mon.DeviceID)
'     Log("DisplayType: " & Mon.DisplayType)
'     Log("ErrorCleared: " & Mon.ErrorCleared)
'     Log("ErrorDescription: " & Mon.ErrorDescription)
'     Log("IsLocked: " & Mon.IsLocked)
'     Log("LastErrorCode: " & Mon.LastErrorCode)
'     Log("MonitorManufacturer: " & Mon.MonitorManufacturer)
'     Log("MonitorType: " & Mon.MonitorType)
'     Log("PixelsPerXLogicalInch: " & Mon.PixelsPerXLogicalInch)
'     Log("PixelsPerYLogicalInch: " & Mon.PixelsPerYLogicalInch)
'     Log("PNPDeviceID: " & Mon.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & Mon.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Mon.PowerManagementSupported)
'     Log("ScreenHeight: " & Mon.ScreenHeight)
'     Log("ScreenWidth: " & Mon.ScreenWidth)
'     Log("Status: " & Mon.Status)
'     Log("StatusInfo: " & Mon.StatusInfo)
'     Log("SystemCreationClassName: " & Mon.SystemCreationClassName)
'     Log("SystemName: " & Mon.SystemName)
' Next
' </code>
Public Sub ComputerGetDesktopMonitors As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_DesktopMonitor")
		Dim t As CompInfo_DesktopMonitor
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Availability = GetStr(m, "Availability")
		t.Bandwidth = GetStr(m, "Bandwidth")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.Description = GetStr(m, "Description")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DeviceID = GetStr(m, "DeviceID")
		t.DisplayType = GetStr(m, "DisplayType")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.IsLocked = GetStr(m, "IsLocked")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.MonitorManufacturer = GetStr(m, "MonitorManufacturer")
		t.MonitorType = GetStr(m, "MonitorType")
		t.PixelsPerXLogicalInch = GetStr(m, "PixelsPerXLogicalInch")
		t.PixelsPerYLogicalInch = GetStr(m, "PixelsPerYLogicalInch")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.ScreenHeight = GetStr(m, "ScreenHeight")
		t.ScreenWidth = GetStr(m, "ScreenWidth")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Motherboard components.
' Example:
' <code>
' For Each Mobo As CompInfo_MotherboardDevice In CI.ComputerGetMotherboardDevices
'     Log("Name: " & Mobo.Name)
'     Log("Availability: " & Mobo.Availability)
'     Log("ConfigManagerErrorCode: " & Mobo.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Mobo.ConfigManagerUserConfig)
'     Log("Description: " & Mobo.Description)
'     Log("CreationClassName: " & Mobo.CreationClassName)
'     Log("DeviceID: " & Mobo.DeviceID)
'     Log("ErrorCleared: " & Mobo.ErrorCleared)
'     Log("ErrorDescription: " & Mobo.ErrorDescription)
'     Log("LastErrorCode: " & Mobo.LastErrorCode)
'     Log("PNPDeviceID: " & Mobo.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & Mobo.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Mobo.PowerManagementSupported)
'     Log("PrimaryBusType: " & Mobo.PrimaryBusType)
'     Log("RevisionNumber: " & Mobo.RevisionNumber)
'     Log("SecondaryBusType: " & Mobo.SecondaryBusType)
'     Log("Status: " & Mobo.Status)
'     Log("StatusInfo: " & Mobo.StatusInfo)
'     Log("SystemCreationClassName: " & Mobo.SystemCreationClassName)
'     Log("SystemName: " & Mobo.SystemName)
' Next
' </code>
Public Sub ComputerGetMotherboardDevices As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_MotherboardDevice")
		Dim t As CompInfo_MotherboardDevice
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Availability = GetStr(m, "Availability")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.Description = GetStr(m, "Description")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DeviceID = GetStr(m, "DeviceID")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.PrimaryBusType = GetStr(m, "PrimaryBusType")
		t.RevisionNumber = GetStr(m, "RevisionNumber")
		t.SecondaryBusType = GetStr(m, "SecondaryBusType")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Pointing Devices (Mice) connected to the system.
' Example:
' <code>
' For Each Mouse As CompInfo_PointingDevice In CI.ComputerGetPointingDevices
'     Log("Name: " & Mouse.Name)
'     Log("Availability: " & Mouse.Availability)
'     Log("ConfigManagerErrorCode: " & Mouse.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Mouse.ConfigManagerUserConfig)
'     Log("Description: " & Mouse.Description)
'     Log("CreationClassName: " & Mouse.CreationClassName)
'     Log("DeviceID: " & Mouse.DeviceID)
'     Log("DeviceInterface: " & Mouse.DeviceInterface)
'     Log("DoubleSpeedThreshold: " & Mouse.DoubleSpeedThreshold)
'     Log("ErrorCleared: " & Mouse.ErrorCleared)
'     Log("ErrorDescription: " & Mouse.ErrorDescription)
'     Log("Handedness: " & Mouse.Handedness)
'     Log("HardwareType: " & Mouse.HardwareType)
'     Log("InfFileName: " & Mouse.InfFileName)
'     Log("InfSection: " & Mouse.InfSection)
'     Log("IsLocked: " & Mouse.IsLocked)
'     Log("LastErrorCode: " & Mouse.LastErrorCode)
'     Log("Manufacturer: " & Mouse.Manufacturer)
'     Log("NumberOfButtons: " & Mouse.NumberOfButtons)
'     Log("PNPDeviceID: " & Mouse.PNPDeviceID)
'     Log("PointingType: " & Mouse.PointingType)
'     Log("PowerManagementCapabilities: " & Mouse.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Mouse.PowerManagementSupported)
'     Log("QuadSpeedThreshold: " & Mouse.QuadSpeedThreshold)
'     Log("Resolution: " & Mouse.Resolution)
'     Log("SampleRate: " & Mouse.SampleRate)
'     Log("Status: " & Mouse.Status)
'     Log("StatusInfo: " & Mouse.StatusInfo)
'     Log("Synch: " & Mouse.Synch)
'     Log("SystemCreationClassName: " & Mouse.SystemCreationClassName)
'     Log("SystemName: " & Mouse.SystemName)
' Next
' </code>
Public Sub ComputerGetPointingDevices As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_PointingDevice")
		Dim t As CompInfo_PointingDevice
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Availability = GetStr(m, "Availability")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.Description = GetStr(m, "Description")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DeviceID = GetStr(m, "DeviceID")
		t.DeviceInterface = GetStr(m, "DeviceInterface")
		t.DoubleSpeedThreshold = GetStr(m, "DoubleSpeedThreshold")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.Handedness = GetStr(m, "Handedness")
		t.HardwareType = GetStr(m, "HardwareType")
		t.InfFileName = GetStr(m, "InfFileName")
		t.InfSection = GetStr(m, "InfSection")
		t.IsLocked = GetStr(m, "IsLocked")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.NumberOfButtons = GetStr(m, "NumberOfButtons")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PointingType = GetStr(m, "PointingType")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.QuadSpeedThreshold = GetStr(m, "QuadSpeedThreshold")
		t.Resolution = GetStr(m, "Resolution")
		t.SampleRate = GetStr(m, "SampleRate")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.Synch = GetStr(m, "Synch")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Network Adapters and their properties.
' Example:
' <code>
' For Each Net As CompInfo_NetworkAdapter In CI.ComputerGetNetworkAdapters
'     Log("Name: " & Net.Name)
'     Log("AdapterType: " & Net.AdapterType)
'     Log("AdapterTypeId: " & Net.AdapterTypeId)
'     Log("AutoSense: " & Net.AutoSense)
'     Log("Description: " & Net.Description)
'     Log("Availability: " & Net.Availability)
'     Log("ConfigManagerErrorCode: " & Net.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Net.ConfigManagerUserConfig)
'     Log("CreationClassName: " & Net.CreationClassName)
'     Log("DeviceID: " & Net.DeviceID)
'     Log("ErrorCleared: " & Net.ErrorCleared)
'     Log("ErrorDescription: " & Net.ErrorDescription)
'     Log("Index: " & Net.Index)
'     Log("Installed: " & Net.Installed)
'     Log("LastErrorCode: " & Net.LastErrorCode)
'     Log("MACAddress: " & Net.MACAddress)
'     Log("Manufacturer: " & Net.Manufacturer)
'     Log("MaxNumberControlled: " & Net.MaxNumberControlled)
'     Log("MaxSpeed: " & Net.MaxSpeed)
'     Log("NetConnectionID: " & Net.NetConnectionID)
'     Log("NetConnectionStatus: " & Net.NetConnectionStatus)
'     Log("NetworkAddresses: " & Net.NetworkAddresses)
'     Log("PermanentAddress: " & Net.PermanentAddress)
'     Log("PNPDeviceID: " & Net.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & Net.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Net.PowerManagementSupported)
'     Log("ProductName: " & Net.ProductName)
'     Log("ServiceName: " & Net.ServiceName)
'     Log("Speed: " & Net.Speed)
'     Log("Status: " & Net.Status)
'     Log("StatusInfo: " & Net.StatusInfo)
'     Log("SystemCreationClassName: " & Net.SystemCreationClassName)
'     Log("SystemName: " & Net.SystemName)
'     Log("TimeOfLastReset: " & Net.TimeOfLastReset)
' Next
' </code>
Public Sub ComputerGetNetworkAdapters As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_NetworkAdapter")
		Dim t As CompInfo_NetworkAdapter
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AdapterType = GetStr(m, "AdapterType")
		t.AdapterTypeId = GetStr(m, "AdapterTypeId")
		t.AutoSense = GetStr(m, "AutoSense")
		t.Description = GetStr(m, "Description")
		t.Availability = GetStr(m, "Availability")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DeviceID = GetStr(m, "DeviceID")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.Index = GetStr(m, "Index")
		t.Installed = GetStr(m, "Installed")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.MACAddress = GetStr(m, "MACAddress")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.MaxNumberControlled = GetStr(m, "MaxNumberControlled")
		t.MaxSpeed = GetStr(m, "MaxSpeed")
		t.NetConnectionID = GetStr(m, "NetConnectionID")
		t.NetConnectionStatus = GetStr(m, "NetConnectionStatus")
		t.NetworkAddresses = GetStr(m, "NetworkAddresses")
		t.PermanentAddress = GetStr(m, "PermanentAddress")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.ProductName = GetStr(m, "ProductName")
		t.ServiceName = GetStr(m, "ServiceName")
		t.Speed = GetStr(m, "Speed")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.TimeOfLastReset = GetStr(m, "TimeOfLastReset")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Printers available on the system.
' Example:
' <code>
' For Each Prn As CompInfo_Printer In CI.ComputerGetPrinters
'     Log("Name: " & Prn.Name)
'     Log("Attributes: " & Prn.Attributes)
'     Log("Availability: " & Prn.Availability)
'     Log("AvailableJobSheets: " & Prn.AvailableJobSheets)
'     Log("Description: " & Prn.Description)
'     Log("AveragePagesPerMinute: " & Prn.AveragePagesPerMinute)
'     Log("Capabilities: " & Prn.Capabilities)
'     Log("CapabilityDescriptions: " & Prn.CapabilityDescriptions)
'     Log("CharSetsSupported: " & Prn.CharSetsSupported)
'     Log("Comment: " & Prn.Comment)
'     Log("ConfigManagerErrorCode: " & Prn.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Prn.ConfigManagerUserConfig)
'     Log("CreationClassName: " & Prn.CreationClassName)
'     Log("CurrentCapabilities: " & Prn.CurrentCapabilities)
'     Log("CurrentCharSet: " & Prn.CurrentCharSet)
'     Log("CurrentLanguage: " & Prn.CurrentLanguage)
'     Log("CurrentMimeType: " & Prn.CurrentMimeType)
'     Log("CurrentNaturalLanguage: " & Prn.CurrentNaturalLanguage)
'     Log("CurrentPaperType: " & Prn.CurrentPaperType)
'     Log("Default: " & Prn.Default)
'     Log("DefaultCapabilities: " & Prn.DefaultCapabilities)
'     Log("DefaultCopies: " & Prn.DefaultCopies)
'     Log("DefaultLanguage: " & Prn.DefaultLanguage)
'     Log("DefaultMimeType: " & Prn.DefaultMimeType)
'     Log("DefaultNumberUp: " & Prn.DefaultNumberUp)
'     Log("DefaultPaperType: " & Prn.DefaultPaperType)
'     Log("DefaultPriority: " & Prn.DefaultPriority)
'     Log("DetectedErrorState: " & Prn.DetectedErrorState)
'     Log("DeviceID: " & Prn.DeviceID)
'     Log("Direct: " & Prn.Direct)
'     Log("DoCompleteFirst: " & Prn.DoCompleteFirst)
'     Log("DriverName: " & Prn.DriverName)
'     Log("EnableBIDI: " & Prn.EnableBIDI)
'     Log("EnableDevQueryPrint: " & Prn.EnableDevQueryPrint)
'     Log("ErrorCleared: " & Prn.ErrorCleared)
'     Log("ErrorDescription: " & Prn.ErrorDescription)
'     Log("ErrorInformation: " & Prn.ErrorInformation)
'     Log("ExtendedDetectedErrorState: " & Prn.ExtendedDetectedErrorState)
'     Log("ExtendedPrinterStatus: " & Prn.ExtendedPrinterStatus)
'     Log("Hidden: " & Prn.Hidden)
'     Log("HorizontalResolution: " & Prn.HorizontalResolution)
'     Log("InstallDate: " & Prn.InstallDate)
'     Log("JobCountSinceLastReset: " & Prn.JobCountSinceLastReset)
'     Log("KeepPrintedJobs: " & Prn.KeepPrintedJobs)
'     Log("LanguagesSupported: " & Prn.LanguagesSupported)
'     Log("LastErrorCode: " & Prn.LastErrorCode)
'     Log("Local: " & Prn.Local)
'     Log("Location: " & Prn.Location)
'     Log("MarkingTechnology: " & Prn.MarkingTechnology)
'     Log("MaxCopies: " & Prn.MaxCopies)
'     Log("MaxNumberUp: " & Prn.MaxNumberUp)
'     Log("MaxSizeSupported: " & Prn.MaxSizeSupported)
'     Log("MimeTypesSupported: " & Prn.MimeTypesSupported)
'     Log("NaturalLanguagesSupported: " & Prn.NaturalLanguagesSupported)
'     Log("Network: " & Prn.Network)
'     Log("PaperSizesSupported: " & Prn.PaperSizesSupported)
'     Log("PaperTypesAvailable: " & Prn.PaperTypesAvailable)
'     Log("Parameters: " & Prn.Parameters)
'     Log("PNPDeviceID: " & Prn.PNPDeviceID)
'     Log("PortName: " & Prn.PortName)
'     Log("PowerManagementCapabilities: " & Prn.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Prn.PowerManagementSupported)
'     Log("PrinterPaperNames: " & Prn.PrinterPaperNames)
'     Log("PrinterState: " & Prn.PrinterState)
'     Log("PrinterStatus: " & Prn.PrinterStatus)
'     Log("PrintJobDataType: " & Prn.PrintJobDataType)
'     Log("PrintProcessor: " & Prn.PrintProcessor)
'     Log("Priority: " & Prn.Priority)
'     Log("Published: " & Prn.Published)
'     Log("Queued: " & Prn.Queued)
'     Log("RawOnly: " & Prn.RawOnly)
'     Log("SeparatorFile: " & Prn.SeparatorFile)
'     Log("ServerName: " & Prn.ServerName)
'     Log("Shared: " & Prn.Shared)
'     Log("ShareName: " & Prn.ShareName)
'     Log("SpoolEnabled: " & Prn.SpoolEnabled)
'     Log("StartTime: " & Prn.StartTime)
'     Log("Status: " & Prn.Status)
'     Log("StatusInfo: " & Prn.StatusInfo)
'     Log("SystemCreationClassName: " & Prn.SystemCreationClassName)
'     Log("SystemName: " & Prn.SystemName)
'     Log("TimeOfLastReset: " & Prn.TimeOfLastReset)
'     Log("UntilTime: " & Prn.UntilTime)
'     Log("VerticalResolution: " & Prn.VerticalResolution)
'     Log("WorkOffline: " & Prn.WorkOffline)
' Next
' </code>
Public Sub ComputerGetPrinters As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Printer")
		Dim t As CompInfo_Printer
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Attributes = GetStr(m, "Attributes")
		t.Availability = GetStr(m, "Availability")
		t.AvailableJobSheets = GetStr(m, "AvailableJobSheets")
		t.Description = GetStr(m, "Description")
		t.AveragePagesPerMinute = GetStr(m, "AveragePagesPerMinute")
		t.Capabilities = GetStr(m, "Capabilities")
		t.CapabilityDescriptions = GetStr(m, "CapabilityDescriptions")
		t.CharSetsSupported = GetStr(m, "CharSetsSupported")
		t.Comment = GetStr(m, "Comment")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CurrentCapabilities = GetStr(m, "CurrentCapabilities")
		t.CurrentCharSet = GetStr(m, "CurrentCharSet")
		t.CurrentLanguage = GetStr(m, "CurrentLanguage")
		t.CurrentMimeType = GetStr(m, "CurrentMimeType")
		t.CurrentNaturalLanguage = GetStr(m, "CurrentNaturalLanguage")
		t.CurrentPaperType = GetStr(m, "CurrentPaperType")
		t.Default = GetStr(m, "Default")
		t.DefaultCapabilities = GetStr(m, "DefaultCapabilities")
		t.DefaultCopies = GetStr(m, "DefaultCopies")
		t.DefaultLanguage = GetStr(m, "DefaultLanguage")
		t.DefaultMimeType = GetStr(m, "DefaultMimeType")
		t.DefaultNumberUp = GetStr(m, "DefaultNumberUp")
		t.DefaultPaperType = GetStr(m, "DefaultPaperType")
		t.DefaultPriority = GetStr(m, "DefaultPriority")
		t.DetectedErrorState = GetStr(m, "DetectedErrorState")
		t.DeviceID = GetStr(m, "DeviceID")
		t.Direct = GetStr(m, "Direct")
		t.DoCompleteFirst = GetStr(m, "DoCompleteFirst")
		t.DriverName = GetStr(m, "DriverName")
		t.EnableBIDI = GetStr(m, "EnableBIDI")
		t.EnableDevQueryPrint = GetStr(m, "EnableDevQueryPrint")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.ErrorInformation = GetStr(m, "ErrorInformation")
		t.ExtendedDetectedErrorState = GetStr(m, "ExtendedDetectedErrorState")
		t.ExtendedPrinterStatus = GetStr(m, "ExtendedPrinterStatus")
		t.Hidden = GetStr(m, "Hidden")
		t.HorizontalResolution = GetStr(m, "HorizontalResolution")
		t.InstallDate = GetStr(m, "InstallDate")
		t.JobCountSinceLastReset = GetStr(m, "JobCountSinceLastReset")
		t.KeepPrintedJobs = GetStr(m, "KeepPrintedJobs")
		t.LanguagesSupported = GetStr(m, "LanguagesSupported")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.Local = GetStr(m, "Local")
		t.Location = GetStr(m, "Location")
		t.MarkingTechnology = GetStr(m, "MarkingTechnology")
		t.MaxCopies = GetStr(m, "MaxCopies")
		t.MaxNumberUp = GetStr(m, "MaxNumberUp")
		t.MaxSizeSupported = GetStr(m, "MaxSizeSupported")
		t.MimeTypesSupported = GetStr(m, "MimeTypesSupported")
		t.NaturalLanguagesSupported = GetStr(m, "NaturalLanguagesSupported")
		t.Network = GetStr(m, "Network")
		t.PaperSizesSupported = GetStr(m, "PaperSizesSupported")
		t.PaperTypesAvailable = GetStr(m, "PaperTypesAvailable")
		t.Parameters = GetStr(m, "Parameters")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PortName = GetStr(m, "PortName")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.PrinterPaperNames = GetStr(m, "PrinterPaperNames")
		t.PrinterState = GetStr(m, "PrinterState")
		t.PrinterStatus = GetStr(m, "PrinterStatus")
		t.PrintJobDataType = GetStr(m, "PrintJobDataType")
		t.PrintProcessor = GetStr(m, "PrintProcessor")
		t.Priority = GetStr(m, "Priority")
		t.Published = GetStr(m, "Published")
		t.Queued = GetStr(m, "Queued")
		t.RawOnly = GetStr(m, "RawOnly")
		t.SeparatorFile = GetStr(m, "SeparatorFile")
		t.ServerName = GetStr(m, "ServerName")
		t.Shared = GetStr(m, "Shared")
		t.ShareName = GetStr(m, "ShareName")
		t.SpoolEnabled = GetStr(m, "SpoolEnabled")
		t.StartTime = GetStr(m, "StartTime")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.TimeOfLastReset = GetStr(m, "TimeOfLastReset")
		t.UntilTime = GetStr(m, "UntilTime")
		t.VerticalResolution = GetStr(m, "VerticalResolution")
		t.WorkOffline = GetStr(m, "WorkOffline")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves system Processors (CPUs).
' Example:
' <code>
' For Each CPU As CompInfo_Processor In CI.ComputerGetProcessors
'     Log("Name: " & CPU.Name)
'     Log("AddressWidth: " & CPU.AddressWidth)
'     Log("Architecture: " & CPU.Architecture)
'     Log("Availability: " & CPU.Availability)
'     Log("Description: " & CPU.Description)
'     Log("ConfigManagerErrorCode: " & CPU.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & CPU.ConfigManagerUserConfig)
'     Log("CpuStatus: " & CPU.CpuStatus)
'     Log("CreationClassName: " & CPU.CreationClassName)
'     Log("CurrentClockSpeed: " & CPU.CurrentClockSpeed)
'     Log("CurrentVoltage: " & CPU.CurrentVoltage)
'     Log("DataWidth: " & CPU.DataWidth)
'     Log("DeviceID: " & CPU.DeviceID)
'     Log("ErrorCleared: " & CPU.ErrorCleared)
'     Log("ErrorDescription: " & CPU.ErrorDescription)
'     Log("ExtClock: " & CPU.ExtClock)
'     Log("Family: " & CPU.Family)
'     Log("L2CacheSize: " & CPU.L2CacheSize)
'     Log("L2CacheSpeed: " & CPU.L2CacheSpeed)
'     Log("LastErrorCode: " & CPU.LastErrorCode)
'     Log("Level: " & CPU.Level)
'     Log("LoadPercentage: " & CPU.LoadPercentage)
'     Log("Manufacturer: " & CPU.Manufacturer)
'     Log("MaxClockSpeed: " & CPU.MaxClockSpeed)
'     Log("OtherFamilyDescription: " & CPU.OtherFamilyDescription)
'     Log("PNPDeviceID: " & CPU.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & CPU.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & CPU.PowerManagementSupported)
'     Log("ProcessorId: " & CPU.ProcessorId)
'     Log("ProcessorType: " & CPU.ProcessorType)
'     Log("Revision: " & CPU.Revision)
'     Log("Role: " & CPU.Role)
'     Log("SocketDesignation: " & CPU.SocketDesignation)
'     Log("Status: " & CPU.Status)
'     Log("StatusInfo: " & CPU.StatusInfo)
'     Log("Stepping: " & CPU.Stepping)
'     Log("SystemCreationClassName: " & CPU.SystemCreationClassName)
'     Log("SystemName: " & CPU.SystemName)
'     Log("UniqueId: " & CPU.UniqueId)
'     Log("UpgradeMethod: " & CPU.UpgradeMethod)
'     Log("Version: " & CPU.Version)
'     Log("VoltageCaps: " & CPU.VoltageCaps)
'     Log("NumberOfCores: " & CPU.NumberOfCores)
'     Log("NumberOfLogicalProcessors: " & CPU.NumberOfLogicalProcessors)
' Next
' </code>
Public Sub ComputerGetProcessors As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_Processor")
		Dim t As CompInfo_Processor
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AddressWidth = GetStr(m, "AddressWidth")
		t.Architecture = GetInt(m, "Architecture")
		t.Availability = GetStr(m, "Availability")
		t.Description = GetStr(m, "Description")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.CpuStatus = GetStr(m, "CpuStatus")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CurrentClockSpeed = GetInt(m, "CurrentClockSpeed")
		t.CurrentVoltage = GetStr(m, "CurrentVoltage")
		t.DataWidth = GetStr(m, "DataWidth")
		t.DeviceID = GetStr(m, "DeviceID")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.ExtClock = GetStr(m, "ExtClock")
		t.Family = GetStr(m, "Family")
		t.L2CacheSize = GetInt(m, "L2CacheSize")
		t.L2CacheSpeed = GetStr(m, "L2CacheSpeed")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.Level = GetStr(m, "Level")
		t.LoadPercentage = GetStr(m, "LoadPercentage")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.MaxClockSpeed = GetInt(m, "MaxClockSpeed")
		t.OtherFamilyDescription = GetStr(m, "OtherFamilyDescription")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.ProcessorId = GetStr(m, "ProcessorId")
		t.ProcessorType = GetStr(m, "ProcessorType")
		t.Revision = GetStr(m, "Revision")
		t.Role = GetStr(m, "Role")
		t.SocketDesignation = GetStr(m, "SocketDesignation")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.Stepping = GetStr(m, "Stepping")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.UniqueId = GetStr(m, "UniqueId")
		t.UpgradeMethod = GetStr(m, "UpgradeMethod")
		t.Version = GetStr(m, "Version")
		t.VoltageCaps = GetStr(m, "VoltageCaps")
		t.NumberOfCores = GetInt(m, "NumberOfCores")
		t.NumberOfLogicalProcessors = GetInt(m, "NumberOfLogicalProcessors")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves audio and sound devices.
' Example:
' <code>
' For Each Snd As CompInfo_SoundDevice In CI.ComputerGetSoundDevices
'     Log("Name: " & Snd.Name)
'     Log("Availability: " & Snd.Availability)
'     Log("ConfigManagerErrorCode: " & Snd.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & Snd.ConfigManagerUserConfig)
'     Log("Description: " & Snd.Description)
'     Log("CreationClassName: " & Snd.CreationClassName)
'     Log("DeviceID: " & Snd.DeviceID)
'     Log("DMABufferSize: " & Snd.DMABufferSize)
'     Log("ErrorCleared: " & Snd.ErrorCleared)
'     Log("ErrorDescription: " & Snd.ErrorDescription)
'     Log("LastErrorCode: " & Snd.LastErrorCode)
'     Log("Manufacturer: " & Snd.Manufacturer)
'     Log("MPU401Address: " & Snd.MPU401Address)
'     Log("PNPDeviceID: " & Snd.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & Snd.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Snd.PowerManagementSupported)
'     Log("ProductName: " & Snd.ProductName)
'     Log("Status: " & Snd.Status)
'     Log("StatusInfo: " & Snd.StatusInfo)
'     Log("SystemCreationClassName: " & Snd.SystemCreationClassName)
'     Log("SystemName: " & Snd.SystemName)
' Next
' </code>
Public Sub ComputerGetSoundDevices As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_SoundDevice")
		Dim t As CompInfo_SoundDevice
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.Availability = GetStr(m, "Availability")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.Description = GetStr(m, "Description")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.DeviceID = GetStr(m, "DeviceID")
		t.DMABufferSize = GetStr(m, "DMABufferSize")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.MPU401Address = GetStr(m, "MPU401Address")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.ProductName = GetStr(m, "ProductName")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves general System and Computer variables.
' Example:
' <code>
' For Each Sys As CompInfo_ComputerSystem In CI.ComputerGetComputerSystem
'     Log("Name: " & Sys.Name)
'     Log("AdminPasswordStatus: " & Sys.AdminPasswordStatus)
'     Log("AutomaticResetBootOption: " & Sys.AutomaticResetBootOption)
'     Log("AutomaticResetCapability: " & Sys.AutomaticResetCapability)
'     Log("Description: " & Sys.Description)
'     Log("BootOptionOnLimit: " & Sys.BootOptionOnLimit)
'     Log("BootOptionOnWatchDog: " & Sys.BootOptionOnWatchDog)
'     Log("BootROMSupported: " & Sys.BootROMSupported)
'     Log("BootupState: " & Sys.BootupState)
'     Log("ChassisBootupState: " & Sys.ChassisBootupState)
'     Log("CreationClassName: " & Sys.CreationClassName)
'     Log("CurrentTimeZone: " & Sys.CurrentTimeZone)
'     Log("DaylightInEffect: " & Sys.DaylightInEffect)
'     Log("Domain: " & Sys.Domain)
'     Log("DomainRole: " & Sys.DomainRole)
'     Log("EnableDaylightSavingsTime: " & Sys.EnableDaylightSavingsTime)
'     Log("FrontPanelResetStatus: " & Sys.FrontPanelResetStatus)
'     Log("InfraredSupported: " & Sys.InfraredSupported)
'     Log("InitialLoadInfo: " & Sys.InitialLoadInfo)
'     Log("KeyboardPasswordStatus: " & Sys.KeyboardPasswordStatus)
'     Log("LastLoadInfo: " & Sys.LastLoadInfo)
'     Log("Manufacturer: " & Sys.Manufacturer)
'     Log("Model: " & Sys.Model)
'     Log("NameFormat: " & Sys.NameFormat)
'     Log("NetworkServerModeEnabled: " & Sys.NetworkServerModeEnabled)
'     Log("NumberOfProcessors: " & Sys.NumberOfProcessors)
'     Log("OEMLogoBitmap: " & Sys.OEMLogoBitmap)
'     Log("OEMStringArray: " & Sys.OEMStringArray)
'     Log("PartOfDomain: " & Sys.PartOfDomain)
'     Log("PauseAfterReset: " & Sys.PauseAfterReset)
'     Log("PowerManagementCapabilities: " & Sys.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & Sys.PowerManagementSupported)
'     Log("PowerOnPasswordStatus: " & Sys.PowerOnPasswordStatus)
'     Log("PowerState: " & Sys.PowerState)
'     Log("PowerSupplyState: " & Sys.PowerSupplyState)
'     Log("PrimaryOwnerContact: " & Sys.PrimaryOwnerContact)
'     Log("PrimaryOwnerName: " & Sys.PrimaryOwnerName)
'     Log("ResetCapability: " & Sys.ResetCapability)
'     Log("ResetCount: " & Sys.ResetCount)
'     Log("ResetLimit: " & Sys.ResetLimit)
'     Log("Roles: " & Sys.Roles)
'     Log("Status: " & Sys.Status)
'     Log("SupportContactDescription: " & Sys.SupportContactDescription)
'     Log("SystemStartupDelay: " & Sys.SystemStartupDelay)
'     Log("SystemStartupOptions: " & Sys.SystemStartupOptions)
'     Log("SystemStartupSetting: " & Sys.SystemStartupSetting)
'     Log("SystemType: " & Sys.SystemType)
'     Log("ThermalState: " & Sys.ThermalState)
'     Log("TotalPhysicalMemory: " & Sys.TotalPhysicalMemory)
'     Log("UserName: " & Sys.UserName)
'     Log("WakeUpType: " & Sys.WakeUpType)
'     Log("Workgroup: " & Sys.Workgroup)
' Next
' </code>
Public Sub ComputerGetComputerSystem As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_ComputerSystem")
		Dim t As CompInfo_ComputerSystem
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AdminPasswordStatus = GetStr(m, "AdminPasswordStatus")
		t.AutomaticResetBootOption = GetStr(m, "AutomaticResetBootOption")
		t.AutomaticResetCapability = GetStr(m, "AutomaticResetCapability")
		t.Description = GetStr(m, "Description")
		t.BootOptionOnLimit = GetStr(m, "BootOptionOnLimit")
		t.BootOptionOnWatchDog = GetStr(m, "BootOptionOnWatchDog")
		t.BootROMSupported = GetStr(m, "BootROMSupported")
		t.BootupState = GetStr(m, "BootupState")
		t.ChassisBootupState = GetStr(m, "ChassisBootupState")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CurrentTimeZone = GetStr(m, "CurrentTimeZone")
		t.DaylightInEffect = GetStr(m, "DaylightInEffect")
		t.Domain = GetStr(m, "Domain")
		t.DomainRole = GetStr(m, "DomainRole")
		t.EnableDaylightSavingsTime = GetStr(m, "EnableDaylightSavingsTime")
		t.FrontPanelResetStatus = GetStr(m, "FrontPanelResetStatus")
		t.InfraredSupported = GetStr(m, "InfraredSupported")
		t.InitialLoadInfo = GetStr(m, "InitialLoadInfo")
		t.KeyboardPasswordStatus = GetStr(m, "KeyboardPasswordStatus")
		t.LastLoadInfo = GetStr(m, "LastLoadInfo")
		t.Manufacturer = GetStr(m, "Manufacturer")
		t.Model = GetStr(m, "Model")
		t.NameFormat = GetStr(m, "NameFormat")
		t.NetworkServerModeEnabled = GetStr(m, "NetworkServerModeEnabled")
		t.NumberOfProcessors = GetInt(m, "NumberOfProcessors")
		t.OEMLogoBitmap = GetStr(m, "OEMLogoBitmap")
		t.OEMStringArray = GetStr(m, "OEMStringArray")
		t.PartOfDomain = GetStr(m, "PartOfDomain")
		t.PauseAfterReset = GetStr(m, "PauseAfterReset")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.PowerOnPasswordStatus = GetStr(m, "PowerOnPasswordStatus")
		t.PowerState = GetStr(m, "PowerState")
		t.PowerSupplyState = GetStr(m, "PowerSupplyState")
		t.PrimaryOwnerContact = GetStr(m, "PrimaryOwnerContact")
		t.PrimaryOwnerName = GetStr(m, "PrimaryOwnerName")
		t.ResetCapability = GetStr(m, "ResetCapability")
		t.ResetCount = GetStr(m, "ResetCount")
		t.ResetLimit = GetStr(m, "ResetLimit")
		t.Roles = GetStr(m, "Roles")
		t.Status = GetStr(m, "Status")
		t.SupportContactDescription = GetStr(m, "SupportContactDescription")
		t.SystemStartupDelay = GetStr(m, "SystemStartupDelay")
		t.SystemStartupOptions = GetStr(m, "SystemStartupOptions")
		t.SystemStartupSetting = GetStr(m, "SystemStartupSetting")
		t.SystemType = GetStr(m, "SystemType")
		t.ThermalState = GetStr(m, "ThermalState")
		t.TotalPhysicalMemory = GetLng(m, "TotalPhysicalMemory")
		t.UserName = GetStr(m, "UserName")
		t.WakeUpType = GetStr(m, "WakeUpType")
		t.Workgroup = GetStr(m, "Workgroup")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves System Product variables (like UUID and SKUs).
' Example:
' <code>
' For Each SysProd As CompInfo_ComputerSystemProduct In CI.ComputerGetSystemProduct
'     Log("Name: " & SysProd.Name)
'     Log("IdentifyingNumber: " & SysProd.IdentifyingNumber)
'     Log("SKUNumber: " & SysProd.SKUNumber)
'     Log("UUID: " & SysProd.UUID)
'     Log("Description: " & SysProd.Description)
'     Log("Vendor: " & SysProd.Vendor)
'     Log("Version: " & SysProd.Version)
' Next
' </code>
Public Sub ComputerGetSystemProduct As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_ComputerSystemProduct")
		Dim t As CompInfo_ComputerSystemProduct
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.IdentifyingNumber = GetStr(m, "IdentifyingNumber")
		t.SKUNumber = GetStr(m, "SKUNumber")
		t.UUID = GetStr(m, "UUID")
		t.Description = GetStr(m, "Description")
		t.Vendor = GetStr(m, "Vendor")
		t.Version = GetStr(m, "Version")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves Video and Graphics adapter information.
' Example:
' <code>
' For Each GPU As CompInfo_VideoController In CI.ComputerGetVideoControllers
'     Log("Name: " & GPU.Name)
'     Log("AcceleratorCapabilities: " & GPU.AcceleratorCapabilities)
'     Log("AdapterCompatibility: " & GPU.AdapterCompatibility)
'     Log("AdapterDACType: " & GPU.AdapterDACType)
'     Log("Description: " & GPU.Description)
'     Log("AdapterRAM: " & GPU.AdapterRAM)
'     Log("Availability: " & GPU.Availability)
'     Log("CapabilityDescriptions: " & GPU.CapabilityDescriptions)
'     Log("ColorTableEntries: " & GPU.ColorTableEntries)
'     Log("ConfigManagerErrorCode: " & GPU.ConfigManagerErrorCode)
'     Log("ConfigManagerUserConfig: " & GPU.ConfigManagerUserConfig)
'     Log("CreationClassName: " & GPU.CreationClassName)
'     Log("CurrentBitsPerPixel: " & GPU.CurrentBitsPerPixel)
'     Log("CurrentHorizontalResolution: " & GPU.CurrentHorizontalResolution)
'     Log("CurrentNumberOfColors: " & GPU.CurrentNumberOfColors)
'     Log("CurrentNumberOfColumns: " & GPU.CurrentNumberOfColumns)
'     Log("CurrentNumberOfRows: " & GPU.CurrentNumberOfRows)
'     Log("CurrentRefreshRate: " & GPU.CurrentRefreshRate)
'     Log("CurrentScanMode: " & GPU.CurrentScanMode)
'     Log("CurrentVerticalResolution: " & GPU.CurrentVerticalResolution)
'     Log("DeviceID: " & GPU.DeviceID)
'     Log("DeviceSpecificPens: " & GPU.DeviceSpecificPens)
'     Log("DitherType: " & GPU.DitherType)
'     Log("DriverDate: " & GPU.DriverDate)
'     Log("DriverVersion: " & GPU.DriverVersion)
'     Log("ErrorCleared: " & GPU.ErrorCleared)
'     Log("ErrorDescription: " & GPU.ErrorDescription)
'     Log("ICMIntent: " & GPU.ICMIntent)
'     Log("ICMMethod: " & GPU.ICMMethod)
'     Log("InfFilename: " & GPU.InfFilename)
'     Log("InfSection: " & GPU.InfSection)
'     Log("InstalledDisplayDrivers: " & GPU.InstalledDisplayDrivers)
'     Log("LastErrorCode: " & GPU.LastErrorCode)
'     Log("MaxMemorySupported: " & GPU.MaxMemorySupported)
'     Log("MaxNumberControlled: " & GPU.MaxNumberControlled)
'     Log("MaxRefreshRate: " & GPU.MaxRefreshRate)
'     Log("MinRefreshRate: " & GPU.MinRefreshRate)
'     Log("Monochrome: " & GPU.Monochrome)
'     Log("NumberOfColorPlanes: " & GPU.NumberOfColorPlanes)
'     Log("NumberOfVideoPages: " & GPU.NumberOfVideoPages)
'     Log("PNPDeviceID: " & GPU.PNPDeviceID)
'     Log("PowerManagementCapabilities: " & GPU.PowerManagementCapabilities)
'     Log("PowerManagementSupported: " & GPU.PowerManagementSupported)
'     Log("ProtocolSupported: " & GPU.ProtocolSupported)
'     Log("ReservedSystemPaletteEntries: " & GPU.ReservedSystemPaletteEntries)
'     Log("SpecificationVersion: " & GPU.SpecificationVersion)
'     Log("Status: " & GPU.Status)
'     Log("StatusInfo: " & GPU.StatusInfo)
'     Log("SystemCreationClassName: " & GPU.SystemCreationClassName)
'     Log("SystemName: " & GPU.SystemName)
'     Log("SystemPaletteEntries: " & GPU.SystemPaletteEntries)
'     Log("TimeOfLastReset: " & GPU.TimeOfLastReset)
'     Log("VideoArchitecture: " & GPU.VideoArchitecture)
'     Log("VideoMemoryType: " & GPU.VideoMemoryType)
'     Log("VideoMode: " & GPU.VideoMode)
'     Log("VideoModeDescription: " & GPU.VideoModeDescription)
'     Log("VideoProcessor: " & GPU.VideoProcessor)
' Next
' </code>
Public Sub ComputerGetVideoControllers As List
	Dim res As List
	res.Initialize
	For Each m As Map In GetWmiData("Win32_VideoController")
		Dim t As CompInfo_VideoController
		t.Initialize
		t.Name = GetStr(m, "Name")
		t.AcceleratorCapabilities = GetStr(m, "AcceleratorCapabilities")
		t.AdapterCompatibility = GetStr(m, "AdapterCompatibility")
		t.AdapterDACType = GetStr(m, "AdapterDACType")
		t.Description = GetStr(m, "Description")
		t.AdapterRAM = GetLng(m, "AdapterRAM")
		t.Availability = GetStr(m, "Availability")
		t.CapabilityDescriptions = GetStr(m, "CapabilityDescriptions")
		t.ColorTableEntries = GetStr(m, "ColorTableEntries")
		t.ConfigManagerErrorCode = GetStr(m, "ConfigManagerErrorCode")
		t.ConfigManagerUserConfig = GetStr(m, "ConfigManagerUserConfig")
		t.CreationClassName = GetStr(m, "CreationClassName")
		t.CurrentBitsPerPixel = GetInt(m, "CurrentBitsPerPixel")
		t.CurrentHorizontalResolution = GetInt(m, "CurrentHorizontalResolution")
		t.CurrentNumberOfColors = GetStr(m, "CurrentNumberOfColors")
		t.CurrentNumberOfColumns = GetStr(m, "CurrentNumberOfColumns")
		t.CurrentNumberOfRows = GetStr(m, "CurrentNumberOfRows")
		t.CurrentRefreshRate = GetInt(m, "CurrentRefreshRate")
		t.CurrentScanMode = GetStr(m, "CurrentScanMode")
		t.CurrentVerticalResolution = GetInt(m, "CurrentVerticalResolution")
		t.DeviceID = GetStr(m, "DeviceID")
		t.DeviceSpecificPens = GetStr(m, "DeviceSpecificPens")
		t.DitherType = GetStr(m, "DitherType")
		t.DriverDate = GetStr(m, "DriverDate")
		t.DriverVersion = GetStr(m, "DriverVersion")
		t.ErrorCleared = GetStr(m, "ErrorCleared")
		t.ErrorDescription = GetStr(m, "ErrorDescription")
		t.ICMIntent = GetStr(m, "ICMIntent")
		t.ICMMethod = GetStr(m, "ICMMethod")
		t.InfFilename = GetStr(m, "InfFilename")
		t.InfSection = GetStr(m, "InfSection")
		t.InstalledDisplayDrivers = GetStr(m, "InstalledDisplayDrivers")
		t.LastErrorCode = GetStr(m, "LastErrorCode")
		t.MaxMemorySupported = GetStr(m, "MaxMemorySupported")
		t.MaxNumberControlled = GetStr(m, "MaxNumberControlled")
		t.MaxRefreshRate = GetStr(m, "MaxRefreshRate")
		t.MinRefreshRate = GetStr(m, "MinRefreshRate")
		t.Monochrome = GetStr(m, "Monochrome")
		t.NumberOfColorPlanes = GetStr(m, "NumberOfColorPlanes")
		t.NumberOfVideoPages = GetStr(m, "NumberOfVideoPages")
		t.PNPDeviceID = GetStr(m, "PNPDeviceID")
		t.PowerManagementCapabilities = GetStr(m, "PowerManagementCapabilities")
		t.PowerManagementSupported = GetStr(m, "PowerManagementSupported")
		t.ProtocolSupported = GetStr(m, "ProtocolSupported")
		t.ReservedSystemPaletteEntries = GetStr(m, "ReservedSystemPaletteEntries")
		t.SpecificationVersion = GetStr(m, "SpecificationVersion")
		t.Status = GetStr(m, "Status")
		t.StatusInfo = GetStr(m, "StatusInfo")
		t.SystemCreationClassName = GetStr(m, "SystemCreationClassName")
		t.SystemName = GetStr(m, "SystemName")
		t.SystemPaletteEntries = GetStr(m, "SystemPaletteEntries")
		t.TimeOfLastReset = GetStr(m, "TimeOfLastReset")
		t.VideoArchitecture = GetStr(m, "VideoArchitecture")
		t.VideoMemoryType = GetStr(m, "VideoMemoryType")
		t.VideoMode = GetStr(m, "VideoMode")
		t.VideoModeDescription = GetStr(m, "VideoModeDescription")
		t.VideoProcessor = GetStr(m, "VideoProcessor")
		t.AsMap = m
		res.Add(t)
	Next
	Return res
End Sub

' Retrieves actual 64-bit GPU info bypassing WMI's 4GB limit, filtering out virtual adapters.
' Example:
' <code>
' For Each GPU As RealGPUInfo In CI.ComputerGetGPUInfo
'     Log("GPU Name: " & GPU.Name)
'     Log("Provider: " & GPU.ProviderName)
'     Log("Driver Version: " & GPU.DriverVersion)
'     Log("VRAM (Bytes): " & GPU.VRAMBytes)
' Next
' </code>
Public Sub ComputerGetGPUInfo As List
	Dim res As List
	res.Initialize
	
	Dim psCommand As String
	Dim localScript As String = "Get-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\00*' -ErrorAction SilentlyContinue | Select-Object @{Name='Name';Expression={$_.DriverDesc}}, DriverVersion, ProviderName, @{Name='VRAMBytes';Expression={$_.'HardwareInformation.qwMemorySize'}} | Where-Object { $_.Name -ne $null }"
	
	If ComputerName = "localhost" Or ComputerName = "127.0.0.1" Then
		psCommand = localScript & " | ConvertTo-Json -Compress"
	Else
		' Wraps the command for remote execution
		psCommand = $"Invoke-Command -ComputerName ${ComputerName} -ScriptBlock { ${localScript} } | ConvertTo-Json -Compress"$
	End If
	
	Dim shl As Shell
	shl.Initialize("shl", "powershell.exe", Array As String("-Command", psCommand))
	Dim shlRes As ShellSyncResult = shl.RunSynchronous(15000)
	
	If shlRes.Success And shlRes.StdOut.Trim <> "" Then
		Dim jp As JSONParser
		jp.Initialize(shlRes.StdOut.Trim)
		Try
			Dim rootList As List
			Try
				rootList = jp.NextArray
			Catch
				rootList.Initialize
				jp.Initialize(shlRes.StdOut.Trim)
				rootList.Add(jp.NextObject)
			End Try
			
			For Each m As Map In rootList
				Dim gpuName As String = GetStr(m, "Name")
				Dim vram As Long = GetLng(m, "VRAMBytes")
				
				Dim isVirtual As Boolean = False
				Dim nameLower As String = gpuName.ToLowerCase
				
				If nameLower.Contains("remote display") Or nameLower.Contains("basic display") Or _
				   nameLower.Contains("virtual") Or nameLower.Contains("hyper-v") Then
					isVirtual = True
				End If
				
				If gpuName <> "" And isVirtual = False And vram > 0 Then
					Dim t As GPUInfo
					t.Initialize
					t.Name = gpuName
					t.DriverVersion = GetStr(m, "DriverVersion")
					t.ProviderName = GetStr(m, "ProviderName")
					t.VRAMBytes = vram
					t.AsMap = m
					res.Add(t)
				End If
			Next
		Catch
			Log("Error parsing Real GPU JSON: " & LastException.Message)
		End Try
	End If
	
	Return res
End Sub
' Converts raw bytes into a human-readable formatted string (KB, MB, GB, TB)
Public Sub FormatBytes (Bytes As Long) As String
	If Bytes < 1024 Then Return Bytes & " B"
	If Bytes < 1048576 Then Return NumberFormat2(Bytes / 1024, 1, 2, 2, False) & " KB"
	If Bytes < 1073741824 Then Return NumberFormat2(Bytes / 1048576, 1, 2, 2, False) & " MB"
	If Bytes < 1099511627776 Then Return NumberFormat2(Bytes / 1073741824, 1, 2, 2, False) & " GB"
	Return NumberFormat2(Bytes / 1099511627776, 1, 2, 2, False) & " TB"
End Sub