### Wangpos Printer SDK not using bluetooth by jbaillie2461
### 09/19/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143017/)

Hi guys I though I would publish this if anyone is ever stuck with a wangpos printer add this your main   
  
  
  
Public Sub StartActivityForResult(i As Intent)  
 Dim jo As JavaObject = GetBA  
 ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
 jo.RunMethod("startActivityForResult", Array As Object(ion, i))  
End Sub  
  
Sub GetBA As Object  
 Dim jo As JavaObject  
 Dim cls As String = Me  
 cls = cls.SubString("class ".Length)  
 jo.InitializeStatic(cls)  
 Return jo.GetField("processBA")  
End Sub  
  
Sub InitPrinter()  
 NativeMe.RunMethod("\_initprint",Null)  
End Sub  
  
Sub PrintStringLeft(s As String)  
 NativeMe.RunMethod("\_printLeft",Array As Object(s,FontSize,Bold))  
 FontSize = 22  
 Bold = False  
End Sub  
  
  
Sub PrintStringLeftFontAndBold(s As String)  
FontSize = 26  
 Bold = True  
 NativeMe.RunMethod("\_printLeft",Array As Object(s,FontSize,Bold))  
 FontSize = 22  
 Bold = False  
End Sub  
  
  
Sub PrintStringRight(s As String)  
 NativeMe.RunMethod("\_printRight",Array As Object(s,FontSize,Bold))  
 FontSize = 22  
 Bold = False  
End Sub  
  
Sub PrintStringCenter(s As String)  
 NativeMe.RunMethod("\_printCenter",Array As Object(s,FontSize,Bold))  
 FontSize = 22  
 Bold = False  
End Sub  
  
Sub EndPrinter()  
 NativeMe.RunMethod("\_postprint",Null)  
 Reprint = "Reprint"  
End Sub  
  
#if Java  
  
import android.content.Context;  
import android.os.RemoteException;  
  
  
import wangpos.sdk4.libbasebinder.Printer;  
import wangpos.sdk4.libbasebinder.Printer.Align;  
  
  
  
   
  
Printer mPrinter;  
  
public void init()  
{  
 new Thread()   
 {   
 [USER=69643]@override[/USER]  
 public void run()  
 {  
   
 BA.Log("Printer A");   
 mPrinter = new Printer(getApplicationContext());   
 BA.Log("Printer B");  
 }  
 }.start();  
}  
  
public void \_initprint()  
{   
 try  
 {  
 mPrinter.printInit();  
 mPrinter.clearPrintDataCache();  
 }  
 catch (RemoteException e)  
 {  
 e.printStackTrace();  
 }  
}  
  
public void \_printLeft(String \_text,int \_fontsize ,boolean \_bold)  
{  
 try  
 {   
 mPrinter.printString(\_text, \_fontsize, Printer.Align.LEFT, \_bold, false);  
 }  
 catch (RemoteException e)  
 {  
 e.printStackTrace();  
 }  
}  
  
public void \_printRight(String \_text,int \_fontsize ,boolean \_bold)  
{  
 try  
 {   
 mPrinter.printString(\_text, \_fontsize, Printer.Align.RIGHT, \_bold, false);  
 }  
 catch (RemoteException e)  
 {  
 e.printStackTrace();  
 }  
}  
  
public void \_printCenter(String \_text,int \_fontsize ,boolean \_bold)  
{  
 try  
 {   
 mPrinter.printString(\_text, \_fontsize, Printer.Align.CENTER, \_bold, false);  
 }  
 catch (RemoteException e)  
 {  
 e.printStackTrace();  
 }  
}  
  
public void \_postprint()  
{  
 try  
 {   
 mPrinter.printPaper(100);  
 mPrinter.printFinish();  
 }  
 catch (RemoteException e)  
 {  
 e.printStackTrace();  
 }  
}  
  
#End If  
#End Region  
  
'Program code should go into B4XMainPage and other pages.  
'Program code should go into B4XMainPage and other pages.  
  
  
If you ever stuck call me + 27 84 944 6808