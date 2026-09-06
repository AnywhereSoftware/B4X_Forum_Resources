###  xfood HTML Report Generator (Tanuzzu Report) v2 by Xfood
### 09/02/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171945/)

Good morning. I am pleased to present my first B4X library for generating visual reports. The report generation component is written in HTML and produces a JSON file for use in your B4X applications; this allows you to manage your reports visually—adjusting fields, margins, fonts, etc.—without altering the code. Simply generate the new JSON file, and you're all set.  
As shown here, the report can be generated in either PDF or HTML format.  
  

```B4X
'Genera l'HTML (per anteprima/stampa via browser)  
    Dim html As String = rep.RenderToHTML  
    File.WriteString(File.DirApp, "ReportOutput.html", html)  
  
    'Genera il PDF nativo  
    Dim pdf As String = rep.RenderToPDF  
    File.WriteString(File.DirApp, "ReportOutput.pdf", pdf)
```

  
  
Feel free to use it as you see fit, and—if you deem it appropriate—to make any necessary customizations and modifications.  
P.S. If you consider this a truly valuable solution, a donation here would be appreciated (though not mandatory):  
[we offer a coffee to a friend](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2QZD3ZXPHMCNJ)  
  
Hi friends, with the help of AI, I’ve created an HTML report generator that saves a JSON file. In theory, it can be used with any program, including B4X. I’ve attached a simple example that reads the `report.json` file from B4X (specifically B4J) and generates the report (creating an HTML report page that can then be printed or managed however you like).  
  
If anyone wants to improve it, I’m attaching everything here:  
  
1) Added calculated fields  
  
2) UI/layout improvements  
  
3) And much more  
  
4) Added Undo and Redo buttons, plus various fixes to the xFood\_ReportDesigner.html report generator.  
![](https://www.b4x.com/android/forum/attachments/173376)  
  
  
![](https://www.b4x.com/android/forum/attachments/173337)  
![](https://www.b4x.com/android/forum/attachments/173338)  
  
  
![](https://www.b4x.com/android/forum/attachments/173339)