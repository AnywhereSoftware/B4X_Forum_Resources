### 0.0344827586206896551724137931 = 1/29 by ShepSoft
### 07/14/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/120159/)

**If the title of![](https://www.b4x.com/android/forum/attachments/97107) this snippet in any way intrigues you then here is the routine which did that conversion**.  
You are, however, warned that however intriguing it might be it is all but totally useless …..  
  
Conversion of decimal numbers to neat integer fractions is something you may have learned at school. The basic process is easy. Given 3.65 we just push the dot two places to the right, which means multiplying by 100, then use a divisor (denominator) of 100 and, voila, we have 365/100. We can see, however, that both numerator and denominator are divisible by 5 so the result can be simplified to 73/20.  
  
But what if the number is a never-ending recurring decimal like 0.66666666… ? There's a well-known way to manage that (look at [www.calculatorsoup.com](http://www.calculatorsoup.com) which explains and illustrates it) but it doesn't work properly for non-terminating numbers that do not have a recurring part or whose recurring part is very long.  
  
The algorithm in this snippet works for all types of numbers and is radically simpler than other techniques. As a bonus, it tests the number to see if it is a factor of a set of well-known constants, like π, e, or φ or low order prime roots - √2, √3 and √5. Because it is interesting (to me!) I've thrown in a test for π² as well.  
  
The main algorithm manipulates two Double values which we call n and d. We start a loop and initialise it with d = 1 and n = our number of interest. In each iteration of the loop we divide d by n to get the next value for d and take the fractional part of the reciprocal of n for its next value. In essence it's just two lines:  

```B4X
d = d / n  
n = (1/n) - Floor(1/n)
```

  
As the Loop progresses n gets smaller and d gets larger. We exit the loop when either n is tiny or d is very large. The choice of values used as limits for the loop determines the precision of the results. With the limits used here (n>0.01 and d<10000) accuracy is excellent (e.g 0.0588235294117647 = 1/17). The algorithm is concise, lucid, and fast. It gets 'long period' recurrences exactly right - 0.0344827586206896551724137931 = 1/29. The online tool at [www.CalculatorSoup.com](http://www.CalculatorSoup.com) returns 344827586206 / 9999999999999 partly because it has insufficient input precision but also because it uses an algorithm that doesn't cope with long period recurrences.  
  
We round the results to integers using a value denoted by q. This effectively limits results to shorter denominators. Longer denominators will not be very 'useful' but shorter ones, even though slightly less accurate, are more so. q can be any value above 0 up to about 15 before it causes overflows. A value of 5 gives quite concise and useful approximations.  
  
**Recurring decimals**: In maths we use dotted or overline (vinculum) notation to show recurring digits but we can't easily input that on a standard keyboard. In this code we allow the use of any non-numeric character (other than a dot) to mark the start of a recurring sequence, for example the caret ^, pipe | or even just a space. So a string input of '0.6' will return 3/5 but '0. 6' will return 2/3. Recurring decimals also need adequate precision to yield accurate results. To ensure this without forcing long input strings we fill out the string in code with the recurring part until it is at least 16 digits long.  
  
**Well-known constants**: This code returns a set of results that shows how the number relates to the well-known constants √2, √3, √5, φ, e, π and π². (φ = 'golden mean' = (1+√5)/2 with the properties: φ-1 = 1/φ and φ+1 = φ².) For example, 3.14159 = π. All the results are returned in an 8x3 dimensioned array. The first element of each of the 8 results is a flag used to mark overflow where no real result is calculable ('X' or blank). The second element is the factor symbol (blank, √2, √3, √5, φ, e, π or π²). The third element is the result or an empty string if non-calculable.  
  
There is no attempt to produce a particularly elegant visual output. However, the code includes a short visual formatting routine which adjusts the size and colour of the text of each result according to the 'quality' of the approximation the algorithm has achieved. You can comment out the line with "X" to see all results even if they are not 'useful' ones, in which case blank lines will be shown for non-calculable results.  
  
The code uses no libraries or the Visual Designer - you can just copy and paste this block:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: PointLess Answers  
    #VersionCode: 0  
    #VersionName: 26_06_20  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    Dim saveInput As String  
    Dim saveOutput As String  
End Sub  
  
Sub Globals  
    Dim lbl As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
     
    'base panel  
    Dim rootPanel As Panel  
  rootPanel.Initialize("mBase")  
    rootPanel.Color = Colors.LightGray  
    Activity.AddView(rootPanel,0,0,100%x,100%y)  
  
  'input field              
    Dim et As EditText  
    et.Initialize("ETname")  
    rootPanel.AddView(et,5%x,5%y,90%x,10%y)  
    et.SingleLine = True  
    et.Text = saveInput  
     
  'output label            
    lbl.Initialize("lblName")  
    lbl.TextColor = Colors.White  
    lbl.TextSize = 1  
    lbl.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL  
    lbl.SetTextSizeAnimated(1000,26)  
    Dim cd As ColorDrawable  
    cd.Initialize(0xff880000, 25dip)  
    lbl.Background = cd  
    rootPanel.AddView(lbl,5%x,20%y,90%x,75%y)  
    lbl.Text = saveOutput  
     
End Sub  
  
Sub Activity_Pause(UserClosed As Boolean)  
End Sub  
  
Sub Activity_Resume  
    lbl.Text = FormatResults(saveInput)  
End Sub  
  
Sub ETname_EnterPressed  
    Dim etCtl As EditText = Sender  
    saveInput = etCtl.Text  
    lbl.Text = FormatResults(saveInput)  
End Sub  
  
  
Sub FormatResults(InStr As String) As CSBuilder  
    Private    cs As    CSBuilder  
    cs.Initialize.Bold.Append(InStr & CRLF & "=" & CRLF).Pop  
    Dim h(,) As String = SS_dec2frc(InStr)  
    Dim len As Int, fsz As Double  
    For m = 0 To h.Length -1  
        len = h(m,2).Length  
        If h(m,0) = "X" Or len > 10 Then Continue  
        fsz = 1.5 - (len*0.05)  
        If len <= 6 Then : cs.Color(Colors.Yellow).RelativeSize(fsz)  
        Else : cs.Color(0xFFd0FFd0).RelativeSize(fsz) : End If  
        cs.Append(h(m,2) & CRLF).PopAll  
    Next  
    Return cs  
End Sub  
  
  
Sub SS_dec2frc(InStr As String) As String(,)  
     
    'split input string into integer, non-recurring, & recurring parts  
    InStr = InStr.Trim  
    Dim dot As Boolean = False  
    Dim s() As String = Array As String("","","")  
    Dim c As Char  
    For b = 0 To InStr.length-1  
        c = InStr.CharAt(b)  
        If Asc© <> Asc(".") And (Asc© < Asc("0") Or Asc© > Asc("9")) Then  
            If dot = True Then s(2) = InStr.SubString(b+1)  
            Exit  
        Else If Asc© = Asc(".") Then  
            dot = True  
        Else If dot = True Then  
            s(1) = s(1) & c  
        Else  
            s(0) = s(0) & c  
        End If  
    Next  
     
    'check it's a valid number - return blanks if not  
    Dim ret(8,3) As String  
    Dim out As String = s(0).Trim & "." & s(1).Trim & s(2).Trim  
    If IsNumber(out) = False Then Return ret  
  
    'extend any recurring digits until length is at least 16  
    If s(2).Length > 0 Then  
        Do Until s(2).Length >= 16  
            s(2) = s(2) & s(2)  
        Loop  
    End If  
     
    Dim InDub As Double = s(0) & "." & s(1) & s(2)  
    Dim ItDub As Double = InDub  
    Dim facSym As String = ""  
    Dim q As Int = 4  
     
  'loop the algorithm 8 times for the  
    'basic and 7 other factor results  
    For i = 0 To 7  
         
        facSym = ""  
        Select i  
            Case 1 : facSym = "√2" : ItDub = Round2(InDub/Sqrt(2),q)  
            Case 2 : facSym = "√3" : ItDub = Round2(InDub/Sqrt(3),q)  
            Case 3 : facSym = "√5" : ItDub = Round2(InDub/Sqrt(5),q)  
            Case 4 : facSym = "φ"  : ItDub = Round2(InDub/((1+Sqrt(5))/2),q)  
            Case 5 : facSym = "e"  : ItDub = Round2(InDub/cE,q)  
            Case 6 : facSym = "π"  : ItDub = Round2(InDub/cPI,q)  
            Case 7 : facSym = "π²" : ItDub = Round2(InDub/(cPI*cPI),q)  
        End Select  
         
        'main algorithm  
    Dim nmult As Double = Abs(ItDub)  
    Dim denom As Double = 1  
       Do While nmult > 0.01 And denom < 10000  
        denom = denom/nmult  
        nmult = (1/nmult) - Floor(1/nmult)  
    Loop  
      Dim n As Int = Round2(ItDub*denom,0)  
      Dim d As Int = Round2(denom,0)  
         
    'results  
        '(overflow flag, factor symbol, fraction)  
        ret(i,0) = ""  
        ret(i,1) = facSym  
        ret(i,2) = n & facSym  
      'simplify n & d to avoid showing 1 * facSym or /1  
        If n=1 And facSym <> "" Then ret(i,2) = facSym  
        If d<>1 Then ret(i,2) = ret(i,2) & " / " & d  
        'overflow  
        If n<1 Or d<1 Then  
            ret(i,0) = "X"  
            ret(i,1) = facSym  
            ret(i,2) = ""  
        End If  
  
    Next  
     
    Return ret  
     
End Sub
```