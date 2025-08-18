### Find a missing value using Approximation & Guesswork (Goal Seek) by Col
### 11/18/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/136144/)

I have written a few Financial Calculators over the past couple of weeks, and one approach I've found extremely useful is Approximation and Guesswork.  
So I figured, why not share the approach with the forum,   

- A) to hopefully inform and
- B) to see if anyone else has any other intriguing approaches.

  
Rather than re-inventing a load of different functions to find missing values, I take one formula and turn it around (rather similar to the Goal Seek in Excel).  
  
  
Here's how my version of approximation works:  
![](https://www.b4x.com/android/forum/attachments/121882)  
*(This is the old Jackson Structured Programming diagram - still relevant today ;) (aka JSP))*  
  
  
The beauty of the Approximation approach is that **you can find any missing parameter to any calculation** with no prior knowledge of the actual calculation itself!  
And it's fast.  
  
In this example, I have used a low value of 0 years, a high value of 100 years, so the mid is 50 years.   
Each loop halves the difference between the low and mid, or the mid and high, so in a very small number of iterations, you can get from 100 years down to single digits very quickly.:  
[TABLE]  
[TR]  
[TD]Iteration[/TD]  
[TD]Low[/TD]  
[TD]Mid[/TD]  
[TD]High[/TD]  
[/TR]  
[TR]  
[TD]1[/TD]  
[TD]0[/TD]  
[TD]50[/TD]  
[TD]100[/TD]  
[/TR]  
[TR]  
[TD]2[/TD]  
[TD]0[/TD]  
[TD]25[/TD]  
[TD]50[/TD]  
[/TR]  
[TR]  
[TD]3[/TD]  
[TD]0[/TD]  
[TD]12.5[/TD]  
[TD]25[/TD]  
[/TR]  
[TR]  
[TD]4[/TD]  
[TD]0[/TD]  
[TD]6.75[/TD]  
[TD]12.5[/TD]  
[/TR]  
[TR]  
[TD]5[/TD]  
[TD]0[/TD]  
[TD]**3.87**[/TD]  
[TD]6.75[/TD]  
[/TR]  
[/TABLE]  
  
*After only 5 loops, we are already very close to the required answer*. The example below takes about 20 loops to get to the final result. Sometimes, I will build in a 'tolerance' amount, which can significantly reduce the iterations, but when dealing with calculators, it's more important to be accurate, so I decide on a tolerance on a case-by-case basis.   
  
  
In the example below, I've set up a simple Present Value (PV) function. It takes three parameters - the Future Fund Value, the Interest Rate and the Term, and returns the present value of the funds. But **the approach can be applied to any complex calculation you can think of**.  
  
Here's the code:  
  

```B4X
Sub PV(FV As Double, rate As Double, term As Double) As Double  
    Return(FV * (1 / (Power((1+rate),term))))  
End Sub
```

  
  
  
In my Approximation routine, I am attempting to find the Term (I expect to get an answer of 5 years in this case)   

```B4X
Sub Approximate  
    Dim Mid As Double = 50                        ' Mid value is the value we will use to calculate the PV (When the Target result is reached, the Mid value ifs the one we want  
    Dim Low As Double = 0                        ' Used to control how Mid value is calculated  
    Dim High As Double = 100                    ' also used to control how the mid value is calculated  
    Dim Target As Double                        ' The target value we want to achieve       
    Dim myPV As Double = 0                        ' Holds the result from the PV calculation     
    Dim myFV As Double = 5000                    ' The Future Value Amount  
    Dim myRate As Double = .03                    ' The Annual Interest Rate  
  
    Target = (PV(myFV,.03,5))                    ' TARGET IS SET UP HERE ONLY TO AID THE EXAMPLE.   
    Log("Target: " & Target)  
      
    Do While (Round2(myPV,2)<>Round2(Target,2))         
        myPV = PV(myFV, myRate, Mid)             
        Log("Low: " & Round2(Low,2) & ";  Mid: " & Round2(Mid,2) & ";   High: " & Round2(High,2) & "   -   Result=" & Round2(myPV,2))  
          
        If Round2(myPV,2) > Target Then                                                             
            Low = Mid                                                         
        else if Round2(myPV,2) < Target Then     
            High = Mid                             
        End If  
          
        Mid = (Low + High) / 2                     
    Loop     
    xui.MsgboxAsync(Round2(Mid,2),"Result")     
End Sub
```

  
  
  
  
  
*The "Log" statement will give you a good idea of what's happening in the background*.  
  
I first came across the Approximation approach wayyyyyy back in 1979, when I was writing code using punch cards in Assembler (Search for punch cards - it's worth it :)), and I think the technique is still relevant today. It brought a nostalgic smile back to my face when I used it recently to make some very complex financial calculations.