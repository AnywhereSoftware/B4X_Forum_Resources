### Get APK Meta by Blueforcer
### 02/09/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165522/)

For my current project, I needed a way to retrieve metadata from an APK file.  
Im using [APK-Parser](https://github.com/hsiafan/apk-parser) for that.  
  
Here’s how you can do it:  
  
- Copy the attached apkparser.jar into your additional library folder.  
- In your B4J project, add the library with: [ICODE]#AdditionalJar: apkparser.jar[/ICODE]  
  
Then use the following code snippet to get the metadata as a Map:  
  

```B4X
Sub GetApkMetaMap(apkPath As String) As Map  
    Dim out As Map  
    out.Initialize  
     
    Dim fileObj As JavaObject  
    fileObj.InitializeNewInstance("java.io.File", Array(apkPath))  
     
    Dim apkFile As JavaObject  
    apkFile.InitializeNewInstance("net.dongliu.apk.parser.ApkFile", Array(fileObj))  
  
    Dim apkMeta As JavaObject = apkFile.RunMethod("getApkMeta", Null)  
  
    Dim label As String = apkMeta.RunMethod("getLabel", Null)  
    Dim packageName As String = apkMeta.RunMethod("getPackageName", Null)  
    Dim versionName As String = apkMeta.RunMethod("getVersionName", Null)  
    Dim versionCode As Long = apkMeta.RunMethod("getVersionCode", Null)  
    Dim minSdk As String = apkMeta.RunMethod("getMinSdkVersion", Null)  
    Dim targetSdk As String = apkMeta.RunMethod("getTargetSdkVersion", Null)  
     
    Dim compileSdkVersion As String = apkMeta.RunMethod("getCompileSdkVersion", Null)  
    Dim compileSdkVersionCodename As String = apkMeta.RunMethod("getCompileSdkVersionCodename", Null)  
    Dim platformBuildVersionCode As String = apkMeta.RunMethod("getPlatformBuildVersionCode", Null)  
    Dim platformBuildVersionName As String = apkMeta.RunMethod("getPlatformBuildVersionName", Null)  
  
    Dim permissionsJO As JavaObject = apkMeta.RunMethod("getUsesPermissions", Null)  
     
    out.Put("Label", label)  
    out.Put("PackageName", packageName)  
    out.Put("VersionName", versionName)  
    out.Put("VersionCode", versionCode)  
    out.Put("MinSdk", minSdk)  
    out.Put("TargetSdk", targetSdk)  
  
    out.Put("CompileSdkVersion", compileSdkVersion)  
    out.Put("CompileSdkVersionCodename", compileSdkVersionCodename)  
    out.Put("PlatformBuildVersionCode", platformBuildVersionCode)  
    out.Put("PlatformBuildVersionName", platformBuildVersionName)  
    out.Put("Permissions", permissionsJO)  
  
    out.Put("CreatedAt", File.LastModified(apkPath,""))  
    apkFile.RunMethod("close", Null)  
     
    Return out  
End Sub
```

  
  
Output:  
  
  

```B4X
{  
    "VersionCode": 1,  
    "PlatformBuildVersionName": "14",  
    "PackageName": "de.dinotec.netplus",  
    "CompileSdkVersionCodename": "14",  
    "CreatedAt": 1738495617910,  
    "Label": "NetplusCore",  
    "MinSdk": "5",  
    "CompileSdkVersion": "34",  
    "Permissions": [  
        "android.permission.WRITE_EXTERNAL_STORAGE",  
        "android.permission.WAKE_LOCK",  
        "android.permission.SYSTEM_ALERT_WINDOW",  
        "android.permission.SYSTEM_ERROR_WINDOW",  
        "android.permission.INTERNET",  
        "android.permission.WRITE_EXTERNAL_STORAGE",  
        "android.permission.VIBRATE",  
        "android.permission.ACCESS_NETWORK_STATE",  
        "android.permission.ACCESS_WIFI_STATE",  
        "android.permission.CHANGE_WIFI_STATE",  
        "android.permission.ACCESS_FINE_LOCATION",  
        "android.permission.CHANGE_NETWORK_STATE",  
        "android.permission.WRITE_SETTINGS",  
        "android.permission.FOREGROUND_SERVICE",  
        "android.permission.CHANGE_WIFI_MULTICAST_STATE",  
        "android.permission.READ_EXTERNAL_STORAGE"  
    ],  
    "VersionName": "Alpha 0.46",  
    "TargetSdk": "33",  
    "PlatformBuildVersionCode": "34"  
}
```