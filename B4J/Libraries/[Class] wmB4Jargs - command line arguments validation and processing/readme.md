### [Class] wmB4Jargs - command line arguments validation and processing by walt61
### 05/31/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165321/)

See title; new version as of 2026-05-31, see post #3 for the changes. Demo project updated, and B4Xlib also attached.  
  
Example code (from the attached demo project):  

```B4X
Sub AppStart (Args() As String)  
  
    Dim wmB4Jargs1 As wmB4Jargs  
    wmB4Jargs1.Initialize  
    wmB4Jargs1.AddStandaloneArg("–help", "-h", "Prints this help text and terminates", False)  
    wmB4Jargs1.AddStandaloneArg("–nodetails", "-n", "This (optional) argument stands alone and does not need a value", False)  
    wmB4Jargs1.AddValueArg("–number", "-u", "The 'number' argument (optional) needs a numeric value", False, True)  
    wmB4Jargs1.AddPermittedValuesArg("–selectednumber", "-s", "'SelectedNumber' (optional) needs an integer value between 1 and 5 (both included)", False, Array(1, 2, 3, 4, 5), True)  
    wmB4Jargs1.AddPermittedValuesArg("–animal", "-a", "The 'animal' argument (required) needs one of these values: Ape, Bear, Cat", True, Array("Ape", "Bear", "Cat"), False)  
    wmB4Jargs1.AddMultipleValuesArg("–multiple", "-m", "2 to 4 values that must be validated by the caller", False, 2, 4)  
  
    'wmB4Jargs1.LogValuesBeforeParsing = True  
    Dim wmB4JargsResult1 As wmB4JargsResult = wmB4Jargs1.ParseCaseInsensitive(Args)  
    If wmB4JargsResult1.valuesMap.ContainsKey("–help") Then  
        wmB4Jargs1.PrintHelp2(appName, 26, 80, True, " " & CRLF & "This is some optional preface text" & CRLF, " " & CRLF & "This is some optional epilogue text", False)  
        ExitApplication  
        Return  
    Else If wmB4JargsResult1.firstError <> 0 Then  
        Log(" ")  
        Log("Command line argument error" & IIf(wmB4JargsResult1.offendingArg = "", "", " (" & wmB4JargsResult1.offendingArg & ")") & ": " & wmB4JargsResult1.errorMsg)  
        Log("Use '" & appName & " -h' for help")  
        ExitApplication2(1)  
        Return  
    End If  
  
    Log("Argument values found:")  
    Log("Animal: " & wmB4JargsResult1.valuesMap.GetDefault("–animal", "<not specified>"))  
    Log("NoDetails: " & wmB4JargsResult1.valuesMap.GetDefault("–nodetails", "<not specified>"))  
    Log("Number: " & wmB4JargsResult1.valuesMap.GetDefault("–number", "<not specified>"))  
    Log("SelectedNumber: " & wmB4JargsResult1.valuesMap.GetDefault("–selectednumber", "<not specified>"))  
    If wmB4JargsResult1.valuesMap.ContainsKey("–multiple") Then  
        Log("Multiple (a List) is: " & wmB4JargsResult1.valuesMap.Get("–multiple").As(List))  
    End If  
  
End Sub
```

  
  
Generated output:  

```B4X
'Output for #CommandLineArgs: –Animal cat –NODETAILS –number 7 -s 3  
Argument values found:  
Animal: cat  
NoDetails: true  
Number: 7  
SelectedNumber: 3  
  
'Output for #CommandLineArgs: –Animal cat –number 7 -s 3  
Argument values found:  
Animal: cat  
NoDetails: <not specified>  
Number: 7  
SelectedNumber: 3  
  
'Output for #CommandLineArgs: –Animal=cat –NODETAILS –multiple a b c –number 7 -s 3  
Argument values found:  
Animal: cat  
NoDetails: true  
Number: 7  
SelectedNumber: 3  
Multiple (a List) is: (ArrayList) [a, b, c]  
  
'Output for #CommandLineArgs: –NODETAILS –number 7 -s 3  
 Command line argument error (–animal): Required argument is missing  
Use 'wmB4JargsDemo -h' for help  
  
  
' Output for the PrintHelp2 method:  
wmB4JargsDemo  
   
This is some optional preface text  
   
[-h], [–help]            Prints this help text and terminates  
   
[-n], [–nodetails]       This (optional) argument stands alone and does not need  
                          a value  
   
[-u], [–number]          The 'number' argument (optional) needs a numeric value  
   
[-s], [–selectednumber]  'SelectedNumber' (optional) needs an integer value  
                          between 1 and 5 (both included)  
   
-a, –animal              The 'animal' argument (required) needs one of these  
                          values: Ape, Bear, Cat  
   
[-m], [–multiple]        2 to 4 values that must be validated by the caller  
   
This is some optional epilogue text
```