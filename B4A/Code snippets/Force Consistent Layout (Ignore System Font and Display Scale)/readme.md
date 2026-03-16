### Force Consistent Layout (Ignore System Font and Display Scale) by Abdull Cadre
### 03/13/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/170574/)

Hi everyone,  
  
One of the biggest challenges in UI/UX design for Android is when the user changes the **Font Size** (Acessibility) or **Display Size** (Scaling) in the system settings. This often breaks carefully designed layouts, especially when using fixed-size panels or labels.  
  
This snippet, added to your **Activity**, forces the app to render at **100% font scale** and uses the **device's native density**, ignoring system-wide overrides.  
[HEADING=2]**Where to add this code?**[/HEADING]  
**1. B4XPages (Recommended)**  
You only need to add this code to the **Main Activity** module.  
  
In a B4XPages project, there is typically only one underlying Activity that hosts all your pages. By modifying the attachBaseContext of the Main Activity, the configuration is applied to the entire app lifecycle, ensuring all your pages stay consistent with a single block of code.  
[HEADING=3]**2. Activities (Standard B4A)**[/HEADING]  
You must add this code to **each Activity** module in your project.  
  
Each Activity in Android has its own Context. If you only add it to the Main Activity, the system settings (large fonts) will still affect any other Activity you open later. To maintain a consistent UI across the whole app, every Activity must override its base context.  
  
[HEADING=2]**The Code:**[/HEADING]  
  

```B4X
#If JAVA  
import android.content.Context;  
import android.content.res.Configuration;  
import android.content.res.Resources;  
  
@Override  
protected void attachBaseContext(Context newBase) {  
    Resources res = newBase.getResources();  
Configuration config = new Configuration(res.getConfiguration());  
   
// 1. Fix Font Scale to 100% (Ignores "Large Text" settings)  
config.fontScale = 1.0f;  
   
// 2. Fix Density (DPI) to the device's native default  
// This prevents "Display Size" changes from breaking layouts  
    config.densityDpi = res.getDisplayMetrics().densityDpi;  
   
    Context context = newBase.createConfigurationContext(config);  
    super.attachBaseContext(context);  
}  
#End If
```

  
   
  
[HEADING=2]Comparison (System Font set to "Maximum")[/HEADING]  
Below is a comparison using a simple layout with a fixed-size Label and Panel.  
  
[TABLE]  
[TR]  
[TD]**WITHOUT Script**[/TD]  
[TD]**WITH Script**[/TD]  
[/TR]  
[TR]  
[TD]

![](https://www.b4x.com/android/forum/attachments/170585)

[/TD]  
  
[TD]

![](https://www.b4x.com/android/forum/attachments/170586)

[/TD]  
[/TR]  
[TR]  
[TD]**Broken Layout:**  
System font is **oversized and disproportionate**,  
causing text to overlap and clip outside the views.[/TD]  
[TD]**Consistent Layout:**  
The app ignores system scaling  
and maintains the original design proportions.[/TD]  
[/TR]  
[/TABLE]