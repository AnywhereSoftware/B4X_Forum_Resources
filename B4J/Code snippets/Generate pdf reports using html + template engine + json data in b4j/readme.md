### Generate pdf reports using html + template engine + json data in b4j by andrewmp
### 04/14/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/129724/)

We had a client that insisted on using a specific font in reports - we initially tried PDFjet but it was not clear if the original library which dates back to 2014 needed work and anyway we did not feel like forking out $295 to try (open source ver. is limited).  
  
So we came up with this free solution using <https://wkhtmltopdf.org/> and <https://github.com/janl/mustache.js/> , no need for a http server as it executes locally (command line)  
  
Install instuctions :  
  
1) Install wkhtmltopdf on your system<https://wkhtmltopdf.org/downloads.html>  
2) Make a folder called reports and put in the files included in the report folder in the zip  
3) Modify paths in program to suit (specifically path to wkhtmltopdf "c:\program files\wkhtmltopdf\bin\wkhtmltopdf.exe")  
  
You will need to activate the jShell, Json and Javaobject libraries.  
  
Json data is created in the program and exported to render.js , report.html is the report that you can modify to suit json data using mustache.js template engine rules.  
  
Hope it's useful to someone, feel free to modify and make it neater/better.