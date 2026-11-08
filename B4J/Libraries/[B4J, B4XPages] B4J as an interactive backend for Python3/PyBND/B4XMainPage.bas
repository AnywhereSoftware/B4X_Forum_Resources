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

Sub Class_Globals
	Private Root As B4XView	'ignore
	Private xui As XUI
	Private Py As PyUDP
	Private SP As SimpleXYPlot
End Sub

Public Sub Initialize
	SP.Initialize
	Py.Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.AddPageAndCreate("SP", SP)
	B4XPages.AddPageAndCreate("Py", Py)
	Wait for Py_Ready
	Sleep(0)
	B4XPages.ShowPage("Py")

	Dim x As String = "5,7,8,7,2,17,2,9,4,11,12,9,6"
	Dim y As String = "99,86,87,88,111,86,103,87,94,78,77,85,86"

'Do Fibonacci sequence
	Py.Run($"
# Fibonacci numbers module
import sys
def fib(n):
	result = []
	a, b = 0, 1
	while a < n:
		result.append(a)
		a, b = b, a+b
	return result

print(fib(100))
print(fib(200))
print(fib(300))
print("")
"$)
	wait for Py_Complete

'Withoutout killing Py do Linear Regression
	Py.Run($"
# Linear Regression Module
import numpy as np
from scipy import stats

x = np.array([${x}])
y = np.array([${y}])
n = x.size

slope, intercept, r, p, std_err = stats.linregress(x, y)
print("n, intercept, slope, r, p")
print( n, intercept, slope, r, p, sep=", ")
	"$)
	wait for Py_Complete
	
	plotResults(x, y, Py.GetResults)

	Py.Kill
End Sub

'draw simple XY plot
Private Sub plotResults(x As String, y As String, mp As Map)  'ignore
	SP.drawXY(x, y)
	SP.drawRegression(mp.Get("intercept"), mp.Get("slope"))
	Dim r As Float = mp.Get("r")
	SP.addTitle("Fig 1. Best-fit Line to Data Points")
	SP.addSubTitle($"[n=${mp.Get("n")};  r=$1.3{r};  r${Chr(0x00B2)}=$1.3{Power(r, 2)};  p=$1.3{mp.Get("p")}]"$)
	SP.addYLabel("Y - Axis")
	SP.addXLabel("X - Axis")
	B4XPages.ShowPage("SP")
	Py.PlotButton("Plot")
End Sub

Public Sub ShowResultRequest
	B4XPages.ShowPage("SP")
End Sub

'Make sure to kill PyUDP on closing app
Private Sub B4XPage_CloseRequest As ResumableSub
	Py.Kill
	Return True
End Sub
