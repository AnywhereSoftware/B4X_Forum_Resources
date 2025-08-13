package tastytoastwrapper;

import com.sdsmdg.tastytoast.TastyToast;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.Hide;
import anywheresoftware.b4a.BA.Pixel;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.keywords.Common.DesignerCustomView;
import anywheresoftware.b4a.objects.LabelWrapper;
import anywheresoftware.b4a.objects.PanelWrapper;
import anywheresoftware.b4a.objects.ViewWrapper;
import anywheresoftware.b4a.BA.ActivityObject;

import anywheresoftware.b4a.BA.Events;
import android.view.View;
import android.widget.TextView;
import android.widget.ImageView;
import java.util.ArrayList;
import java.util.List;
import android.os.Bundle;


import android.os.Handler;

//@Events(values={"picture_changed(position As Int), scroll_stopped(), picture_touched(position As Int), picture_long_touched(position As Int)"})
//@Events(values={"item_selected(position As Int)"})
@Author("Github: Rahul Yadav, Wrapped by: Fernando Arevalo")
@Version(1.00f)
@ShortName("TastyToast")
@DependsOn(values={"rebound-0.3.8"})
public class tastytoastWrapper {


	private BA ba;
	//private String eventName;
    private TastyToast cv;
	
	public void Initialize(BA ba) {
		_initialize(ba, null);
	}

	@Hide
	public void _initialize(BA ba, Object activityClass) {
		this.ba = ba;

 	}
	
    public void showSuccessToast(String toastmessage) {
        TastyToast.makeText(ba.applicationContext, toastmessage, TastyToast.LENGTH_LONG,
                TastyToast.SUCCESS);
    }

    public void showWarningToast(String toastmessage) {
        TastyToast.makeText(ba.applicationContext, toastmessage, TastyToast.LENGTH_LONG,
                TastyToast.WARNING);
    }

    public void showErrorToast(String toastmessage) {
        TastyToast.makeText(ba.applicationContext, toastmessage, TastyToast.LENGTH_LONG,
                TastyToast.ERROR);
    }
    public void showInfoToast(String toastmessage) {
        TastyToast.makeText(ba.applicationContext, toastmessage, TastyToast.LENGTH_LONG,
                TastyToast.INFO);
    }

    public void showDefaultToast(String toastmessage) {
        TastyToast.makeText(ba.applicationContext, toastmessage, TastyToast.LENGTH_LONG,
                TastyToast.DEFAULT);
    }

	public void showConfusingToast(String toastmessage) {
        TastyToast.makeText(ba.applicationContext, toastmessage, TastyToast.LENGTH_LONG,
                TastyToast.CONFUSING);
    }

 
}
