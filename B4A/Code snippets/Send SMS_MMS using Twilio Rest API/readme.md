### Send SMS/MMS using Twilio Rest API by JohnC
### 01/10/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/108226/)

You need to first create an account at Twilio.com and buy a phone number for around $1.00/month. Then using the below code you can send a text message to any desired number from the twilio number you bought at about $0.01 per SMS (around 125 characters).  
  
Receiving an SMS to your Twilio number is a bit more complex because it requires a server post-back. I also have code to send MMS messages (send text + pictures), and code to receive MMS text/pictures messages and convert them into emails with attachments. I am available for hire if you need these additional abilities :)  
  
Here is the SMS text sending code:  
  

```B4X
Sub SendTwilioSMS(NumbertoSendto As String, MessageToSend As String)  
    'This routine sends an SMS from your Twilio.com number to specified number (must include country code, but without leading "+")  
    'This routine uses the new method that can send more then 160 characters (as an MMS)  
  
    Dim j As HttpJob  
    Dim URL As String         'url to post to  
    Dim P As String           'url parameters  
    Dim TUserName As String   '= your twilio username  
    Dim TPassword As String   '= your twilio password  
    Dim TNumber As String     '= your twilio number (ex. 12125551234 - must include country code, but without leading "+")  
  
    URL = "https://api.twilio.com/2010-04-01/Accounts/" & TUserName & "/Messages"  
    P = "From=%2B" & TNumber & "&To=%2B" & NumbertoSendto & "&Body=" & URLencode(MessageToSend)  
  
    j.Initialize("", Me)  
    j.Username = TUserName  
    j.Password = TPassword  
    j.PostString(URL,P)  
  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        Log(j.GetString)  
  
        Msgbox("Message Sent OK!","SMS")  
    Else  
        Msgbox("There was an error sending the SMS message (" & j.ErrorMessage & ")","Error")  
        Return  
    End If  
    j.Release  
End Sub  
  
Public Sub URLencode(InText As String) As String  
    'works to url encode SMS params to twilio  
    Dim C As Int 'As Integer  
    Dim O As String  
    Dim Z As Int 'As Long  
  
    O = ""  
  
    InText = InText.Replace(CRLF, Chr(10))  
  
    For Z = 1 To InText.Length  
        C = Asc(Mid(InText, Z, 1))  
  
        If C = 13 Then C = 0  
        If C = 94 Then C = 0  
  
        Select Case C  
            Case 10, 37, 38, 43, 94  
                O = O & "%" & Pad(Bit.ToHexString(C), 2, "0")  
            Case 32  
                O = O & "+"  
            Case Else  
                If (C>32 And C<96) Or (C>96 And C<123) Then  
                    O = O & Chr(C)  
                End If  
        End Select  
    Next  
    Return O  
End Sub  
  
Sub Pad(ItemToPad As String, ResultSize As Long, LeadPadding As String) As String  
    'adds lead PADDING if ItemToPad is smaller then ResultSize  
    Return Right(GenString(ResultSize, LeadPadding) & ItemToPad.Trim, ResultSize )  
End Sub  
  
Sub Right(Text As String, Length As Long) As String  
    Dim R As String  
    Try  
        If Length > Text.Length Then Length = Text.Length  
        R = Text.SubString(Text.Length - Length)  
    Catch  
        R = ""  
    End Try  
    Return R  
End Sub  
  
Sub GenString(NumChar As Long, Character As String) As String  
    Dim Z As Long  
    Dim R As String  
    For Z = 1 To NumChar  
        R = R & Character  
    Next  
    Return R  
End Sub  
  
Sub Mid(Text As String, Start As Int, Length As Int) As String  
    Return Text.SubString2(Start-1,(Start + Length) -1)  
End Sub
```