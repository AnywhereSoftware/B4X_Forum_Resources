### Print Made Easy by Hamied Abou Hulaikah
### 07/25/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/149200/)

After understanding this approach, printing will be painless for you forever.  
  
**Requirements:**  
- Any pdf file generation tool, I used [HtmlToPdf](https://www.b4x.com/android/forum/threads/htmltopdf.104026/#content) lib.  
- Any base64 converting tool, I used [Base64EncodeDecodeImage](https://www.b4x.com/android/forum/threads/b4x-library-base64-encode-decode-image-and-file-library.115033/) lib.  
- [Rawbt](https://play.google.com/store/apps/details?id=ru.a402d.rawbtprinter) printing service app, it is free and most downloaded app in play market specialized in printing.  
- Don't forget to configure Rawbt app for first time only (run as a service + select printer + page width).  

```B4X
sub print(html as string)  
                        
    'convert your print content to pdf file  
    Dim phtmltopdf As PalmoHtmlToPdf  
    phtmltopdf.Initialize("phtmltopdf")  
    Dim pdffile As String="rawbtprint.pdf"  
    If File.Exists(File.DirInternal,pdffile) Then File.Delete(File.DirInternal,pdffile)  
    phtmltopdf.ConvertFromString(html,File.DirInternal,pdffile)  
    Wait For phtmltopdf_Finished (Success As Boolean)  
                        
    'send invisible print command to rawbt  
    Dim Intent1 As Intent  
    Intent1.Initialize2($"rawbt:data:application/pdf;base64,${Base64EncodeDecodeImage.Base64AnyFileToString(File.DirInternal,pdffile)}"$, 0)  
    StartActivity(Intent1)   
  
end sub
```

  
  
Thanks.