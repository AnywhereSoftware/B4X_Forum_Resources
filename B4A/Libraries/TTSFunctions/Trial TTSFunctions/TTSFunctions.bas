B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim lSpeak As List
	
	Dim bok_synthsized As Boolean = False
End Sub


#Region Subs For Public Use

'Get the names, packages and default state (if the tts is default) of the TTSs
'Uses TTS Lib, Reflection Lib, Phone Lib
Sub GetTTSNamesAndPackages(t As TTS) As List
	Starter.sSub = "TTSFunctions.GetTTSNamesAndPackages"
	
	Dim r As Reflector
	Dim pm As PackageManager
	Dim l As List
	l.Initialize
	r.Target = t
	Dim engines As List = r.RunMethod("getEngines")
	For Each o As Object In engines
		Dim m As Map
		m.Initialize
		r.Target = o
		m.Put("TTSPackage", r.GetField("name"))
		m.Put("TTSName", pm.GetApplicationLabel(r.GetField("name")))
		Dim sBool As String
		If r.GetField("name") = GetDefaultEngine(t) Then sBool = "true" Else sBool = "false"
		m.Put("IsDefaultTTS", sBool)
		'Log(m)
		l.Add(m)
	Next
	Return l
End Sub


'Set TTS engine by packagename
'Uses Reflection Lib, TTS Lib
Sub SetEngineByPackage(sPackage As String, t As TTS) As TTS
	Starter.sSub = "TTSFunctions.SetEngineByPackage"
	
	Dim r As Reflector
	r.Target = t
	'Log("Setting Engine " & sPackage & " as default.")
	r.RunMethod2("setEngineByPackageName", sPackage, "java.lang.String")
	Return t
End Sub

'Open the Text to speech engine settings to set what you want
Sub StartTextToSpeechSettings
	Starter.sSub = "TTSFunctions.StartTextToSpeechSettings"
	Dim i As Intent
	i.Initialize("com.android.settings.TTS_SETTINGS", "")
	StartActivity(i)
End Sub


'Check if TTS is speaking
'Uses JavaObject Lib, TTS Lib
Sub IsTTSSpeaking(t As TTS) As Boolean
	Starter.sSub = "TTSFunctions.IsTTSSpeaking"
	Dim jTTS As JavaObject = t 
	Return jTTS.RunMethod("isSpeaking", Null) 
End Sub

'Get Default Engine of TTS
'Uses JavaObject Lib, TTS Lib
Sub GetDefaultEngine(t As TTS) As String
	Starter.sSub = "TTSFunctions.GetDefaultEngine"
	Dim jTTS As JavaObject = t
	Return jTTS.RunMethod("getDefaultEngine", Null)
End Sub

'Get max input length of TTS
'Uses JavaObject Lib, TTS Lib
Sub GetMaxInputLength(t As TTS) As Long
	Starter.sSub = "TTSFunctions.GetMaxInputLength"
	Dim jTTS As JavaObject = t
	Return jTTS.RunMethod("getMaxSpeechInputLength", Null)
End Sub


'TTS - synthesize to file
'Uses JavaObject Lib, TTS Lib, RuntimePermissions Lib
Sub SynthesizeToFile(t As TTS, subFolderToPutTheFile As String, filename As String, textToSpeak As String) As ResumableSub
	
	Dim jo2 As JavaObject
	jo2.InitializeStatic(Application.PackageName & ".ttsfunctions")
	jo2.RunMethod("initttstofile", Array(t))
	
	bok_synthsized = False
	
	Starter.sSub = "TTSFunctions.SynthesizeToFile"
	Dim p4 As Phone
	Dim xui As XUI
	If p4.SdkVersion <=29 Then
		Dim jo As JavaObject = t
		Dim m As JavaObject
		
		m.InitializeNewInstance("java.util.HashMap", Null)
		jo.RunMethod("synthesizeToFile", Array(textToSpeak, m, File.Combine(xui.Defaultfolder, subFolderToPutTheFile), filename))
		
	Else

		Dim jo As JavaObject = t
		
		Dim fl As JavaObject
		
		
		fl.InitializeNewInstance("java.io.File", Array(File.Combine(xui.DefaultFolder, subFolderToPutTheFile), filename))
		
		Dim bnd As JavaObject
		bnd.InitializeNewInstance("android.os.Bundle", Null)
		
		
		jo.RunMethod("synthesizeToFile", Array(textToSpeak, bnd, fl, filename))

		Do While bok_synthsized = False
			Sleep(500)
		Loop
		
	End If
	
	
	Return True
End Sub


#if JAVA

public static void initttstofile(android.speech.tts.TextToSpeech textToSpeech){

        textToSpeech.setOnUtteranceProgressListener( 
		
		   new 	android.speech.tts.UtteranceProgressListener() {
            @Override
            public void onStart(String s) {
                
            }

            @Override
            public void onDone(String s) {
        		_bok_synthsized = true;
            }

            @Override
            public void onError(String s) {
        		
            }
		
		 }
		 
		 );

}
#End If


'Play synthesized File From TTS
'Uses RuntimePermissions Lib
Sub PlaySynthesizedFile(subFolderWhereTheFileIsLocated As String, fileName As String)
	Starter.sSub = "TTSFunctions.PlaySynthesizedFile"
	Dim mp As MediaPlayer
	Dim rp As RuntimePermissions
	mp.Initialize
	If subFolderWhereTheFileIsLocated = File.DirAssets Then
		mp.Load(subFolderWhereTheFileIsLocated, fileName)
	Else
		Dim xui As XUI
		mp.Load(File.Combine(xui.DefaultFolder, subFolderWhereTheFileIsLocated), fileName)
	End If
	mp.Play
End Sub

'Get all available languages of the TTS
'Uses Reflection Lib, JavaObject Lib
Sub GetListOfAvailableLanguages(sPackage As String) As ResumableSub
	Starter.sSub = "TTSFunctions.GetListOfAvailableLanguages"
	'Requires API 21 (Android 5.0) and above
	'It is called like this:
	'wait for (TTSFunctions.GetListOfAvailableLanguages) Complete (sLangs As String)
	'manipulate the sLangs variable
	Dim r As Reflector
	Dim jo As JavaObject
	jo.InitializeStatic(Application.PackageName & ".ttsfunctions")
	jo.RunMethod("InitTTS", Array As Object(r.GetContext, sPackage))
	Sleep(2000)
	Return jo.RunMethod("GetLanguages", Null)
End Sub

'Speaks long texts more than MaxLength of TTS
'Uses TTS Lib, Phone Lib
Sub SpeakLongText(t As TTS, TextToSpeak As String)
	Starter.sSub = "TTSFunctions.SpeakLongText"
	
	Try
		GetLongTextDevisions(t, TextToSpeak, GetTTSCurrentLocale(t))
		
		t.Speak(lSpeak.Get(0), True)
		For ii = 1 To lSpeak.Size - 1
			t.Speak(lSpeak.Get(ii), False)
		Next
	Catch
		'Log(LastException)
	End Try
End Sub


'Stops the speaking of long texts more than MaxLength of TTS
'Uses TTS Lib
Sub StopSpeakingLongText(t As TTS)
	Starter.sSub = "TTSFunctions.StopSpeakingLongText"
	t.Speak(" ", True)
	t.Stop
End Sub


'Set a voice to the TTS
'Uses TTS Lib, JavaObject Lib
Sub SetVoice(t As TTS, Voice As String)
	Starter.sSub = "TTSFunctions.SetVoice"
	Dim jt As JavaObject = t
	
	Dim sVcSpecs() As String = Regex.Split("~", Voice)
	
	Dim sVcLastSpec As String = sVcSpecs(5)
	sVcLastSpec = sVcLastSpec.Replace("[","").Replace("]","").Replace(" ","")
	Dim sVcFeatures() As String = Regex.Split(",", sVcLastSpec)
	
	Dim jk As JavaObject
	jk.InitializeStatic(Application.PackageName & ".ttsfunctions")
	
	'CreateTheVoice will return a Voice object
	jt.RunMethodJO("setVoice", Array(jk.RunMethod("CreateTheVoice", Array(Regex.Split("_",sVcSpecs(0)), sVcSpecs(1), sVcSpecs(2), sVcSpecs(3), sVcSpecs(4), sVcFeatures))))
End Sub

'Get Voices of Current Engine of TTS with option to get the voices of current locale only.
'Uses JavaObject Lib, TTS Lib
Sub GetVoices(t As TTS, OnlyCurrentLocale As Boolean) As ResumableSub
	Starter.sSub = "TTSFunctions.GetVoices"
	
	Dim jTTS As JavaObject = t
	Dim obj As Object = jTTS.RunMethod("getVoices", Null)
	
	LogColor(obj,Colors.Red)
	Dim jk As JavaObject
	jk.InitializeStatic(Application.PackageName & ".ttsfunctions")
	Return FilterVoices(t, jk.RunMethod("getVcs", Array(obj)), OnlyCurrentLocale)
End Sub

'Gets the current locale of the TTS
'Uses JavaObject Lib, TTS Lib, Phone Lib
Sub GetTTSCurrentLocale(t As TTS) As String
	Starter.sSub = "TTSFunctions.GetTTSCurrentLocale"
	
	Dim ph As Phone
	Dim jt As JavaObject = t
	If ph.SdkVersion < 21 Then
		Return jt.RunMethod("getLanguage", Null)
	Else
		Return jt.RunMethodJO("getVoice", Null).RunMethod("getLocale", Null)
	End If
End Sub




#End Region


#Region Java Code


#IF JAVA
	
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.speech.tts.Voice;
import java.util.Locale;
import java.util.Set;
import java.util.Arrays;
import android.content.Context;
import java.util.HashSet;

public static String sLangs;
public static TextToSpeech tts;


public static void InitTTS(Object objcon, Object pack) {
    Context context = (Context) objcon;
    String sPackage = (String) pack;

	if (sPackage=="") {
		tts = new TextToSpeech(context, new OnInitListener(){
	        @Override
	        public void onInit(int status) {

	        };
	    });
	}
	else{
		tts = new TextToSpeech(context, new OnInitListener(){
	        @Override
	        public void onInit(int status) {

	        };
	    }, sPackage);
	}
};


public static String GetLanguages() {
    Set<Locale> loc = tts.getAvailableLanguages();
	Object[] objloc = loc.toArray();
    sLangs = Arrays.toString(objloc);
	return sLangs;
};


public static Voice CreateTheVoice(String[] sLoc, String sNam, String sQual, String sLatency, String sNetReq, String[] sFeat) {
    Set<String> feats = new HashSet<String>();
	for (int ii=0; ii < sFeat.length; ii++){
		feats.add(sFeat[ii]);
		};
	int qual = Integer.parseInt(sQual);
	int laten = Integer.parseInt(sLatency);
	boolean bReqNet = Boolean.parseBoolean(sNetReq);
	Locale loc;
	if (sLoc.length == 1) {
		loc = new Locale(sLoc[0], "");
	} else {
		loc = new Locale(sLoc[0], sLoc[1]);
	};
	return new Voice(sNam, loc, qual, laten, bReqNet, feats);
};


public static String[] getVcs(Object objvcs) {
	    
        Set<Voice> svcs;
		svcs = (Set<Voice>)objvcs;
		
        Object[] vcs = svcs.toArray();
	    
		String[] sVCName;
		sVCName = new String[vcs.length];
	    
		int iCount=0;
	    for (Object vc : vcs)
            {
				Voice tempVC = (Voice)vc;
				sVCName[iCount]=tempVC.getLocale() + "~" + tempVC.getName() + "~" + tempVC.getQuality() + "~" + tempVC.getLatency() + "~" + tempVC.isNetworkConnectionRequired() + "~" + tempVC.getFeatures();
		  		iCount = iCount+1;
            }
	    return sVCName;
        };
	
#End If

#End Region


#Region Subs For Internal use

Private Sub FilterVoices(t As TTS, s2() As String, OnlyCurrentLocale As Boolean) As String()
	Starter.sSub = "TTSFunctions.FilterVoices"
	If OnlyCurrentLocale = False Then
		Return s2
	Else
		Dim sCurLoc As String = GetTTSCurrentLocale(t)
		Dim l As List
		l.Initialize
		For ii = 0 To s2.Length - 1
			If s2(ii).StartsWith(sCurLoc) Then
				l.Add(s2(ii))
			End If
		Next
		Dim s3(l.Size) As String
		For ii = 0 To l.Size - 1
			s3(ii) = l.Get(ii)
		Next
		Return s3
	End If
End Sub


Private Sub GetLongTextDevisions(t As TTS, TextToSpeak As String, sLang As String)
	
	Starter.sSub = "TTSFunctions.GetLongTextDevisions"
	
	If lSpeak.IsInitialized = False Then lSpeak.Initialize
	lSpeak.Clear	
	
	

    Dim sDelimeter As String


    TextToSpeak = TextToSpeak.Trim


    Select Case sLang.Substring2(0, 3)
        Case "ja", "zh"
            sDelimeter = "。"
        Case Else
            sDelimeter = "."
    End Select

    If TextToSpeak.EndsWith(sDelimeter) = False Then
        TextToSpeak = TextToSpeak & sDelimeter
    End If
	


    Select Case sLang.Substring2(0, 3)
        Case "ja", "zh"
            Dim iU As Int
            iU = 0
            'Dim iEnd As Integer = 800
            Dim iCount As Int = 0
            Dim bExit As Boolean = False
            Dim iU2 As Int
            iU2 = iU

            Do While True

                For ii = 1 To 3
                    If iU2 + 1 > TextToSpeak.Length - 1 Then
                        bExit = True
                        Exit
                    End If
                    iU2 = TextToSpeak.IndexOf2(sDelimeter, iU2 + 1)
                Next

				If iU2+1 = TextToSpeak.Length Then
					lSpeak.Add(TextToSpeak.Substring2(iU, iU2 + 1))
				Else
					lSpeak.Add(TextToSpeak.Substring2(iU, iU2 + 2))
				End If
				
                iCount = iCount + 1
                iU = iU2 + 1
                If bExit = True Then Exit 
            Loop

        Case Else

            Dim iU As Int
            iU = 0
			Dim iMaxLength As Long = GetMaxInputLength(t)
			Dim iEnd As Int = iMaxLength
            Dim iCount As Int = 0
            Dim bExit As Boolean = False
            Dim iU2 As Int
            Do While True

                If iEnd > TextToSpeak.Length - 1 Then
                    iEnd = TextToSpeak.Length - 1
                    bExit = True
                End If

                iU2 = TextToSpeak.LastIndexOf2(sDelimeter, iEnd) 'Τελευταία εμφάνιση του delimiter

                Dim iEndL As Long
				If iU2+1 = TextToSpeak.Length Then
					iEndL = iU2 + 1
				Else
					iEndL = iU2 + 2
				End If
				
                lSpeak.Add(TextToSpeak.Substring2(iU, iEndL))
                iCount = iCount + 1
                iU = iU2 + 1
				iEnd = iU2 + 1 + iMaxLength
                If bExit = True Then Exit 
            Loop

    End Select
	
End Sub

#End Region






