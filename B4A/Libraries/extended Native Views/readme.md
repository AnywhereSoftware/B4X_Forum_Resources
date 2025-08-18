### extended Native Views by Guenter Becker
### 06/27/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/141438/)

Good Day to the audiance, I hope all of you are well.  
  
Have you ever thought that the native Views could have some more properties like a **unique ViewID** or the possibility to attach the **databaound Column Name** a.s.o. I often had theses whishes and over the time I coded the needed functions again and again. Now I started a new Project to realize my whishes. The code is open therefor you are invited to make own optimizations and enhancement. At the moment I like to publish the results of the first step the open rest will follow. Have look at it, work with it and reply if you find possible errors. Thank you.  
  
If you like it and want to get more. please place a reply here with your proposals and whises.  
  
Best regards Guenter  
  
![](https://www.b4x.com/android/forum/attachments/130861)  
  
Name: TDextEditText, TDextRadioButton, TDextCheckBox  
Type: Coded in B4A, B4xlib  
Version: 1  
(C) TechDoc G. Becker, Royalty Free for personel and commercial use  
  
**Notice!** to get readable code rename the .b4xlib files to .zip and unzip them to get the .bas files.  
  
' ##### extended Views  
 ' EditText -> TDextEditText  
 ' RadioButton -> TDextRadioButton  
 ' CheckBox -> TDExtCheckBox  
 ' ImagView -> step 2  
 ' ListView -> step 2  
 ' Spinner -> step 3  
 ' Progressbar -> step 3  
   
 ' ##### Views Properties get/set by code  
 ' ##### other Custom Properties set by Designer  
   
 ' ##### TDextEditText ##################  
 ' TDextEditText1.BorderColor = set border color  
 ' TDextEditText1.InputChars = set only allowed chars for the keyboard  
 ' TDextEditText1.Spellcheck = set Spellchecking on/of (True/False)  
 ' TDextEditText1.Text = set Text  
 ' TDextEditText1.TextColor = set Textcolor  
 ' TDextEditText1.TextSize = set Textsize  
   
 ' TDextEditText1.BringToFront bring view to front  
 ' TDextEditText1.EditTextView get view internal EditTextView  
 ' TDextEditText1.GetFocus set Focus to view  
   
 ' X = TDextEditText1.ViewID get unique ViewID (String)  
 ' x = TDextEditText1.ColumnName get Databaound ColumnName  
 ' x = TDextEditText1.ColumnType get Datatbound ColumnTye  
 ' x = TDextEditText1.EditTextView get the EditTextView Object  
  
 'possibility to show a border if focused or allways  
  
 'date/time/datetime column type leads to check input against date and time format  
 'possibility to set an audio beep if an error occurs  
 'posibility to show an error background color if error occurs  
  
 ' ##### Views Custom Properties DesignerView  
 ' All Text Properties of the native EditTextView  
 ' ViewID: Custom uniqe ID to identify the view  
 ' Spell Check: switch it on/off  
 ' Column Name: Name of the databound Tablecolumn  
 ' Column Typ: Type of the databound Tablecolumn  
 ' Input Max Length  
 ' Input Min Length  
 ' Input Chars: enabled chars/keys on the keyboard  
 ' Background Focus Color: background color if has focus  
 ' Text Error Color: color if Date/Time check fails  
 ' Background Error Color: color if Date/Time check fails  
 ' Error Beep: error signal if Date/Time or input length check fails  
 ' Border Focus: view has a border if focused if not next properties values are used  
 ' Border Color  
 ' Border Width  
 ' Border Radius  
  
 ' ##### TDextRadioButton ##################  
 ' TDextRadioButton.Text = set Text  
 ' TDextRadioButton.TextColor = set Textcolor  
 ' TDextRadioButton.TextSize = set Textsize  
 ' TDextRadioButton.Checked = true/false  
 ' X = TDextRadioButton.RadioButton get the internal RadioButton Object  
 ' X = TDextRadioButton.Value get current value  
 ' TDextRadioButton.value = set Value/checked  
   
 ' ViewID: Custom uniqe ID to identify the view  
 ' Column Name: Name of the databound Tablecolumn  
 ' Column Typ: Type of the databound Tablecolumn  
 ' Value: checked=1, not checked=0 -> you can store only integer to SQLite  
   
 ' ##### TDextCheckBox ##################  
 ' TDextCheckBox.Text = set Text  
 ' TDextCheckBox.TextColor = set Textcolor  
 ' TDextCheckBox.TextSize = set Textsize  
 ' TDextCheckBox.Checked = true/false  
 ' X = TDextCheckBox.RadioButton get the internal RadioButton Object  
 ' X = TDextCheckBox1.Value get current value  
 ' TDextCheckBox1.value = set Value/checked  
   
 ' ViewID: Custom uniqe ID to identify the view  
 ' Column Name: Name of the databound Tablecolumn  
 ' Column Typ: Type of the databound Tablecolumn  
 ' Value: checked=1, not checked=0 -> you can store only integer to SQLite  
   
 ' ##### more to be done ##################  
 >>>> your whishes??