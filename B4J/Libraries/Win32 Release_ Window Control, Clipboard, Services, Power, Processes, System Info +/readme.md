### Win32 Release: Window Control, Clipboard, Services, Power, Processes, System Info + by Peter Simpson
### 02/23/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170394/)

Hello everyone,  
Yet another library from early last year whilst I was trying to learn more about B4X libraries. This is not converted from an existing library, all methods were written from scratch. I created this library for myself, as I was creating a personal app and needed three or four of these functions. After finishing my personal project, I crazily decided to expand the functinality of the library.  
  
This library provides a broad and practical collection of Win32 functionality for B4J developers who want deeper access to the Windows platform without writing native code. It is built on top of JNA and exposes a clean, consistent set of methods that cover window management, clipboard access, system information, power control, services, input simulation and more. The aim is to make common Windows tasks simple to call from B4J while keeping everything reliable and easy to integrate.  
  
The library includes full support for working with windows, monitors and the desktop environment. You can retrieve titles, handles and class names, move and resize windows, control visibility and topmost state, and enumerate all visible windows. It also provides access to screen metrics, taskbar information and monitor layouts, which makes it useful for multi screen applications and layout aware tools (I believe).  
  
Beyond window control, the library offers a wide range of system level features. These include clipboard text handling, registry access under HKCU, environment variables, file attributes, process information, system uptime, memory statistics and power management commands. There is also support for Windows services, allowing you to check for service existence and query service status directly from B4J.  
  
The goal of this release is to give B4J developers a dependable and well structured way to interact with Windows at a low level while keeping the code readable and straightforward. You can focus on building your application rather than dealing with native API details.  
  
**Please note:**  
Some functions may trigger Windows security prompts or require elevated permissions depending on system configuration. This is normal behaviour for certain Win32 APIs.  
  
**SS\_Win32**  
  
**Author:** Peter Simpson  
**Version:** 1.0  

- **Win32**

- **Fields:**

- **SC\_MONITORPOWER** As Int

- **Functions:**

- **AllowSleep**
*Clears sleep prevention.*- **BringToFront** (hwndValue As Long) As Boolean
*Brings a window to the foreground using its handle.*- **CloseWindow** (hwndValue As Long)
*Closes a window (sends WM\_CLOSE).*- **EnumWindowsTitles** As String()
*Enumerates top-level windows and returns their titles as an array.*- **FileExists** (path As String) As Boolean
*Checks if a file exists.*- **FlashWindow** (hwndValue As Long, count As Int)
*Flashes a window in the taskbar.*- **GetActiveWindowClass** As String
*Returns the class name of the active window.*- **GetActiveWindowHandle** As Long
*Returns the handle (pointer value) of the active window.*- **GetActiveWindowTitle** As String
*Returns the title of the current foreground window.*- **GetAppDataFolder** As String
*Returns the AppData folder path.*- **GetAvailablePhysicalMemoryMB** As Long
*Returns available physical memory in MB.*- **GetBatteryPercent** As Int
*Returns battery percentage (0-100) or -1 if unknown.*- **GetClipboardText** As String
*Gets text from the clipboard.  
 Returns empty string if unavailable.*- **GetCurrentPID** As Int
*Returns the current process ID.*- **GetDefaultGateway** As String
*Returns the default IPv4 gateway by parsing 'route print'.*- **GetDesktopFolder** As String
*Returns the Desktop folder path.*- **GetDesktopRect** As Int()
*Returns the desktop rectangle. [left, top, right, bottom]*- **GetDiskSpace** (path As String) As String
*Returns disk space info for a path: "freeMB,totalMB,usableMB".*- **GetDocumentsFolder** As String
*Returns the Documents folder path.*- **GetEnv** (name As String) As String
*Gets an environment variable value.*- **GetFileAttributes** (path As String) As Int
*Returns file attributes as a bitmask.*- **GetInterfaceAddresses** (interfaceName As String) As String()
*Returns IP addresses for a given interface name.*- **GetInterfaceIPv4** (interfaceName As String) As String
*Returns the first IPv4 address for a specific interface name.*- **GetIPAddress** As String
*Returns the first non-loopback IPv4 address, or empty string if none found.*- **GetIPAddresses** As String()
*Returns all non-loopback IPv4 addresses.*- **GetMACAddress** As String
*Returns the MAC address of the first active IPv4 interface.*- **GetMonitorCount** As Int
*Returns the number of monitors.*- **GetMonitorRects** As Int()
*Returns monitor rectangles as [ [l,t,r,b], … ].*- **GetNetworkInterfaces** As String()
*Returns a list of network interfaces as "Name:DisplayName".*- **GetParentPID** As Int
*Returns the parent process ID.*- **GetProcessList** As String()
*Returns a list of processes as "PID:Name".*- **GetProcessMemoryMB** (pid As Int) As Int
*Returns memory usage (MB) of a process by PID, or -1 if unavailable.*- **GetProcessorCount** As Int
*Returns the number of processors.*- **GetScreenHeight** As Int
*Returns the primary screen height.*- **GetScreenWidth** As Int
*Returns the primary screen width.*- **GetSystemBootTime** As String
*Returns system boot time as a formatted string.*- **GetSystemCPUUsage** As Int
*Returns accurate system-wide CPU usage percentage (0–100).*- **GetSystemDirectory** As String
*Returns the system directory path.*- **GetSystemUptime** As Long
*Returns system uptime in milliseconds.*- **GetTaskbarRect** As Int()
*Returns the taskbar rectangle. [left, top, right, bottom] or zeros if not found.*- **GetTotalPhysicalMemoryMB** As Long
*Returns total physical memory in MB.*- **GetWindowClass** (hwndValue As Long) As String
*Returns the class name of a window by handle.*- **GetWindowExStyle** (hwndValue As Long) As Int
*Gets the extended window style (GWL\_EXSTYLE).*- **GetWindowRect** (hwndValue As Long) As Int()
*Returns the rectangle of a window.  
 [left, top, right, bottom]*- **GetWindowsDirectory** As String
*Returns the Windows directory path.*- **GetWindowStyle** (hwndValue As Long) As Int
*Gets the window style (GWL\_STYLE).*- **GetWorkAreaHeight** As Int
*Returns the work area height (excluding taskbar).*- **GetWorkAreaWidth** As Int
*Returns the work area width (excluding taskbar).*- **Hibernate**
*Hibernates the system.*- **IsInterfaceUp** (interfaceName As String) As Boolean
*Returns whether the interface is up.*- **KeyDown** (vk As Int)
*Sends a key down event.*- **KeyUp** (vk As Int)
*Sends a key up event.*- **LockWorkstation**
*Locks the workstation (same as Win+L).*- **MaximiseWindow** (hwndValue As Long)
*Maximises a window.*- **MinimiseWindow** (hwndValue As Long)
*Minimises a window.*- **MonitorOff**
*Turns the monitor off.*- **MonitorOn**
*Turns the monitor on.*- **MouseClick**
*Sends a left mouse click.*- **MouseMove** (dx As Int, dy As Int)
*Moves the mouse by dx, dy relative to current position.*- **MouseRightClick**
*Sends a right mouse click.*- **MouseWheel** (delta As Int)
*Scrolls the mouse wheel by the given delta (positive = up, negative = down).*- **MoveWindow** (hwndValue As Long, x As Int, y As Int, width As Int, height As Int, repaint As Boolean)
*Moves and resizes a window.*- **PreventSleep**
*Prevents system sleep until cleared.*- **RegDeleteKey** (key As String)
*Deletes a key from HKCU.*- **RegDeleteValue** (key As String, valueName As String)
*Deletes a value from HKCU.*- **RegKeyExists** (key As String) As Boolean
*Checks if a key exists in HKCU.*- **RegReadBinary** (key As String, valueName As String) As Byte()
*Reads a binary value from HKCU.*- **RegReadDword** (key As String, valueName As String) As Int
*Reads a DWORD value from HKCU.*- **RegReadString** (key As String, valueName As String) As String
*Reads a string value from HKCU.*- **RegWriteBinary** (key As String, valueName As String, value As Byte())
*Writes a binary value to HKCU.*- **RegWriteDword** (key As String, valueName As String, value As Int)
*Writes a DWORD value to HKCU.*- **RegWriteString** (key As String, valueName As String, value As String)
*Writes a string value to HKCU.*- **Restart**
*Restarts Windows.*- **RestoreWindow** (hwndValue As Long)
*Restores a window.*- **RunAsAdmin** (command As String) As Boolean
*Runs a command with UAC elevation (Run as Administrator).*- **RunCommand** (command As String) As Boolean
*Runs a command using cmd.exe /c (like Windows Run dialog).*- **RunGetOutput** (command As String) As String
*Runs a command and returns its stdout output as a string.*- **RunHidden** (command As String) As Boolean
*Runs a command hidden (no console window).*- **RunWait** (command As String) As Int
*Runs a command and waits for it to finish.  
 Returns exit code.*- **RunWaitGetOutput** (command As String) As String
*Runs a command, waits for it to finish, and returns its stdout output.*- **RunWaitGetOutputFull** (command As String) As String
*Runs a command, waits for it to finish, and returns both output and exit code.*- **SendKey** (vk As Int)
*Sends a single key press (virtual key code).*- **ServiceExists** (serviceName As String) As Boolean
*Returns true if a service exists.*- **ServiceGetStatus** (serviceName As String) As String
*Returns the status of a service as a string.*- **ServiceStart** (serviceName As String) As Boolean
*Starts a service.*- **ServiceStop** (serviceName As String) As Boolean
*Stops a service.*- **SetClipboardText** (text As String) As Boolean
*Sets text to the clipboard.*- **SetEnv** (name As String, value As String) As Boolean
*Sets an environment variable value for the current process.*- **SetFileAttributes** (path As String, attrs As Int) As Boolean
*Sets file attributes (bitmask).*- **SetTopMost** (hwndValue As Long, topMost As Boolean)
*Sets or clears the topmost flag for a window.*- **SetWindowExStyle** (hwndValue As Long, style As Int)
*Sets the extended window style (GWL\_EXSTYLE).*- **SetWindowStyle** (hwndValue As Long, style As Int)
*Sets the window style (GWL\_STYLE).*- **ShellOpen** (target As String) As Boolean
*Opens a file or URL with the default associated application.*- **ShowInExplorer** (path As String)
*Shows a file in Explorer (selects it).*- **Shutdown**
*Shuts down Windows.*- **Sleep**
*Puts the system to sleep.*
  
The attached example will start notepad (in two different ways), cmd window, and the calculator.  
  
  
**Enjoy…**