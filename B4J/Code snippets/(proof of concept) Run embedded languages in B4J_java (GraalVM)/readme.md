### (proof of concept) Run embedded languages in B4J/java (GraalVM) by Daestrum
### 07/16/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162107/)

A little example to show how you can run embedded languages in the GraalVM.  
The example shows JavaScript and Python, although there are other languages available. ( [languages](https://www.graalvm.org/latest/graalvm-as-a-platform/language-implementation-framework/Languages/) )  
  
Not using maven makes it a bit tricky as you chase down missing jars, but nothing too hard.  
  
The example currently uses a jvm per language (as I have yet to figure out how to add the languages to the main GraalVM)  
I use different build configurations as it makes it easier than commenting out loads of code just to run in a particular language.  
The code is virtually comment free (bad me) but should be clear enough to get the gist.  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes   
    #MergeLibraries: True  
    #if JAVASCRIPT      
        #AdditionalJar: D:\graaljs-24.0.1\modules\polyglot.jar  
        #AdditionalJar:  D:\graaljs-24.0.1\modules\nativeimage.jar  
        #VirtualMachineArgs: -Dpolyglotimpl.DisableVersionChecks=true -Dpolyglotimpl.TraceClassPathIsolation=true –module-path D:\graaljs-24.0.1\modules\  
        #JavaCompilerPath: 22, D:\graaljs-24.0.1\jvm\bin\javac.exe  
    #end if  
          
    #if PYTHON      
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\polyglot.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\nativeimage.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\truffle-api.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\truffle-icu4j.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\graalpython.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\bouncycastle-provider.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\bouncycastle-pkix.jar  
        #AdditionalJar: D:\graalpy-comm-24.0.1\modules\bouncycastle-util.jar  
        #VirtualMachineArgs: -Dpolyglot.engine.WarnInterpreterOnly=false -Dpolyglotimpl.DisableVersionChecks=true -Dpolyglotimpl.TraceClassPathIsolation=true –module-path D:\graalpy-comm-24.0.1\modules\   
        #JavaCompilerPath: 22, D:\graalpy-comm-24.0.1\jvm\bin\javac.exe  
    #end if      
  
#End Region  
  
Sub Process_Globals  
      
End Sub  
  
Sub AppStart (Args() As String)  
#if JAVASCRIPT  
    Dim cd As String  
    cd=$"  
function jsTest(a){  
    return "Hello there " + a + " from embedded javascript"  
}  
"$  
#end if  
  
#if PYTHON  
    Dim cd As String  
    cd=$"  
def my_function():  
  print("Hello from a function")  
    
def my_function2(*args):  
    return sum(args)    
"$  
#end if  
#if JAVASCRIPT or PYTHON  
    Dim context As JavaObject = Me.as(JavaObject).RunMethod("createContext",Null)  
#end if  
      
#if PYTHON  
    context.RunMethod("eval",Array("python",cd))  
  
    Dim func,func2 As JavaObject  
    func = context.RunMethodjo("getBindings",Array("python")).RunMethodJO("getMember",Array("my_function"))  
    func2 = context.RunMethodjo("getBindings",Array("python")).RunMethodJO("getMember",Array("my_function2"))  
    Me.as(JavaObject).RunMethod("exec",Array(func))  
    Dim ret As JavaObject = Me.as(JavaObject).RunMethodjo("exec",Array(func2,Array(3,4,5,6,7)))  
    Log(ret.RunMethod("asInt",Null))  
#end if  
  
#if JAVASCRIPT  
    context.RunMethod("eval",Array("js",cd))  
    Dim func As JavaObject  
    func = context.RunMethodJO("getBindings",Array("js")).RunMethodJO("getMember",Array("jsTest"))  
    Dim ret As JavaObject = Me.as(JavaObject).RunMethod("exec",Array(func,Array("fred")))  
    Log(ret.RunMethod("asString",Null))  
#End If  
  
End Sub  
#if java  
import org.graalvm.polyglot.*;  
import org.graalvm.nativeimage.*;  
  
    public static Context createContext(){  
        return Context.create();  
    }  
    public static void exec(Value v){  
        v.execute();  
    }  
    public static Object exec(Value v, Object… o){  
        return v.execute(o);  
    }  
      
#End If
```