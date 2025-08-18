### To Make a simple CharSequence: by Antoine EGO
### 01/02/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126089/)

We all need colored text, but using Append & Pop is really tiring when we have many spans.  
This command uses (Message As String) so you can anytime have a colored message without turning the message into CSBuilder.  
  
Most of time we don't need more than a colored message!  
  

```B4X
'To Make a simple CharSequence:  
'Message="Color1/text1/Color2/text2/Color3/text3…."  
'Color1 can be TheColorName or TheColorNumber ex: (red or 4)  
'  Example : <code>  
'Dim msg As string  
'msg="black/Hello Mr. /red/Antoine /green/*EGO*/gray/ How are you?"  
''msg="0/Hello Mr. /4/Antoine /2/*EGO*/8/ How are you?"  
'Msgbox(CS(msg),"Title")  
'  Equals to :  
'Dim msg As CSBuilder  
'msg.Initialize.Append("Hello Mr. ").Color(Colors.Red).Append("Antoine ").Pop. _  
'Color(Colors.Green).Bold.Append("EGO").Pop.Pop.color(Colors.gray).Append _  
'(" How are you?").PopAll  
'Msgbox(msg,"Title")  
'</code>  
'If Color is omitted so it is Black  
'If text is written like *txt* so it is Bold  
'If text starts with {} so a new line is added, Example:<code>  
'Message="red/Dear sir/blue/{}Hope we meet tomorrow./green/{}*Thanks*"  
'Message="4/Dear sir/1/{}Hope we meet tomorrow./2/{}*Thanks*"  
'Message="/Dear sir//{}Hope we meet tomorrow.//{}*Thanks*"  
'</code>  
Sub CS (Message As String) As CSBuilder  
    Dim msg As CSBuilder  
    msg.Initialize  
    '——————-  
    If Not (Message.Contains("/")) Then  
        msg.Append(Message).PopAll  
        Return  msg  
    End If  
    '——————–  
    Log("Now to start my CS")  
     
    Dim L,i As Int  
    Dim P() As String' Parts of string  
     
    P=Regex.Split("/",Message)  
    L=P.Length 'How many parts  
    If L Mod 2 <>0 Then L=L-1 ' If L is odd we delete the last part  
     
    Dim C(L) As Int 'Color of part P(i)  
     
    For i=0 To L-1  
        Log("P ("&i&")= " & P(i))  
  
        If i Mod 2=0 Then '——————–  
            'Even part  
            Select P(i).ToLowerCase 'same color numbers as DOS  
                'Case "black","0","":C(i)=Colors.DarkGray  
                Case "blue","1":C(i)=Colors.blue  
                Case "green","2":C(i)=Colors.green  
                Case "cyan","3":C(i)=Colors.Cyan  
                Case "red","4":C(i)=Colors.red  
                Case "magenta","5":C(i)=Colors.Magenta  
                Case "yellow","6":C(i)=Colors.yellow  
                Case "white","7":C(i)=Colors.white  
                Case "gray","8":C(i)=Colors.gray  
                Case Else  
                    C(i)=Colors.DarkGray  
            End Select  
        Else '——————–  
            'Odd part  
            If p(i).StartsWith("{}") Then 'add a new line  
                msg.Append(CRLF)  
                P(i)=P(i).SubString(2)  
            End If  
             
            If p(i).StartsWith("*") And P(i).EndsWith("*") Then ' Bold text must be like: *txt*  
                P(i)=P(i).Replace("*","")  
                msg.Color(C(i-1)).Bold.Append(P(i)).Pop.Pop  
            Else  
                msg.Color(C(i-1)).Append(P(i)).Pop  
            End If  
        End If '——————–  
    Next  
    msg.append("").PopAll  
    Return msg  
End Sub
```