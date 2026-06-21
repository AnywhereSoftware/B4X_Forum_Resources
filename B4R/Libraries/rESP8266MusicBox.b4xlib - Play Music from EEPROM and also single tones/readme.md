### rESP8266MusicBox.b4xlib - Play Music from EEPROM and also single tones. by hatzisn
### 06/18/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/171315/)

With this library you can play music from the eeprom and download music to save it to eeprom (in order to play it) - code for downloading is not included because of course it is site dependant (music plays in a passive buzzer). The music must be in the form byte(ii)=0-89 and byte(ii+1)\*40 = milliseconds of duration. This pattern repeats for all notes. The 0 to 89 value is the note where 47 has the frequency of 440Hz and going down the frequency is [2^(-x/12)] \* 440 and going up the frequency is [2^(x/12)] \* 440Hz where x=1,2,3,4…. Frequency 440 corresponds to note A above middle C. A value of 0 for the note means it is pause. Also byte(0) and byte(1) in EEPROM is the length of the track which Length = byte(0)\*255+byte(1). Then from byte(2) and above are the notes in the previous mentioned format. The music can be saved in any position of the EEPROM and then byte(0) is saved in this position - so it is {position in EEPROM}+0. You just have to pass the initial position as a parameter.  
  
You can also play single tones.  
  

```B4X
ESP8266MusicBox.Play(D2, 440, 1000)
```