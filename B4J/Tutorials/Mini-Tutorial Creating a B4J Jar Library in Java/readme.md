### Mini-Tutorial Creating a B4J Jar Library in Java by rwblinn
### 09/28/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168830/)

**Overview**  
This repository is a **mini-tutorial** that shows how to create a simple B4J library (**jMathLib**) written in Java and use it inside a B4J application.  
  
It’s not meant as a full-blown library project, but rather as a **step-by-step guide** for hobbyists (like myself) who haven’t touched Java/B4J library development for a while and need a quick refresher.  
  
You’ll learn how to:  

1. Write a small Java class (**MathLib.java**).
2. Compile it into the B4J library **jMathLib** using the **Simple Library Compiler** (SLC).
3. Add it to your B4J Additional Libraries folder.
4. Reference and use it in a B4J B4XPages test app.
5. (Optional) Generate Javadoc documentation.

Everything is kept simple and self-contained.  
If you just want the ready-to-use library and demo, download the archive containing the latest source codes **B4JHowToCreateJarLibrary.zip**.  
  
Note  
This tutorial uses  

- **JDK 8** because the SLC requires it. Paths in the examples assume installation under `C:\Prog\jdk8`, but you can adapt them to your setup.
- **JDK21** for thr Java library `MathLib.java`.

---

  
  
**Quick Start**  
  
1. **Download the ZIP**  
 Download the attached archive `B4JHowToCreateJarLibrary.zip` and unzip it to a folder of choice.  
  
2. **Copy the JAR**  
 Place `jMathLib.jar` into your B4J `Additional Libraries` folder.  
  
3. **Refresh libraries**  
 In B4J, click **Windows > Library Manager > Right click Refresh** to make the library show up.  
  
4. **Use in your project**  
Select the library `jMathLib` from the Library Manager.  

```B4X
Dim ml As MathLib  
ml.Initialize  
Log(ml.add(2,3))   ' Prints 5
```

  
  
**Folder Structure**  
Project Folder: c:\Daten\b4\b4j\b4jhowto\B4JHowToCreateJarLibrary  
with sub-folders (Notes)  
**Java Library**  
+-Java  
+–bin (will be created during the build)  
+–bin\classes\de\rwbl\mathlib\MathLib.class  
+–libs (put any additional libraries that should be referenced during compilation)  
+–src  
+–src\de\rwbl\mathlib\MathLib.java (Library Java source)  
+–src\docs (JavaDoc documentation)  
+–src\genjavadoc.bat (Generate Javadoc)  
  
**B4J B4XPages Test Application**  
+-B4J (Main folder which has several sub-folders as given by the B4XPages project)  
  
**Batch**  
+-slc.bat (Simple Library Compiler to create the jMathLib.jar & .xml)  
  

---

  
  
**Step 1 – Write Java class**  
File: MathLib.java  
Notes  

- Initialize currently does nothing. It is only included to follow common B4J library patterns and can be safely omitted for static-only classes.
- The source code example below shows version 0.1, but the source code in the archive has the latest like version 0.5 or higher.

```B4X
/**  
 * File: MathLib.java  
 * Version: 0.1.0  
 */  
package de.rwbl.mathlib;  
  
// Anywhere Software  
import anywheresoftware.b4a.BA;  
import anywheresoftware.b4a.BA.ActivityObject;  
import anywheresoftware.b4a.BA.DependsOn;  
import anywheresoftware.b4a.BA.Permissions;  
import anywheresoftware.b4a.BA.ShortName;  
import anywheresoftware.b4a.BA.Version;  
  
@Version(0.1f)  
@ShortName("MathLib")  
@ActivityObject  
  
public class MathLib {  
  
    @BA.Hide  
    private BA ba;     
  
    /** Common math constant PI */  
    public static final double PI = 3.141592653589793;  
  
    /** Common math constant E */  
    public static final double E = 2.718281828459045;  
  
    /**  
     * Init new instance  
     */  
    public void Initialize() {  
        // Does nothing (yet).  
    }  
  
    /**  
     * Add two double values.  
     * @param a first operand  
     * @param b second operand  
     * @return sum of a and b  
     */  
    public static double add(double a, double b) {  
        return a + b;  
    }  
  
    /**  
     * Subtract one double value from another.  
     * @param a first operand  
     * @param b second operand  
     * @return result of a - b  
     */  
    public static double subtract(double a, double b) {  
        return a - b;  
    }  
  
    /**  
     * Multiply two double values.  
     * @param a first operand  
     * @param b second operand  
     * @return product of a and b  
     */  
    public static double multiply(double a, double b) {  
        return a * b;  
    }  
  
    /**  
     * Divide one double value by another safely.  
     * @param a numerator  
     * @param b denominator  
     * @return quotient of a / b, or Double.NaN if b == 0  
     */  
    public static double divide(double a, double b) {  
        if (b == 0) {  
            System.err.println("MathLib.divide: Division by zero detected!");  
            return Double.NaN; // safer than returning 0  
        }  
        return a / b;  
    }  
  
}
```

  
  

---

  
  
**Step 2 – Compile with SLC**  
Windows .bat `slc.bat` compiles the Java sources and generates the library Jar & XML in the B4J additional libraries folder.  
Requires JDK 8.  

```B4X
REM slc.bat  
REM B4J Simple Library Compiler (SLC) for project MathLib.  
REM Date 2025-09-26  
REM  
REM Documentation SLC:  
REM https://www.b4x.com/android/forum/threads/tool-simple-library-compiler-build-libraries-without-eclipse.29918/#content  
REM  
REM Settings SLC:  
REM Java8 Compiler = C:\Prog\jdk8\bin\javac.exe  
REM Project Folder = C:\Daten\b4\b4j\b4jhowto\B4JHowToCreateJarLibrary  
REM Library Name = jMathLib  
  
REM Remove bin & classes  
if exist bin\classes rd /s /q bin\classes  
if exist bin rd /s /q bin  
  
REM Path to the SLC  
set SLC_COMPILER=c:\Daten\b4\b4j\tools\B4JSimpleLibraryCompiler  
  
REM Start the SLC  
%SLC_COMPILER%\b4j_librarycompiler.exe
```

  
with output example:  

```B4X
SLC (B4J)  
Starting step: Compiling Java code.  
Completed successfully.  
Starting step: Creating jar file.  
Completed successfully.  
Starting step: Creating XML file.  
Loading source file C:\Daten\b4\b4j\b4jhowto\B4JHowToCreateJarLibrary\Java\src\rwbl\mathlib\MathLib.java…  
Constructing Javadoc information…  
[-doclet, BADoclet]  
[-docletpath, c:\Daten\b4\b4j\tools\B4JSimpleLibraryCompiler]  
[-doclet, BADoclet]  
[-docletpath, c:\Daten\b4\b4j\tools\B4JSimpleLibraryCompiler]  
[-classpath, C:\Prog\B4J\B4J.exe\../libraries\jFX.jar;C:\Prog\B4J\B4J.exe\../libraries\jCore.jar;C:\Prog\jdk8\bin\..\jre\lib\jfxrt.jar;]  
[-sourcepath, src]  
[-b4atarget, C:\Daten\b4\b4j\libraries\jMathLib.xml]  
starting….  
Working with class: de.rwbl.mathlib.MathLib  
finish: C:\Daten\b4\b4j\libraries\jMathLib.xml  
  
Completed successfully.  
*** Don't forget to refresh the libraries list in the IDE (right click and choose Refresh) ***
```

  
The files jMathLib.jar and jMathLib.xml are created in the B4J additional libraries folder: c:\Daten\b4\b4j\libraries\  
  

---

  
  
**Step 3 – Use in B4J app**  
This test application uses the library jMathLib.  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    Private TextFieldParamA As B4XView  
    Private TextFieldParamB As B4XView  
    Private LabelResult As B4XView  
    Private ChoiceBoxMethod As ChoiceBox  
     
    Private MathLib As MathLib  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
     
    B4XPages.SetTitle(Me, "jMathLib Example")  
     
    ' Populate ChoiceBoxMethod  
    ChoiceBoxMethod.Items.AddAll(Array As String("Add", "Subtract", "Multiply", "Divide"))  
    ChoiceBoxMethod.SelectedIndex = 0  
  
    ' Init the MathLib instance  
    MathLib.Initialize  
  
    ' Log constants & operations  
    OperationsDemo     
  
    ' UI  
    ' Set defaults  
    TextFieldParamA.Text = 2  
    TextFieldParamB.Text = 3  
    LabelResult.Text = "Result"  
End Sub  
  
' Log all operations and constants.  
Private Sub OperationsDemo  
    ' Log constants  
    Log("PI = " & MathLib.PI)  
    Log("E  = " & MathLib.E)  
    ' Operations  
    Log("2 + 3 = " & MathLib.add(2, 3))  
    Log("2 - 3 = " & MathLib.subtract(2, 3))  
    Log("2 * 3 = " & MathLib.multiply(2, 3))  
    Log("6 / 3 = " & MathLib.divide(6, 3))  
End Sub  
  
' Calculate result based on operation selected.  
Private Sub ButtonCalculate_Click  
    Try  
        Dim a As Double = TextFieldParamA.Text  
        Dim b As Double = TextFieldParamB.Text  
  
        Select ChoiceBoxMethod.SelectedIndex  
            Case 0  
                Dim result As Double = MathLib.add(a, b)  
            Case 1  
                Dim result As Double = MathLib.subtract(a, b)  
            Case 2  
                Dim result As Double = MathLib.multiply(a, b)  
            Case 3  
                Dim result As Double = MathLib.divide(a, b)  
        End Select  
        LabelResult.Text = result  
    Catch  
        LabelResult.Text = "Invalid input"  
    End Try  
    Log($"${ChoiceBoxMethod.Items.Get(ChoiceBoxMethod.SelectedIndex)}: ${TextFieldParamA.Text}, ${TextFieldParamB.Text} = ${result}"$)  
End Sub
```

  
  

---

  
  
**Step 4 – Run the demo**  
Run the B4J demo application.  
  

---

  
  
**Step 5 - JavaDoc**  
Generate Javadoc documentation in the docs folder.  
Create a dummy BA.java which is required for Javadoc generation, and should not be used by SLC.  

```B4X
package anywheresoftware.b4a;  
  
/**  
 * Dummy class for Javadoc generation only.  
 * Contains empty definitions of B4J annotations.  
 */  
public class BA {  
  
    /** Dummy Hide annotation */  
    public @interface Hide {}  
  
    /** Dummy ShortName annotation */  
    public @interface ShortName {  
        String value();  
    }  
  
    /** Dummy Version annotation */  
    public @interface Version {  
        float value();  
    }  
}
```

  
  
Goto folder: c:\Daten\b4\b4j\b4jhowto\B4JHowToCreateJarLibrary\Java\src>  
  
Run Javadoc command with parameters  

```B4X
javadoc -d docs -sourcepath . -subpackages de.rwbl.mathlib -locale en_US -encoding UTF-8 -charset UTF-8 -J-Duser.language=en -J-Duser.country=US
```

  
  
Parameter explanation:  
  
\* `-d docs` → output folder for the generated documentation.  
\* `-sourcepath .` → location of your source files (here: current folder).  
\* `-subpackages de.rwbl.mathlib` → generate docs for this package and its subpackages.  
\* `-locale en\_US` → sets locale to U.S. English (affects some date/number formats).  
\* `-encoding UTF-8` → specifies source file encoding.  
\* `-charset UTF-8` → specifies HTML charset in the generated pages.  
\* `-J-Duser.language=en` → forces JVM to use English language resources.  
\* `-J-Duser.country=US` → forces JVM to use U.S. country settings.  
  
The documentation is created in the folder: c:\Daten\b4\b4j\b4jhowto\B4JHowToCreateJarLibrary\Java\src\docs\  
  
Open the documentation with index.html  
  
**Important**  
Rename BA.jave to BA.javadoc to avoid being compiled by the SLC.  
When generating new Javadoc documentation, rename back to BA.java.  
  
Here is a Windows batch file `genjavadoc.bat` to create the Javadoc.  
Run from the src folder.  

```B4X
@echo off  
REM =============================================================  
REM Generate Javadoc documentation for MathLib  
REM Project: jMathLib (B4J Library)  
REM Note: BA.javadoc is a stub needed for Javadoc only.  
REM It is renamed temporarily to BA.java for Javadoc generation,  
REM then restored so it won’t interfere with B4J SLC compilation.  
REM =============================================================  
  
echo Creating Javadoc for project MathLib.  
echo =====================================  
  
set SRC=.  
set SRC_FOLDER=de\rwbl\mathlib  
set DOCS=docs  
set PKG=de.rwbl.mathlib  
  
REM — Remove docs folder —  
if exist %DOCS% rmdir /s /q %DOCS%  
  
REM — Ensure docs folder exists —  
if not exist %DOCS% mkdir %DOCS%  
  
REM — Temporarily rename BA.javadoc -> BA.java —  
if exist %SRC%\%SRC_FOLDER%\BA.javadoc ren %SRC%\%SRC_FOLDER%\BA.javadoc BA.java  
  
REM — Run javadoc with English output —  
javadoc -d %DOCS% -sourcepath %SRC% -subpackages %PKG% -locale en_US -encoding UTF-8 -charset UTF-8 -J-Duser.language=en -J-Duser.country=US  
  
REM — Rename BA.java back -> BA.javadoc —  
if exist %SRC%\%SRC_FOLDER%\BA.java ren %SRC%\%SRC_FOLDER%\BA.java BA.javadoc  
  
REM — Check if index.html is there —  
if exist %DOCS%\index.html  (  
  echo.  
  echo Javadoc generated. Open "%DOCS%\index.html".  
  echo ===========================================  
) else (  
  echo.  
  echo Javadoc not created. Check console for details.  
  echo ===============================================  
)  
  
pause
```

  
  

---