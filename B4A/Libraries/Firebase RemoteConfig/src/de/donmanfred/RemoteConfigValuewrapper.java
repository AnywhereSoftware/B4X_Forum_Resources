package de.donmanfred;

import java.util.Set;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigInfo;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigValue;

import android.content.Context;
import android.support.annotation.NonNull;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Events;
import anywheresoftware.b4a.BA.Hide;
import anywheresoftware.b4a.BA.Pixel;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.keywords.Common.DesignerCustomView;
import anywheresoftware.b4a.objects.CustomViewWrapper;
import anywheresoftware.b4a.objects.LabelWrapper;
import anywheresoftware.b4a.objects.PanelWrapper;
import anywheresoftware.b4a.objects.ViewWrapper;
import anywheresoftware.b4a.objects.collections.Map;
import anywheresoftware.b4a.objects.collections.Map.MyMap;

@ShortName("RemoteConfigValue")
//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"FetchCompleted(success As Boolean)"})
//@DependsOn(values={"android-viewbadger"})
public class RemoteConfigValuewrapper extends AbsObjectWrapper<FirebaseRemoteConfigValue> {

	public boolean asBoolean(){
		return getObject().asBoolean();
	}
	public byte[] asByteArray(){
		return getObject().asByteArray();
	}
	public double asDouble(){
		return getObject().asDouble();
	}
	public long asLong(){
		return getObject().asLong();
	}
	public String asString(){
		return getObject().asString();
	}
	public String getSource(){
		int source = getObject().getSource();
		if(source == FirebaseRemoteConfig.VALUE_SOURCE_DEFAULT){
			return "Default";
		} else if (source == FirebaseRemoteConfig.VALUE_SOURCE_REMOTE){
			return "Remote";
		} else if (source == FirebaseRemoteConfig.VALUE_SOURCE_STATIC){
			return "Static";			
		}
		return null;
	}
	public int getSource2(){
		return getObject().getSource();
	}

}