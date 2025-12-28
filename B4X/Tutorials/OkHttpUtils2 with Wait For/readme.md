###  OkHttpUtils2 with Wait For by Erel
### 12/25/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/79345/)

[MEDIA=vimeo]256583317[/MEDIA]  
  
Downloading resources is simpler with the new [Resumable Subs](https://www.b4x.com/android/forum/threads/78601/#content) feature.  
  
Using *Wait For* we can wait for the JobDone event in the same sub that started the download.  
No longer is it needed to have a single sub that handles all requests results.  
  
Simplest example:  

```B4X
Dim j As HttpJob  
j.Initialize("", Me)  
j.Download("https://www.google.com")  
Wait For (j) JobDone(j As HttpJob)  
If j.Success Then  
   Log(j.GetString)  
End If  
j.Release
```

  
  
  
Example of downloading a quote from a quotes service:  

```B4X
Sub DownloadQuote  
   Dim j As HttpJob  
   j.Initialize("", Me) 'name is empty as it is no longer needed  
   j.Download("http://quotesondesign.com/wp-json/posts?filter[orderby]=rand")  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     'The result is a json string. We parse it and log the fields.  
     Dim jp As JSONParser  
     jp.Initialize(j.GetString)  
     Dim quotes As List = jp.NextArray  
     For Each quot As Map In quotes  
       Log("Title: " & quot.Get("title"))  
       Log("Content: " & quot.Get("content"))  
     Next  
   End If  
   j.Release  
End Sub
```

  
  
Note that the HttpJob object is a local variable. This is the recommended way to create HttpJobs as it allows us to set the sender filter parameter (read more in the tutorial about resumable subs).  
The same sub can be called multiple times and also other subs that send HttpJobs. As each HttpJob is unique, all the events will reach the correct place.  
  
Downloading two resources, one after another:  

```B4X
Sub DownloadTwoLinks  
   Dim j As HttpJob  
   j.Initialize("", Me) 'name is empty as it is no longer needed  
   j.Download("https://www.google.com")  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     Log(j.GetString)  
   End If  
   j.Release  
   'second request  
   Dim j As HttpJob 'redim and initialize  
   j.Initialize("", Me)  
   j.Download("https://www.duckduckgo.com")  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     Log(j.GetString)  
   End If  
   j.Release  
End Sub
```

  
  
Now for a very common question. How to download a list of resources, one by one?  
Simple:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   DownloadMany(Array("http://www.google.com", "http://duckduckgo.com", "http://bing.com"))  
End Sub  
  
Sub DownloadMany (links As List)  
   For Each link As String In links  
     Dim j As HttpJob  
     j.Initialize("", Me) 'name is empty as it is no longer needed  
     j.Download(link)  
     Wait For (j) JobDone(j As HttpJob)  
     If j.Success Then  
       Log("Current link: " & link)  
       Log(j.GetString)  
     End If  
     j.Release  
   Next  
End Sub
```

  
  
A sub that downloads an image and sets it to an ImageView:  
  

```B4X
Sub DownloadImage(Link As String, iv As ImageView)  
   Dim j As HttpJob  
   j.Initialize("", Me)  
   j.Download(Link)  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     iv.Bitmap = j.GetBitmap  
   End If  
   j.Release  
End Sub
```

  
  
Example of saving the downloaded file:  

```B4X
Sub DownloadAndSaveFile (Link As String)  
   Dim j As HttpJob  
   j.Initialize("", Me)  
   j.Download(Link)  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
       Dim out As OutputStream = File.OpenOutput(File.DirInternal, "filename.dat", False)  
     File.Copy2(j.GetInputStream, out)  
     out.Close '<—— very important  
   End If  
   j.Release  
End Sub
```

  
  
The nice thing about this sub, and all above subs as well, is that they can be called multiple times:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   Activity.LoadLayout("1")  
   DownloadImage("https://b4x-4c17.kxcdn.com/android/forum/data/avatars/m/0/1.jpg?1469350209", ImageView1)  
   DownloadImage("https://b4x-4c17.kxcdn.com/images3/code.png", ImageView2)  
End Sub
```

  
  
The images will be downloaded concurrently.  
  
Tip about the code flow: *Sleep* and *Wait For* are equivalent to calling Return from the calling sub perspective.  
  
The three libraries are identical and are internal libraries.