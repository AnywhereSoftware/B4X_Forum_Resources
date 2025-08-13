### Share a PDF with a specific WhatsApp number. by Zirfer
### 05/16/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/147997/)

Hi everyone, i've been working with B4A since 2016 or maybe 2015 and today, after a request from a client. I needed to send a PDF to a specific number in whats app.  
  
After two days, i finally figure it out  
  
Im sharing this here with you all, because is this forum what keeps B4A alive.  
  
Im using cPDF for create the PDF file.  
  

```B4X
'These are my functions that im currently using  
  
Sub savePDF(apdf As cPDF,afile As String,acompress As Int)  
    Dim folder As String  
    folder=Starter.fFileProvider.SharedFolder  
    apdf.saveToFile(folder,afile,acompress)  
End Sub  
  
Sub openPDF(afile As String)  
    Dim in As Intent  
    in.Initialize(in.ACTION_VIEW, "")  
    Starter.ffileProvider.SetFileUriAsIntentData(in, afile)  
    in.SetComponent("android/com.android.internal.app.ResolverActivity")  
    in.SetType("application/pdf")  
    StartActivity(in)  
End Sub  
  
Sub sharePDF(afile As String)  
    Dim in As Intent  
    ' Inicializar  
    in.Initialize(in.ACTION_SEND, "")  
    Starter.ffileProvider.SetFileUriAsIntentData(in, afile)  
    in.SetComponent("android/com.android.internal.app.ResolverActivity")  
    in.SetType("application/pdf")  
    in.PutExtra("android.intent.extra.STREAM", Starter.ffileProvider.GetFileUri(afile))  
    in.SetPackage("com.whatsapp")  
    StartActivity(in)  
End Sub  
  
Sub sharePDFToViaWs(afile As String, toNumber As String)  
    Dim in As Intent  
    in.Initialize(in.ACTION_SEND,"")  
    Starter.fFileProvider.SetFileUriAsIntentData(in, afile)  
    in.SetType("application/pdf")  
    in.SetPackage("com.whatsapp")  
    in.PutExtra("android.intent.extra.STREAM", Starter.fFileProvider.GetFileUri(afile))  
    in.PutExtra("jid", "57" & toNumber & "@s.whatsapp.net")  
    StartActivity(in)  
End Sub
```