###  Resumable subs and the index pattern by Erel
### 11/24/2019
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/111487/)

The "index pattern" is a pattern that you can see in many examples and libraries where resumable subs are used. It is a simple solution to avoid race conditions and unexpected states.  
  
The resumable subs code like all other standard B4X code, is executed by the main thread. Still, with resumable subs you can easily have multiple instances of the same sub running almost at the same time.  
  
As an example we will update the value of a label based on the value of a B4XSeekBar (XUI Views). Instead of setting the value directly we want to be more sophisticated and change it gradually until it reaches the desired value.  
  

```B4X
Sub B4XSeekBar1_ValueChanged (Value As Int)  
   Do Until Label1.Text = Value  
       If Value > Label1.Text Then  
           Label1.Text = Label1.Text + 1  
       Else If Value < Label1.Text Then  
           Label1.Text = Label1.Text - 1  
       End If  
       Sleep(30)  
   Loop  
End Sub
```

  
  
![](https://www.b4x.com/basic4android/images/NJeTxy7Qoo.gif)  
  
It looks like it is working properly, however if we change the bar value while the label is being updated then bad things start to happen (it looks much worse in the real app):  
  
![](https://www.b4x.com/basic4android/images/v15xrVPseW.gif)  
B4XSeekBar1\_ValueChanged was called multiple times and there are now multiple instances of this sub running, each one with a different target value. This causes the label value to go back and forth.  
  
We want to cancel previous running instances when the value changes. The solution is quite simple:  

```B4X
Sub B4XSeekBar1_ValueChanged (Value As Int)  
   Label1Index = Label1Index + 1 'global Int variable  
   Dim MyIndex As Int = Label1Index  
   Do Until Label1.Text = Value  
       If Value > Label1.Text Then  
           Label1.Text = Label1.Text + 1  
       Else If Value < Label1.Text Then  
           Label1.Text = Label1.Text - 1  
       End If  
       Sleep(30)  
       'Need to check after every call to Sleep or Wait For  
       If MyIndex <> Label1Index Then Return  
   Loop  
End Sub
```

  
  
Whenever the sub instance is resumed after Sleep or Wait For we check whether MyIndex, which is a local variable specific to each sub instance, is the same as the global Label1Index variable. If not we immediately return.  
  
Result:  
  
![](https://www.b4x.com/basic4android/images/VV5CjmJ2LU.gif)  
  
As you can see the label is updated correctly even though the ValueChanged is raised many many times.