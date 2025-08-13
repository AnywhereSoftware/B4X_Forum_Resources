### Load data from Website and display in a WebView as a Marquee by GMan
### 02/27/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/165864/)

I wanted to realize a kind of Ticker with some metal datas.  
  
So i created a WebView, read in the data from a financial website, work them up and load the HTML in the WebViewTicker moving from right to left![](https://www.b4x.com/android/forum/attachments/162119).  
The WebViewNews-Webview is for displaying in a big view,  
The WebViewTicker-WebView is a small banner at the buttom of the screen:  
  
So here is the code for this:  
  

```B4X
Sub LoadWebTickerei  
  
    Dim http As HttpJob  
    http.Initialize("", Me)  
    http.Download("https://www.boerse.de/nachrichten/Goldpreis/XC0009655157")  
  
    Wait For (http) JobDone(job As HttpJob)  
  
    If job.Success Then  
        Dim htmlContent As String = job.GetString  
        'Log(htmlContent)  
    End If  
          
    Dim startIndex As Int = htmlContent.IndexOf("Uhr")-6  
    ' Log(startIndex)  
    Dim endIndex As Int = htmlContent.LastIndexOf("Uhr")+310  
    ' Log(endIndex)  
          
          
    'Die Enchilada entwursten…     
    Dim extractedHtml As String = htmlContent.SubString2(startIndex, endIndex)  
     extractedHtml = extractedHtml.Replace("</div>","")  
    extractedHtml = extractedHtml.Replace("<div class=<","")  
    extractedHtml = extractedHtml.Replace("row row-bordered","")  
    extractedHtml = extractedHtml.Replace("<div class=","")' extractedHtml  
    extractedHtml = extractedHtml.Replace("col-xs-9 col-md-","")' extractedHtml  
    extractedHtml = extractedHtml.Replace("col-xs-3 col-md-2","")' extractedHtml  
    extractedHtml = extractedHtml.Replace(Chr(34) & Chr(34) & ">","")  
    extractedHtml = extractedHtml.Replace(Chr(34) & "10" & Chr(34) & ">","")  
    extractedHtml = extractedHtml.Replace(Chr(34) & Chr(34) & ">","")  
'    Log(extractedHtml) 'visueller Check  
    WebViewNews.LoadHtml(extractedHtml)  
'    WebViewNews.Visible=True 'visueller Check  
    WebViewTicker.LoadHtml("<marquee>" & "News zu Edelmetallen: " & extractedHtml & "<marquee>")  
  
End Sub
```