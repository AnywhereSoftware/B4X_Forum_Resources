package de.donmanfred;

import java.util.Set;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigInfo;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigValue;

import android.support.annotation.NonNull;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.BA.Events;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.objects.collections.Map;
import anywheresoftware.b4a.objects.collections.Map.MyMap;

@Version(2.04f)
@ShortName("FirebaseRemoteConfig")
//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
@Events(values={"onFetchCompleted(success As Boolean)"})
@DependsOn(values={"com.google.firebase:firebase-core","com.google.firebase:firebase-common","com.google.firebase:firebase-config","com.google.firebase:firebase-perf"})
public class FirebaseRemoteConfigwrapper {
	private BA ba;
	private String eventName;
	private FirebaseRemoteConfig cfg;
	/*
	 * Initialize the HTML-TextView 
	 */   	
	public FirebaseRemoteConfig Initialize(BA ba, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.cfg = FirebaseRemoteConfig.getInstance();
		return this.cfg;
	}

	public boolean getBoolean(String key){
		return FirebaseRemoteConfig.getInstance().getBoolean(key);
	}
	public boolean getBoolean2(String key, String namespace){
		return FirebaseRemoteConfig.getInstance().getBoolean(key, namespace);
	}
	public byte[] getByteArray(String key){
		return FirebaseRemoteConfig.getInstance().getByteArray(key);
	}
	public byte[] getByteArray2(String key, String namespace){
		return FirebaseRemoteConfig.getInstance().getByteArray(key, namespace);
	}
	public double getDouble(String key){
		return FirebaseRemoteConfig.getInstance().getDouble(key);
	}
	public double getDouble2(String key, String namespace){
		return FirebaseRemoteConfig.getInstance().getDouble(key, namespace);
	}
	public FirebaseRemoteConfigInfo getInfo(){
		return FirebaseRemoteConfig.getInstance().getInfo();
	}
	public Set<String> getKeysByPrefix(String prefix){
		return FirebaseRemoteConfig.getInstance().getKeysByPrefix(prefix);
	}
	public Set<String> getKeysByPrefix2(String prefix, String namespace){
		return FirebaseRemoteConfig.getInstance().getKeysByPrefix(prefix, namespace);
	}
	public long getLong(String key){
		return FirebaseRemoteConfig.getInstance().getLong(key);
	}
	public long getLong2(String key, String namespace){
		return FirebaseRemoteConfig.getInstance().getLong(key, namespace);
	}
	public String getString(String key){
		return FirebaseRemoteConfig.getInstance().getString(key);
	}
	public String getString(String key, String namespace){
		return FirebaseRemoteConfig.getInstance().getString(key, namespace);
	}
	public FirebaseRemoteConfigValue getValue(String key){
		return FirebaseRemoteConfig.getInstance().getValue(key);
	}
	public FirebaseRemoteConfigValue getValue2(String key, String namespace){
		return FirebaseRemoteConfig.getInstance().getValue(key, namespace);
	}
	/**
	 * Activates the Fetched Config, so that the fetched key-values take effect. 
	 */
	public boolean activateFetched(){
		return FirebaseRemoteConfig.getInstance().activateFetched();
	}
	public void setConfigSettings(FirebaseRemoteConfigSettings setting){
		FirebaseRemoteConfig.getInstance().setConfigSettings(setting);
	}
	public void setDefaults3(int resourceId){
		FirebaseRemoteConfig.getInstance().setDefaults(resourceId);
	}
	public void setDefaults(Map defaults){
		FirebaseRemoteConfig.getInstance().setDefaults(B4AMapToJMap(defaults));
	}
	public void setDefaults2(Map defaults, String namespace){
		FirebaseRemoteConfig.getInstance().setDefaults(B4AMapToJMap(defaults), namespace);
	}
	@SuppressWarnings("unchecked")
	java.util.Map<String, Object> B4AMapToJMap(anywheresoftware.b4a.objects.collections.Map map) {
    return (java.util.Map)map.getObject();
	}
	MyMap JMapToB4AMap(java.util.Map<String, Object> map) {
		anywheresoftware.b4a.objects.collections.Map m = new anywheresoftware.b4a.objects.collections.Map();
		m.Initialize();
		m.getObject().putAll(map);
		return m.getObject();
	}
	/**
	 * fetch(long cacheExpirationSeconds)
	 * Fetches parameter values for your app. 
	 * @param cacheExpiration
	 */
	public void fetch2(long cacheExpiration){
		// cacheExpirationSeconds is set to cacheExpiration here, indicating the next fetch request
		// will use fetch data from the Remote Config service, rather than cached parameter values,
		// if cached parameter values are more than cacheExpiration seconds old.
		// See Best Practices in the README for more information.
		FirebaseRemoteConfig.getInstance().fetch(cacheExpiration)
		.addOnCompleteListener(new OnCompleteListener<Void>() {
			@Override
			public void onComplete(@NonNull Task<Void> task) {
				if (task.isSuccessful()) {
					//Toast.makeText(MainActivity.this, "Fetch Succeeded",
					//          Toast.LENGTH_SHORT).show();
					// After config data is successfully fetched, it must be activated before newly fetched
					// values are returned.
					FirebaseRemoteConfig.getInstance().activateFetched();
					ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_onfetchcomplete", true, new Object[] {Boolean.valueOf(true)});

				} else {
					ba.setLastException(task.getException());
					//ba.Log(task.getException().getCause().getMessage());
					ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_onfetchcomplete", true, new Object[] {Boolean.valueOf(false)});
					//Toast.makeText(MainActivity.this, "Fetch Failed",
	        //Toast.LENGTH_SHORT).show();
				}
				//displayWelcomeMessage();
			}
		});

	}
	public static final int LAST_FETCH_STATUS_FAILURE = 1;
	public static final int LAST_FETCH_STATUS_NO_FETCH_YET = 0;
	public static final int LAST_FETCH_STATUS_SUCCESS = -1;
	public static final int LAST_FETCH_STATUS_THROTTLED = 2;
	public void fetch(){
		// cacheExpirationSeconds is set to cacheExpiration here, indicating the next fetch request
		// will use fetch data from the Remote Config service, rather than cached parameter values,
		// if cached parameter values are more than cacheExpiration seconds old.
		// See Best Practices in the README for more information.
		FirebaseRemoteConfig.getInstance().fetch()
		.addOnCompleteListener(new OnCompleteListener<Void>() {
			@Override
			public void onComplete(@NonNull Task<Void> task) {
				if (task.isSuccessful()) {
					//Toast.makeText(MainActivity.this, "Fetch Succeeded",
					//		Toast.LENGTH_SHORT).show();
					// 	After config data is successfully fetched, it must be activated before newly fetched
					// values are returned.
					FirebaseRemoteConfig.getInstance().activateFetched();
					ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_onfetchcomplete", true, new Object[] {Boolean.valueOf(true)});
				} else {
					//Toast.makeText(MainActivity.this, "Fetch Failed",
	        //                    Toast.LENGTH_SHORT).show();
					ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_onfetchcomplete", true, new Object[] {Boolean.valueOf(false)});
				}
				//displayWelcomeMessage();
			}
		});

	}
	//@Events(values={"CommandApduProcessed(message() As Byte)"})
	@ShortName("FetchStatus")
	public static class FetchStatuswrapper {
		/**
		 * Indicates that the most recent attempt to fetch parameter 
		 * values from the Remote Config Server was throttled.
		 */
		public int getThrottled(){
			return FirebaseRemoteConfig.LAST_FETCH_STATUS_THROTTLED;
		}
		public int getSuccess(){
			return FirebaseRemoteConfig.LAST_FETCH_STATUS_SUCCESS;
		}
		/**
		 * Indicates that the most recent attempt to fetch parameter 
		 * values from the Remote Config Server has failed.
		 */
		public int getFailure(){
			return FirebaseRemoteConfig.LAST_FETCH_STATUS_FAILURE;
		}
		/**
		 * Indicates that the FirebaseRemoteConfig singleton object 
		 * has not yet attempted to fetch parameter values from 
		 * the Remote Config Server.
		 */
		public int getNoFetchYet(){
			return FirebaseRemoteConfig.LAST_FETCH_STATUS_NO_FETCH_YET;
		}
	}
	public static final int VALUE_SOURCE_DEFAULT = 1;
	public static final int VALUE_SOURCE_REMOTE = 2;
	public static final int VALUE_SOURCE_STATIC = 0;

	@ShortName("ValueSource")
	public static class ValueSourcewrapper {
		/**
		 * Indicates that the value returned was 
		 * retrieved from the Default Config.
		 */
		public int getDefault(){
			return FirebaseRemoteConfig.VALUE_SOURCE_DEFAULT;
		}
		/**
		 * Indicates that the value returned was 
		 * retrieved from the Remote Config Server.
		 */
		public int getRemote(){
			return FirebaseRemoteConfig.VALUE_SOURCE_REMOTE;
		}
		/**
		 * Indicates that the value returned 
		 * is the static default value.
		 */
		public int getStatic(){
			return FirebaseRemoteConfig.VALUE_SOURCE_STATIC;
		}
	}

	@ShortName("ConfigSettingsBuilder")
	public static class FirebaseRemoteConfigSettingsBuilder {
		private FirebaseRemoteConfigSettings.Builder builder;
		public FirebaseRemoteConfigSettingsBuilder Initialize() {
			builder = new FirebaseRemoteConfigSettings.Builder();
			return this;
		}
		public FirebaseRemoteConfigSettingsBuilder setDeveloperModeEnabled(boolean enabled){
			builder.setDeveloperModeEnabled(enabled);
			return this;
		}
		public FirebaseRemoteConfigSettings build(){
			return builder.build();
		}
	}
}