### Wise Easy Print Code P052 by jbaillie2461
### 03/24/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/166282/)

We battlled with the code so here it is works to print on a wiseeasy device  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
'#BridgeLogger: True  
#AdditionalJar:  WiseSdk_P_1.29_00a_24041501.aar  
#AdditionalJar:  WiseSdk_D_1.09_00a_24032501.aar  
Sub Process_Globals  
    Public ActionBarHomeClicked As Boolean  
    Public NativeMe As JavaObject  
    Public FontSize As Int = 30  
    Public Alignment As Int  
    Public Bold As Boolean=False  
End Sub  
  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Dim pm As B4XPagesManager  
    pm.Initialize(Activity)  
    If FirstTime Then  
        NativeMe.InitializeContext  
        NativeMe.RunMethod("initPrinter",Null)  
    End If  
End Sub  
  
'Template version: B4A-1.01  
#Region Delegates  
  
Sub Activity_ActionBarHomeClick  
    ActionBarHomeClicked = True  
    B4XPages.Delegate.Activity_ActionBarHomeClick  
    ActionBarHomeClicked = False  
End Sub  
  
Sub Activity_KeyPress (KeyCode As Int) As Boolean  
    Return B4XPages.Delegate.Activity_KeyPress(KeyCode)  
End Sub  
  
Sub Activity_Resume  
    B4XPages.Delegate.Activity_Resume  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    B4XPages.Delegate.Activity_Pause  
End Sub  
  
Sub Activity_PermissionResult (Permission As String, Result As Boolean)  
    B4XPages.Delegate.Activity_PermissionResult(Permission, Result)  
End Sub  
  
Sub Create_Menu (Menu As Object)  
    B4XPages.Delegate.Create_Menu(Menu)  
End Sub  
  
Sub InitPrinter()  
    NativeMe.RunMethod("InitPrinterr",Null)  
      
  
      
      
End Sub  
  
  
Sub PrintStringLeft(s As String) As ResumableSub  
    NativeMe.RunMethod("printTextLeft",Array As Object(s,FontSize,Bold,3))  
    FontSize = 22  
    Bold = False  
    Return True  
      
End Sub  
  
PrintIt  
  
Sub PrintIt()  
    NativeMe.RunMethod("PrintIt",Null)  
      
      
      
End Sub  
  
#if Java  
import com.wisepos.smartpos.Impl.PrinterImpl;  
import com.wisepos.smartpos.WisePosException;  
import com.wisepos.smartpos.WisePosSdk;  
import com.wisepos.smartpos.printer.BarcodeType;  
import com.wisepos.smartpos.printer.Printer;  
import com.wisepos.smartpos.printer.PrinterListener;  
import com.wisepos.smartpos.printer.TextInfo;  
import com.wisedevice.sdk.IInitDeviceSdkListener;  
import com.wisedevice.sdk.WiseDeviceSdk;  
import com.wisepos.smartpos.InitPosSdkListener;  
import com.wisepos.smartpos.WisePosSdk;  
import java.io.InputStream;  
import java.util.ArrayList;  
import java.util.HashMap;  
import java.util.List;  
import java.util.Map;  
import static com.wisepos.smartpos.errorcode.WisePosErrorCode.ERR_SUCCESS;  
import android.util.Log;  
import java.awt.font.*;  
  
 private Printer printer;  
    public static final int PRINT_STYLE_LEFT = 0x01;    //Print style to the left  
    public static final int PRINT_STYLE_CENTER = 0x02;  //print style to the center  
    public static final int PRINT_STYLE_RIGHT = 0x04;   //print style to the right  
    public   WisePosSdk wisePosSdk = null;  
    public   WiseDeviceSdk wiseDeviceSdk = null;  
    private int gray = 2;  
  
  
public boolean _onCreateOptionsMenu(android.view.Menu menu) {  
     processBA.raiseEvent(null, "create_menu", menu);  
     return true;  
      
}  
  
 public void initPrinter(){  
      wiseDeviceSdk = WiseDeviceSdk.getInstance();  
    wisePosSdk = WisePosSdk.getInstance();  //Obtain the WisePsoSdk object.  
    Log.d("sdkdemo", "initPosSdk: process！");  
    wisePosSdk.initPosSdk(this, new InitPosSdkListener() {  //Initialize the SDK and bind the service  
        @Override  
        public void onInitPosSuccess() {             
            Log.e("B4A","initPosSdk: success!" );  
        }  
  
        @Override  
        public void onInitPosFail(int i) {             
            Log.e("B4A","initPosSdk: fail!" );  
        }  
    });  
    wiseDeviceSdk.initDeviceSdk(this, new IInitDeviceSdkListener() {  
        @Override  
        public void onInitPosSuccess() {  
            Log.e("B4A","initDeviceSdk: success!" );  
        }  
  
        @Override  
        public void onInitPosFail(int i) {  
            Log.e("B4A","initDeviceSdk: fail!" );  
        }  
    });  
  
    
      
 }  
  
  
  
  
  
  
      
      
    public void InitPrinterr()  
    {  
      
            printer = WisePosSdk.getInstance().getPrinter();  
      
            if(printer==null) {  
                Log.e("B4A","Printer is  null!" );  
            }  
             printer.initPrinter();  //Initializing the printer.  
              
    }  
      
      
     public void printTextLeft(String _text,int _fontsize ,boolean  _bold,int _Style) {  
        try {  
            Map<String, Object> map;  
            int ret;  
              
              
                              
        
              
            
            ret = printer.setGrayLevel(3);   //Set the printer gray value.  
            if (ret != ERR_SUCCESS) {  
                Log.e("B4A","setGrayLevel failed" + String.format(" errCode = 0x%x\n", ret));  
                //return;  
            }  
  
            map = printer.getPrinterStatus();   //Gets the current status of the printer.  
            if (map == null) {  
                Log.e("B4A","getStatus failed" + String.format(" errCode = 0x%x\n", ret));  
                return;  
            }  
            //Gets whether the printer is out of paper from the map file.  
            if ((byte) map.get("paper") == 1) {  
               Log.e("B4A","IsHavePaper = false\n");  
                return;  
            } else {  
               Log.e("B4A","IsHavePaper = true\n");  
            }  
  
             //When printing text information, the program needs to set the printing font. The current setting is the default font.  
            Bundle bundle1 = new Bundle();  
            if (android.os.Build.MODEL.equals("P5SE") ||android.os.Build.MODEL.equals("P5MAX") ||android.os.Build.MODEL.equals("P052")){  
                bundle1.putString("font", SystemFontType.SANS_SERIF_LIGHT);  
            } else {  
                bundle1.putString("font", "DEFAULT");  
            }  
  
//            bundle1.putString("systemFont", "CutiveMono.ttf");  
//            bundle1.putString("path", "/sdcard/PraduhhTheGreat.ttf");  
            printer.setPrintFont(bundle1);  
  
  
            TextInfo textInfo = new TextInfo();  
  
           textInfo.setAlign(PRINT_STYLE_LEFT);  
              
            if(_Style==1)  
            {  
              
             textInfo.setAlign(PRINT_STYLE_LEFT);  
            }  
              
            if(_Style==2)  
            {  
              
             textInfo.setAlign(PRINT_STYLE_CENTER);  
            }  
              
            if(_Style==3)  
            {  
              
             textInfo.setAlign(PRINT_STYLE_RIGHT);  
            }  
              
              
            textInfo.setFontSize(_fontsize);  
            printer.setLineSpacing(1);  
  
            textInfo.setText(_text);  
            printer.addSingleText(textInfo);  
  
             } catch (Exception e) {  
            e.printStackTrace();  
            Log.e("B4A","print failed " + e.toString() + "\n");  
        }  
            
    }  
      
     public void PrintIt()  
     {  
       try {  
      
       Bundle printerOption = new Bundle();  
            //Start printing  
            printer.startPrinting(printerOption, new PrinterListener() {  
                @Override  
                public void onError(int i) {  
                    Log.e("B4A","startPrinting failed errCode = " + i);  
                }  
  
                @Override  
                public void onFinish() {  
                    Log.e("B4A","print success\n");  
                    try {  
                        //After printing, Feed the paper.  
                        printer.feedPaper(0);  
                    } catch (WisePosException e) {  
                        e.printStackTrace();  
                    }  
                }  
  
                @Override  
                public void onReport(int i) {  
                    //The callback method is reserved and does not need to be implemented  
                }  
            });  
              
        } catch (Exception e) {  
            e.printStackTrace();  
            Log.e("B4A","print failed " + e.toString() + "\n");  
        }  
      
     }  
      
    static class SystemFontType {  
        public static final String ARIAL = "arial";  
        public static final String BASKERVILLE = "baskerville";  
        public static final String CASUAL = "casual";  
        public static final String COURIER = "courier";  
        public static final String COURIER_NEW = "courier new";  
  
        public static final String CURSIVE = "cursive";  
        public static final String GEORGIA = "georgia";  
        public static final String GOUDY = "goudy";  
        public static final String MONACO = "monaco";  
        public static final String MONOSPACE = "monospace";  
        public static final String HELVETICA = "helvetica";  
        public static final String ITC_STONE_SERIF = "ITC Stone Serif";  
        public static final String PALATINO = "palatino";  
  
        public static final String SANS_SERIF = "sans-serif";  
        public static final String SANS_SERIF_CONDENSED = "sans-serif-condensed";  
        public static final String SANS_SERIF_BLACK = "sans-serif-black";  
        public static final String SANS_SERIF_LIGHT = "sans-serif-light";  
        public static final String SANS_SERIF_THIN = "sans-serif-thin";  
        public static final String SANS_SERIF_MEDIUM = "sans-serif-medium";  
        public static final String SANS_SERIF_SMALLCAPS = "sans-serif-smallcaps";  
  
        public static final String SANS_SERIF_CONDENSED_LIGHT = "sans-serif-condensed-light";  
        public static final String SANS_SERIF_MONOSPACE = "sans-serif-monospace";  
  
        public static final String SANS_SERIF_CONDENSED_MEDIUM = "sans-serif-condensed-medium";  
  
  
        public static final String SERIF = "serif";  
        public static final String SERIF_BOLD = "serif-bold";  
        public static final String SERIF_MONOSPACE = "serif-monospace";  
  
        public static final String SOURCE_SANS_PRO = "source-sans-pro";  
        public static final String SOURCE_SANS_PRO_SEMI_BOLD = "source-sans-pro-semi-bold";  
  
        public static final String TAHOMA = "tahoma";  
        public static final String TIMES = "times";  
        public static final String TIMES_NEW_ROMAN = "times new roman";  
        public static final String VERDANA = "verdana";  
    }  
  
  
  
#End If  
#End Region  
  
'Program code should go into B4XMainPage and other pages.
```