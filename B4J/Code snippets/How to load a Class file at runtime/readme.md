### How to load a Class file at runtime by Daestrum
### 07/16/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162097/)

After seeing a qustion in B4A asking how to 'insert' a class at runtime I thought I would post an example.  
Uses JavaObject  
I just use GraalVm as I like the native-image support.  
The class can be on local machine or on a server. (file:/// or https://)  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
    #JavaCompilerPath: 22, D:/graalvm-comm-openjdk-22/bin/javac.exe  
#End Region  
  
Sub Process_Globals  
    Dim myNewClass As Object 'ignore  
  
End Sub  
  
Sub AppStart (Args() As String)  
    myNewClass = Me.as(JavaObject).RunMethod("loadTheClass",Array(Me,"org.dynamic.DynamicClass","file:///C:\SimpleLibraryCompiler\DynamicClass\bin\classes\"))  
    'direct calls  
    'Me.as(JavaObject).RunMethod("call",Array(myNewClass,"say1","Hello there world!"))  
    'Log(Me.as(JavaObject).RunMethod("call",Array(myNewClass,"say2","Hello there world! ")))  
    
    'calls via subs  
    say1("Hello world!")  
    Log(say2("Hello world! "))  
End Sub  
  
Sub say1(message As String)  
    Me.as(JavaObject).RunMethod("call",Array(myNewClass,"say1",message))  
End Sub  
  
Sub say2(message As String) As String  
    Return Me.as(JavaObject).RunMethod("call",Array(myNewClass,"say2",message))  
End Sub  
#if java  
import java.net.URL;  
import java.net.URLClassLoader;  
import java.lang.reflect.*;  
  
public static Object loadTheClass(Class c,String className, String path) throws Exception {  
    // url for the class path to look in  
    URL url = new URL(path);  
    //get the app class loader  
    ClassLoader parent = c.getClassLoader();  
    //create a url class loader with app class loader as parent  
    URLClassLoader classLoader = new URLClassLoader(new URL[]{url}, parent);  
    // load the class  
    Class<?> MyClass = classLoader.loadClass(className);  
    // object to hold reference as MyClass cannot be directly used  
    Object o = MyClass.newInstance();  
    return o;  
}  
// call the method in the object - you need to know the name and params and what to expect to get back  
public static Object call(Object c,String methodName, Object arg) throws NoSuchMethodException , IllegalAccessException, InvocationTargetException{  
    return c.getClass().getMethod(methodName,arg.getClass()).invoke(c,arg);  
}  
#End If  
  
' DynamicClass was compiled with SLC /bin/classes holds the compiled class  
'  
'package org.dynamic;  
'public class DynamicClass {  
'    public DynamicClass(){}  
'    
'  
'    public void say1(String s){  
'        System.out.println(s);  
'    }  
'  
'    public String say2(String s){  
'        Return s + "message from class";  
'    }  
'}
```