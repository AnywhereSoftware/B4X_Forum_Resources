###  Mapping a range of numbers into a target number of simplified categories by William Lancee
### 07/17/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/132661/)

For humans it is easy to do this, but it is hard to translate the idea of "simplified" into an algorithm.   
I needed this, so I thought I'd share. Apologies if this has already done by others - if so, I couldn't find it.  
  

```B4X
'Mapping a range of numbers into a target number of simplified categories  
Sub AppStart (Args() As String)  
    Dim ncategories As Int = 15            'or close to this  
    Dim minValue As Double = 1134.7  
    Dim maxValue As Double = 25185.8  
    Dim lowerBoundaries As List = thresholds(ncategories, minValue, maxValue)  
    For i = 1 To lowerBoundaries.Size - 1  
        Dim lower As String = NumberFormat2(lowerBoundaries.Get(i-1), 1, 5, 0, False)  
        Dim upper As String = NumberFormat2(lowerBoundaries.Get(i), 1, 5, 0, False)  
        Log(i & TAB & lower & IIf(i < lowerBoundaries.Size - 1, " up to (excl.) " & upper, " up to (incl.) " & maxValue))  
    Next  
    'Log:  
        '1    1000 up to (excl.) 3000  
        '2    3000 up to (excl.) 5000  
        '3    5000 up to (excl.) 7000  
        '4    7000 up to (excl.) 9000  
        '5    9000 up to (excl.) 11000  
        '6    11000 up to (excl.) 13000  
        '7    13000 up to (excl.) 15000  
        '8    15000 up to (excl.) 17000  
        '9    17000 up to (excl.) 19000  
        '10    19000 up to (excl.) 21000  
        '11    21000 up to (excl.) 23000  
        '12    23000 up to (excl.) 25000  
        '13    25000 up to (incl.) 25185.8  
  
    'This alogoritm can also be used to do the same thing for dates - with a bit of pre and post processing  
    DateTime.DateFormat = "yyyy-MM-dd"  
    Log(TAB)  
    Dim ncategories As Int = 15            'or close to this  
    Dim minDate As String = "1995-04-21"  
    Dim maxDate As String = "2021-07-17"  
    Dim lowerBoundaries As List = periods(ncategories, minDate, maxDate)  
    For i = 1 To lowerBoundaries.Size - 1  
        Dim lower As String = lowerBoundaries.Get(i-1)  
        Dim upper As String = lowerBoundaries.Get(i)  
        Log(i & TAB & lower & IIf(i < lowerBoundaries.Size - 1, " up to (excl.) " & upper, " up to (incl.) " & maxDate))  
    Next  
    'Log:    
        '1    1994-01-01 up to (excl.) 1996-01-01  
        '2    1996-01-01 up to (excl.) 1998-01-01  
        '3    1998-01-01 up to (excl.) 2000-01-01  
        '4    2000-01-01 up to (excl.) 2002-01-01  
        '5    2002-01-01 up to (excl.) 2004-01-01  
        '6    2004-01-01 up to (excl.) 2006-01-01  
        '7    2006-01-01 up to (excl.) 2008-01-01  
        '8    2008-01-01 up to (excl.) 2010-01-01  
        '9    2010-01-01 up to (excl.) 2012-01-01  
        '10    2012-01-01 up to (excl.) 2014-01-01  
        '11    2014-01-01 up to (excl.) 2016-01-01  
        '12    2016-01-01 up to (excl.) 2018-01-01  
        '13    2018-01-01 up to (excl.) 2020-01-01  
        '14    2020-01-01 up to (incl.) 2021-07-17  
End Sub
```

  
  

```B4X
Sub thresholds(ncats As Int, minimum As Double, maximum As Double) As List  
    Dim result As List: result.Initialize    
    If ncats<>ncats Or ncats = 1/0 Or ncats = 0 Or maximum = minimum Then Return result    'Algorithm fails if ncats = (NaN or infinity or 0) Or range = 0  
    Dim range As Double = maximum - minimum  
    Dim roughStepSize As Double = range / ncats  
    Dim factor As Double = Power(10, Floor(Logarithm(roughStepSize, 10)))    'Factor is .001, .01, 1, 10, 100, 1000 etc.  
    Dim simplifiedStep As Double = factor * Ceil(roughStepSize / factor)    'need largest number, Ceil  
    Dim simplifiedMinimum As Double = factor * Floor(minimum / factor)        'need lowest number, Floor  
    Dim threshold As Double = simplifiedMinimum  
    Dim k As Int                                                            'use multiplier, cumulative adding adds inaccuracy  
    Do Until threshold > (maximum + simplifiedStep)                            'maximum should be less then largest threshold  
        result.add(threshold)  
        k = k + 1  
        threshold = simplifiedMinimum + k * simplifiedStep  
    Loop  
    Return result  
End Sub
```

  
  

```B4X
Sub periods(ncats As Int, earliest As String, latest As String) As List  
    Dim result As List  
    result.Initialize    
    Dim dt0 As Long = DateTime.DateParse(earliest)  
    Dim dtn As Long = DateTime.DateParse(latest)  
    Dim daysBetween As Period = DateUtils.PeriodBetweenInDays(dt0, dtn)  
    Dim range As Long = daysBetween.Days  
    Dim nominalUnit As String            'determine what the units should be (days, weeks, months, years - extend for centuries etc.)  
    Dim minValue, maxValue As Double  
    minValue  = dt0 / DateTime.TicksPerDay  
    maxValue = dtn / DateTime.TicksPerDay  
    If range / 365 > ncats Then  
        nominalUnit = "Years"  
        minValue = minValue / 365  
        maxValue = maxValue / 365  
    Else If range / 30 > ncats Then  
        nominalUnit = "Months"  
        minValue = minValue / 30  
        maxValue = maxValue / 30  
    Else If range / 7 > ncats Then  
        nominalUnit = "Weeks"  
        minValue = minValue / 7  
        maxValue = maxValue / 7  
    Else  
        nominalUnit = "Days"  
    End If  
    Dim tempResult As List = thresholds(ncats, minValue, maxValue)        'can use the numbers algorithm  
    For i = 0 To tempResult.Size - 1  
        Dim d As Long = tempResult.Get(i)  
        Dim dt As String  
        Select nominalUnit  
            Case "Years"  
                dt = DateTime.Date(d * 365 * DateTime.TicksPerDay)  
                dt = dt.SubString2(0, 4) & "-01-01"  
            Case "Months"  
                dt = DateTime.Date(d * 30 * DateTime.TicksPerDay)  
                dt = dt.SubString2(0, 7) & "-01"  
            Case "Weeks"  
                Dim ticks As Long = d * 7 * DateTime.TicksPerDay  
                Dim nearestSunday As Long = ticks - DateTime.GetDayOfWeek(ticks) * DateTime.TicksPerDay  
                dt = DateTime.Date(nearestSunday)  
            Case "Days"  
                dt = DateTime.Date(d)  
        End Select  
        result.Add(dt)  
    Next  
    Return result  
End Sub
```

  
  
P.S. It looks like I am warming up to the use of "IIF"