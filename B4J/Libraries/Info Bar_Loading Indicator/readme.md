### Info Bar/Loading Indicator by Guenter Becker
### 10/01/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168879/)

Name: GBEInfoBar  
Version: 1.5  
Language: B4J  
Licence: Royalty Free  
(C)  
Soundfiles Royalty Free taken from pixabay.com  
Additional lib Royalty Free taken from Anywhere Forum  
  
This Custom View may be used as an Info Bar to show App Process Information tu the user by code.  
  
![](https://www.b4x.com/android/forum/attachments/167482)  
Features:  

- GUI customizable
- Inbuild Progressbar
- Flashing Message
- Inbuild Loading Indicator (spinner)
- Inbuild Beep/Alarm Sound

  
**Properties:**  
'## Function: create/show/update progressbar  
'## Parameter: Progress in Percent, color Barcolor, Text labeltext  
**ProgBar**(Progress As Int, color As Int, Text As String)  
'# if label text endet with % it will be shown as *Text Progress%* like ABC 25%  
  
'## Function: activate/stop beep sound  
'## Parameter: 0 = Stop, 1-3 = play, 1 Beep A, 2 Beep B, 3 Alarm  
**Beep**(Number As Int)  
  
'## Function: show label text  
**Text**(Text As String)  
  
'## Function: activate/stop flashing label text  
'## Parameter: Activate True=stop=false  
**Flash**(Activate As Boolean)  
  
'## Function: show/hide loading indicator  
'## Parameter: Activate True=show hide=false  
**LOI**(Activate As Boolean)  
  
'## Function: play beep  
'## Parameter: 0 = Stop, 1-3 = play, 1 Beep A, 2 Beep B, 3 Alarm  
**DoBeep**(No as int)  
  
**Custom Click Event by click on the message:**  
GBEInfoBar1\_Clicked  
  
**See Setup and usage as shown in attached Example Project. Notice needed libraries.  
Example Project including CustomView as Class-Module in clear code.**  
  
![](https://www.b4x.com/android/forum/attachments/167486)