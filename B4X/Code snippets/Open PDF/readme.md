###  Open PDF by Lucas Siqueira
### 02/19/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/164989/)

```B4X
Sub OpenPDF(dirFile As String, nameFile As String)  
    Try  
        #If B4A  
        ' Platform: Android  
        Dim provider As FileProvider  
        provider.Initialize  
        
        ' Copy the file to the shared directory  
        Wait For (File.CopyAsync(dirFile, nameFile, provider.SharedFolder, nameFile)) Complete (Success As Boolean)  
        Log("Android - File copy successful: " & Success)  
        
        If Success = False Then  
            Log("Android - Error: Failed to copy the file to the shared directory.")  
            Return  
        End If  
  
        ' Configure the Intent to open the PDF  
        Dim docIntent As Intent  
        docIntent.Initialize(docIntent.ACTION_VIEW, "")  
        provider.SetFileUriAsIntentData(docIntent, nameFile)  
        docIntent.SetType("application/pdf")  
        docIntent.Flags = Bit.Or(1, 2) ' FLAG_GRANT_READ_URI_PERMISSION  
        StartActivity(docIntent)  
        
        #Else If B4I  
        ' Platform: iOS  
        ' Check if the file exists  
        If File.Exists(dirFile, nameFile) = False Then  
            Log("iOS - Error: PDF file not found in " & dirFile & "/" & nameFile)  
            Return  
        End If  
  
        ' Initialize DocumentInteraction to open the PDF  
        Dim docInteraction As DocumentInteraction  
        docInteraction.Initialize("docInteraction", dirFile, nameFile)  
        'docInteraction.OpenFile(B4XPages.GetNativeParent(Me).RootPanel) ' shared file  
        docInteraction.PreviewFile(B4XPages.GetNativeParent(Me)) ' view file  
        Log("iOS - PDF opened successfully.")  
        
        #Else If B4J  
        ' Platform: Desktop  
        ' Check if the file exists  
        If File.Exists(dirFile, nameFile) = False Then  
            Log("B4J - Error: PDF file not found in " & dirFile & "/" & nameFile)  
            Return  
        End If  
  
        ' Open the PDF using JFX  
        Private fx As JFX  
        fx.ShowExternalDocument(File.GetUri(dirFile, nameFile))  
        Log("B4J - PDF opened successfully.")  
        #End If  
    Catch  
        Log("Error while opening the PDF: " & LastException)  
    End Try  
End Sub
```