### Haptic feedback in B4A: 4 approaches compared by GeoT
### 10/08/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172225/)

I recently went down a rabbit hole comparing the different ways to trigger haptic feedback (vibration) in B4A, and ended up decompiling Phone.jar (CFR) and reading the .b4xlib source of XUI Views directly, instead of guessing. Sharing the findings here in case it saves someone else the trouble.  
  
Four approaches, all Android:  
  
[TABLE]  
[TR]  
[TD][/TD]  
  
[TD]**VIBRATE permission**[/TD]  
[TD]**Needs a View**[/TD]  
[TD]**Cross-platform**[/TD]  
[/TR]  
[TR]  
[TD]A. PhoneVibrate[/TD]  
[TD]YES[/TD]  
[TD]NO[/TD]  
[TD]NO[/TD]  
[/TR]  
[TR]  
[TD]B. performHaptic[/TD]  
[TD]NO[/TD]  
[TD]YES[/TD]  
[TD]NO[/TD]  
[/TR]  
[TR]  
[TD]C. VibrationEffect[/TD]  
[TD]YES[/TD]  
[TD]NO[/TD]  
[TD]NO[/TD]  
[/TR]  
[TR]  
[TD]D. XUIViewsUtils[/TD]  
[TD]NO[/TD]  
[TD]YES[/TD]  
[TD]YES[/TD]  
[/TR]  
[/TABLE]  
  
   
[HEADING=2]A. Phone library — PhoneVibrate.Vibrate(TimeMs)[/HEADING]  
'Alternative: .Vibrate(TimeMs As Long) on the PhoneVibrate object  
'from the Phone library (needs android.permission.VIBRATE)  
I decompiled Phone.jar to see what's actually inside. This is the real implementation:  
  

```B4X
public static class Phone.PhoneVibrate {  
    public static void Vibrate(BA ba, long TimeMs) {  
        Vibrator v = (Vibrator) ba.context.getSystemService("vibrator");  
        v.vibrate(TimeMs);  
    }  
}
```

  
   
It's a bare call to the legacy Vibrator.vibrate(long), no attributes, no settings check whatsoever in the code. Two things worth knowing if you use this:  

- **On a LongClick**, if your listener returns True, Android automatically fires its own performHapticFeedback(LONG\_PRESS) right after your Sub runs — and that second vibration overrides yours. So your custom TimeMs is only respected on a plain **Click**, not on a LongClick (where you get the system's fixed long-press pattern instead, same as option B).
- Empirically, **both** the Click and the LongClick paths only vibrate if the system's "haptic feedback" setting is enabled — even though the decompiled code shows no such check. So this gating happens at the Android framework/OEM level for the unattributed legacy call, not in B4A code.

  
[HEADING=2]B. Manual JavaObject — performHapticFeedback[/HEADING]  

```B4X
Public Sub TriggerHapticLongPress(v As View)  
        Try  
                ' performHapticFeedback flags (per AOSP HapticFeedbackConstants):  
                ' 0 = LONG_PRESS   (press-and-hold feedback)  
                ' 1 = VIRTUAL_KEY  (standard tap feedback)   <- flag actually used below  
                ' 3 = KEYBOARD_TAP (very light feedback)  
                Dim jo As JavaObject = v  
                jo.RunMethod("performHapticFeedback", Array As Object(1))  
        Catch  
                Log("Error triggering haptic feedback: " & LastException)  
        End Try  
End Sub
```

  
  
No permission needed. Respects both View.hapticFeedbackEnabled and the system's touch-feedback setting, per Android docs.  
  
   
[HEADING=2]C. Manual JavaObject — VibrationEffect (full control)[/HEADING]  

```B4X
Private Sub TriggerHapticFeedback  
        Try  
                Dim sdkInt As Int = GetSdkInt  
                Dim ctx As JavaObject  
                ctx.InitializeContext  
                Dim duration As Long = 150  
                Dim amplitude As Int = -1  
                Dim effect As JavaObject  
                effect = effect.InitializeStatic("android.os.VibrationEffect") _  
                        .RunMethod("createOneShot", Array As Object(duration, amplitude))  
  
                If sdkInt >= 31 Then  
                        ' VibratorManager -> getDefaultVibrator  
                        ' (sdkInt >= 33 additionally uses VibrationAttributes.createForUsage)  
  
                Else If sdkInt >= 26 Then  
                        ' Vibrator.vibrate(effect)  
                Else  
                        ' Vibrator.vibrate(legacyDuration)  ' same call as option A  
                End If  
  
        Catch  
                Log("Vibration error: " & LastException.Message)  
        End Try  
End Sub
```

  
  
Needs VIBRATE permission and 3–4 SDK branches to maintain, but it's the only option that gives you real control over duration/amplitude while explicitly ignoring the "haptic feedback" system setting (it only respects Silent/DND).  
  
  
[HEADING=2]D. XUI Views — XUIViewsUtils.PerformHapticFeedback[/HEADING]  
  
Depends on XUI (per the library's own manifest.txt: B4A.DependsOn=BitmapCreator, XUI, DateUtils, xCustomListView, IME, JavaObject, B4XFormatter). I unzipped the .b4xlib (it's just a zip) and read XUIViewsUtils.bas directly — no decompiling needed, it's plain source:  
  

```B4X
Public Sub PerformHapticFeedback (View As B4XView)  
    Initialize  
   #if B4A  
    Dim jo As JavaObject = View  
    jo.RunMethod("performHapticFeedback", Array(1))  
    #Else if B4i  
    If FeedbackGenerator.IsInitialized Then  
        FeedbackGenerator.RunMethod("impactOccurred", Null)  
    End If  
    #end if  
End Sub
```

  
  
On Android, this is functionally identical to option B — same method, same flag, no extra settings logic. The only real reason to use it over your own implementation is the #if B4i branch, which uses UIImpactFeedbackGenerator natively on iOS. Usage:  
  

```B4X
' A plain B4A View works here thanks to the XUI dependency  
Sub btnConfirm_Click  
        XUIViewsUtils.PerformHapticFeedback(btnConfirm)  
End Sub
```

  
  
  
[HEADING=2]Checking the setting before vibrating (for A, B, D)[/HEADING]  
Since A, B and D all depend on the system's haptic feedback setting, this pair of Subs checks it and can send the user to the right settings screen:  
  

```B4X
' Checks whether touch feedback is enabled in the system settings  
Public Sub IsHapticFeedbackEnabled As Boolean  
        Try  
                Dim ctxt As JavaObject  
                ctxt.InitializeContext  
                Dim cr As JavaObject = ctxt.RunMethod("getContentResolver", Null)  
                Dim settingsSystem As JavaObject  
                settingsSystem.InitializeStatic("android.provider.Settings$System")  
  
                Dim hapticOn As Int = settingsSystem.RunMethod( _  
                        "getInt", Array As Object(cr, "haptic_feedback_enabled", 0))  
                Return hapticOn = 1  
        Catch  
                Log("Error reading haptic feedback state: " & LastException)  
                Return True ' Assume True when in doubt, to avoid false warnings  
        End Try  
End Sub  
  
' Opens Android's sound/vibration settings screen  
Public Sub OpenHapticSettings  
        Dim ctxt As JavaObject  
        ctxt.InitializeContext  
  
        Dim actions() As String = Array As String( _  
                "android.settings.SOUND_SETTINGS", _  
                "android.settings.VIBRATION_SETTINGS", _  
                "android.provider.Settings.ACTION_SOUND_SETTINGS", _  
                "android.settings.SETTINGS" _  
        )  
  
        For Each act As String In actions  
                If TryStartIntent(ctxt, act) Then  
                        Return  
                End If  
        Next  
  
        ToastMessageShow("Could not open settings automatically", False)  
End Sub  
  
Private Sub TryStartIntent(ctxt As JavaObject, actionName As String) As Boolean  
        Try  
                Dim joIntent As JavaObject  
                joIntent.InitializeNewInstance("android.content.Intent", Array(actionName))  
                joIntent.RunMethod("addFlags", Array(0x10000000)) ' FLAG_ACTIVITY_NEW_TASK  
                ctxt.RunMethod("startActivity", Array(joIntent))  
                Return True  
        Catch  
                Return False  
        End Try  
End Sub
```

  
  
Doesn't add any permission (it's a read-only getInt) or dependency beyond JavaObject, which all four options already use. Usage pattern:  
  

```B4X
If HapticManager.IsHapticFeedbackEnabled Then  
        ' trigger the vibration normally  
Else  
        ' optional: warn the user or call HapticManager.OpenHapticSettings  
End If
```

  
  
Note this check doesn't add anything useful for **option C** — it explicitly ignores that setting, so testing it wouldn't change its behaviour.  
  
   
[HEADING=2]TL;DR[/HEADING]  

- Want the simplest, permission-free option and don't care about the exact pattern → **B**.
- Want full control over duration/amplitude and don't want it gated by the haptic-feedback setting → **C**, at the cost of maintaining SDK branches.
- Building for Android + iOS → **D** (identical to B on Android, native on iOS).
- **A** doesn't offer any verified advantage over B or D: it needs an extra permission and, on top of that, still ends up gated by the same system setting.

  
Happy to share the full write-up (with the decompiled bytecode and the .bas source side by side) if anyone wants more detail.