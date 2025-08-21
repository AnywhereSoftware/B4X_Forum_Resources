package b4a.example.tms.message.designerscripts;
import anywheresoftware.b4a.objects.TextViewWrapper;
import anywheresoftware.b4a.objects.ImageViewWrapper;
import anywheresoftware.b4a.BA;


public class LS_main{

public static void LS_general(java.util.LinkedHashMap<String, anywheresoftware.b4a.keywords.LayoutBuilder.ViewWrapperAndAnchor> views, int width, int height, float scale) {
anywheresoftware.b4a.keywords.LayoutBuilder.setScaleRate(0.3);
//BA.debugLineNum = 2;BA.debugLine="AutoScaleAll"[main/General script]
anywheresoftware.b4a.keywords.LayoutBuilder.scaleAll(views);
//BA.debugLineNum = 3;BA.debugLine="Button1.Left = 50%x-Button1.Width/2"[main/General script]
views.get("button1").vw.setLeft((int)((50d / 100 * width)-(views.get("button1").vw.getWidth())/2d));
//BA.debugLineNum = 4;BA.debugLine="Button1.Top  = 50%y-Button1.Height/2"[main/General script]
views.get("button1").vw.setTop((int)((50d / 100 * height)-(views.get("button1").vw.getHeight())/2d));

}
}