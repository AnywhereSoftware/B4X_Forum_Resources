### Tidy Up Unused Modules (PowerShell Script) by tchart
### 12/08/2019
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/112000/)

Below is a PowerShell script you can use to tidy up you project folder. You can run it from PowerShell ISE.  
  
It compiles a list of modules referenced in the b4j file and then compares this to modules in the projects directory. It then deletes modules that are not referenced.  
  
I used this to tidy up a large project from which I had removed a bunch of modules that were no longer needed.  
  
NOTE: As this deletes file be careful and make a backup of your project.  
  

```B4X
$cls  
  
$prj = "D:\Dropbox\My Apps\B4J\someproject\someproject.b4j"  
  
$modules = @()  
  
foreach($line in Get-Content $prj)  
{  
    if($line.StartsWith("Module"))  
    {  
        $tmp = $line.Split('=')  
  
        $modules += $tmp[1]  
    }  
}  
  
write-host $modules  
  
$bas = Get-ChildItem -Path ([System.IO.Path]::GetDirectoryName($prj)) -Filter *.bas  
  
foreach($f in $bas)  
{  
    $bb = $f.Name.Replace(".bas","")  
  
    if ($modules.Contains($bb))  
    {  
        #write-host "Contains $bb"  
    }  
    else  
    {  
        write-host "NOT contains $bb"  
        Remove-Item –path $b.FullName -Force  
    }  
}
```