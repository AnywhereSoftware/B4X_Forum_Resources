### VivaWallet / VivaPayment Class using CLOUD API by Magma
### 04/26/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/160577/)

Hi there,  
  
I am sharing a Class created for using CLOUD API and sending "request" for paying from EFT-POS connected to VivaPayments (Viva Terminal)…  
  
For those who know - who is Viva (Virtual Bank at Greece, offers Wallet, POS, Payments, etc)… need to have Business Account… For those not know - please read everything about viva.com before proceed.  
  
Then create a Demo Account (if you wanna test my class and you will have the "feature" to download demo terminal apk): <https://demo.vivapayments.com/el/signup>  
  
This a way to get payments for EFT-POS - without writting the amount at the POS-machine.. but our TAX services need to lock the keyboard too… I am searching this… and I am searching for unversal solution too (read for my tries here: [Common protocol tcp v3](https://www.b4x.com/android/forum/threads/trying-to-figure-way-of-connection.160464/))  
  
How it works:  

```B4X
    Dim a As VivaWalletEFTPOS  
    a.Initialize  
    a.usedemo=False 'True if demo  
  
  
    Dim livepossource As Int = 0000' Where 0000 is your physical shop as written at vivawallet.com when sign in..  
    
    Wait For (a.GetAccessToken("youruserapikey.apps.vivapayments.com","yourapipassword)) Complete (Success1 As Boolean) 'then get API username/password from your profile…  
  
    If Success1=True Then  'This mean you got Token… :-)  
        Wait For (a.SearchLivePOSatSource(livepossource)) Complete (listofterminals As List)  
        If listofterminals.Size>0 Then  
            Log(a.terminal_id) 'get the last one terminal from list - this is a test although  
            Wait For (a.RequestSalesPayment("no_of_invoice-try08",a.terminal_id,"YOURCASHIERSERIAL001",30,978,"test…","test…","false",0,0)) complete (success As Boolean)  
'30 is the amount of 0.30 eur  
'978 is for EUR Currency…. 840=usd, 124=cad, 036=aud (ISO 4217)  
            If success=True Then  
'That means payment is at your wallet … now !
```

  
  
\* ps: If anyone had something for Greek EFT-POS as AADE (Tax Services) wanted and if anything about the common api tcp v3 - please share it…  
  
This needed a lot of work… have in mind that VIVA working in many Countries !!!  
You can always donate me…