### Icon System Tray Example (Inline Java version) by jkhazraji
### 03/15/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166123/)

from: <https://gist.github.com/jewelsea>  

```B4X
Sub Process_Globals  
    Private MainForm As Form  
    Private ps As JavaObject  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
   
    Dim JavaFXTrayIconSample As JavaObject  
    JavaFXTrayIconSample.InitializeNewInstance(getPackageName & ".main$SystemTrayExample", Array(Null))  
End Sub  
Private Sub getPackageName() As String  
    Dim joBA As JavaObject  
    joBA.InitializeStatic("anywheresoftware.b4a.BA")  
    Log("Packagename: " & joBA.GetField("packageName"))  
    Return joBA.GetField("packageName")  
End Sub  
#if JAVA  
import javafx.application.Platform;  
import javafx.scene.control.Label;  
import javafx.scene.layout.StackPane;  
import javafx.scene.Scene;  
import javafx.stage.Stage;  
import javafx.stage.StageStyle;  
  
import javax.imageio.ImageIO;  
import java.awt.*;  
import java.io.IOException;  
import java.net.URL;  
import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.util.Timer;  
import java.util.TimerTask;  
  
public class SystemTrayExample {  
  
    private static final String iconImageLoc = "https://icons.iconarchive.com/icons/scafer31000/bubble-circle-3/16/GameCenter-icon.png";  
    private Timer notificationTimer = new Timer();  
    private SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");  
    private Stage stage;  
  
    public SystemTrayExample() {   
        javax.swing.SwingUtilities.invokeLater(this::addAppToTray);  
    }  
  
    private void addAppToTray() {  
        try {  
            if (!SystemTray.isSupported()) {  
                System.out.println("No system tray support, exiting.");  
                return;  
            }  
  
            SystemTray tray = SystemTray.getSystemTray();  
            URL imageLoc = new URL(iconImageLoc);  
            Image image = ImageIO.read(imageLoc);  
            TrayIcon trayIcon = new TrayIcon(image, "B4J Tray App");  
  
            // Double-click opens the app  
            trayIcon.addActionListener(event -> Platform.runLater(this::showStage));  
  
            // Menu options  
            PopupMenu popup = new PopupMenu();  
            MenuItem openItem = new MenuItem("Open");  
            openItem.addActionListener(event -> Platform.runLater(this::showStage));  
            popup.add(openItem);  
             
             
            MenuItem abItem = new MenuItem("About");  
                    abItem.addActionListener(event -> {  
                        BA.Log("B4J Tray App");  
                    });  
            popup.add(abItem);  
  
            MenuItem exitItem = new MenuItem("Exit");  
            exitItem.addActionListener(event -> {  
                notificationTimer.cancel();  
                Platform.exit();  
                tray.remove(trayIcon);  
            });  
            popup.add(exitItem);  
  
            trayIcon.setPopupMenu(popup);  
            tray.add(trayIcon);  
  
            // Show notifications periodically  
            notificationTimer.schedule(new TimerTask() {  
                @Override  
                public void run() {  
                    trayIcon.displayMessage("Reminder", "Current time: " + timeFormat.format(new Date()), TrayIcon.MessageType.INFO);  
                }  
            }, 5000, 60000);  
  
        } catch (AWTException | IOException e) {  
            e.printStackTrace();  
        }  
    }  
  
    private void showStage() {  
        if (stage == null) {  
            stage = new Stage();  
            stage.initStyle(StageStyle.UTILITY);  
            Label label = new Label("Hello from System Tray!");  
            StackPane root = new StackPane(label);  
            Scene scene = new Scene(root, 300, 200);  
            stage.setScene(scene);  
        }  
        stage.show();  
        stage.toFront();  
    }  
}  
  
#End If
```

  
![](https://www.b4x.com/android/forum/attachments/162564)