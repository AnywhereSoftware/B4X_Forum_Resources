B4J=true
Group=Filters
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
'Cross-Origin Resource Sharing (CORS) Filter class
Sub Class_Globals
	Private cPath As String
	Private cSettings As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (Path As String, Settings As Map)
	cPath = Path
	cSettings = Settings
End Sub

'Return True to allow the request to proceed.
'Public Sub Filter (req As ServletRequest, resp As ServletResponse) As Boolean
'	Return True
'End Sub

Public Sub AddToServer (ServerObject As Server)
    Dim joServerWrapper As JavaObject = ServerObject
    Dim joMe As JavaObject = Me
    joMe.RunMethod("addFilter", Array As Object(joServerWrapper.GetField("context"), cPath, cSettings))
End Sub

#If JAVA

import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map.Entry;

// import javax.servlet.DispatcherType;
// import javax.servlet.Filter;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;

import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.FilterHolder;

import anywheresoftware.b4a.objects.collections.Map.MyMap;

public void addFilter(ServletContextHandler context, String path, MyMap settings) throws Exception {
    FilterHolder fh = new FilterHolder((Class<? extends Filter>) Class.forName("org.eclipse.jetty.servlets.CrossOriginFilter"));
    if (settings != null) {
        HashMap<String,String> m = new HashMap<String, String>();
        copyMyMap(settings, m, true); //integerNumbersOnly!
        fh.setInitParameters(m);
    }
    context.addFilter(fh, path, EnumSet.of(DispatcherType.REQUEST));
}

private void copyMyMap(MyMap m, java.util.Map<String, String> o, boolean integerNumbersOnly) {
    for (Entry<Object, Object> e : m.entrySet()) {
        String value;
        if (integerNumbersOnly && e.getValue() instanceof Number) {
            value = String.valueOf(((Number)e.getValue()).longValue());
        } else {
            value = String.valueOf(e.getValue());
            o.put(String.valueOf(e.getKey()), value);
        }
    }
}

#End If