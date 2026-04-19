###  ErrorAnalyzer -Turn  Error Logs Into a Call History with Actual B4X Source Line Numbers and Text by William Lancee
### 04/17/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/170836/)

Recently I have been looking at #Macros, and then a few days ago there was a post about error reports.  
It occurred to me that a faster way to find the source of errors is possible.  
Introducing "errorAnalyzer"…  
  
1. Add errorAnalyzer.jar to your Additional folder  
  
2. Add this macro to your project (Main or B4XMainPage). This will add a button to the top of the IDE.  
 #Macro: Title, Error Analyzer, ide://run?File=%ADDITIONAL%\errorAnalyzer.jar&Args=%PROJECT%  
   
3. When an error occurs and you want to see the calling history of the error:  
 Just copy all from the log, errorAnalyzer will find the error at the end of the Log.  
   
4. Invoke errorAnalyzer by clicking on the button at top of IDE (or type its shortcut).  
  
5. Paste the contents of the clipboard to the designated area. Press Ready.  
  
6. You'll see the details of the calling history  
  
7. Press X to exit, or Copy to Clipboard. Paste the results at the END OF ANY MODULE (so line numbers aren't changed).  
  
8. Use the included IDE Ctrl Click GoTo links to quickly go to source of error.  
  
  
![](https://www.b4x.com/android/forum/attachments/171175)![](https://www.b4x.com/android/forum/attachments/171176)![](https://www.b4x.com/android/forum/attachments/171179)![](https://www.b4x.com/android/forum/attachments/171178)![](https://www.b4x.com/android/forum/attachments/171177)  
  
The .jar is too large to upload. So here is a Drop Box link - Version 1.02  
<https://www.dropbox.com/scl/fi/nygg34v88pan8i7gaoix1/EAnalyzerV1.02.zip?rlkey=gnydzlzudquuna2qas75nqxab&st=6jrab69p&dl=0>  
  
The jar file is inside the zipped folder EAnalyzer.zip