### Correct this misconseption - "Call B4R subs from InLine c code" - see post #2 by hatzisn
### 09/29/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/110022/)

Having had my work flow cut down in the middle by vicious "circumstances" I decided to let it all go and "go fishing" as mr. Miyaghi (Karate kid) would say. So I did some things I couldn't do while being on the run and today I remembered to deal again (just for fun) with a problem that bugged me in the past and I couldn't find a solution until today.  
  
The problem was how to combine the UTFT and URTouch libraries (<http://rinkydinkelectronics.com/>) to create interface in a TFT screen that can interact with B4R code. It was a firewall that you just couldn't go through so I figured out that I should go around it. All you have to do is call from your c code on tft clicks the voids firstbutton, secondbutton. There is also the possibility to activate the timer manually in the voids but my c knowledge to do this is limited and further more I do not know if the Timer Object in the B4R universe is a wrapper or not. Here is the solution:  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
  
Sub Process_Globals  
   Public Serial1 As Serial  
   Private iSel As Int  
   Dim tim As Timer  
   
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   Log("AppStart")  
   iSel = -1  
   tim.Initialize("tim_Tick",200)  
   tim.Enabled = True  
End Sub  
  
  
Private Sub tim_Tick  
    Select Case iSel  
        Case -1  
            '  
        Case 1  
            FirstCallThis  
        Case 2  
            ThenCallThis  
    End Select  
    iSel = -1  
End Sub  
  
Private Sub FirstCallThis  
     
End Sub  
  
Private Sub ThenCallThis  
     
End Sub  
  
  
#if C  
void firstbutton (B4R::Object* o) {  
   b4r_main::_isel=1;  
}  
  
void secondbutton (B4R::Object* o) {  
   b4r_main::_isel=2;  
}  
#End if
```