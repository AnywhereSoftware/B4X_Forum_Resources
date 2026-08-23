### B4A EMV NFC Credit Card Reader - Free Source codes by dynamicx.codes
### 08/19/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171847/)

Hello Everyone !  
  
Below is a fully working B4A EMV NFC Credit card reader.  
It works on :   
1- Visa Card (A000000003)  
2- MasterCard (A000000004)  
3- Maestro (A000000005)  
4- American Express (A000000025)  
5- JCB (A000000065)  
6- Discover (A000000152)  
You can add more cards types (AIDs) in "GetCardTypeFromAID"  

```B4X
Sub GetCardTypeFromAID(AID() As Byte) As String  
    If AID.Length < 5 Then Return "Unknown"  
      
    Dim RID As String = BytesToHexString(Array As Byte(AID(0), AID(1), AID(2), AID(3), AID(4)))  
      
    Select RID  
        Case "A000000003"  
            Return "Visa"  
        Case "A000000004"  
            Return "MasterCard"  
        Case "A000000005"  
            Return "Maestro"  
        Case "A000000025"  
            Return "American Express"  
        Case "A000000065"  
            Return "JCB"  
        Case "A000000152"  
            Return "Discover"  
        Case Else  
            Return "Unknown"  
    End Select  
End Sub
```

  
  
**Demo video :**   
[MEDIA=youtube]llFgU1mx\_gY[/MEDIA]  
  
How the system works :   
1- Place your phone on top of the card (Your phone has to support NFC)  
2- Keep the phone in place without moving it because if you move it it will close the connection between the phone and the card and reconnect again   
3- within less than 2 seconds the phone will read the card information (card number, expiry date, Track2Data, BIN and ATR)  
4- Then the phone will send a request to B4J (API , source included) to get the bank name from "bin-list-data.csv" which is an updated list of all banks BINs and the API will return to the app the bank name based on the extracted BIN from the card  
  
**How does it work? :**   
Once the card is scanned by the app it will create a fake transaction between the app and the card (PSE and PDOL) which extracts the ATR and Track2Data, and the app parses the data to get the EMV data and card information  
  
The class "Cls\_Card\_Reader" has a timer of 500 MS to check if the connection is open or not between the card and the app to make sure the connection never dies   

```B4X
Private ConnectionMonitor As Timer  
Private IsMonitoring As Boolean
```

  
  
And if the connection dies then it will inform the activity to reanimate the views.  
  
**B4J API Link :**   
When you run B4J on your device/server, make sure in B4A you change the URL to your URL :  

```B4X
Sub Get_Bank_Name(pan_number As String)  
    Try  
        pan_number = pan_number.Replace(" ","")  
        pan_number = pan_number.SubString2(0,6).Trim  
        Log("BIN pan_number : " & pan_number)  
          
        Dim job As HttpJob  
        job.Initialize("", Me)  
        job.PostString("http://192.168.1.105:51042/bin_lookup_api", pan_number)  
        job.GetRequest.SetContentType("application/json")  
        Wait For (job) JobDone (job As HttpJob)  
        If job.Success Then  
            Log(job.GetString)  
              
            Dim response As Map = job.GetString.As(JSON).ToMap  
            Log(response)  
              
            lblBankName.Text = response.Get("Issuer").As(String).Replace($"""$,"").Trim  
            lblcategory.Text = response.Get("Category").As(String).Replace($"""$,"").Trim  
            lblCardType.Text =  response.Get("Brand").As(String) & " " &  response.Get("Type").As(String)  
        End If  
        job.Release  
    Catch  
        Log(LastException)  
    End Try  
      
      
    Sleep(200)  
    p_shadow.SetColorAnimated(100,Colors.ARGB(200,0,0,0),Colors.ARGB(200,33,157,86))  
    Sleep(200)  
      
    p_shadow.SetColorAnimated(200,Colors.ARGB(200,33,157,86),Colors.ARGB(200,0,0,0))  
      
      
      
      
    Dim cls(2) As Int  
      
      
    lblBankName.TextColor = Colors.White  
    lblCardNumber.TextColor = Colors.White  
    lblCardType.TextColor = Colors.White  
    lblcategory.TextColor = Colors.White  
    lblExpiryDate.TextColor = Colors.White  
      
    If lblCardType.text.Trim.ToLowerCase.Contains("visa") Then  
        cls(0) = Colors.Rgb(73,154,213)  
        cls(1) = Colors.Rgb(0,135,203)  
    Else if lblCardType.text.Trim.ToLowerCase.Contains("master") Then  
        cls(0) = Colors.Rgb(213,73,73)  
        cls(1) = Colors.Rgb(203,0,0)  
    Else  
        cls(0) = Colors.Rgb(250,250,250)  
        cls(1) = Colors.Rgb(250,250,250)  
          
        lblBankName.TextColor = Colors.Black  
        lblCardNumber.TextColor = Colors.Black  
        lblCardType.TextColor = Colors.Black  
        lblcategory.TextColor = Colors.Black  
        lblExpiryDate.TextColor = Colors.Black  
          
          
    End If  
      
      
    Dim gd As GradientDrawable  
    gd.Initialize("TL_BR",cls)  
    gd.CornerRadius = 5%x  
      
    p_card_back.Background= gd  
      
    Sleep(500)  
          
    p_shadow.Visible = False  
    p_overlay.SetLayoutAnimated(500,0,100%y,100%x,55%y)  
      
      
    p_processing_gif.Visible = True  
    lbl_processing1.Visible = True  
    lbl_processing2.Visible = True  
      
End Sub
```

  
  
**UI text Languages :**   
The app supports : English, Italian , Spanish languages  
  
**One of the use cases for this technology :**   
NFC Remote payment:  
User 1 is at home and User 2 is at the supermarket , User 2 needs to pay the bill, contacts User 1 and tell them to place the card under the phone, User 2 receives the card and pays the bill using User 1 credit card   
  
**The above project is a basic credit card information extraction, for the full NFC remote payment system (NFC Relay), you can visit our website to see it working :**   
[Remote NFC Payment](https://dynamicx.codes/projects/post/31)  
  
Source codes attached :   
1- B4A : Scanner and extractor  
2- B4J : API to get the bank name from the updated list "bin-list-data.csv"  
  
\*\*Make sure :   
1- Your phone supports NFC  
2- Your card is not disabled by the bank   
3- Your card is not expired  
4- Your card supports NFC payments  
  
\*Couldn't upload the files (4 MB) here because it says "Your uploaded file is too large" , download the files from the below link :   
1- B4A Project :   
<http://dynamicx.codes/freeware/LegacyReader.zip>  
  
2- B4J API project :  
<http://dynamicx.codes/freeware/LegacyNFC_Server.zip>  
  
Thank you,  
DynamicX.Codes