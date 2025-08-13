### B4X - OpenAI - a class to work with OpenAI in your B4X-Project by DonManfred
### 04/08/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160256/)

This clas is based on the work of [USER=115614]@Abdull Cadre[/USER] and [USER=68345]@JackKirk[/USER].  
  
I got addicted and played a bit with OpenAI and added some Methods from the Api. ?  
I also added the functionality in my Discord-Bot in my racing-league.  
  
I would like to share the actual class here and also i try to give some help in implementing this Class.  
  
  
Note that i developed the Class using B4J and use Windows-Path for the downloadfolder. change them to Androidspecific folders like File.DirInternal.  
  
ATTENTION: Please note that OpenAI is **not a free service** if you want to use the Api, want to use your own Assistants.  
  
Add a Environmentvariable OpenAItoken containing your ApiKey to your system. The ApiKey is read from Environment when Initializing the Class  
  
Add the class to your project and Initialize it  

```B4X
    Public AI As OpenAI  
    AI.Initialize("org-Ucp") ' Set your OrganisationID here  
    AI.Assistant = "asst_TQ…" ' Set your AssistantID here if you want to use the Assistant-API  
    AI.Logfilepath = "C:\ORCBot\logs\OpenAI" ' Set logfilepath to a working path for logfiles. Set it to "" to disable logging
```

  
  
  
Class Methods:  
- CreateAssistant  
- CreateAssistantFile  
- ModifyAssistant  
- ListAssistants  
- ListAssistantFiles  
- UploadFile  
- RetrieveMessage  
  
- ChatCompletion  
- CreateThread  
- CreateRun  
- RetrieveRun  
- ListRunSteps  
- CreateThreadAndRun  
   
- createTranscription  
- createSpeech  
  
- QueryImage