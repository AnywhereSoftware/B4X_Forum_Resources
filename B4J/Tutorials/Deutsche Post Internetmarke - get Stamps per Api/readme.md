### Deutsche Post Internetmarke - get Stamps per Api by DonManfred
### 03/08/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166015/)

This Thread is about the german Post and their free Api Service for Postalstamps and other Services.  
  
<https://developer.dhl.com/api-reference/deutsche-post-internetmarke-post-paket-deutschland#get-started-section>  
  
I´ll post some Examples in this Thread. Most probably it is not of interest for someone out of Germany but i´ll write this Tutorial in english for anyone be interested in it ;-)  
  
I am not resposible for any Copyrights or anything. See the DHL-Developersite and DHL Site for any Agreements, Licenses, regularities, ect,  
  
To get started you need:  
- register a Account at the Developersite linked above. There is a  
![](https://snapshots.basic4android.de/firefox_b4XpdOirm2.png) Button on the opper right.  
  
Once you get registered you´ll get some Mails from the german Post.  
You´ll get a Sandbox-Account Login and a password for this Login (in a seperate mail).  
You can use this credentials to work with the Api until you want to apply for production.  
Note that the sandboxaccount only last for three months.  
  
In this time you are able to use the sandbox-login to create Labels, test the implementation and so on. **These stamps can not be used to ship in real world though!**  
  
- Create an "Application" in this Account.  
- Add the Service/Api) "**Post DE Internetmarke (Post & Parcel Germany)**" to your App and wait for Approval.  
- Get AppKey and AppSecret from your App  
![](https://snapshots.basic4android.de/firefox_JISGj98HAm.png)  
Click on **Show key** to show the Values and copy them.  
  
For now we do have these Values:  
- email and passwort for your own account  
- email and password for an Sandboxaccount on the Portokasse having €1000,- to test the Api.  
  
For now we are working with the sandbox-credentials and the App in our own Account.  
  
Create an Accesstoken  
===============  

```B4X
    Dim sb As StringBuilder  
    sb.Initialize  
    sb.Append("grant_type=client_credentials").Append("&")  
    sb.Append("username="&apiloginSandbox).Append("&")  
    sb.Append("password="&apipasswordSandbox).Append("&")  
    sb.Append("client_id=[client-key from deelopersite]").Append("&")  
    sb.Append("client_secret=[client-secret from deelopersite]")  
    Dim body As String = sb.ToString  
    Log(body)  
     
    Dim j As HttpJob  
    j.Initialize("",Me)  
    j.PostString("https://api-eu.dhl.com/post/de/shipping/im/v1/user", body)  
    J.GetRequest.SetContentType("application/x-www-form-urlencoded; charset=UTF-8")  
  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        Dim result As String = j.GetString  
        Dim parser As JSONParser  
        parser.Initialize(result)  
        Dim jRoot As Map = parser.NextObject  
        Dim access_token As String = jRoot.Get("access_token")  
        Dim userToken As String = jRoot.Get("userToken")  
        Dim walletBalance As Int = jRoot.Get("walletBalance")  
        Dim showTermsAndConditions As String = jRoot.Get("showTermsAndConditions")  
        Dim external_customer_id As String = jRoot.Get("external_customer_id")  
        Dim token_type As String = jRoot.Get("token_type")  
        Dim authenticated_user As String = jRoot.Get("authenticated_user")  
        Dim expires_in As Int = jRoot.Get("expires_in")  
        Dim issued_at As String = jRoot.Get("issued_at")  
        Dim infoMessage As String = jRoot.Get("infoMessage")  
        '  
  
        j.Release  
    Else  
        j.Release  
    End If
```

  
  
- access\_token is the Accesstoken we can use as a Bearer Authentification with the Api.  
- expires\_in is the amount of seconds for the given access\_token to expire.  
  
You can calculate a real date with this code  

```B4X
        ' Calculate Expiredate based on the expires_in value  
        Dim p As Period  
        p.Seconds = expires_in  
        Dim expireDate As Long = DateUtils.AddPeriod(DateTime.Now,p)
```

  
  
It is a good idea to store the token and the calculated expireDate to a kvs or hold in memory to later check if the token is still Valid.  
  
They token given lasts for one day. So you do not have to create a new one each time.  
  

```B4X
    Dim apikey As String = "jvBQ06AAAGeBJCcgntoBxxxxx"  
    Dim apisecret As String = "SeWnbZ73yyyyy"  
    Dim apiloginSandbox As String = "testpk_xxxxx@dhldp-test.de"  
    Dim apipasswordSandbox As String = "AElSzzzzzz"  
  
    kvs.Initialize(File.DirApp,"kvs.dat")
```

  
  

```B4X
Public Sub CreateToken() As ResumableSub  
   
    Dim sb As StringBuilder  
    sb.Initialize  
    sb.Append("grant_type=client_credentials").Append("&")  
    sb.Append("username="&apiloginSandbox).Append("&")  
    sb.Append("password="&apipasswordSandbox).Append("&")  
    sb.Append("client_id="&apikey).Append("&")  
    sb.Append("client_secret="&apisecret)  
    Dim body As String = sb.ToString  
    Log(body)  
     
    Dim j As HttpJob  
    j.Initialize("",Me)  
    j.PostString("https://api-eu.dhl.com/post/de/shipping/im/v1/user", body)  
    J.GetRequest.SetContentType("application/x-www-form-urlencoded; charset=UTF-8")  
  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        Dim result As String = j.GetString  
        Dim parser As JSONParser  
        parser.Initialize(result)  
        Dim jRoot As Map = parser.NextObject  
        Dim access_token As String = jRoot.Get("access_token")  
        Dim userToken As String = jRoot.Get("userToken")  
        Dim walletBalance As Int = jRoot.Get("walletBalance")  
        Dim showTermsAndConditions As String = jRoot.Get("showTermsAndConditions")  
        Dim external_customer_id As String = jRoot.Get("external_customer_id")  
        Dim token_type As String = jRoot.Get("token_type")  
        Dim authenticated_user As String = jRoot.Get("authenticated_user")  
        Dim expires_in As Int = jRoot.Get("expires_in")  
        Dim issued_at As String = jRoot.Get("issued_at")  
        Dim infoMessage As String = jRoot.Get("infoMessage")  
        '  
  
        j.Release  
    Else  
        j.Release  
    End If  
End Sub  
  
Public Sub UpdateAccessToken As ResumableSub  
    Wait For (CreateToken)Complete (usermap As Map)  
    If Initialized(usermap) Then  
        globalusermap = usermap  
       
        Dim access_token As String = usermap.Get("access_token")  
        kvs.Put("access_token",access_token)  
       
        Dim userToken As String = usermap.Get("userToken")  
        kvs.Put("userToken",userToken)  
       
        Dim walletBalance As Int = usermap.Get("walletBalance")  
        kvs.Put("walletBalance",walletBalance)  
       
        Dim showTermsAndConditions As String = usermap.Get("showTermsAndConditions")  
        kvs.Put("showTermsAndConditions",showTermsAndConditions)  
       
        Dim external_customer_id As String = usermap.Get("external_customer_id")  
        kvs.Put("external_customer_id",external_customer_id)  
       
        Dim token_type As String = usermap.Get("token_type")  
        kvs.Put("token_type",token_type)  
       
        Dim authenticated_user As String = usermap.Get("authenticated_user")  
        kvs.Put("authenticated_user",authenticated_user)  
       
        Dim expires_in As Int = usermap.Get("expires_in") ' Seconds  
       
        ' Calculate Expiredate based on the expires_in value  
        Dim p As Period  
        p.Seconds = expires_in  
        Dim expireDate As Long = DateUtils.AddPeriod(DateTime.Now,p)  
        ' and write it to kvs  
        kvs.Put("expireDate",expireDate)  
        ' We later can use it to check if the written token is Valid when we start the app again.  
       
        Log($"Expires $date{expireDate} $Time{expireDate}"$)  
        Dim issued_at As String = usermap.Get("issued_at")  
        kvs.Put("issued_at",issued_at)  
  
        Dim infoMessage As String = usermap.Get("infoMessage")  
        kvs.Put("infoMessage",infoMessage)  
        '  
        'Log(result)  
        Log($"external_customer_id: ${external_customer_id}"$)  
        Log($"Authenticated User: ${authenticated_user}"$)  
        Log($"Authenticated TokenIssued: ${issued_at}"$)  
        Log($"AT: ${access_token}"$)  
        Log($"UT: ${userToken}"$)  
        Return usermap  
    Else  
        Dim dummy As Map  
        Return dummy  
    End If  
End Sub  
  
Private Sub Button1_Click  
    DateTime.DateFormat = "dd.MM.yyyy"  
   
    If kvs.GetDefault("expireDate",0) > DateTime.Now Then  
        Dim attoken As String = kvs.Get("access_token")  
        Dim expire As Long = kvs.GetDefault("expireDate",0)  
        Log($"Expires $Date{expire} $time{expire}"$)  
        Log($"ExpireDate in Future. AccessToken available ${attoken}"$)  
    Else  
        Log($"No Token available or Expired. Get new token…"$)  
        Wait For (UpdateAccessToken)Complete(resultmap As Map)  
        If Initialized(resultmap) Then  
            Log($"Update OK"$)  
            Dim expire As Long = kvs.GetDefault("expireDate",0)  
            Log($"$Date{expire} $time{expire}"$)  
            Dim attoken As String = kvs.Get("access_token")  
        End If  
    End If  
  
    If attoken <> "" Then  
        ' Do whatever you need with the token      
    End If  
  
End Sub
```

  
  
  
Useful resource for your app if you want to use Different Internetstamps in your Application.  
  
<https://developer.dhl.com/api-reference/deutsche-post-internetmarke-post-paket-deutschland#downloads-section>  
Download "Produkt-/Preisliste für Partner Version 5.70, gültig ab 1.1.2025" from there. You´ll get a CSV-File with all Productcodes for the Stamps.  
  
here just a small snippet from this file  

```B4X
PROD_GUEAB;T&T;PROD_ID;PROD_AUSR;PROD_NAME;PROD_BRPREIS;BP_NAME;BP_BRPREIS;ADD_NAME;ADD_BRPREIS;MINL;MINB;MINH;MAXL;MAXB;MAXH;MING;MAXG;MIND;MAXD;PROD_ANM;INTMA_HINWTEXT;INTMA_PROD_URL;INTMA_VERTRAG;INTMA_ZOLLERKL  
01.01.2025;;1;N;Standardbrief;0,95;Standardbrief;0,95;;;140;90;0;235;125;5;0;20;;;Die Länge muss mindestens das 1,4-fache der Breite betragen.;Preis nach UStG umsatzsteuerfrei. Für Briefe, Schriftstücke und kleinere Gegenstände bis 20 g. Die Länge muss mindestens das 1,4-fache der Breite betragen.;https://www.deutschepost.de/de/b/brief_postkarte.html;nein;nein  
01.01.2025;;11;N;Kompaktbrief;1,10;Kompaktbrief;1,10;;;100;70;0;235;125;10;0;50;;;Die Länge muss mindestens das 1,4-fache der Breite betragen.;Preis nach UStG umsatzsteuerfrei. Für Briefe, Schriftstücke und kleinere Gegenstände bis 50 g. Die Länge muss mindestens das 1,4-fache der Breite betragen.;https://www.deutschepost.de/de/b/brief_postkarte.html;nein;nein  
01.01.2025;;21;N;Großbrief;1,80;Großbrief;1,80;;;100;70;0;353;250;20;0;500;;;;Preis nach UStG umsatzsteuerfrei. Für Briefe, Schriftstücke und kleinere Gegenstände bis 500 g.;https://www.deutschepost.de/de/b/brief_postkarte.html;nein;nein
```

  
  
It is the PROD\_ID we use for orders. PROD\_BRPREIS holds the price for it in Euro. You need to calculate the cents from them for the Orders total sum.  
  
There a a few stepts to order an InternetMarke:  
- Get an AccessToken  
- Create a ShoppingCart and get it´s ID. We later need the given shopOrderId to add Positions to the Shoppingcart.  

```B4X
Public Sub CreateShopOrderID(token) As ResumableSub  
    Dim j As HttpJob  
    j.Initialize("",Me)  
    
    j.PostString("https://api-eu.dhl.com/post/de/shipping/im/v1/app/shoppingcart", "")  
    'J.GetRequest.SetContentType("application/x-www-form-urlencoded; charset=UTF-8")  
    j.GetRequest.SetHeader("Authorization",$"Bearer ${token}"$)  
    j.GetRequest.SetHeader("Content-Length",0)  
    'J2.GetRequest.SetContentType("application/x-www-form-urlencoded; charset=UTF-8")  
    
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        Dim jobresult As String = j.GetString  
        Log($"CreateOrderID.result: ${jobresult}"$)  
        
        Dim parser As JSONParser  
        parser.Initialize(jobresult)  
        Dim jRoot As Map = parser.NextObject  
        Dim shopOrderId As String = jRoot.Get("shopOrderId")  
        j.Release  
        Return shopOrderId  
    Else  
    End If  
    j.Release  
    Return ""  
  
End Sub
```

  
  
Create a PNG-Request for a Single (in this case) or Multiple InternetMarke.  
  
Note that i only use ONE Position in this Order resulting in ONE PNG-File to be downloaded in a ZIP after Ordering the InternetMarke.  
  
If you would orrder multiple InternetMarke with one call then you need to adapt the code after unzipping the zip-file ;-)  
  

```B4X
                Log($"calling CreateIrderID()"$)  
                Wait For (CreateShopOrderID(attoken))Complete (shopOrderId As String)  
                Log("ShopOrderID: "&shopOrderId)  
  
            Dim AdrName As String = "ReceiverName"  
            Dim AdrLine1 As String = "ReceiverAddressLine1"  
            Dim AdrLine2 As String = "ReceiverAddressLine2"  
            Dim AdrPLZ As String = ReceiverPostCode"  
            Dim AdrOrt As String = "ReceiverCity"  
            Dim AdrLand As String = "ReceiverCountry (3-Character-code)"  
  
                ' data holds the hole orderinformations.  
                Dim data As Map  
                data.Initialize  
                data.Put("type","AppShoppingCartPNGRequest") ' Tyxpe of Order. Here we are ordering PNG-Files  
                data.Put("shopOrderId",shopOrderId) ' One order belongs to a shopOrderId which we got  
            
                ' The Order can have multiple Positions.  
                ' Even it is only one (like in this code) we have to use a List for it.  
                Dim positions As List  
                positions.Initialize  
            
                    
                ' =======================================================  
                ' The position is a Map which hold all relevant information about the Position.  
                ' productCode is the Product you want to buy.  
                ' In this example i´m always using "Großbrief"  
                ' for a receiver in DE it is productCode 21 and costs 1,80 €. -> 180 cent  to count  
                ' for a receiver in AT and CH it is productCode 10051 and costs 3,30 €. -> 330 cent  to count  
                ' a standard letter in germany for example would be productCode 1 with a cost of 0,95€ -> 95 cent to count  
                    
                Dim position As Map  
                position.Initialize  
            
               ' Receiver country germany. Großbrief in this Case. Stamp of 1,80  
               If AdrLand = "DE" Then  
                    position.Put("productCode",21) ' 01.01.2025;;21;N;Großbrief;1,80  
                    data.Put("total",180) ' sum of Positions. Here only one position per order  
                Else  
                    ' others Stamp of 3,30 for AT/CH  
                    position.Put("productCode",10051) ' 01.01.2025;;10051;I;Großbrief Intern. GK;3,30  
                    data.Put("total",330) ' sum of Positions. Here only one position per order  
                End If  
                    
                data.Put("dpi","DPI300") ' DPI  
                data.Put("optimizePNG",True) ' Optimize PNG removes unnecceary margins  
                data.Put("createManifest",True) '  
                
                '=================================================================  
                ' address is a Map that holds the Sender- and Receiver-Informations  
                '=================================================================  
                Dim address As Map  
                address.Initialize  
            
                ' Receiver  
                Dim adrreceiver As Map  
                adrreceiver.Initialize  
                adrreceiver.Put("name","ReceiverName")  
                'adrreceiver.Put("additionalName","")  
                adrreceiver.Put("addressLine1","Receiver Addressline 1")  
                If AdrLine2 <> "" Then  
                    adrreceiver.Put("addressLine2",AdrLine2) ' only add addressLine2 it is is not empty  
                End If  
                adrreceiver.Put("postalCode","Receiver postcode")  
                adrreceiver.Put("city","Receiver City")  
                    
                ' In my Database i have addresses with DE, AT and CH als languagecodes.  
                ' Internetmarke needs them as 3-Chars  
                ' DE -> DEU  
                ' AT -> AUT  
                ' CH -> CHE  
                If AdrLand = "AT" Then  
                    adrreceiver.Put("country","AUT")  
                else if AdrLand = "CH" Then  
                    adrreceiver.Put("country","CHE")  
                Else  
                    adrreceiver.Put("country","DEU")  
                End If  
                    
                ' Add receiver to addressmap  
                address.Put("receiver",adrreceiver)  
  
  
                ' Sender  
                Dim adrsender As Map  
                adrsender.Initialize  
                adrsender.Put("name","SenderName")  
                'adrsender.Put("additionalName","additional name")  
                adrsender.Put("addressLine1","Senderstreet No")  
                'adrsender.Put("addressLine2","") ' Only use if not empty  
                adrsender.Put("postalCode","postalcode")  
                adrsender.Put("city","City")  
                adrsender.Put("country","DEU")  
  
                ' add sender to addressmap  
                address.Put("sender",adrsender)  
                    
                ' add the addressmap to the Position  
                position.Put("address",address)  
                    
                ' This is the layout to be used. Honestly i only know "ADDRESS_ZONE" and  
                ' "FRANKING_ZONE" but i would like to get more on this if one knows  
                ' them :D  
                position.Put("voucherLayout","ADDRESS_ZONE")  
                'position.Put("voucherLayout","FRANKING_ZONE")  
                    
                ' mark the position as a AppShoppingCartPosition  
                position.Put("positionType","AppShoppingCartPosition")  
  
                ' add the position to the positions-List  
                positions.Add(position)  
                    
                ' add the List of positions to the Order  
                data.Put("positions",positions)  
            
                ' Feed JSONGnerator with the ord-Map  
                Dim jgen As JSONGenerator  
                jgen.Initialize(data)  
            
                ' and generate a JSON-String from it  
                Dim jsonstr As String= jgen.ToString  
                Log(jsonstr)  
                '  
                Dim job As HttpJob  
                job.Initialize("",Me)  
                job.PostString("https://api-eu.dhl.com/post/de/shipping/im/v1/app/shoppingcart/png", jsonstr)  
                job.GetRequest.SetHeader("Authorization",$"Bearer ${attoken}"$)  
                job.GetRequest.SetContentType("application/json")  
                Wait For (job) JobDone(job As HttpJob)  
                If job.Success Then  
                    Dim shoppingcartresult As String = job.GetString  
                    Log($"shoppingcartresult: ${shoppingcartresult}"$)  
                    File.WriteBytes(File.DirApp,$"shoppingcartresult-${shopOrderId}.json"$,shoppingcartresult.GetBytes("UTF8"))  
  
                    Dim parser As JSONParser  
                    parser.Initialize(shoppingcartresult)  
                    Dim jRoot As Map = parser.NextObject  
                    Dim manifestLink As String = jRoot.Get("manifestLink")  
                    Log($"Manifest-Link:${manifestLink}"$)  
                        
                    Dim link As String = jRoot.Get("link")  
                    Dim shoppingCart As Map = jRoot.Get("shoppingCart")  
                    Dim shopOrderId As String = shoppingCart.Get("shopOrderId")  
                
                    Dim path As String = $"Internetmarke\"$  
                    File.MakeDir(File.DirApp,path)  
  
                    Wait For (DownloadAndSave(link, File.Combine(File.DirApp,"Internetmarke"),$"Sandbox-${shopOrderId}.zip"$))Complete (success As Boolean)  
                    Log($"Download ${$"Sandbox-${shopOrderId}.zip"$} success = ${success}"$)  
  
                    Dim sh As Shell  
      
                    ' Shell/7-Zip command:  
                    ' - "sh": Event name, used later in "sh_ProcessCompleted" to read output  
                    ' - "cmd": Windows command interpreter to be run by Shell  
                    ' - "/c": Run a command or executable program  
                    ' - "7za.exe": Stand-alone 7-Zip program  
                    ' - "l": (Command) List contents of archive  
                    ' - "-slt": (Switch) Show technical information. Optional.  
                    ' - sFilePathName: File path including file name  
                    sh.Initialize("sh", "cmd", Array As String("/c", "C:\Program Files\7-Zip\7z.exe", "x", $"${File.Combine(File.DirApp,"Internetmarke")}\Sandbox-${shopOrderId}.zip"$))  
                    ' Directory containing '7za.exe'  
                    sh.WorkingDirectory = File.Combine(File.DirApp,"Internetmarke")  ' Same directory as the compiled JAR file  
                    ' Start the process  
                    sh.Run(-1)  
      
                    ' Wait for the process to be completed, and read outputs  
                    ' "sh" in "sh_ProcessCompleted" must be the Event name defined in sh.Initialize("sh", …)  
                    Wait For sh_ProcessCompleted (success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
                    Log("sh_ProcessCompleted.Success: " & success)  
                    Log("sh_ProcessCompleted.ExitCode: " & ExitCode)  
                    Log("sh_ProcessCompleted.StdOut: " & StdOut)  
                    Log("sh_ProcessCompleted.StdErr: " & StdErr)  
  
                    Dim voucherList As List = shoppingCart.Get("voucherList")  
                    For Each colvoucherList As Map In voucherList  
                        Dim voucherId As String = colvoucherList.Get("voucherId")  
                    
                        If File.Exists(File.Combine(File.DirApp,"Internetmarke"),"0.png") Then  
                    
                            File.Copy(File.Combine(File.DirApp,"Internetmarke"),"0.png",File.Combine(File.DirApp,"Internetmarke"),$"${shopOrderId}-${voucherId}.png"$)  
  
                            'File.Delete(File.Combine(File.DirApp,"Internetmarke"),"0.png")  
                           ' File.Delete(File.Combine(File.DirApp,"Internetmarke"),$"Sandbox-${shopOrderId}.zip"$)  
                    
                        End If  
                    
                        'Dim trackId As String = colvoucherList.Get("trackId")  
                    Next  
                    Dim walletBallance As Int = jRoot.Get("walletBallance")  
                    Log($"New Balance = ${walletBallance} Cent"$)  
                    Dim wallet As Double = walletBallance/100  
                    Log($"New Balance = $3.2{wallet} €"$)  
                    'Dim Type As String = jRoot.Get("type")  
                    job.Release  
                End If  
                job.Release
```

  
  
  
END OF PART 1  
===================  
I´ll stop this Post at this time.  
  
I´ll post more related Tutorials in future  
  
I´ve not found everything to configure but here we go.  
At least i can work with what i have discovered so far.