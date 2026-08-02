### B4J - Oshi Monitor (CPU, RAM, GPU, Battery, M/B, display, etc) by Peter Simpson
### 07/28/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170272/)

Hello everyone,  
This is a library I use all the time. My own personal monitoring app is built on it, and it lets me keep an eye on individual running processes and their resources with ease. I personally use this application to monitor CPU and RAM resources for the processes of large bespoke applications that I've developed for clients. I used to rely on another excellent B4J library, but unlike that one, this library does not require administrator privileges.  
  
Oshi Monitor is a lightweight B4J library built on top of the OSHI hardware‑inspection framework. It gives your B4J apps real‑time access to system metrics such as CPU load, RAM usage, CPU temperature (where applicable), and per‑process resource consumption, GPU model and RAM, Battery capacity and usage state, main board model and bios version, sound card and virtual memory, OS name, version and build, plus much more.  
  
The library runs its own background thread, raises regular update events, and includes optional smoothing, maximum value tracking, and multi-process aggregation (useful for apps like Chrome).  
  
You can monitor the whole system or target a specific process by name, with events for CPU, RAM, temperature (where applicable), and process appearance or termination. It also exposes helper methods for listing running processes and retrieving total memory information.  
  
This library is ideal for dashboards, diagnostics tools, performance monitors, or any B4J app that needs live system statistics with minimal overhead.  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/169842)  
  
**PLEASE NOTE:**  
To run the attached example, you will **NEED** to download and install Erel's jGuages library from [**HERE…**](https://www.b4x.com/android/forum/threads/jgauges.70538/)  
  
**Monitoring all (idle) system resource usage:**  
![](https://www.b4x.com/android/forum/attachments/169859)  
  
**Monitoring chrome 3 x 4K tabs resource usage:**  
![](https://www.b4x.com/android/forum/attachments/169867)  
  
**Monitoring its own resources usage:**  
![](https://www.b4x.com/android/forum/attachments/169843)  
  
**Monitoring B4J resources usage:  
![](https://www.b4x.com/android/forum/attachments/169840)  
  
Selecting a currently running process:  
![](https://www.b4x.com/android/forum/attachments/169841)  
  
SS\_OshiMonitor  
  
Author:** Peter Simpson  
**Version:** 1.1  

- **OshiMonitor**
*OshiMonitor library for B4J.  
 Uses the OSHI library to monitor CPU, RAM, and Temperature.*

- **Events:**

- **BatteryCharging** (Value As Boolean)
- **BatteryWatts** (Value As Double)
- **CpuTemp** (Value As Double)
- **CpuUsage** (Value As Double)
- **ProcessCpuUsage** (Value As Double)
- **ProcessFound** (Name As String)
- **ProcessRamUsage** (Value As Double)
- **ProcessRamUsageMB** (Value As Double)
- **ProcessTerminated** (Name As String)
- **RamUsage** (Value As Double)
- **RamUsageMB** (Value As Double)
- **Updated** (Stats As Map)

- **Fields:**

- **Debug** As Boolean
*Enables diagnostic logging.  
 When true internal debug messages are written to the B4J log.*
- **Functions:**

- **GetBatteryCharging** As Boolean
*Returns true if the battery is currently charging, false otherwise.*- **GetBatteryCurrentCapacity** As Double
*Returns the current battery capacity in mAh.*- **GetBatteryDesignCapacity** As Double
*Returns the battery design capacity in mAh.*- **GetBatteryWatts** As Double
*Returns the current power usage in watts as reported by the battery controller.  
 Note: When plugged in, this reflects the charge rate; when on battery,   
 this reflects the total system power draw.*- **GetBiosVersion** As String
*Returns the system BIOS or firmware version string.*- **GetCpuVoltage** As Double
*Returns the current CPU voltage in volts.*- **GetCurrentPowerWatts** As Double
*Returns the current power usage in watts as reported by the battery controller.  
 Note: When plugged in, this reflects the charge rate; when on battery,   
 this reflects the total system power draw.*- **GetDisplays** As List
*Returns a list containing information about connected displays.*- **GetDriveLatency** (index As Int) As Double
*Returns the average I/O latency in milliseconds for a specific drive index.  
 Latency = (Total Time Spent / Total Operations)*- **GetFanSpeeds** As Int()
*Returns an array containing the current speed of each system fan in RPM.*- **GetGraphicsCards** As List
*Returns a List containing the name and video memory size of each graphics card.*- **GetInterfaceTrafficSpeed** (index As Int) As Double()
*Returns a custom result object (or array) with current traffic speeds   
 in Bytes per second for a specific interface.*- **GetLogicalDrives** As List
*Returns a list containing space and mount point information for logical drives.*- **GetLogicalProcessorCount** As Int
*Returns the total number of logical processors (threads).*- **GetMostActiveInterfaceIndex** As Int
*Returns the index of the network interface with the highest combined   
 Traffic (received + sent) since system boot.*- **GetMotherboardModel** As String
*Returns the motherboard or baseboard model name.*- **GetNetworkInDrops** (index As Int) As Long
*Returns the number of inbound packets dropped for a specific interface index.*- **GetNetworkInErrors** (index As Int) As Long
*Returns the number of inbound errors for a specific interface index.*- **GetNetworkInterfaceNames** As java.util.List
*Returns a list of names of all network interfaces.*- **GetNetworkIPv4Addresses** As List
*Returns a list containing the IPv4 addresses for each active network interface.*- **GetNetworkIPv6Addresses** As List
*Returns a list containing the IPv6 addresses for each active network interface.*- **GetNetworkOutErrors** (index As Int) As Long
*Returns the number of outbound errors for a specific interface index.*- **GetOSBuild** As String
*Returns the exact build number of the current operating system.*- **GetOSName** As String
*Returns the full family and description name of the operating system.*- **GetPhysicalCoreCount** As Int
*Returns the number of physical CPU cores.*- **GetProcessDetails** (processName As String) As Map
*Returns a map containing detailed information about a specific process by its name.*- **GetProcessorLoad** As Double()
*Returns an array of CPU load percentages for each individual logical processor.*- **GetProcessorName** As String
*Returns the processor name from the system.*- **GetProcessPeakMemory** (processName As String) As Long
*Returns the peak resident set size (physical memory) used by a process in bytes.*- **GetRefreshRate** As Int
*Returns the current refresh rate of the primary display in Hz.  
 Returns 0 if the refresh rate is unknown or cannot be determined.*- **GetSoundCards** As List
*Returns a list containing the names of active sound cards or audio interfaces.*- **GetSwapTotal** As Long
*Returns the total swap file size in bytes.*- **GetSwapUsed** As Long
*Returns the currently used swap file size in bytes.*- **GetSystemModel** As String
*Returns the physical computer system model name.*- **GetSystemUptimeHours** As Double
*Returns the system uptime in hours.*- **GetSystemUptimeMinutes** As Double
*Returns the system uptime in minutes.*- **GetSystemUptimeSeconds** As Long
*Returns the system uptime in seconds.*- **GetTotalBytesForInterface** (index As Int) As Long
*Returns the total bytes (received + sent) for a specific network interface.*- **GetTotalBytesRead** As Long
*Returns total bytes read across all disks since system boot.*- **GetTotalBytesReceived** As Long
*Returns the number of bytes received across all network interfaces.*- **GetTotalBytesSent** As Long
*Returns the number of bytes sent across all network interfaces.*- **GetTotalBytesWritten** As Long
*Returns total bytes written across all disks since system boot.*- **GetTrackedPeakMemory** (processName As String) As Long
*Returns the highest combined resident set size (physical memory) used by all instances   
 of a specific process name since the application started monitoring.*- **GetUsbDevices** As List
*Returns a list containing the names of connected USB devices.*- **GetVirtualMemoryTotal** As Long
*Returns the total virtual memory in bytes.*- **GetVirtualMemoryUsed** As Long
*Returns the currently used virtual memory in bytes.*- **HasCpuTemp** As Boolean
*Returns true if CPU temperature monitoring is supported.*- **Initialize** (EventName As String)
*Initializes the monitor and prepares OSHI hardware access.*- **IsCharging** As Boolean
*Checks if the primary battery is currently charging.  
 Return true if charging, false otherwise.*- **IsInitialized** As Boolean
*Returns true if the object has been initialized and not yet killed.*- **IsLaptopByBattery** As Boolean
*Returns true if the system appears to be a laptop based on battery presence.*- **Kill**
*Kills the ba object reference to free memory and stops the thread cleanly.  
 After calling this, IsInitialized will return false.*- **ListProcesses** As List
*Returns a List of unique running process names, sorted A-Z.*- **ResetMaximums**
*Resets the tracked maximum CPU and RAM values for the system to zero.*- **ResetProcessMaximums**
*Resets the tracked maximum CPU and RAM values for the target process to zero.*- **Start**
*Starts the background monitoring thread.  
 Raises Updated, CpuUsage, CpuTemp and RamUsage events at the configured interval.*- **Stop**
*Stops the monitoring thread.  
 The object remains initialized and can be restarted with Start.*
- **Properties:**

- **CpuTemp** As Double [read only]
*Returns CPU temperature in C.*- **CpuUsage** As Double [read only]
*Returns CPU usage as a percentage.*- **IntervalMs** As Int [write only]
*Sets the update interval in milliseconds.  
 Values lower than 100ms are clamped to 100ms.*- **MaxCpuUsage** As Double [read only]
*Returns the highest CPU usage recorded since start or reset.*- **MaxProcessCpuUsage** As Double [read only]
*Returns the highest Process CPU usage recorded since the process was targeted or reset.*- **MaxProcessRamUsage** As Double [read only]
*Returns the highest Process RAM usage percentage recorded.*- **MaxProcessRamUsageMB** As Double [read only]
*Returns the highest Process RAM usage in megabytes recorded.*- **MaxRamUsage** As Double [read only]
*Returns the highest RAM usage percentage recorded since start or reset.*- **MaxRamUsageMB** As Double [read only]
*Returns the highest RAM usage in megabytes recorded since start or reset.*- **PowerUsageWatts** As Double [read only]
*Gets the current power usage in watts.  
 Return Watts being used or supplied.*- **ProcessCpuUsage** As Double [read only]
*Returns CPU usage for the configured target process as a percentage.*- **ProcessRamUsage** As Double [read only]
*Returns RAM usage for the configured target process as a percentage of total system RAM.*- **ProcessRamUsageMB** As Double [read only]
*Returns RAM usage for the configured target process in megabytes.*- **RamTotal** As Long [read only]
*Returns total physical memory in bytes.*- **RamTotalGB** As Double [read only]
*Returns total physical memory in gigabytes.*- **RamTotalMB** As Double [read only]
*Returns total physical memory in megabytes.*- **RamUsage** As Double [read only]
*Returns RAM usage as a percentage.*- **RamUsageMB** As Double [read only]
*Returns used RAM in megabytes.*- **TargetProcessName** As String
*Returns the current target process name.  
 Returns an empty string if no process is configured.*
  
**PLEASE NOTE:   
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE** - Download Extra Libraries](https://www.dropbox.com/scl/fi/xxyuxu8uu32j51yy8nr4h/Oshi-Monitor.zip?rlkey=n1kck43cnre55mh1u0kbyxf6x&st=ywbrv14n&dl=0) <<<<<<<<<<<<<<<<<<<<<<<<  
  
D = 148 + 132  
  
**Enjoy…**