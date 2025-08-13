package b4a.example.toastmessageshow.in.timer.designerscripts;
import anywheresoftware.b4a.objects.TextViewWrapper;
import anywheresoftware.b4a.objects.ImageViewWrapper;
import anywheresoftware.b4a.BA;


public class LS_layout{

public static void LS_general(anywheresoftware.b4a.BA ba, android.view.View parent, anywheresoftware.b4a.keywords.LayoutValues lv, java.util.Map props,
java.util.Map<String, anywheresoftware.b4a.keywords.LayoutBuilder.ViewWrapperAndAnchor> views, int width, int height, float scale) throws Exception {
anywheresoftware.b4a.keywords.LayoutBuilder.setScaleRate(0.3);
//BA.debugLineNum = 2;BA.debugLine="AutoScaleAll"[Layout/General script]
anywheresoftware.b4a.keywords.LayoutBuilder.scaleAll(views);
//BA.debugLineNum = 3;BA.debugLine="Button1.HorizontalCenter = 50%x"[Layout/General script]
views.get("button1").vw.setLeft((int)((50d / 100 * width) - (views.get("button1").vw.getWidth() / 2)));
//BA.debugLineNum = 4;BA.debugLine="Button1.VerticalCenter = 50%y"[Layout/General script]
views.get("button1").vw.setTop((int)((50d / 100 * height) - (views.get("button1").vw.getHeight() / 2)));

}
}