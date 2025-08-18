### maybe not so simple way to clean up texts from wikipedia api by DIYMicha
### 09/21/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/122604/)

this might be far from perfect, but it works well for me. This little routine replaces useful html tags to bb tags, and gets rid of unwanted html tags in fetched wikipedia api texts.  
  

```B4X
Sub CleaningWikipediaText(text As String) As String  
    Dim firststring,laststring As String  
    Dim found As Int  
    Dim endfound As Int  
    Dim foundstring As String  
    Dim liste() As String  
   
    ' list of useful html tags that are converted to bb tags. Watch out for [font=italic][/font] as you have to declare it in your textengine  
    ' same scema: always in pairs of search string, replace string  
    ' 1st escape all opening and closing square brackets in the wiki text, to prevent the app from crashing  
    liste=Array As String("[","[plain][[/plain]","]","[plain]][/plain]","<b>","","</b>","","<i>","[font=italic]","</i>","[/font]","<p>","","</p>",CRLF,"<h1>","[textsize=22]","</h1>","[/textsize]","<h2>","[textsize=20]","</h2>","[/textsize]","<h3>","[textsize=18]","</h3>","[/textsize]")  
    For i = 0 To liste.Length-1 Step 2  
        firststring = liste(i)  
        laststring = liste(i+1)  
        text=text.Replace(firststring,laststring)  
    Next  
   
    ' list of strings of html tags to delete within the main text alwais in pairs of beginning and end of the string  
    ' this is useful for tags like <a href= … > or <span id="something"> can be extended to delete other tags  
    liste = Array As String("<span",">","</span",">","<ul",">","</ul",">","<li",">","</li",">","<cite",">","</cite",">")  
    For  i = 0 To liste.Length-1 Step 2  
        firststring = liste(i)  
        laststring = liste(i+1)  
       
        found = 0  
        Do While found > -1  
            found = text.IndexOf(firststring)  
            If found > -1 Then  
                endfound = text.IndexOf2(laststring,found)+laststring.Length  
                foundstring = text.SubString2(found,endfound)  
                text = text.replace(foundstring,"")  
            End If  
        Loop  
    Next  
    found = 0  
    Do While found > -1                            ' getting rid of redundand blanks  
        found = text.IndexOf("  ")  
        If found > -1 Then  
            text = text.Replace("  "," ")  
        End If  
    Loop  
  
    text = "[Alignment=justify]"&text&"[/alignment]"                                ' Blocksatz - delete if not needed  
   
    Return text  
End Sub
```

  
  
The result is not perfect, and needs a little manual work afterwards, but it's a good beginning. I'm curious for a simpler way to solve this :) And I'm trying to get rid of redundant trippled or more line feeds.