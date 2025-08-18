### Set slf4j log level by tchart
### 08/25/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/121595/)

A 3rd party library I am using was outputting INFO level messages frequently and ended up creating a 20gb log file. Ive asked the author to change the log level for the function to DEBUG but in the meantime I had to reduce the logging level of slf4j.  
  
This can be done using the inline code below and calling it via a JavaObject  
  

```B4X
' Possible log levels are  TRACE, DEBUG, INFO, WARN and ERROR  
jo.RunMethod("setLevel", Array("WARN"))
```

  
  

```B4X
#IF JAVA  
import org.slf4j.LoggerFactory;  
import ch.qos.logback.classic.Level;  
import ch.qos.logback.classic.Logger;  
  
public static void setLevel(String LogLevel){  
    Logger root = (Logger)LoggerFactory.getLogger(Logger.ROOT_LOGGER_NAME);  
    root.setLevel(Level.toLevel(LogLevel));  
    }  
#End If
```