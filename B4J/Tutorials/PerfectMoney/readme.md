### PerfectMoney by MichalK73
### 10/24/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/137482/)

Hello.  
PerfectMoney is an alternative method of payment on the Internet for services. For a client I had to write API support for PerfectMoney. He was only interested in 2 functions.  
  
1. Retrieving wallet values of currencies on subaccounts, e.g. $,Euro, BTC etc.  
2. Receiving eVoucher from customers and automatically credit their PerfectMoney account.  
  
You can see how the library works in the example code. The function call is answered by a return proceure returning a response from PerfectMoney. There is added error handling from server side or lack of connection with PerfectMoney server.  
Functions are tested and work correctly.  
Please remember to activate API in PerfectMoney in your account in API settings and to give a specific IP from which connections are received.  
  

```B4X
Sub AppStart (Args() As String)  
    
    Dim PM As PerfectMoney  
    PM.Initialize(Me, "AcountID","AcoutLogin","Password")  
    PM.Balance  
  
  
    PM.ActiveVoucher("111111111111111","2222222222222222222222")  
    
    StartMessageLoop  
End Sub  
  
  
Sub PM_Balance(result As Map)  
    If result.ContainsKey("error") Then  
        Log(result.Get("error"))  
    Else  
        Log(result)  
    End If  
End Sub  
  
  
Sub PM_ActiveVoucher(result As Map)  
    If result.ContainsKey("error") Then  
        Log(result.Get("error"))  
    Else  
        Log(result)  
        'VOUCHER_NUM, VOUCHER_AMOUNT, VOUCHER_AMOUNT_CURRENCY, Payee_Account, PAYMENT_BATCH_NUM  
    End If  
End Sub
```

  
  
2022-10-24 - Library v.1.1 with correct PM domain to API.