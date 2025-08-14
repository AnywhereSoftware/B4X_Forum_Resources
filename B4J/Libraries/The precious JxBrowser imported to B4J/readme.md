### The precious JxBrowser imported to B4J by jkhazraji
### 06/21/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167488/)

JxBrowser is a powerful Chromium based browser.   
**Features:**  

- it displays modern web pages built with the latest web standards
- it calls Java code from JavaScript and vice versa.
- it renders 4K video full screen with 60FPS via GPU.
- it displays web pages in the lightweight off-screen Swing/JavaFX component.
- It saves the web page as a PNG or JPEG file.

These are some of its features.   
However, JxBrowser is a commercial library that requires a valid license key in order to work. It is very expensive. Its price ranges from $1,979 (Issued to a person) to   
$8,199 (issued to a company). Although, you can 'enjoy' this luxury for one month.  
To use it, from [this site](https://teamdev.com/jxbrowser/) get 30-day free trial and follow the instructions sent to your email. They will send you a license key and you can run the jXBrowser   
on command line by compiling the Github repo supplied with the instructions.  
In documentation it states that:  
[HEADING=2]JxBrowser in JavaFX[/HEADING]  
The easiest way to start working with JxBrowser in a JavaFX Gradle project is to clone the GitHub repository where everything is already set up and ready to go.  
But to integrate it in Java you have to download the zip file from the link in your email.   
The license key is essential to run it. It is a string of capital letters and numbers that you can set in two ways.  
  
Using the jxbrowser.license.key system property:  
  

```B4X
System.setProperty("jxbrowser.license.key", "your_license_key");
```

  
  
  
Another way is to use the licenseKey(String) engine option. Setting the key this way allows you to use different licenses for different Engine instances:  

```B4X
var engine = Engine.newInstance(  
        EngineOptions.newBuilder(HARDWARE_ACCELERATED)  
                .licenseKey("your_license_key")  
                .build()  
);
```

  
In b4j,there is no Gradle. However, JxBrowser was imported with full functionality.  
Demo video :  
[MEDIA=youtube]rv-JO6U9oIk[/MEDIA]  
  
[SPOILER="Code"]

```B4X
#AdditionalJar: jxbrowser-javafx-8.8.0  
#AdditionalJar: jxbrowser-win64-8.8.0  
#AdditionalJar: jxbrowser-8.8.0  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As Button  
    Private primaryStage As JavaObject  
    Private pane As JavaObject  
    Private Engine As JavaObject  
    Private TextField1 As TextField  
    Private lblFoundNum As Label  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    Engine=(Me).As(JavaObject).InitializeStatic("com.teamdev.jxbrowser.engine.Engine")  
    Dim pane As JavaObject= (Me).As(JavaObject).InitializeNewInstance("javafx.scene.layout.BorderPane",Null)  
    pane=(Me).As(JavaObject).RunMethod("MyBrowser",Array(pane))  
    MainForm.RootPane.AddNode(pane,0,0,1330,800)  
    MainForm.Show  
End Sub  
  
Private Sub MainForm_CloseRequest (EventData As Event)  
     (Me).As(JavaObject).RunMethod("closeEngine",Null)  
End Sub  
  
#if java  
//import jxbrowser jar file class here  
  
import com.teamdev.jxbrowser.browser.Browser;  
import com.teamdev.jxbrowser.engine.Engine;  
import com.teamdev.jxbrowser.navigation.event.LoadFinished;  
import com.teamdev.jxbrowser.navigation.event.LoadStarted;  
import com.teamdev.jxbrowser.navigation.Navigation;  
import com.teamdev.jxbrowser.navigation.NavigationEntry;  
import com.teamdev.jxbrowser.view.javafx.BrowserView;  
import javafx.application.Application;  
import javafx.application.Platform;  
import javafx.scene.Scene;  
import javafx.scene.layout.BorderPane;  
import javafx.stage.Stage;  
import javafx.scene.control.TextField;  
import javafx.scene.control.Button;  
import javafx.scene.control.ComboBox;  
import javafx.event.ActionEvent;  
import javafx.event.EventHandler;  
import javafx.collections.*;  
import javafx.scene.control.Label;  
import javafx.geometry.Pos;  
import anywheresoftware.b4a.keywords.Common;  
import anywheresoftware.b4a.BA;  
import anywheresoftware.b4a.BA.Events;  
  
import javafx.scene.layout.HBox;  
  
//public final class JavaFxSample extends Application {  
     public static Engine engine;  
     public static Browser browser;  
     public static int FoundNum=0;  
    public static BorderPane MyBrowser(BorderPane root) {  
        //see: https://jxbrowser-support.teamdev.com/docs/guides/introduction/licensing.html  
        System.setProperty("jxbrowser.license.key", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");  
        engine = Engine.newInstance(HARDWARE_ACCELERATED);  
  
        browser= engine.newBrowser();  
  
        BrowserView view = BrowserView.newInstance(browser);  
        Navigation navigation = browser.navigation();  
   
        Label addressLabel = new Label("Address Bar:");  
        addressLabel.setAlignment(Pos.BOTTOM_LEFT);  
      
        TextField addressBar = new TextField("https://html5test.com");  
        addressBar.setPrefWidth(480);  
          
        // Weekdays  
        String URLs[] ={ };  
   
        ComboBox combobox =  
                 new ComboBox(FXCollections.observableArrayList(URLs));  
        combobox.setPrefWidth(400);         
                          
        combobox.setPromptText("URLS");  
        combobox.setOnAction(event -> {  
           System.out.println(combobox.getValue() + " selected");  
           String selectedURL =combobox.getValue().toString();  
          try{  
           browser.navigation().loadUrl(selectedURL);  
           addressBar.setText(browser.url());  
           }  
           catch(Exception e){  
              System.out.println("Error please relaunch app");  
           }  
        });  
          
        addressBar.setOnAction(event -> {         
                browser.navigation().loadUrl(addressBar.getText());  
                addressBar.setText(browser.url());  
        });  
          
        Button bwButton = new Button("backward");  
        bwButton.setOnAction(event -> {  
          
                browser.navigation().goBack();  
                addressBar.setText(browser.url());  
          
        });  
      
      
        Button fwButton = new Button("forward");  
        fwButton.setOnAction(event -> {  
              
                browser.navigation().goForward();  
                addressBar.setText(browser.url());  
        });  
      
      
          Button refresh =new Button("Refresh");  
          refresh.setOnAction( event -> {  
                     browser.navigation().reload();  
                  
         });  
      
        HBox navigationBar = new HBox(combobox, addressLabel, addressBar, fwButton, bwButton, refresh);  
        
          
        root.setTop(navigationBar);  
        root.setCenter(view);  
        root.setBottom(StatusBar);  
              
        root.setPrefWidth(1600);  
        root.setPrefHeight(600);  
        root.setStyle("-fx-background-color: #F4DDF4");  //#FFC300");  
      
        browser.navigation().loadUrl(addressBar.getText());  
           navigation.on(LoadFinished.class, event -> {  
        System.out.println("Finished loading");  
        addressBar.setText(browser.url());  
        combobox.getItems().clear();  
        for (int index = 0; index < navigation.entryCount(); index++) {  
          NavigationEntry navigationEntry = navigation.entryAtIndex(index);  
          System.out.println("URL: " + navigationEntry.url());  
          combobox.getItems().add(navigationEntry.url());  
          System.out.println("Title: " + navigationEntry.title());  
      }  
      
    });  
            navigation.on(LoadStarted.class, event -> {  
         System.out.println("Started loading");  
      
    });  
        return root;  
    }  
      
   public static void closeEngine(){  
        engine.close();  
   }  
   
#End If
```

[/SPOILER]