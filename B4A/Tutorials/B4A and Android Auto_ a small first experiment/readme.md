### B4A and Android Auto: a small first experiment by marcick
### 10/30/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172437/)

Hi all,  
I have been experimenting with Android Auto from B4A, with a lot of help from ChatGPT. I would not have managed the native integration on my own. After getting it working on a desktop head unit and in a real car, I wanted to share a small starting point for anyone curious about how it fits together.  
  
This is not a wrapper library or a complete Android Auto application. The example simply displays a message and a button. Pressing the button changes a counter. That is enough to show the basic structure without adding maps, network requests or other application logic.  
  
Please note: this guide was also written by ChatGPT. If something is unclear or does not work, I suggest giving ChatGPT the guide together with your question and any error messages, and asking it for help directly. I simply followed its instructions, explaining what I wanted to achieve and understand. I would honestly struggle to provide technical support for this integration myself.  
  
**The first thing I learned: it is not screen mirroring**  
  
Android Auto does not display the layout created in the B4A Designer. It has a separate interface. With the Android for Cars App Library, the app supplies a template and its contents; Android Auto renders them on the head unit.  
  
There are templates for messages, information panels, lists and grids, with supported actions and other components. They are not ordinary B4A views, and I cannot place an unlimited number of controls wherever I want. The available combinations depend on the template, category and API level.  
  
The phone interface and the car interface can therefore look completely different. This example does not use a Designer layout at all.  
  
**One important limitation before starting**  
  
Getting an app to run in Android Auto does not mean Google Play will approve it. Apps must belong to a supported category and meet the driver-distraction requirements. I would check that first, before investing time in a real integration.  
  
If the category is unclear, I suggest contacting Google Play Developer Support before starting. Sign in with your developer account using the link below and submit a support request. Describe exactly what the app would show and let the driver do, and ask whether that functionality fits a supported Android Auto category. If necessary, ask for the question to be forwarded to the Android Auto team. This is a request for guidance, not a guarantee of approval: the finished app still has to pass review.  
  
[Contact Google Play Developer Support](https://play.google.com/console/developers/help-and-support)  
  
The manifest below uses POI only as a development example. A message and a counter do not qualify as a POI app. This is a technical demonstration, not something to submit to Google Play as a finished product.  
  
**1. What is needed**  
  

- B4A with an AndroidX SDK environment. My starting configuration was B4A 14.2 and Android SDK 36.
- An Android phone with Android Auto, USB debugging enabled and a USB data cable.
- The Android Auto Desktop Head Unit (DHU), available in Android Studio → SDK Manager → SDK Tools → Android Auto Desktop Head Unit Emulator.
- The two Google Car App Library AAR files listed below, copied into the Additional Libraries directory configured in B4A.

  
I have kept the same library version used in my experiment so the example has a definite starting point. It is not a recommendation to choose a release candidate for a production app.  
  
[app-1.8.0-rc01.aar](https://dl.google.com/dl/android/maven2/androidx/car/app/app/1.8.0-rc01/app-1.8.0-rc01.aar)  
[app-projected-1.8.0-rc01.aar](https://dl.google.com/dl/android/maven2/androidx/car/app/app-projected/1.8.0-rc01/app-projected-1.8.0-rc01.aar)  
  
Keep the AAR files intact. The Main module also lists AndroidX lifecycle and arch-core dependencies. They must be available in the B4A SDK; if B4A reports one as missing, install it through B4A SDK Manager rather than removing the reference.  
  
**2. Create a small B4A project**  
  

- Create a new standard Activity project, not a B4XPages project. Save it in a new directory.
- Set its package name to org.example.b4aautodemo for this exercise.
- Replace Main with the contents of Main.txt from the attachment.
- Use Add Existing Modules to add AutoDemo.bas. It is a Code Module, not a B4A Service module.
- In the Manifest Editor, replace the default text of this new demo project with Manifest.txt.

  
Main only displays a message on the phone and includes the required libraries:  
  

```B4X
#Region Project Attributes  
#ApplicationLabel: B4A Auto Demo  
#VersionCode: 1  
#VersionName: 0.1  
#SupportedOrientations: unspecified  
#CanInstallToExternalStorage: False  
#AdditionalJar: app-1.8.0-rc01.aar  
#AdditionalJar: app-projected-1.8.0-rc01.aar  
#AdditionalJar: androidx.arch.core:core-common  
#AdditionalJar: androidx.arch.core:core-runtime  
#AdditionalJar: androidx.lifecycle:lifecycle-common  
#AdditionalJar: androidx.lifecycle:lifecycle-runtime  
#MultiDex: True  
#End Region  
  
#Region Activity Attributes  
#FullScreen: False  
#IncludeTitle: True  
#End Region  
  
'No shared state is needed for this demo.  
Sub Process_Globals  
End Sub  
  
'No Designer controls are needed for this demo.  
Sub Globals  
End Sub  
  
'Shows a simple message on the phone.  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.Color = Colors.White  
    Dim Info As Label  
    Info.Initialize("")  
    Info.Text = "Open B4A Auto Demo in Android Auto."  
    Info.TextColor = Colors.Black  
    Info.TextSize = 20  
    Activity.AddView(Info, 20dip, 30dip, 100%x - 40dip, 100dip)  
End Sub  
  
'No action is needed when the phone screen resumes.  
Sub Activity_Resume  
End Sub  
  
'The car screen is managed by its own session.  
Sub Activity_Pause(UserClosed As Boolean)  
End Sub
```

  
  
**3. Register the Android Auto service**  
  
This manifest tells Android Auto where to find the native service and declares that the app uses templates. The $ in autodemo$DemoCarService identifies a Java class nested inside the class generated for the AutoDemo module.  
  

```B4X
'Sets the Android SDK levels and the phone app appearance.  
AddManifestText(<uses-sdk android:minSdkVersion="23" android:targetSdkVersion="36"/>)  
SetApplicationAttribute(android:icon, "@drawable/icon")  
SetApplicationAttribute(android:label, "$LABEL$")  
CreateResourceFromFile(Macro, Themes.LightTheme)  
  
'Registers the native service contained in the AutoDemo code module.  
AddApplicationText(  
<meta-data android:name="com.google.android.gms.car.application" android:resource="@xml/automotive_app_desc"/>  
<meta-data android:name="androidx.car.app.minCarApiLevel" android:value="1"/>  
<service android:name="$PACKAGE$.autodemo$DemoCarService" android:exported="true">  
    <intent-filter>  
        <action android:name="androidx.car.app.CarAppService"/>  
        <category android:name="androidx.car.app.category.POI"/>  
    </intent-filter>  
</service>  
)  
  
'Declares the use of Android Auto templates.  
CreateResource(xml, automotive_app_desc.xml,  
<automotiveApp>  
    <uses name="template"/>  
</automotiveApp>  
)  
  
'Keeps the native classes when building a Release APK.  
AddProguardText(  
-keep class **.autodemo { *; }  
-keep class **.autodemo$** { *; }  
)
```

  
  
**4. Add the native code**  
  
AutoDemo.bas contains the following code. The B4A module hosts three small Java classes: a service, a session and a screen. The screen returns a MessageTemplate with one button.  
  
For this development-only example I use ALLOW\_ALL\_HOSTS\_VALIDATOR, as in Google’s introductory codelab. A production implementation must validate its hosts instead of accepting all of them.  
  

```B4X
'Hosts the native Android Auto classes.  
Sub Process_Globals  
End Sub  
  
#If JAVA  
import android.content.Intent;  
import androidx.car.app.CarAppService;  
import androidx.car.app.CarContext;  
import androidx.car.app.Screen;  
import androidx.car.app.Session;  
import androidx.car.app.model.Action;  
import androidx.car.app.model.MessageTemplate;  
import androidx.car.app.model.OnClickListener;  
import androidx.car.app.model.Template;  
import androidx.car.app.validation.HostValidator;  
  
public static class DemoCarService extends CarAppService {  
    // Allows host connections for this development-only example.  
    @Override  
    public HostValidator createHostValidator() {  
        return HostValidator.ALLOW_ALL_HOSTS_VALIDATOR;  
    }  
  
    // Creates the car session.  
    @Override  
    public Session onCreateSession() {  
        return new DemoSession();  
    }  
}  
  
public static class DemoSession extends Session {  
    // Opens the demo screen on the head unit.  
    @Override  
    public Screen onCreateScreen(Intent intent) {  
        return new DemoScreen(getCarContext());  
    }  
}  
  
public static class DemoScreen extends Screen {  
    private int taps = 0;  
  
    // Creates the screen with its own counter.  
    public DemoScreen(CarContext context) {  
        super(context);  
    }  
  
    // Displays a message and a button that updates the counter.  
    @Override  
    public Template onGetTemplate() {  
        Action button = new Action.Builder().setTitle("Tap me")  
            .setOnClickListener(new OnClickListener() {  
                // Updates the message after a button press.  
                @Override  
                public void onClick() {  
                    taps++;  
                    invalidate();  
                }  
            }).build();  
        return new MessageTemplate.Builder("Hello from B4A! Button taps: " + taps)  
            .setTitle("B4A Auto Demo")  
            .setHeaderAction(Action.APP_ICON)  
            .addAction(button)  
            .build();  
    }  
}  
#End If
```

  
  
The button increments the counter and calls invalidate(). Android Auto then asks for the template again. There is no Label to update on the head unit: the app supplies the new screen contents. I used an anonymous listener rather than a Java lambda to avoid a compilation issue encountered with my B4A toolchain.  
  
**5. Try it on the desktop head unit**  
  
Compile and install the app on the phone. Then enable Android Auto developer mode: open Android Auto settings, expand the Version information and tap the version/permission information repeatedly until developer mode is enabled. In the Android Auto menu, select Start head unit server.  
  
Connect the unlocked phone to the PC and accept the USB debugging prompt. In PowerShell, set the SDK path and check the connection:  
  

```B4X
$AutoSdk = "$env:LOCALAPPDATA\Android\Sdk"  
& "$AutoSdk\platform-tools\adb.exe" devices
```

  
  
The phone must appear with status device. Copy its serial into the next command:  
  

```B4X
$AutoSerial = "YOUR_PHONE_SERIAL"  
& "$AutoSdk\platform-tools\adb.exe" -s $AutoSerial forward tcp:5277 tcp:5277  
Set-Location "$AutoSdk\extras\google\auto"  
.\desktop-head-unit.exe –adb=127.0.0.1:5277
```

  
  
Open B4A Auto Demo in the Android Auto launcher. The expected result is a message reading “Hello from B4A! Button taps: 0”. Press Tap me and the counter should increase.  
  
If the DHU stays on Waiting for phone, check that the head unit server is running on the phone and that adb devices shows device. The DHU is also available for macOS; Google’s setup guide is linked below. B4A itself can remain on Windows.  
  
**6. Trying it in a real car**  
  
In my tests, an app installed directly worked on the DHU but did not appear in the real car. Internal App Sharing provided the installation route for testing it there. It is different from publishing a normal Play Store release.  
  

- Build a Release APK and upload it at <https://play.google.com/console/internal-app-sharing/> using an authorized Play Console account.
- On the phone, open Play Store settings and tap the Play Store version repeatedly to enable its developer options. Enable Internal app sharing.
- Open the link generated for the upload on the phone with an authorized Google account and install the app.
- Connect Android Auto to the car and look for the app in its launcher. Test the button while parked.

  
Internal App Sharing is a testing facility, not approval for public distribution. Google’s “unknown sources” setting is not a general substitute for this installation route for Car App Library apps.  
  
**What this example shows**  
  
The basic route is: add the Car App Library, declare the service in the manifest, and provide the car interface through native Java classes. B4A can host that code without a dedicated Android Auto Designer or a full wrapper library.  
  
This is the small starting point I wanted to share. The next step is not necessarily adding more code: it is deciding which useful, permitted part of an application belongs on the car screen.  
  
**Official references**  
  
[Car App Library overview](https://developer.android.com/training/cars/apps/library)  
[Google’s introductory codelab](https://developer.android.com/codelabs/car-app-library-fundamentals)  
[Android Auto manifest setup](https://developer.android.com/training/cars/apps/auto)  
[Desktop Head Unit setup](https://developer.android.com/training/cars/testing/dhu)  
[Testing in real vehicles](https://developer.android.com/training/cars/testing)  
[Car app quality requirements](https://developer.android.com/docs/quality-guidelines/car-app-quality)  
[Internal App Sharing](https://support.google.com/googleplay/android-developer/answer/9844679?hl=en)