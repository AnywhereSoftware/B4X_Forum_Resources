###  SnapCLVAdvanced - Move to the nearest item - Instant snap by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/139371/)

I took the original [CLVSnap](https://www.b4x.com/android/forum/threads/b4x-snapclv-move-to-the-nearest-item.109500/#content)code from [USER=1]@Erel[/USER] and modified it to create a new class.  
  
With this class you can decide if you want to have an instant snap or if you want the list to snap only when the list stops moving.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
It is compatible with B4A, B4i and B4J.  
Note that you need to call snap.ScrollChanged from the ScrollChanged event.  
On B4I you need [GestureRecognizer](https://www.b4x.com/android/forum/threads/gesturerecognizer-native-uigesturerecognizer.52836/) Download the .bas file in the attachment  
  

```B4X
AdvancedSnap.InstantSnap = True
```

  
Default: False  
If False then the snap works like the original CLVSnap Class.  
  
![](https://www.b4x.com/android/forum/attachments/126958)  
  

```B4X
    For i = 0 To 50 -1  
     
        Dim xpnl As B4XView = xui.CreatePanel("")  
        xpnl.Color = Rnd(0xff000000, 0xffffffff)  
        xpnl.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, Rnd(200dip, 300dip))  
        CustomListView1.Add(xpnl, "")  
     
    Next  
   
    AdvancedSnap.Initialize(CustomListView1)  
    AdvancedSnap.InstantSnap = True  
  
…  
Sub CustomListView1_ScrollChanged (Offset As Int)  
    AdvancedSnap.ScrollChanged(Offset)  
End Sub
```

  
  
**SnapCLVAdvanced  
Author: Alexander Stolte  
Version: 1.00  
  
Changelog**  

- **1.00**

- Release

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)