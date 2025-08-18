### Using Infinity and NaN as special Numbers by William Lancee
### 09/06/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/122017/)

[USER=74323]@wonder[/USER] posted <https://www.b4x.com/android/forum/threads/return-nan-and-infinity.106046/post-663817>  
  
This is an addendum to his posting to show how these two objects are both numbers and not numbers, and how to test for that.  

```B4X
Private Sub specialNumbers  
   
    'Infinity behaves in the expected way as as an infinitely large number  
    Dim infinity As Double = 1 / 0  
    Log(infinity = -Logarithm(0, cE))        'True  
    Log((infinity = infinity))                      'True  
    Log((infinity = -infinity))                    'False  
    Log(TAB)  
  
    Log((infinity + 5))                       'Infinity  
    Log((infinity - 5))                        'Infinity  
    Log((infinity * 5))                        'Infinity  
    Log((infinity / 5))                        'Infinity  
    Log((infinity / 0))                        'Infinity  
    Log(infinity * infinity)                 'Infinity  
    Log(Sqrt(infinity))                       'Infinity  
    Log(Power(cE, infinity))              'Infinity  
   
    'Numberformat shows a nice infinity symbol  
    Log(NumberFormat2(infinity, 1, 0, 0, False))    '∞  
   
  
    Log((1 / infinity))                        '0  
    Log((100 / infinity))                    '0  
    Log((1000 / infinity))                   '0  
    Log((1000 / -infinity))                 '-0  
    Log(TAB)  
   
    'However, like the Sqrt(-1), the following are undefined and therefore NaN  
    Log((infinity / infinity))         'NaN  
    Log((infinity / -infinity))        'NaN  
  
    'The simplest NaN is 0 / 0  
    Dim NaN As Double = 0 / 0  
    Log((NaN = Sqrt(-1000)))        'False    - this is unexpected, but understandable given that the comparison of NaN with anything return False  
    Log((NaN = NaN))                   'False  
    Log((NaN = -NaN))                  'False  
    Log((NaN = "NaN"))                 'False - this is unexpected, but understandable given the order of the string conversion  
    Log(("NaN" = NaN))                 'True  
  
    'IsNumber only checks if string can be converted to number, so it's argument is first converted to a string "NaN"  
    '                                        which is (paradoxically) interpreted as a valid a number  
    Log(IsNumber(Sqrt(-1)))            'True  
    Log(IsNumber(0 / 0))                 'True  
    Log(IsNumber(0))                      'True  
    Log(IsNumber(infinity))             'True  
  
    'NaN is the only "number" that is not equal to itself - this can be used to test for NaN - see  
        'Private Sub IsNaN(z As Double) As Boolean  
        '    Return z <> z  
        'End Sub  
   
    Log(IsNaN(Sqrt(-1)))            'True  
    Log(IsNaN(0 / 0))                 'True  
    Log(IsNaN(0))                       'False  
    Log(IsNaN(infinity))              'False  
    Log(IsNaN(NaN))                  'True  
   
    'all computations with NaN result in NaN          [NaN could be used as "missing" value in Statistics]  
    Log((NaN + 5))                   'NaN  
    Log((NaN - 5))                    'NaN  
    Log((NaN * 5))                    'NaN  
    Log((NaN / 5))                    'NaN  
    Log((NaN / 0))                    'NaN  
    Log(NaN * NaN)                 'NaN  
    Log(Sqrt(NaN))                   'NaN  
    Log(Power(cE, NaN))          'NaN  
    Log((1 / NaN))                    'NaN  
    Log((100 / NaN))                'NaN  
    Log((1000 / NaN))              'NaN  
    Log((NaN / NaN))              'NaN  
End Sub  
  
Private Sub IsNaN(z As Double) As Boolean  
    Return z <> z  
End Sub  
  
Private Sub NotNaN(z As Double) As Boolean  
    Return z = z  
End Sub
```