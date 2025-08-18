### [XLUtils] Conditional formatting by Erel
### 05/06/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130454/)

XLUtils v1.05 adds support for conditional formatting.  
  
![](https://www.b4x.com/android/forum/attachments/112943)  
  
A conditional formatting element is made of the applied range and one or more rules. A rule is made of a formula and formatting effects.  
The formula will be evaluated on each cell in the range. By using a relative address to the first cell in the formula, we are actually referencing all cells in range.  
  
Adding conditional formatting is done in three steps:  
1. Create one or more rules using Sheet.CreateConditionalFormattingRule.  
2. Set the formatting effects.  
3. Add the rules with Sheet.AddConditionalFormatting.  
  
The attached example demonstrates several kinds of rules.