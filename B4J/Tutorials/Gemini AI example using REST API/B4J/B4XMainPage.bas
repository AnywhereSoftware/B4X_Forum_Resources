B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private GeminiApiKey As String
	Private txtPrompt As TextArea
	Private txtResponse As TextArea
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	B4XPages.SetTitle(Me, "B4J Gemini")
	DateTime.DateFormat = "yyyy-MM-dd_HHmmss"
	If File.Exists(File.DirApp, "env.txt") = False Then
		File.WriteMap(File.DirApp, "env.txt", CreateMap("GEMINI_API_KEY": "AIzaxxxxxxxxxxxxxxxxxxxxxxx"))
	End If
	' REMEMBER DON'T SHARE YOUR API KEY!!!
	Dim env As Map = File.ReadMap(File.DirApp, "env.txt")
	GeminiApiKey = env.Get("GEMINI_API_KEY")
	If GeminiApiKey = "AIzaxxxxxxxxxxxxxxxxxxxxxxx" Then
		txtResponse.Text = $"Please edit your GEMINI_API_KEY"$
	End If
	txtPrompt.Text = "How to implement Gemini in B4J?"
	txtPrompt.SetSelection(txtPrompt.Text.Length, txtPrompt.Text.Length)
End Sub

Private Sub btnSend_Click
	QueryGemini(txtPrompt.Text, GeminiApiKey)
End Sub

' 1. Define the Sub to call Gemini
Sub QueryGemini (Prompt As String, ApiKey As String)
    ' Define the model - You can change gemini-1.5-flash to gemini-pro if needed
    Dim Model As String = "gemini-2.5-flash" 
    Dim URL As String = $"https://generativelanguage.googleapis.com/v1beta/models/${Model}:generateContent?key=${ApiKey}"$

    ' 2. Prepare the JSON Payload
    ' Structure: { "contents": [ { "parts": [ { "text": "..." } ] } ] }
    Dim PartMap As Map
    PartMap.Initialize
    PartMap.Put("text", Prompt)
    
    Dim PartsList As List
    PartsList.Initialize
    PartsList.Add(PartMap)
    
    Dim ContentMap As Map
    ContentMap.Initialize
    ContentMap.Put("parts", PartsList)
    
    Dim ContentsList As List
    ContentsList.Initialize
    ContentsList.Add(ContentMap)
    
    Dim RootMap As Map
    RootMap.Initialize
    RootMap.Put("contents", ContentsList)

    Dim JSONGen As JSONGenerator
    JSONGen.Initialize(RootMap)
    Dim JsonBody As String = JSONGen.ToString

    ' 3. Make the Request
    Dim Job As HttpJob
    Job.Initialize("GeminiJob", Me)
    Job.PostString(URL, JsonBody)
    Job.GetRequest.SetContentType("application/json")

	txtResponse.Text = "Please wait..."
    ' 4. Wait for Response
    Wait For (Job) JobDone(Job As HttpJob)
    If Job.Success Then
        Try
            ' 5. Parse the Response
            Dim Parser As JSONParser
            Parser.Initialize(Job.GetString)
            Dim RootMap As Map = Parser.NextObject
            
            ' Navigate down: candidates -> content -> parts -> text
            Dim Candidates As List = RootMap.Get("candidates")
            If Candidates.IsInitialized And Candidates.Size > 0 Then
                Dim FirstCandidate As Map = Candidates.Get(0)
                Dim Content As Map = FirstCandidate.Get("content")
                Dim Parts As List = Content.Get("parts")
                Dim FirstPart As Map = Parts.Get(0)
                
                Dim ResponseText As String = FirstPart.Get("text")
                Log("Gemini Response: " & ResponseText)
                
				txtResponse.Text = ResponseText
                ' If this is a server handler, write response back to client here
                ' resp.Write(ResponseText)				
            End If
        Catch
            Log("Error parsing JSON: " & LastException)
        End Try
    Else
        Log("Network Error: " & Job.ErrorMessage)
        Log("Response: " & Job.GetString) ' Print server error details
    End If
    
    Job.Release
End Sub

Private Sub btnSave_Click
	If txtResponse.Text.Length = 0 Then Return
	Dim timestamp As String = DateTime.Date(DateTime.Now)
	Dim content As String = $"Prompt: ${CRLF}${txtPrompt.Text}${CRLF}${CRLF}Response: ${CRLF}${txtResponse.Text}"$
	File.WriteString(File.DirApp, $"response_${timestamp}.txt"$, content)
	xui.MsgboxAsync($"Response saved to response_${timestamp}.txt"$, "")
End Sub