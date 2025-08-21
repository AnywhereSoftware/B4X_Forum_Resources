### [BANano] Using an external Editor like WYSIWYG Web Builder with B4J/BANano by alwaysbusy
### 03/23/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/115269/)

WYSIWYG Web Builder (<https://www.wysiwygwebbuilder.com/>) is a cheap Website builder that makes it very easy to make your design. [USER=114867]@Alejandro Moyano[/USER] mentioned it in his post on his history with B4X. This gave me the idea that it could be used to program the logic of such a site using simple B4J code and BANano.  
  
What I did. I'm sure I could expand BANano more to make this process easier. Suggestions are welcome:  
  
1. Build a simple page in the WYSIWYG Web Builder  
2. Saved it to HTML  
3. For all the images, I replace the paths to "./assets/" in the html because this is where BANano gets its assets  
4. Made a new B4J non-UI project  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
    #IgnoreWarnings: 16, 10, 14, 15   
#End Region  
  
Sub Process_Globals  
    Private BANano As BANano 'ignore  
   
    ' dim some elements we will work with  
    Private Button1 As BANanoElement  
    Private Editbox1 As BANanoElement  
End Sub  
  
Sub AppStart (Args() As String)  
    BANano.Initialize("BANano", "BANanoWYSIWYG",1)  
   
    BANano.Header.AddCSSFile("index.css")   
    BANano.Header.AddCSSFile("Untitled1.css")   
       
    BANano.Build(File.DirApp)   
   
    ExitApplication  
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub  
  
' HERE STARTS YOUR APP  
Sub BANano_Ready()  
    ' get the body element  
    Dim body As BANanoElement  
    body.Initialize("#body")  
   
    ' loading the body from the html file that the WYSIWYG Web Builder generated  
    Dim init As BANanoFetchOptions  
    init.Initialize  
    init.Mode = "no-cors"  
   
    Dim response As BANanoFetchResponse  
    Dim Text As String  
   
    ' fetch it with a promise  
    Dim getHTML As BANanoFetch  
    getHTML.Initialize("./assets/index.html", init)  
    getHTML.Then(response)  
        ' got the response, now get the content  
        Return response.Text 'ignore  
    getHTML.Then(Text) 'ignore  
       ' got the content, extract the body part and add it to the body tag  
        body.SetHTML(ExtractBodyPart(Text))  
       
        ' get the Button1 and the Editbox1 (id = case sensitive)  
        Button1.Initialize("#Button1")  
        Editbox1.Initialize("#Editbox1")  
       
        '  add a click event to the button  
        Button1.On("click", Me, "HandleButton1")  
    getHTML.end  
End Sub  
  
public Sub HandleButton1(event As BANanoEvent)  
    ' set the text value of the Editbox to something  
    Editbox1.SetValue("Alain Bailleul")  
End Sub  
  
' helper method to extract the body part of the html  
public Sub ExtractBodyPart(html As String) As String  
    Dim bodyBegin As Int = html.IndexOf("<body>")  
    html = html.SubString(bodyBegin + 6)  
    Dim bodyEnd As Int =  html.IndexOf("</body>")  
    html = html.SubString2(0,bodyEnd)   
    Return html  
End Sub
```

  
  
5. copied all the assets to the B4J Files folder and synced (css files, images and the html file WYSIWYG Web Builder generated)  
  
![](http://gorgeousapps.com/assets.jpg)  
  
6. Run the project to Transpile the B4J code to Javascript  
7. Started a Web Server in Chrome (the Fetch does need a real server as it does not allow CORS calls). I use this because it is very simple for development: <https://www.b4x.com/android/forum/threads/banano-tip-running-a-test-server.100180/>  
8. In the browser, went to <http://127.0.0.1:8887> and I got this:  
  
![](http://gorgeousapps.com/wysiwyg.jpg)  
  
When I click the button, Alain Bailleul was put in the Editbox.  
  
Other Web site builders can be used in the same way, as long as you have things like ids on your tags.  
  
Alwaysbusy