### Beauty Theme for Android app - Kongzue Dialog V3 by tuhatinhvn
### 07/16/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/132625/)

I make this inline java library for b4x android developer , this very nice and easy to use  
  
<https://github.com/kongzue/DialogV3>  
  
Download aar:  
<https://www.dropbox.com/s/hx7495rv24iv956/dialogv32.aar?dl=0>  
  
How to use:  
1.Copy dialogv32.aar into your libs folder  
2. Use example project to use  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
#AdditionalJar:dialogv32.aar  
#Extends: android.support.v7.app.AppCompatActivity  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private cmdloading As Button  
    Private cmd_showtip As Button  
    Private cmdbottommenu As Button  
    Private cmdinput As Button  
    Private cmd_mess As Button  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
    '////STYLE_MATERIAL, STYLE_KONGZUE, STYLE_IOS, STYLE_MIUI  
    'DARK(LIGHT)  
    initTheme("STYLE_MIUI","DARK")  
    Activity.LoadLayout("Layout")  
      
      
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Private Sub cmdloading_Click  
    showwaitDialog("Loading…..",True)  
End Sub  
  
Private Sub cmd_showtip_Click  
    showtipDialog("Now is success!","SUCCESS",True,3000)  
End Sub  
  
Private Sub cmdbottommenu_Click  
    Dim listnicemenu As List  
    listnicemenu.Initialize  
    Dim cs As CSBuilder  
    cs.Initialize.Color(Colors.Red).Append("Hello World!").PopAll  
    listnicemenu.Add(cs)  
    Dim cs As CSBuilder  
    cs.Initialize.Color(Colors.Cyan).Append("Hello World2!").PopAll  
    listnicemenu.Add(cs)  
BottomMenu("menumain",listnicemenu,"Title",True)  
End Sub  
Sub menumain_bottomclick(vitri As Int)  
    Log("clicked " & vitri)  
End Sub  
Private Sub cmdinput_Click  
    InputDialog("inputdialog","Title here","Enter value …","OK","","Enter filename here",Colors.Blue,False)  
End Sub  
Sub inputdialog_input(noidung As String)  
    Log("Value is " & noidung)  
End Sub  
Private Sub cmd_mess_Click  
    MessageDialog("mess","Title here","Content","OK","Cancel","Other",False)  
End Sub  
Sub mess_okclick  
    Log("OK clicked")  
End Sub  
Sub mess_otherclick  
    Log("Other clicked")  
End Sub  
Sub mess_cancelclick  
    Log("Cancel clicked")  
End Sub  
Sub MessageDialog(eventname As String,title As String, content As String,oktext As String,canceltext As String,othertext As String,cancelable As Boolean)  
    Dim nt As JavaObject  
    nt.InitializeContext  
    nt.RunMethod("MessageDialog",Array As Object(eventname,title,content,oktext,canceltext,othertext,cancelable))  
End Sub  
Sub initTheme(themename As String, darklight As String)  
    Dim nt As JavaObject  
    nt.InitializeContext  
    nt.RunMethod("initTheme",Array As String(themename,darklight))  
End Sub  
Sub BottomMenu(eventname As String,listmenu As List,title As String, cancelable As Boolean)  
    Dim nt As JavaObject  
    nt.InitializeContext  
    nt.RunMethod("BottomMenu",Array As Object(eventname,listmenu,title,cancelable))  
End Sub  
Sub InputDialog(eventname As String,title As String, mess As String,okbutton As String,defaultvalue As String,hinttext As String,colortext As Int,cancelable As Boolean)  
    Dim nt As JavaObject  
    nt.InitializeContext  
    nt.RunMethod("InputDialog",Array As Object(eventname,title,mess, okbutton,defaultvalue,hinttext,colortext,cancelable))  
End Sub  
Sub showwaitDialog(title As String,cancelable As Boolean)  
    Dim nt As JavaObject  
    nt.InitializeContext  
    nt.RunMethod("showwaitDialog",Array As Object(title,cancelable))  
End Sub  
Sub showtipDialog( title As String, typedialog As String ,  cancelable As Boolean, timeout As Int)  
    Dim nt As JavaObject  
    nt.InitializeContext  
    nt.RunMethod("showtipDialog",Array As Object(title,typedialog,cancelable,timeout))  
End Sub  
' public void showtipDialog(String title,String typedialog , Boolean cancelable,int timeout){  
'final String eventname,String title,String mess, String okbutton,String defaultvalue,String hinttext,int colortext,boolean cancelable){  
#IF JAVA  
import com.b4alib.dialog.util.DialogSettings;  
import com.b4alib.dialog.v3.MessageDialog;  
import  android.view.View;  
import com.b4alib.dialog.util.BaseDialog;  
import com.b4alib.dialog.interfaces.OnDialogButtonClickListener;  
import java.util.ArrayList;  
import java.util.List;  
import com.b4alib.dialog.interfaces.OnMenuItemClickListener;  
import com.b4alib.dialog.v3.BottomMenu;  
import com.b4alib.dialog.interfaces.OnInputDialogButtonClickListener;  
import com.b4alib.dialog.v3.InputDialog;  
import com.b4alib.dialog.util.TextInfo;  
import android.text.InputType;  
import com.b4alib.dialog.util.InputInfo;  
import com.b4alib.dialog.v3.WaitDialog;  
import com.b4alib.dialog.v3.TipDialog;  
  
WaitDialog awaitDialog;  
TipDialog tipDialog;  
  
public void initTheme(String themename,String darklight){  
DialogSettings.init();  
if (themename.equals("STYLE_MIUI")){DialogSettings.style = DialogSettings.STYLE.STYLE_MIUI;}  
if (themename.equals("STYLE_IOS")){DialogSettings.style = DialogSettings.STYLE.STYLE_IOS;}  
if (themename.equals("STYLE_KONGZUE")){DialogSettings.style = DialogSettings.STYLE.STYLE_KONGZUE;}  
if (themename.equals("STYLE_MATERIAL")){DialogSettings.style = DialogSettings.STYLE.STYLE_MATERIAL;}  
  
  
if (darklight.equals("DARK")){DialogSettings.theme =DialogSettings.THEME.DARK;}  
if (darklight.equals("LIGHT")){DialogSettings.theme =DialogSettings.THEME.LIGHT;}  
  
}  
  
 public void showtipDialog(String title,String typedialog , Boolean cancelable,int timeout){  
        // WARNING, SUCCESS, ERROR, OTHER  
        if (typedialog.equals("WARNING")){tipDialog.show(this,title,TipDialog.TYPE.WARNING).setCancelable(cancelable).setTipTime(timeout);}  
        if (typedialog.equals("SUCCESS")){tipDialog.show(this,title,TipDialog.TYPE.SUCCESS).setCancelable(cancelable).setTipTime(timeout);}  
        if (typedialog.equals("ERROR")){tipDialog.show(this,title,TipDialog.TYPE.ERROR).setCancelable(cancelable).setTipTime(timeout);}  
        if (typedialog.equals("OTHER")){tipDialog.show(this,title,TipDialog.TYPE.OTHER).setCancelable(cancelable).setTipTime(timeout);}  
    }  
    public void closetipDialog(){  
        tipDialog.doDismiss();  
    }  
    public boolean isShowingtipDialog(){  
        return tipDialog.isShow;  
    }  
  
  
  public void showwaitDialog(String title,Boolean cancelable){  
        awaitDialog.show(this,title).setCancelable(cancelable);  
    }  
    public void closewaitDialog(){  
        awaitDialog.doDismiss();  
    }  
    public boolean isShowingwaitDialog(){  
        return awaitDialog.isShow;  
    }  
  
  
public void MessageDialog(final String eventname,String title, String Mess,String OKtext, String Cancel, String other,Boolean cancelable){  
        MessageDialog.build(this)  
        ////STYLE_MATERIAL, STYLE_KONGZUE, STYLE_IOS, STYLE_MIUI  
                //.setStyle(DialogSettings.STYLE.STYLE_MIUI)  
               // .setTheme(DialogSettings.THEME.DARK)  
                .setTitle(title)  
                .setMessage(Mess)  
                .setOkButton(OKtext, new OnDialogButtonClickListener() {  
                    @Override  
                    public boolean onClick(BaseDialog baseDialog, View v) {  
                        //  BA.Log(" click ok");  
                        //processBA.raiseEventFromDifferentThread(this, null, 0, eventname + "_okclick", false, new Object[] {message.getMessageObject()});  
                        processBA.raiseEventFromDifferentThread(this, null, 0, eventname.toLowerCase() + "_okclick", false, new Object[] {});  
                        return false;  
                    }  
                })  
                .setCancelButton(Cancel, new OnDialogButtonClickListener() {  
                    @Override  
                    public boolean onClick(BaseDialog baseDialog, View v) {  
                        //  BA.Log(" click cancel");  
                        processBA.raiseEventFromDifferentThread(this, null, 0, eventname.toLowerCase() + "_cancelclick", false, new Object[] {});  
                        return false;  
                    }  
                })  
                .setOtherButton(other, new OnDialogButtonClickListener() {  
                    @Override  
                    public boolean onClick(BaseDialog baseDialog, View v) {  
                        //  BA.Log(" click cancel");  
                        processBA.raiseEventFromDifferentThread(this, null, 0, eventname.toLowerCase() + "_otherclick", false, new Object[] {});  
                        return false;  
                    }  
                })  
                .setCancelable(cancelable)  
                .show();  
    }  
      
      
    public void BottomMenu(final String eventname,List<CharSequence> listvao,String title,boolean cancelable){  
        BottomMenu.show(this,listvao, new OnMenuItemClickListener() {  
            @Override  
            public void onClick(String text, int index) {  
                //返回参数 text 即菜单名称，index 即菜单索引  
                processBA.raiseEventFromDifferentThread(this, null, 0, eventname.toLowerCase() + "_bottomclick", false, new Object[] {index});  
            }  
        }).setTitle(title).setCancelable(cancelable);  
    }  
      
    public void InputDialog(final String eventname,String title,String mess, String okbutton,String defaultvalue,String hinttext,int colortext,boolean cancelable){  
  
InputDialog.show(this, title, mess, okbutton)  
        .setInputText(defaultvalue)  
        .setHintText(hinttext)  
        .setCancelable(cancelable)  
            .setInputInfo(new InputInfo()  
  
                             // .setMAX_LENGTH(6)     //限制最大输入长度  
                              .setInputType(InputType.TYPE_CLASS_TEXT)     //仅输入密码类型  
                              .setTextInfo(new TextInfo()       //设置文字样式  
                                               //    .setFontColor(colortext)     //修改文字样式颜色为红色  
                              )  
                                      .setMultipleLines(false)       //支持多行输入  
        )  
.setOnOkButtonClickListener(new OnInputDialogButtonClickListener() {  
        @Override  
        public boolean onClick(BaseDialog baseDialog, View v, String inputStr) {  
            //inputStr 即当前输入的文本  
   processBA.raiseEventFromDifferentThread(this, null, 0, eventname.toLowerCase() + "_input", false, new Object[] {inputStr});  
            return false;  
        }  
    })  
    ;  
}  
  
#End If
```

  
  
  
  
![](https://github.com/kongzue/Res/raw/master/app/src/main/res/mipmap-xxxhdpi/img_dialog_v3_miui.jpg)  
  
![](https://github.com/kongzue/Res/raw/master/app/src/main/res/mipmap-xxxhdpi/img_dialog_v3.png)