B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
'
'Author: Starchild Corp, Australia
'Revised: 4/Sep/2019
'
'Completely free and for general use.
'no copyright and no liability.
'
'My Web sites:
'   www.starchild.com.au
'   www.takethis.com.au
'

Sub Class_Globals
	Private reader As TextReader
	Private NextDefaultInputResponse As String
	Private UseDefaultInputResponse As Boolean
End Sub

'Initializes the Class. 
'
'Force this class to fetch default keyboard input
'from the last given Default string.
'
'NB: <UseDefaultInput> is forced TRUE when running
'    in Debug mode.
Public Sub Initialize(UseDefaultInput As Boolean)
	Dim sys As JavaObject
	sys.InitializeStatic("java.lang.System")
	Dim I As InputStream = sys.GetField("in")
	reader.Initialize(I)

#if Debug
	UseDefaultInputResponse = True
#Else
	UseDefaultInputResponse = UseDefaultInput
#End If

	NextDefaultInputResponse = ""
End Sub

'Output <ThisString> to console then move
'cursor to start of next line 
Public Sub Print(ThisString As String)
	PrintString(ThisString & " ")
	LineFeed
End Sub

'Output the <Prompt> then wait for typed string from keyboard.
'Returns: the typed string when the ENTER key is pressed.
Public Sub Input(Prompt As String) As String
	PrintString(Prompt & " ")
	
	If UseDefaultInputResponse Then
		ShortDelay(250)  '1sec delay
		Dim DefaultResponse As String = NextDefaultInputResponse
		NextDefaultInputResponse = ""
		Print(DefaultResponse)
		ShortDelay(1500)
		Return DefaultResponse
	Else
		Try
			Return reader.ReadLine   'get string from keyboard
		Catch
			Log(" ")
			Log(" ")
			Log("============================================")
			Log("??? Can't use the <Input> or <GetKey> functions of")
			Log("??? the MyConsoleClass in RELEASE from the IDE.")
			Log("    ie. No Keyboard for generating Input Response.")
			Log(" ")
			Log("--- For testing, you can run in Debug mode, or")
			Log("--- initialise the MyConsoleClass with the")
			Log("--- parameter, UseDefaultInput=TRUE, and then")
			Log("--- provide Default keyboard responses in the code.")
			Log("--- You must run the Release JAR file inside a Java VM.")
			Log("---      eg.    java -jar yourprogram.jar")
			Log(" ")
			Log(">>> Program has been Terminated.")
			ExitApplication
		End Try
	End If
End Sub

'Returns: a single key press from the keybaord
'Returns: "" if no key was pressed.
'
'NB: non-blocking.
Public Sub GetKey As String
	If UseDefaultInputResponse Then
		ShortDelay(1000)  '1sec delay
		Dim DefaultResponse As String = ""
		If NextDefaultInputResponse.Length > 0 Then
			DefaultResponse = NextDefaultInputResponse.CharAt(0)
		End If
		NextDefaultInputResponse = ""
		Return DefaultResponse
	End If

	If reader.Ready Then
		Dim C() As Char
		reader.Read(C,0,1)  'get single CHR from keyboard
		Return C(0)
	Else
		Return ""
	End If
End Sub

'CRLF to start of next line
Public Sub LineFeed
	PrintString(" " & CRLF)
End Sub

'clear the console screen
Public Sub ClearScreen
	Dim I As Int
	For I = 1 To 50
		Log(" ")
	Next
End Sub

'Print the Prompt but DON'T linefeed.
'Remains at end of printed string.
Public Sub PrintString(Prompt As String)
	Private nativeMe As JavaObject=Me
	nativeMe.RunMethod("javaPrint",Array(Prompt))
End Sub

#If JAVA

public static void javaPrint(String prompt)
{
	System.out.print(prompt);
	System.out.flush();
}
#End IF

'Set the next default input response.
'
'NB: only when this class is initiated with the parameter
'    UseDefaultInput=TRUE, or running in DEGUB mode
Public Sub Default(DefaultFromKeyboard As String)
	NextDefaultInputResponse = DefaultFromKeyboard
End Sub

'blocking for one second
Private Sub ShortDelay(InMsec As Long)
	Dim T As Long = DateTime.Now + InMsec
	Do Until DateTime.Now > T
	Loop
End Sub
