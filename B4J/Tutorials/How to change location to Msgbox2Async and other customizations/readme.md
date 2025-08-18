### How to change location to Msgbox2Async and other customizations by Star-Dust
### 07/31/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/141939/)

**[SIZE=6]change location[/SIZE]**  
You will surely have noticed that xui.Msgbox2Async places the alert in the center of the last form shown that depends on its Owner.  
  
Sometimes there is a need to place it on a specific point on the screen. How to do?  
  

```B4X
Dim msg As JavaObject = xui.Msgbox2Async("Message", "Title", "Yes", "", "No", Null)  
Dim jo As JavaObject = Me  
jo.RunMethod("PosDialog",Array (msg,300,300))  
Wait For (msg) Msgbox_Result (Result As Int)  
' ………………..  
#if Java  
 import javafx.scene.control.Dialog;  
 import javafx.scene.control.Alert;  
// import javafx.scene.control.ButtonType;  
// import javafx.scene.control.ButtonBar;  
   
   public static void PosDialog(Alert alrt, int x, int y) {  
    alrt.setX(x);  
    alrt.setY(y);  
   System.out.println("work fine");  
 }  
#End If
```