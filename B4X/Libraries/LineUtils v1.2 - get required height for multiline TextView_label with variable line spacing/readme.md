###  LineUtils v1.2 - get required height for multiline TextView/label with variable line spacing by epiCode
### 02/27/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/138786/)

**LineUtils  
Version:** 1.2  
  
Based on code by Erel for StringUtils function MeasureMultilineTextHeight  
 StringUtils function calculates the height for multiplier value 1 only.  
 With this function you can calculate height with variable line spacing.  
   
  

- **LineUtils**
Methods:

- **getMultilineHeight** (TextView As android.widget.TextView, Text As java.lang.CharSequence, multi As float) **As int**
Returns the required height in order to show the given text in a label with varying line spacing.
This can be used to show dynamic text in a label.
Note that the label must first be added to its parent and only then its height can be set.
*Usage: getMultiLineHeight( TextView as android.widget.TextView , Text as CharSequence, multiplier as float)  
 Multiplier is Line Spacing Multiplier, where 1 is normal, 2 is double line spacing so on…   
   
**Example:**  
 Dim Label1 As Label  
 Label1.Initialize("")  
 Label1.Text = "this is a long sentence, and we need to " \_   
 & "know the height required in order To show it completely."  
 Label1.TextSize = 20  
 Activity.AddView(Label1, 10dip, 10dip, 200dip, 30dip)  
 Dim LineS As LineUtils  
 Label1.Height = LineS.getMultilineHeight(Label1, Label1.Text, 1.5)*
  

```B4X
    public int getMultilineHeight(TextView TextView, CharSequence Text, float multi) {  
        StaticLayout sl = new StaticLayout(Text, TextView.getPaint(),  
                TextView.getLayoutParams().width - TextView.getPaddingLeft() - TextView.getPaddingRight(),  
                Alignment.ALIGN_NORMAL, multi, 0 , true);  
        return sl.getLineTop(sl.getLineCount());  
    }
```