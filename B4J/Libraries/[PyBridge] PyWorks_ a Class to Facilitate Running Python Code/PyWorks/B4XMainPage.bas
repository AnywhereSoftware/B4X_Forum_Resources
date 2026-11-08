B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests
'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

'I Recommend disabling "Auto Format when Pasting" in Tools->IDE Options - you can always us Alt F to format all B4X code
'However the 'check" method of PyWorks will automatically undo wrongly capitalized keywords shared by B4X and Python

'In this demo, I have copied the Log output as a corresponding comment following each example.

Sub Class_Globals
	Private Root As B4XView		'ignore
	Private xui As XUI
	Private pw As PyWorks
	Private filesDir As String
End Sub

Public Sub Initialize
	filesDir = File.DirApp
	filesDir = filesDir.SubString2(0, filesDir.LastIndexOf("\")) & "\Files"
End Sub

'This is a demo Python session of 8 Example scripts - Python Global variables are retained during a session
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	pw.Initialize(Me, False)		'Verbose=False hides most confirmatory logs, but still shows the Python output and error logs.
	Wait for (pw.connect) Complete (OK As Boolean)
	If Not(OK) Then ExitApplication		'If OK and Verbose=True, a list of scripts in storage will show in log file
	Log(pw.kernel)  'a global variable
																	
'Example 1: Execute as script for it's 'effect': pw.exe  (no arguments, no return value)
	logHead(1)
	Dim script As String = $"
TestVarName1 = "a test"	  # an example of a global variable
print("Hello World #1")
	"$
	Wait For (pw.clean(script)) Complete (script As String)
	Wait For (pw.exec(script)) Complete (Success As Boolean)
	pw.show(script)
	
	pw.clipboard(script)
'#__________ anon_68702 __________
'TestVarName1 = "a test"	
'print("Hello World #1")
'	

'Example 2: Execute as script for it's 'result': pw.call (0,1,2, ... arguments, return value as Object)
	logHead(2)
	'This example has 4 syntax errors - can you spot them? They are all fixed by 'clean'
	Dim script As String = $"
	TestVarName2 = "a test"
	Def TryThis():
	    Print("Hello World #2")
		TheTruth = True
		
		# since this sub has a message to return - this will just show when it is done
		Return "The print output is in the queue - it will show in B4X Logs later"
"$
	Wait For (pw.clean(script)) Complete (script As String)
	Wait For (pw.call(script, Array())) Complete (obj As Object)
	Log(obj)
'The print output is in the queue - it will show in B4X Logs later in light blue


'Example 3: Track python logs synchronously, 'blog' instead of 'print'
	logHead(3)
	Dim script As String = $"
	blog("Hello")
	blog("World")
"$
	Wait For (pw.clean(script)) Complete (script As String)
	Wait For (pw.exec(script)) Complete (Success As Boolean)
	Wait For (pw.blogs) Complete (Success As Boolean)
'Hello
'World


'Example 4: Installs a package in same location as kernel. If it is already installed - takes time but no harm done	
	logHead(4)
	'Wait For (pw.install("pandas")) Complete (Success As Boolean)


'Example 5: Create a pandas dataframe as a global variable - to be used later
	logHead(5)
	Log("!!!Note: the earlier print outputs of example 1 and example 2 should still show up soon")
	Dim script As String = $"
import pandas As pd
data = {
    'first_name': ['John', 'Andrew', 'Maria', 'Helen'],
    'last_name': ['Brown', 'Purple', 'White', 'Blue'],
    'age': [25, 48, 76, 19]
}
df = pd.DataFrame(data)
"$
	Wait For (pw.clean(script)) Complete (script As String)
	Wait For (pw.exec(script)) Complete (Success As Boolean)
	

'Example 6: List global user defined variable names, in this case we are interested in 'df'
	logHead(6)
	Wait For (pw.names) Complete (obj As Object)
	Log(obj)
'(ArrayList) [varnames, TestVarName1, anon_1, TestVarName2, TryThis, anon_2, pd, data, df, anon_3]


'Example 7: Use a previously created dataframe as a global variable 'df' and send a query
	logHead(7)
	Dim script As String = $"
def getColumn(cname):
	global df
	Return Df[cname].to_list()
"$
	Wait For (pw.clean(script)) Complete (script As String)
	Dim pdColumn As String = script
	pw.show(pdColumn)

	Wait For (pw.call(pdColumn, Array("first_name"))) Complete (obj As Object)
	Log(obj)
'[John, Andrew, Maria, Helen]

'Example 8: Time to execute 1000 calls to pdColumn = 366 msecs (Release mode)
	logHead(8)
	Dim markTime As Long = DateTime.Now
	For i = 1 To 1000
		Wait For (pw.call(pdColumn, Array("age"))) Complete (obj As Object)
	Next
	Log(DateTime.Now - markTime)

'Example 9: If you try to clean a script that already exists, the process will fail - same as in B4X
	'You can call a 'cleaned' def (the last def in a script) as many times as you need. However, the script will not be re-registered.
	'The first copy will be used. You can't modify an existing script at runtime.
	'You can start a new session (disconnect and re- connect).  This will clear all registered scripts. 

	logHead(9)
	'Note: Python names can start with underline
	Dim script As String = $"
	test = 1
	def _dummy_1():
		return test
"$
	Wait For (pw.clean(script)) Complete (script As String)
	Wait For (pw.call(script, Array())) Complete (obj As Object)
	Log(obj)
	'1

	Dim script As String = $"
	test = 2
	def _Dummy_1():
		return test
"$
	Wait For (pw.clean(script)) Complete (script As String)
	'Error: Dummy already exists as dummy
	'Job Terminated
	'Change _Dummy_1 to _Dummy_2 and see if it runs!
	
	Wait For (pw.call(script, Array())) Complete (obj As Object)
	Log(obj)
	'2
	
	
	pw.disconnect
End Sub

Private Sub logHead(number As Int)
	Log(TAB)
	LogColor($"Example ${number} ______________________________________"$, xui.Color_RGB(0, 170, 0))
End Sub
