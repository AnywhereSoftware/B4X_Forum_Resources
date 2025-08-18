### Offline calculation of call to prayer time and religious times by b4a programmer
### 04/17/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/129823/)

Hello,  
Happy Ramazan  
I found a piece of code today and I will share it with you.  
This code calculates the call to prayer offline with advanced mathematical algorithms.  
This code is very suitable for making Saying the call to prayer programs.  
I put this piece of code here to promote the religion of Islam :  
I hope you get enough use:  
  

```B4X
Sub GetReligious_times(Month As Int,Day As Int,Longitude As Object,latitude As Object,Second_Show As Boolean,Official_time As Boolean) As Object  
    Private azan(6) As String  
    Private a_1(6) As Object  
    If Month=0 Or Month<0 Or Month>12 Then  
        Log("Month must be between 1 and 12 -> Input value is invalid for the Month.")  
        Return  
    End If  
    If Day <= 0 Or Day > 31 Then  
        Log ("Day must be between 1 and 31 -> Input value is invalid for the Day.")  
        Return  
    End If  
    Private m As Object=Month  
    Private d As Object=Day  
    Private lg As Object=Longitude  
    Private lat As Object=latitude  
    Private seconds As Object  
    Private dslst As Object  
    If Second_Show=True Then  
        seconds=1  
    Else  
        seconds=0  
    End If  
    If Official_time=True Then  
        dslst=1  
    Else  
        dslst=0  
    End If  
    Private a_2() As Object=Array("107.695","90.833","0","90.833","94.5","0")  
    Private doy_1 As Object  
  
    If m<7 Then  
        doy_1=(m-1)+((m-1)*30) + d  
    Else  
        doy_1=(6)+((m-1)*30) + d  
    End If  
  
    Private h As Object=0  
    For i=0 To 5  
  
        Private s_m As Object=m  
        Private s_lg  As Object=lg  
        If i<5 Then  
  
            Private doy As Object=doy_1+(h/24)  
  
            s_m=74.2023+(0.98560026*doy)  
            Private s_l As Object=(-2.75043)+(0.98564735*doy)  
  
            Private s_lst As Object=8.3162159+(0.065709824*Floor(doy))+(24.06570984*fmod(doy,1))+(s_lg/15)  
            Private s_omega As Object=(4.85131-(0.052954*doy))*0.0174532  
            Private s_ep As Object=(23.4384717+(0.00256*Cos(s_omega)))*0.0174532  
            Private s_u As Object=s_m  
  
            For s_i=1 To 4  
                s_u=s_u-((s_u-s_m-(0.95721*Sin(0.0174532*s_u)))/(1-(0.0167065*Cos(0.0174532*s_u))))  
            Next  
      
            Private s_v As Object=2*(ATan(Tan(0.00872664*s_u)*1.0168)*57.2957)  
            Private s_theta As Object=(s_v-s_m-2.75612-(0.00479*Sin(s_omega))+(0.98564735*doy))*0.0174532  
            Private s_delta As Object=ASin(Sin(s_ep)*Sin(s_theta))*57.2957  
            Private s_alpha As Object=57.2957*ATan2(Cos(s_ep)*Sin(s_theta),Cos(s_theta))  
            If(s_alpha>=360)Then s_alpha=s_alpha-360  
            Private s_ha As Object=s_lst-(s_alpha/15)  
            Private s_zohr As Object=fmod(h-s_ha,24)  
            Private loc2hor As Object  
  
            loc2hor=((ACos(((Cos(0.0174532*a_2(i))-Sin(0.0174532*s_delta)*Sin(0.0174532*lat))/Cos(0.0174532*s_delta)/Cos(0.0174532*lat)))*57.2957)/15)  
  
            Private myint2 As Object  
            If i<2 Then  
                myint2=s_zohr-loc2hor  
            Else If i>2 Then  
                myint2=s_zohr+loc2hor  
            Else  
                myint2=s_zohr  
            End If  
  
            Private my_azan As String=fmod(myint2,24)  
            azan(i)=my_azan  
        Else  
          
            azan(i)=(azan(0)+azan(3)+24)/2  
        End If  
          
        Private x As Object=azan(i)  
        If dslst=1 And doy_1>1 And doy_1<186 Then  
          
            x=x+1  
        Else  
  
            dslst=0  
        End If  
        If(x<0) Then  
            x=x+24  
        Else if x>=24 Then  
            x=x-24  
        End If  
  
        Private hor As Object=Ceil(x)  
        Private ml As Object=fmod(x,1)*60  
        Private Min1 As Object=Ceil(ml)  
        Private mr As Object=Round(ml)  
        Private sec As Object=Ceil(fmod(ml,1)*60)  
      
        If hor < 10 Then  
            a_1(i)="0"&(hor-1)&":"  
        Else  
            a_1(i)=""&(hor-1)&":"  
        End If  
  
        If seconds=0 Then  
            If mr<10 Then  
                a_1(i)=a_1(i)&"0"&mr  
            Else  
                a_1(i)=a_1(i)&""&mr  
            End If  
      
        Else  
            If Min1<"10" Then  
                a_1(i)=a_1(i)&"0"&(Min1-1)&":"  
            Else  
                a_1(i)=a_1(i)&""&(Min1-1)&":"  
            End If  
            If sec<"10" Then  
                a_1(i)=a_1(i)&"0"&(sec-1)  
            Else  
                a_1(i)=a_1(i)&""&(sec-1)  
            End If  
        End If  
      
      
        If(h="0") Then  
            h=azan(i)  
            i=i-1  
        Else  
            h="0"  
        End If  
    Next  
  
    Private output(6) As Object  
    For o = 0 To 5  
        output(o)=a_1(o)  
    Next  
    Return output  
End Sub  
  
Private Sub fmod(s1 As Object , s2 As Object) As Object  
    Return s1 Mod s2  
End Sub
```