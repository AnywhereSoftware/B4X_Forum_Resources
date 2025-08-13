###  B4XFormatter - Advanced number formatter by Erel
### 05/21/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/102055/)

B4XFormatter is an alternative to NumberFormat / NumberFormat2 keywords. It is implemented in B4X and it is cross platform.  
  
There are two types in the library:  
  
B4XFormatter - The main class.  
B4XFormatData - A type with various configurable fields.  
  
The formatter holds a list of format data objects. A new formatter starts with a single format data which acts as the default format.  
  

```B4X
formatter.Initialize  
formatter.GetDefaultFormat.MaximumFractions = 3  
formatter.GetDefaultFormat.MinimumFractions = 3  
Log(formatter.Format(12.34))
```

  
Output: 12.340  
  
You can add more formats to the formatter. Each format except of the default format has a specific range. You can for example add a format for negative numbers:  
  

```B4X
formatter.Initialize  
Dim DefaultFormat As B4XFormatData = formatter.GetDefaultFormat  
DefaultFormat.MaximumFractions = 2  
DefaultFormat.MinimumFractions = 2  
DefaultFormat.Prefix = "$ "  
Dim NegativeFormat As B4XFormatData = formatter.CopyFormatData(DefaultFormat)  
NegativeFormat.TextColor = xui.Color_Red  
NegativeFormat.Prefix = "$ ("  
NegativeFormat.Postfix = ")"  
NegativeFormat.FormatFont = xui.CreateDefaultBoldFont(15)  
formatter.AddFormatData(NegativeFormat, formatter.MIN_VALUE, 0, False) 'from MIN_VALUE to 0 not including the edges
```

  
  
Result:  
![](https://www.b4x.com/basic4android/images/SS-2019-01-29_17.59.00.png)  
  
The idea is to configure the formatter once and later use it to format numbers in different ranges.  
  
There are two 'format' methods:  
Format - Formats a number and returns a string.  
FormatLabel - Formats a number and sets it as the label's Text property. This method respects the format data TextColor and FormatFont fields.  
  
As you can see in the above code the negative format is created by copying the default format. You can add as many formats as you need. When a number is formatted it goes over the list of formats, starting from the last one added, until it finds a format with a range that contains the number.  
  
B4XFormatData fields:  

- Prefix - Arbitrary string that is added before the number.
- Postfix - Arbitrary string that is added after the number.
- MinimumIntegers - Minimum number of integers. Will pad the number with 0s when needed.
- MinimumFractions - Minimum number of fraction digits. Will pad the number with 0s when needed.
- MaximumFractions - Maximum number of fraction digits.
- GroupingCharacter - Thousands separator. Default value is comma. Set to empty string if not needed.
- DecimalPoint - Decimal point character. Default value is dot.
- TextColor / FormatFont - Relevant when calling FormatLabel.
- RemoveMinusSign - Set to True to remove the minus sign for negative numbers.

  
**Updates**  
  
V1.04 - Fixes issue with B4J non-ui projects.  
V1.03 - Adds support for B4J non-ui projects.  
V1.02 - NewFormatData method: creates a copy of the default format.  
- Bug fix related to format data copies.  
  
- V1.01 - B4XFormatData new fields: IntegerPaddingChar and FractionPaddingChar. Default values are "0".  
Example:  

```B4X
formatter.GetDefaultFormat.FractionPaddingChar = "X"  
formatter.GetDefaultFormat.IntegerPaddingChar = "B"  
Log(formatter.Format(12.34)) 'output: B12.34XX
```

  
  
The library and a small example are attached.  
**This is an internal library.** 