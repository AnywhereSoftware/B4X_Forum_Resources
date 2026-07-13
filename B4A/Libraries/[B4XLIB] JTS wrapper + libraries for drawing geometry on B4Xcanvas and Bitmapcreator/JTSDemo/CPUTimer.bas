B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@






'Class module
'Accumulates CPU time (thread CPU time) and elapsed wall time across multiple
'Start/Stop pairs. Designed for per-frame instrumentation: call Start at the
'beginning of the work to measure and Stop at the end; totals accumulate.
'
'CPU time excludes time the thread spends blocked/idle (e.g. waiting on a
'background thread), so it isolates real UI-thread work from wait time.
'
'Platform behaviour:
' - B4A (Android): android.os.Debug.threadCpuTimeNanos, nanosecond granularity.
' - B4J on Linux/macOS: ThreadMXBean.getCurrentThreadCpuTime, sub-microsecond.
' - B4J on Windows: QueryThreadCycleTime via JNA, ~100ns granularity.
'   Falls back to ThreadMXBean (15.6ms granularity) if JNA is unavailable.
'
'NOTE (B4J): ThreadMXBean is reached through the inline-Java helpers at the
'bottom of this module rather than through JavaObject reflection. The concrete
'implementation (sun.management.ThreadImpl) lives in a non-exported JDK module,
'so reflective invocation throws InaccessibleObjectException on Java 9+. Calling
'the methods from Java source compiles to an interface dispatch against the
'public, exported java.lang.management.ThreadMXBean, which has no access check
'and needs no --add-opens / --add-exports VM arguments.
Sub Class_Globals
	Private mStartElapsedNs As Long
	Private mStartCpuNs As Long
	Private mTotalElapsedNs As Long
	Private mTotalCpuUsedNs As Long
	Private mRunning As Boolean
	Private mNestedStartCount As Int
	Private mOrphanStopCount As Int

	'Cached reflection handles — created once to avoid per-call overhead
	'(which would otherwise be counted into the measurement itself).
	Private joSystem As JavaObject
	#If B4A
	Private joDebug As JavaObject
	#Else
	'Wraps Me so we can call the inline-Java ThreadMXBean helpers.
		Private joMe As JavaObject
		Private mCpuSupported As Boolean
	'Windows-specific via JNA. mUseCycleTime gates the path.
		Private mUseCycleTime As Boolean
		Private joKernel32 As JavaObject
		Private joQTCT As JavaObject 'Cached QueryThreadCycleTime Function
		Private joCurrentThreadHandle As JavaObject
		Private joCycleBuf As JavaObject 'long[1] reused per call
		Private mNsPerCycle As Double
		Private const m8L As Long = 8
		Private const m0L As Long = 0
	#End If
End Sub

Public Sub Initialize
	joSystem.InitializeStatic("java.lang.System")
	#If B4A
	joDebug.InitializeStatic("android.os.Debug")
	#Else
		joMe = Me
		mCpuSupported = joMe.RunMethod("cpuSupported", Null)
		If mCpuSupported Then joMe.RunMethod("enableCpu", Null)
		mUseCycleTime = False
		If IsWindows Then TryInitCycleTime
	#End If
	Reset
End Sub

Public Sub Reset
	mStartElapsedNs = 0
	mStartCpuNs = 0
	mTotalElapsedNs = 0
	mTotalCpuUsedNs = 0
	mRunning = False
	mNestedStartCount = 0
	mOrphanStopCount = 0
End Sub

Public Sub Start
	If mRunning Then
		mNestedStartCount = mNestedStartCount + 1
		Return
	End If
	mRunning = True
	mStartElapsedNs = GetSystemNanos
	mStartCpuNs = GetThreadCpuNanos
End Sub

Public Sub Stop
	If Not(mRunning) Then
		mOrphanStopCount = mOrphanStopCount + 1
		Return
	End If
	mRunning = False
	mTotalElapsedNs = mTotalElapsedNs + (GetSystemNanos - mStartElapsedNs)
	Dim cpu As Long = GetThreadCpuNanos
	'Guard against unsupported measurement (-1) which would corrupt the total.
	If cpu >= 0 And mStartCpuNs >= 0 Then
		mTotalCpuUsedNs = mTotalCpuUsedNs + (cpu - mStartCpuNs)
	End If
End Sub

Public Sub TotalElapsedNs As Long
	Return mTotalElapsedNs
End Sub

Public Sub TotalCpuUsedNs As Long
	Return mTotalCpuUsedNs
End Sub

Public Sub NestedStartCount As Int
	Return mNestedStartCount
End Sub

Public Sub OrphanStopCount As Int
	Return mOrphanStopCount
End Sub

'Returns a short description of the CPU measurement method actually in use.
'Useful for logging and tests so you know which backend produced the numbers.
Public Sub MeasurementMethod As String
	#If B4A
	Return "android.os.Debug.threadCpuTimeNanos (Android)"
	#Else
		If mUseCycleTime Then Return "QueryThreadCycleTime (Windows, JNA)"
		If mCpuSupported Then Return "ThreadMXBean.getCurrentThreadCpuTime"
		Return "unsupported"
	#End If
End Sub

#If B4J
Private Sub IsWindows As Boolean
	Dim os As String = joSystem.RunMethod("getProperty", Array("os.name"))
	Return os.ToLowerCase.StartsWith("windows")
End Sub

'Attempts to set up JNA-backed QueryThreadCycleTime. Silently falls back to
'ThreadMXBean if JNA isn't on the classpath or any step fails.
Private Sub TryInitCycleTime
	Try
		Dim joNativeLibrary As JavaObject
		joNativeLibrary.InitializeStatic("com.sun.jna.NativeLibrary")
		joKernel32 = joNativeLibrary.RunMethod("getInstance", Array("kernel32"))

		'GetCurrentThread returns a pseudo-handle; safe to cache.
		Dim fnGetCurrentThread As JavaObject = joKernel32.RunMethod("getFunction", Array("GetCurrentThread"))
		joCurrentThreadHandle = fnGetCurrentThread.RunMethod("invokePointer", Array(Null))

		'Cache the QueryThreadCycleTime Function so the hot path avoids lookup.
		joQTCT = joKernel32.RunMethod("getFunction", Array("QueryThreadCycleTime"))

		'Reusable output buffer for QueryThreadCycleTime (PULONG64).
		Dim joMemory As JavaObject
		joMemory.InitializeNewInstance("com.sun.jna.Memory", Array(m8L))
		joCycleBuf = joMemory

		'Calibrate cycles-per-nanosecond by burning ~50ms of CPU.
		mNsPerCycle = CalibrateNsPerCycle
		If mNsPerCycle > 0 Then mUseCycleTime = True
	Catch
		Log($"CpuTimer: cycle-time path unavailable (${LastException.Message}); using ThreadMXBean."$)
		mUseCycleTime = False
	End Try
End Sub

'Burns CPU for ~50ms wall-time and computes nanoseconds per cycle.
'Returns 0 on failure.
Private Sub CalibrateNsPerCycle As Double
	Dim startNs As Long = GetSystemNanos
	Dim startCycles As Long = ReadCycleCountRaw
	If startCycles < 0 Then Return 0
	Dim x As Double = 1.0001
	Do While GetSystemNanos - startNs < 50000000
		For i = 1 To 100000
			x = x * 1.0000001 + 0.5
		Next
	Loop
	If x = 0 Then Log("never")
	Dim endCycles As Long = ReadCycleCountRaw
	Dim endNs As Long = GetSystemNanos
	Dim dCycles As Long = endCycles - startCycles
	Dim dNs As Long = endNs - startNs
	If dCycles <= 0 Or dNs <= 0 Then Return 0
	Return dNs / dCycles
End Sub

'Reads raw cycle count via QueryThreadCycleTime.
'No Try/Catch: TryInitCycleTime already validated the JNA path (it calls
'this sub during calibration), and the cached handles cannot become invalid.
'A FALSE return from the Win32 call is the only realistic failure mode.
Private Sub ReadCycleCountRaw As Long
	Dim ok As Int = joQTCT.RunMethod("invokeInt", Array(Array As Object(joCurrentThreadHandle, joCycleBuf)))
	If ok = 0 Then Return -1
	Return joCycleBuf.RunMethod("getLong", Array(m0L))
End Sub
#End If

Private Sub GetSystemNanos As Long
	Return joSystem.RunMethod("nanoTime", Null)
End Sub

Private Sub GetThreadCpuNanos As Long
	#If B4A
	Return joDebug.RunMethod("threadCpuTimeNanos", Null)
	#Else
		If mUseCycleTime Then
			Dim c As Long = ReadCycleCountRaw
			If c < 0 Then Return -1
			Return c * mNsPerCycle
		End If
		If mCpuSupported = False Then Return -1
		Return joMe.RunMethod("threadCpuTime", Null)
	#End If
End Sub

'--- Inline Java: ThreadMXBean access without VM args (B4J only) ---
'These compile to direct interface calls on java.lang.management.ThreadMXBean
'(a public, exported type), so they avoid the InaccessibleObjectException that
'reflective JavaObject calls hit against sun.management.ThreadImpl on Java 9+.
'
'Must be wrapped in #If B4J: java.lang.management does not exist on Android,
'so this region has to be excluded from the B4A build.
#If B4J
#If JAVA
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadMXBean;

private static final ThreadMXBean B4X_TMX = ManagementFactory.getThreadMXBean();

public boolean cpuSupported() {
	return B4X_TMX.isThreadCpuTimeSupported();
}

public void enableCpu() {
	if (B4X_TMX.isThreadCpuTimeSupported())
		B4X_TMX.setThreadCpuTimeEnabled(true);
}

public long threadCpuTime() {
	return B4X_TMX.getCurrentThreadCpuTime();
}
#End If
#End If
