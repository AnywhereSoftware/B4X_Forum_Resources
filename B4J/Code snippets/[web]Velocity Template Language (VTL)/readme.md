### [web]Velocity Template Language (VTL) by aeric
### 06/14/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/148503/)

This example is based on <https://velocity.apache.org/engine/2.3/developer-guide.html#how-velocity-works>  
  
Download additional libraries:  
[velocity-engine-core-2.3.jar](https://dlcdn.apache.org//velocity/engine/2.3/velocity-engine-core-2.3.jar)  
[commons-lang3-3.12.0.jar](https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar)  
[slf4j-api-2.0.7.jar](https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.7/slf4j-api-2.0.7.jar)  
[slf4j-simple-2.0.7.jar](https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/2.0.7/slf4j-simple-2.0.7.jar)  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
#AdditionalJar: commons-lang3-3.12.0  
'#AdditionalJar: commons-collections4-4.4  
#AdditionalJar: velocity-engine-core-2.3  
#AdditionalJar: slf4j-api-2.0.7  
#AdditionalJar: slf4j-simple-2.0.7  
Sub Process_Globals  
  
End Sub  
  
Sub AppStart (Args() As String)  
    Dim Velocity As JavaObject  
    Velocity.InitializeStatic("org.apache.velocity.app.Velocity")  
    Velocity.RunMethod("init", Null)  
   
    Dim Context As JavaObject  
    Context.InitializeNewInstance("org.apache.velocity.VelocityContext", Null)  
    Context.RunMethod("put", Array("name", "Velocity"))  
   
    Dim Template As JavaObject  
    Template = Template.InitializeNewInstance("org.apache.velocity.Template", Null)  
    Template = Velocity.RunMethod("getTemplate", Array As String("test.vm"))  
   
    Dim StringWriter As JavaObject  
    StringWriter.InitializeNewInstance("java.io.StringWriter", Null)  
    Template.RunMethodJO("merge", Array( Context, StringWriter ) )  
   
    Dim Content As String = StringWriter.RunMethod("toString", Null)  
    StringWriter.RunMethod("close", Null)  
   
    Log(Content)  
End Sub
```