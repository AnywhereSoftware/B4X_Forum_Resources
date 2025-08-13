### [Class] wmB4Jargs - command line arguments validation and processing by walt61
### 01/28/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165321/)

See title. Example code (from the attached demo project):  

```B4X
Sub AppStart (Args() As String)  
  
    Dim wmB4Jargs1 As wmB4Jargs  
    wmB4Jargs1.Initialize  
    wmB4Jargs1.AddStandaloneArg("–nodetails", "-n", "This (optional) argument stands alone and does not need a value", False)  
    wmB4Jargs1.AddValueArg("–number", "-u", "The 'number' argument (optional) needs a numeric value", False, True)  
    wmB4Jargs1.AddPermittedValuesArg("–selectednumber", "-s", "'SelectedNumber' (optional) needs an integer value between 1 and 5 (both included)", False, Array(1, 2, 3, 4, 5), True)  
    wmB4Jargs1.AddPermittedValuesArg("–animal", "-a", "The 'animal' argument (required) needs one of these values: Ape, Bear, Cat", True, Array("Ape", "Bear", "Cat"), False)  
  
    Dim parseResult As wmB4JargsResult = wmB4Jargs1.Parse(Args)  
    If parseResult.firstError <> 0 Then  
        Log("ERROR: " & parseResult.offendingArg & ": " & parseResult.errorMsg) ' The error message can be localised via map wmB4Jargs.mapErrorMessages  
    Else  
        Log("Argument values found:")  
        Log("Animal: " & parseResult.valuesMap.GetDefault("–animal", "<not specified>"))  
        Log("NoDetails: " & parseResult.valuesMap.GetDefault("–nodetails", "<not specified>"))  
        Log("Number: " & parseResult.valuesMap.GetDefault("–number", "<not specified>"))  
        Log("SelectedNumber: " & parseResult.valuesMap.GetDefault("–selectednumber", "<not specified>"))  
    End If
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
  
'Output for #CommandLineArgs: –NODETAILS –number 7 -s 3  
ERROR: –animal: Required argument is missing  
  
' Output for the PrintHelp method:  
Arguments:  
  
-a, –animal              The 'animal' argument (required) needs one of these  
                          values: Ape, Bear, Cat  
  
[-n], [–nodetails]       This (optional) argument stands alone and does not need  
                          a value  
  
[-u], [–number]          The 'number' argument (optional) needs a numeric value  
  
[-s], [–selectednumber]  'SelectedNumber' (optional) needs an integer value  
                          between 1 and 5 (both included)
```