### Freemarker Library by EnriqueGonzalez
### 12/13/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/157971/)

Hi All!  
With great pleasure i want to present the freemarker library.  
  
Freemarker page:  
<https://freemarker.apache.org/index.html>  
  
Download latest version here:  
<https://freemarker.apache.org/freemarkerdownload.html>  
  
Example on how to use it  
  
setup:  

```B4X
    public be_free As Freemarker 'Process_Globals  
    be_free.Initialize  
    be_free.DefaultEncoding = "UTF-8"  
    be_free.DirectoryForTemplateLoading = File.DirApp & "/freemarker_templates"  
    be_free.LazyAutoImports = True  
    be_free.addAutoImport("fun", "functions.ftl")  
    be_free.exposeFields  
    be_free.addSharedVariable("base_url", "http://localhost:3000")
```

  
  
usage:  

```B4X
    Dim t As Template = main.be_free.getTemplate(freemarker_template)  
    resp.CharacterEncoding = "UTF-8"  
    resp.Write(t.stdOut(root))
```

  
  
Do you want to create a webapp but are afraid of all the set up needed? I am offering a B4x focused VPS!  
<https://www.b4x.com/android/forum/threads/b4x-focused-vps.157120/>  
It comes with free consulting  
  
You can look at a full fledged example with TailwindCSS + HTMX + Freemarker and of course B4x here:  
<https://www.b4x.com/android/forum/threads/htmx-tailwindcss-freemarker.157970/>