B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'esprtc_livecounter module name

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Public LiveCounter As ULong
End Sub

Sub Read_livecounter
	RunNative("rtccount", Null)
	Log("LiveCounter = " , LiveCounter)
	'testing
	Delay(2000)
	others.Go_Sleep(2000)	'RunNative("esprestart", Null)
End Sub


#if C
static RTC_NOINIT_ATTR ulong counter = 0;

void rtccount(B4R::Object* u) {
esp_reset_reason_t reason = esp_reset_reason();
if ((reason != ESP_RST_DEEPSLEEP) && (reason != ESP_RST_SW))
{
  counter = 0;
}
counter++;
b4r_esprtc_livecounter::_livecounter = counter;
}

void esprestart(B4R::Object* u) {
esp_restart();
}

#end if
