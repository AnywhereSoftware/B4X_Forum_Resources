examples of typical usage:

to save synthesized audio to a file:
	Dim rawpcm() As Byte = ttsextras.RawAudio
	Log("raw audio: " & rawpcm.Length)
	dim filename as string = "ASSIGN_SOME_NAME.wav"

	save to safedirdefaultexternal:	
	Dim rp As RuntimePermissions
	Dim fname As String = File.Combine(rp.GetSafeDirDefaultExternal(""),filename)
				
	ttsextras.saveToDisk(filename, rawpcm)
	wait for tssextras_writingdone(msg As String)
	Log("on saving event: " & msg)

	save to system Audio/MediaStore:
	ttsextras.saveToDisk2(filename, rawpcm)
	wait for ttsextras_writingdone(msg As String)
	Log("on saving event: " & msg)
---------------------------------------------------------------------------
to set a voice (eg, from a listview of voices):
	voicename = ttsextras.getVoiceName( Value )
	Log(voicename)
	Log("setting voice to: " & Value)
	ttsextras.Voice = Value
---------------------------------------------------------------------------
to speak a text string:
	ttsextras.speak( textstring )
	if you're using a file, you need to load its text to a string first.
---------------------------------------------------------------------------
initialize ttsextras (on resume):
	If ttsextras.isInitialized = False Then
		ttsextras.Initialize("ttsextras")
		Wait For ttsextras_complete (Success As Boolean)
		Log("ttsextras initialiezed: " & Success)
	End If
---------------------------------------------------------------------------
release ttsextras (on pause):
	If ttsextras.isInitialized Then
		ttsextras.release
	End If
---------------------------------------------------------------------------
to save raw pcm audio bytes to a file:
	Dim rawpcm() As Byte = ttsextras.RawAudio
	Log("raw audio: " & rawpcm.Length)
	If rawpcm.Length > 0 Then
		ttsextras.rawAudio2Files( rawpcm, "rawpcm.pcm")
		wait for ttsextras_writingdone(msg As String)
		Log(msg)
	end if
---------------------------------------------------------------------------

load a list of voices currently supported:
	voices = ttsextras.Voices
	If voices = Null Then
		Sleep(1000)
		voices = ttsextras.Voices
	End If
---------------------------------------------------------------------------	

anatomy of a voice:
	a voice is an object (javaobject). it's what you use to communicate with the tts engine. its only use to us is its name (a string) and its locale (where it is primarily used).
	voice attributes also include latency and quality.  for latency, the lower the value, the better.  for quality, the higher the value returned, the better.
	oddly, all the voices on my device were rated "high" (i guess they're leaving room open for "very high" some day).
	in order to find out which language it represents and the country where it is spoken, you need its locale.
	in order to know how the voice sounds is to listen to it.  you can then build a little database to help you recognize a voice by its name.

	in other words:
	dim voices() as Object = ttsextras.Voices

	For Each voice As JavaObject In voices
		Dim voicename As String = ttsextras.getVoiceName(voice)
		Dim locale As JavaObject = ttsextras.getLocale(voice)
		Dim country As String = ttsextras.getDisplayCountry( locale )
		Dim displayLanguage As String = ttsextras.getDisplayLanguage(locale)
		Dim quality as String = ttsextras.getQuality(voice)
		Dim latency as String = ttsextras.getLatency(voice)
		Dim features As String = ttsextras.getFeatures( voice )
		If features.Contains("notInstalled") Then
			log("this voice is not installed")  ' i skip over such voices
		End If
	next

