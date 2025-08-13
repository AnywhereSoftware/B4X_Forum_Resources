package b4j.example.designerscripts;
import anywheresoftware.b4a.BA;


public class LS_frm_main{

public static void LS_general(anywheresoftware.b4j.objects.LayoutBuilder.LayoutData views, int width, int height, float scale) {
;
//BA.debugLineNum = 2;BA.debugLine="lbl_show_msg.HorizontalCenter = 50%x"[frm_main/General script]
views.get("lbl_show_msg").setLeft((int)((50d / 100 * width) - (views.get("lbl_show_msg").getPrefWidth() / 2)));

}
}