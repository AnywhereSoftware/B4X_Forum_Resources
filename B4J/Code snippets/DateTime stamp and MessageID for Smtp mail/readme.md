### DateTime stamp and MessageID for Smtp mail by MbedAndroid
### 10/21/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123709/)

Noticed that the emailprovider suddenly deletes my automatic generated mails from the Pi.  
Looking in the output the dateinfo was not included and also no Message-ID thus the server classifies it as Spam.  
This routine generates the map you need to for composing a mail with Date/MessageID  
Only issue i didnt resolved (yet) is CultureInfo. Dont know to insert this for DateTime format with B4j.  
The Pi generates month/days format in my language, but the english notation is needed. Solved it replacing it in the final string (for the moment)  
But there must be a beter way  
  

```B4X
Sub GenerateRandomArray As Byte()  
    Private bc As ByteConverter  
    Return bc.IntsToBytes(Array As Int(Rnd(0,10000000000)))  
      
End Sub
```

  

```B4X
Sub GenerateHeader As Map  
  
    Private m As Map  
    m.Initialize  
    Private bc As ByteConverter  
    Private domain=Main.Settings.Email_sender As String  
    If domain.IndexOf("@")>0 Then  
        domain=domain.SubString(domain.IndexOf("@"))  
        Else  
        domain="@nodomain"  
    End If  
    Private st="<"& bc.HexFromBytes(GenerateRandomArray) &"-" & bc.HexFromBytes(GenerateRandomArray) &"-" & bc.HexFromBytes(GenerateRandomArray) &"-"& bc.HexFromBytes(GenerateRandomArray) &"-"& bc.HexFromBytes(GenerateRandomArray)  & domain &">" As String  
    m.Put("Message-Id",st)  
    Log(st)     
    DateTime.DateFormat="EEE, dd MMM yyyy HH:mm:ss Z"  
    st=DateTime.Date(DateTime.now)  
    st=st.ToLowerCase  
    If st.Contains("di,") Then st=st.Replace("di,","Tue,")  
    If st.Contains("ma,") Then st=st.Replace("ma,","Mon,")  
    If st.Contains("wo,") Then st=st.Replace("wo,","Wed,")  
    If st.Contains("do,") Then st=st.Replace("do,","Thu,")  
    If st.Contains("vr,") Then st=st.Replace("vr,","Fri,")  
    If st.Contains("za,") Then st=st.Replace("za,","Sat,")  
    If st.Contains("zo,") Then st=st.Replace("zo,","Sun,")  
    If st.Contains("okt ") Then st=st.Replace("okt ","Oct ")  
    If st.Contains("mei ") Then st=st.Replace("mei ","May ")  
    If st.Contains("mrt ") Then st=st.Replace("mrt ","Mar ")  
    If st.Contains("nov ") Then st=st.Replace("nov ","Nov ")  
    If st.Contains("dec ") Then st=st.Replace("dec ","Dec ")  
    If st.Contains("jan ") Then st=st.Replace("jan ","Jan ")  
    If st.Contains("feb ") Then st=st.Replace("feb ","Feb ")  
    If st.Contains("apr ") Then st=st.Replace("apr ","Apr ")  
    If st.Contains("jun ") Then st=st.Replace("jun ","Jun ")  
    If st.Contains("jul ") Then st=st.Replace("jul ","Jul ")  
    If st.Contains("aug ") Then st=st.Replace("aug ","Aug ")  
    If st.Contains("sep ") Then st=st.Replace("sep ","Sep ")  
    m.Put("Date",st)  
  
      
    Return m  
End Sub
```