### full screen desktop clock with image server by aziznetstudio
### 10/17/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169057/)

# Clock-Desk 🕐  
A modern, feature-rich fullscreen clock application for desktop with real-time weather data, Islamic prayer times, and multilingual support. Built with B4J (Basic4Java) and JavaFX.  
![License](<https://img.shields.io/github/license/aziznetstudio-shamildev/Clock-Desk>)  
![GitHub stars](<https://img.shields.io/github/stars/aziznetstudio-shamildev/Clock-Desk>)  
## 📸 Screenshots  
<div align="center">  
### Digital Clock Mode  
![Digital Clock](screenshots/digital-clock.png)  
### Analog Clock Mode  
![Analog Clock](screenshots/analog-clock.png)  
### Weather & Prayer Times  
![Weather Display](screenshots/weather-display.png)  
### Settings Panel  
![Settings](screenshots/settings-panel.png)  
### Multilingual Support (Arabic)  
![Arabic Language](screenshots/language-arabic.png)  
</div>  
## ✨ Features  
### 🎨 Display Modes  
- \*\*Digital Clock\*\*: Large, customizable digital time display (up to 128px font)  
- \*\*Analog Clock\*\*: Classic analog clock with smooth animations  
- \*\*Responsive Design\*\*: Automatically adapts to any screen resolution  
- \*\*Fullscreen Mode\*\*: Distraction-free clock display  
### 🌤️ Weather Integration  
- Real-time weather data from Open-Meteo API  
- Temperature, humidity, and wind speed  
- Dynamic weather emoji icons  
- Global city search with geocoding  
- Automatic location saving  
### 🕌 Prayer Times  
- Accurate Islamic prayer time calculations  
- Muslim World League calculation method  
- Beautiful card-based display layout  
- Toggle on/off functionality  
- Support for worldwide locations  
### 🌍 Multilingual Support  
- \*\*Languages\*\*: English, French, Arabic  
- RTL (Right-to-Left) support for Arabic  
- Translated UI elements  
- Easy language switching  
### 🎨 Customization  
- \*\*10 Color Themes\*\*: Cyan, White, Yellow, Orange, Magenta, Lime, Pink, Red, Green, Random  
- \*\*Background Images\*\*: Rotating backgrounds with customizable intervals (5s - 1h)  
- \*\*Solid Color Backgrounds\*\*: Alternative to images  
- \*\*Transparent Info Panel\*\*: Modern overlay design  
## 🚀 Getting Started  
### Prerequisites  
- \*\*B4J IDE\*\* version 9.0 or higher - [Download](<https://www.b4x.com/b4j.html>)  
- \*\*Java JDK\*\* 11 or higher  
- Internet connection (for weather and geocoding)  
### Required B4J Libraries  
- B4XPages  
- jCore  
- jFX  
- jHttpUtils2  
- jJSON  
- XUI Views  
### Installation  
1. \*\*Clone the repository\*\*:  
git clone <https://github.com/aziznetstudio-shamildev/Clock-Desk.git>  
cd Clock-Desk  
text  
2. \*\*Open in B4J\*\*:  
- Launch B4J IDE  
- File → Open → Select the `.b4j` file  
3. \*\*Compile and Run\*\*:  
- Press F5 or click "Run"  
## 🎮 Usage  
### Keyboard Shortcuts  
| Key | Action |  
|—–|——–|  
| `ESC` | Exit application |  
| `F11` | Toggle fullscreen |  
### Settings Panel  
Click ⚙️ (top-right) to access:  
- 🔢 \*\*Clock Mode\*\*: Switch between digital/analog  
- 🎨 \*\*Theme\*\*: Change clock colors  
- ⏱️ \*\*Image Timer\*\*: Set background rotation interval  
- 🖼️ \*\*Background\*\*: Toggle background images  
- 🎨 \*\*BG Color\*\*: Change solid background color  
- 🕌 \*\*Prayer\*\*: Toggle prayer times display  
- 🌐 \*\*Language\*\*: Switch language (EN/FR/AR)  
- 📋 \*\*Info\*\*: Toggle info panel visibility  
- 🌍 \*\*City\*\*: Search and change location  
## 🌐 APIs Used  
- [Open-Meteo Weather API](<https://open-meteo.com/>) - Free weather data  
- [Open-Meteo Geocoding API](<https://open-meteo.com/en/docs/geocoding-api>) - City search  
- [Lorem Picsum](<https://picsum.photos/>) - Background images  
## 📐 Prayer Time Calculation  
- \*\*Method\*\*: Muslim World League  
- \*\*Fajr Angle\*\*: 18°  
- \*\*Isha Angle\*\*: 17°  
- \*\*Asr Method\*\*: Shafi/Maliki/Hanbali  
- \*\*Accuracy\*\*: ±1 minute  
Based on astronomical algorithms from [PrayTimes.org](<http://praytimes.org/>)  
## 🤝 Contributing  
Contributions are welcome! Please:  
1. Fork the repository  
2. Create a feature branch (`git checkout -b feature/NewFeature`)  
3. Commit your changes (`git commit -m 'Add NewFeature'`)  
4. Push to the branch (`git push origin feature/NewFeature`)  
5. Open a Pull Request  
## 📋 Roadmap  
- [ ] Add more Islamic calculation methods  
- [ ] Hijri calendar display  
- [ ] Custom font selection  
- [ ] Alarm and timer functionality  
- [ ] Weather forecast (3-7 days)  
- [ ] Customizable prayer alerts  
## 📄 License  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  
## 👨‍💻 Author  
\*\*Aziz Net Studio - Shamil Dev\*\*  
- Location: Saïda, Algeria 🇩🇿  
- GitHub: [@aziznetstudio-shamildev](<https://github.com/aziznetstudio-shamildev>)  
## 🙏 Acknowledgments  
- Built with [B4J](<https://www.b4x.com/b4j.html>) by Anywhere Software  
- Weather API by [Open-Meteo](<https://open-meteo.com/>)  
- Prayer algorithms from [PrayTimes.org](<http://praytimes.org/>)  
- B4X developer community  
## ⭐ Support  
If you find this project useful:  
- ⭐ Star the repository  
- 🐛 Report bugs via [Issues](<https://github.com/aziznetstudio-shamildev/Clock-Desk/issues>)  
- 💡 Suggest features  
- 🔀 Fork and contribute  
—  
\*\*Made with ❤️ in Algeria | Built for the Muslim community worldwide 🌍\*\*  
  
  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 1280  
    #MainFormHeight: 800  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private xui As XUI  
    Private MainForm As Form  
    Private pnlBackground As Pane  
    Private lblClock As Label  
    Private lblDate As Label  
    Private lblWeather As Label  
    Private lblTemperature As Label  
    Private lblWeatherIcon As Label  
    Private lblWeatherDetails As Label  
      
    Private pnlAnalogClock As Pane  
    Private cvsAnalogClock As B4XCanvas  
    Private isAnalogMode As Boolean = False  
      
    ' Transparent info overlay panel  
    Private pnlInfoOverlay As Pane  
    Private showInfoPanel As Boolean = True  
      
    Private timUpdate As Timer  
    Private timImageChange As Timer  
      
    Private jo As JavaObject  
    Private jStage As JavaObject  
      
    Private job As HttpJob  
    Private imgView As ImageView  
    Private showImage As Boolean = True  
    Private currentImageInterval As Int = 0  
    Private imageIntervals As List = Array As Int(0, 5, 10, 30, 60, 300, 900, 3600)  
    Private imageIntervalNames As List = Array As String("OFF", "5s", "10s", "30s", "1m", "5m", "15m", "1h")  
    Private lastImageChangeTime As Long = 0  
      
    Private pnlSettings As Pane  
    Private btnSettings As Button  
    Private btnTheme As Button  
    Private btnImageTimer As Button  
    Private btnBackground As Button  
    Private btnBgColor As Button  
    Private btnClockMode As Button  
    Private btnPrayerToggle As Button  
    Private btnLanguage As Button  
    Private btnInfoPanel As Button  
    Private settingsVisible As Boolean = False  
      
    Private colorSchemes As List  
    Private currentThemeIndex As Int = 0  
    Private currentBgIndex As Int = 0  
    Private currentClockColor As Int  
      
    Private weatherData As Map  
    Private latitude As Double = 34.8333  
    Private longitude As Double = 0.1500  
    Private cityName As String = "Saïda, Algeria"  
    Private weatherEmoji As String = "🌤️"  
      
    Private showPrayerTimes As Boolean = True  
    Private lblPrayerTimes As Label  
      
    Private pnlPrayerCards As Pane  
    Private prayerLabels As Map  
      
    Private currentLanguage As String = "en"  
    Private translations As Map  
      
    Private weatherData As Map  
    Private latitude As Double = 34.8333  
    Private longitude As Double = 0.1500  
    Private cityName As String = "Saïda, Algeria"  
    Private weatherEmoji As String = "🌤️"  
      
    Private settingsFile As String = "clock_settings.txt"  
      
    Private btnChangeCity As Button  
    Private citySearchDialog As JavaObject  
End Sub  
  
Sub Globals  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    Try  
        MainForm = Form1  
      
        colorSchemes.Initialize  
        weatherData.Initialize  
        translations.Initialize  
        prayerLabels.Initialize  
        SetupColorSchemes  
        SetupTranslations  
        currentClockColor = xui.Color_RGB(0, 255, 255)  
        LoadSettings  
        ' Background panel (full screen)  
        pnlBackground.Initialize("")  
        pnlBackground.Style = "-fx-background-color: #000000;"  
        MainForm.RootPane.AddNode(pnlBackground, 0, 0, 1280, 800)  
      
        ' Background image (full screen)  
        imgView.Initialize("")  
        MainForm.RootPane.AddNode(imgView, 0, 0, 1280, 800)  
      
        ' Analog clock panel (centered) - ADD BEFORE INFO OVERLAY  
        pnlAnalogClock.Initialize("")  
        MainForm.RootPane.AddNode(pnlAnalogClock, 440, 200, 400, 400)  
        cvsAnalogClock.Initialize(pnlAnalogClock)  
        pnlAnalogClock.Visible = False  
      
        ' Digital clock (centered horizontally, positioned vertically)  
        lblClock.Initialize("")  
        lblClock.Text = "00:00:00"  
        lblClock.TextColor = fx.Colors.RGB(0, 255, 255)  
        lblClock.TextSize = 96  
        lblClock.Style = "-fx-font-weight: bold; -fx-effect: dropshadow(three-pass-box, black, 15, 0, 0, 0);"  
        lblClock.Alignment = "CENTER"  
        MainForm.RootPane.AddNode(lblClock, 0, 280, 1280, 120)  
      
        ' IMPORTANT: Add this AFTER analog clock so it appears on top  
        pnlInfoOverlay.Initialize("")  
        pnlInfoOverlay.Style = "-fx-background-color: rgba(0, 0, 0, 0.75); -fx-background-radius: 20px; -fx-border-color: rgba(0, 200, 255, 0.5); -fx-border-width: 2px; -fx-border-radius: 20px; -fx-effect: dropshadow(three-pass-box, black, 20, 0, 0, 0);"  
        MainForm.RootPane.AddNode(pnlInfoOverlay, 50, 480, 1180, 280)  
      
        ' Date label (inside overlay, centered)  
        lblDate.Initialize("")  
        lblDate.Text = ""  
        lblDate.TextColor = fx.Colors.RGB(200, 200, 200)  
        lblDate.TextSize = 20  
        lblDate.Style = "-fx-font-weight: normal;"  
        lblDate.Alignment = "CENTER"  
        pnlInfoOverlay.AddNode(lblDate, 10, 10, 1160, 30)  
      
        ' Weather container width calculation: icon(120) + temp(150) + details(400) = 670px  
        ' Center position: (1160 - 670) / 2 = 245px from left  
          
        ' Large weather icon  
        lblWeatherIcon.Initialize("")  
        lblWeatherIcon.Text = "🌤️"  
        lblWeatherIcon.TextSize = 72  
        lblWeatherIcon.Alignment = "CENTER"  
        pnlInfoOverlay.AddNode(lblWeatherIcon, 245, 50, 120, 100)  
      
        ' Large temperature  
        lblTemperature.Initialize("")  
        lblTemperature.Text = "–°"  
        lblTemperature.TextColor = fx.Colors.RGB(255, 200, 0)  
        lblTemperature.TextSize = 64  
        lblTemperature.Style = "-fx-font-weight: bold;"  
        lblTemperature.Alignment = "CENTER"  
        pnlInfoOverlay.AddNode(lblTemperature, 365, 50, 150, 100)  
      
        ' Weather details (humidity, wind, city)  
        lblWeatherDetails.Initialize("")  
        lblWeatherDetails.Text = GetTranslation("loading_weather")  
        lblWeatherDetails.TextColor = fx.Colors.RGB(180, 180, 180)  
        lblWeatherDetails.TextSize = 16  
        lblWeatherDetails.Style = "-fx-font-weight: normal;"  
        lblWeatherDetails.Alignment = "CENTER_LEFT"  
        pnlInfoOverlay.AddNode(lblWeatherDetails, 525, 60, 400, 80)  
      
  
        pnlPrayerCards.Initialize("")  
        pnlPrayerCards.Style = "-fx-background-color: transparent;"  
        pnlInfoOverlay.AddNode(pnlPrayerCards, 30, 170, 1120, 80)  
      
        CreatePrayerTimeCards  
      
        ' Settings button (top-right) - ADD LAST SO IT'S ALWAYS ON TOP  
        btnSettings.Initialize("btnSettings")  
        btnSettings.Text = "⚙️"  
        btnSettings.Style = "-fx-font-size: 28px; -fx-background-color: rgba(0,0,0,0.7); -fx-text-fill: cyan; -fx-background-radius: 25px;"  
        MainForm.RootPane.AddNode(btnSettings, 1200, 20, 60, 60)  
      
        ' Settings panel (centered horizontally at top) - ADD LAST  
        pnlSettings.Initialize("")  
        pnlSettings.Style = "-fx-background-color: rgba(0,0,0,0.9); -fx-border-color: cyan; -fx-border-width: 2px; -fx-border-radius: 10px;"  
        MainForm.RootPane.AddNode(pnlSettings, 40, 20, 1200, 80)  ' Increased width to 1200  
        pnlSettings.Visible = False  
      
        ' … (rest of settings buttons - keep as is)  
        btnClockMode.Initialize("btnClockMode")  
        btnClockMode.Text = "🔢 Digital"  
        btnClockMode.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnClockMode, 10, 20, 120, 40)  
      
        btnTheme.Initialize("btnTheme")  
        btnTheme.Text = "🎨 Cyan"  
        btnTheme.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnTheme, 140, 20, 120, 40)  
      
        btnImageTimer.Initialize("btnImageTimer")  
        btnImageTimer.Text = "⏱️ OFF"  
        btnImageTimer.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnImageTimer, 270, 20, 120, 40)  
      
        btnBackground.Initialize("btnBackground")  
        btnBackground.Text = "🖼️ Image ON"  
        btnBackground.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnBackground, 400, 20, 140, 40)  
      
        btnBgColor.Initialize("btnBgColor")  
        btnBgColor.Text = "🎨 BG Color"  
        btnBgColor.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnBgColor, 550, 20, 140, 40)  
        btnBgColor.Enabled = False  
      
        btnPrayerToggle.Initialize("btnPrayerToggle")  
        btnPrayerToggle.Text = "🕌 Prayer ON"  
        btnPrayerToggle.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnPrayerToggle, 700, 20, 140, 40)  
      
        btnLanguage.Initialize("btnLanguage")  
        btnLanguage.Text = "🌐 EN"  
        btnLanguage.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnLanguage, 850, 20, 100, 40)  
      
        btnInfoPanel.Initialize("btnInfoPanel")  
        btnInfoPanel.Text = "📋 Info"  
        btnInfoPanel.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnInfoPanel, 960, 20, 100, 40)  
          
        ' NEW: Change City button  
        btnChangeCity.Initialize("btnChangeCity")  
        btnChangeCity.Text = "🌍 City"  
        btnChangeCity.Style = "-fx-font-size: 14px; -fx-background-color: #333; -fx-text-fill: white; -fx-background-radius: 5px;"  
        pnlSettings.AddNode(btnChangeCity, 1070, 20, 100, 40)  
      
        ' Fullscreen setup  
        MainForm.SetFormStyle("UNDECORATED")  
        jo = MainForm  
        jStage = jo.GetFieldJO("stage")  
        jStage.RunMethod("setFullScreen", Array(True))  
        jStage.RunMethod("setAlwaysOnTop", Array(True))  
        MainForm.Resizable = False  
        MainForm.Show  
      
        ' Initial centering  
        CenterAllElements  
      
        ' Load initial content  
        LoadBackgroundImage  
        lastImageChangeTime = DateTime.Now / 1000  
      
        timUpdate.Initialize("timUpdate", 1000)  
        timUpdate.Enabled = True  
      
        timImageChange.Initialize("timImageChange", 1000)  
        timImageChange.Enabled = False  
      
        FetchWeather  
        FetchPrayerTimes  
        UpdateClock  
      
        Log("Modern clock UI started with proper z-ordering")  
    Catch  
        Log("AppStart error: " & LastException.Message)  
    End Try  
End Sub  
  
  
  
Sub CenterAllElements  
    Try  
        Dim w As Double = MainForm.Width  
        Dim h As Double = MainForm.Height  
          
        Log("Screen resolution: " & w & "x" & h)  
          
        ' Clear previous clock state before repositioning  
        ClearAllClocks  
          
        ' Background and image (always full screen)  
        pnlBackground.prefWidth = w  
        pnlBackground.prefHeight = h  
        pnlBackground.Left = 0  
        pnlBackground.Top = 0  
          
        If imgView <> Null Then  
            imgView.prefWidth = w  
            imgView.prefHeight = h  
            imgView.Left = 0  
            imgView.Top = 0  
        End If  
          
        Dim clockWidth As Double = w * 0.8  
        If clockWidth > 1000 Then clockWidth = 1000  
        Dim clockHeight As Double = 120  
          
        ' Make clock BIGGER when info panel is hidden  
        If Not(showInfoPanel) Then  
            lblClock.TextSize = 128 ' Larger font  
            clockHeight = 150  
            lblClock.Left = (w - clockWidth) / 2  
            lblClock.Top = (h - clockHeight) / 2 ' Perfect center  
        Else  
            lblClock.TextSize = 96 ' Normal font  
            clockHeight = 120  
            lblClock.Left = (w - clockWidth) / 2  
            lblClock.Top = (h * 0.25) ' 25% from top  
        End If  
          
        lblClock.prefWidth = clockWidth  
        lblClock.prefHeight = clockHeight  
          
        Dim analogSize As Double  
          
        ' Make analog clock BIGGER when info panel is hidden  
        If Not(showInfoPanel) Then  
            analogSize = Min(w, h) * 0.5 ' 50% of screen (LARGE)  
            If analogSize > 700 Then analogSize = 700 ' Max 700px  
            If analogSize < 400 Then analogSize = 400 ' Min 400px  
              
            pnlAnalogClock.Left = (w - analogSize) / 2  
            pnlAnalogClock.Top = (h - analogSize) / 2 ' Perfect center  
        Else  
            analogSize = Min(w, h) * 0.25 ' 25% of screen (NORMAL)  
            If analogSize < 250 Then analogSize = 250 ' Min 250px  
            If analogSize > 450 Then analogSize = 450 ' Max 450px  
              
            pnlAnalogClock.Left = (w - analogSize) / 2  
            pnlAnalogClock.Top = (h * 0.15) ' 15% from top  
        End If  
          
        pnlAnalogClock.prefWidth = analogSize  
        pnlAnalogClock.prefHeight = analogSize  
          
        ' Reinitialize canvas with new size  
        Try  
            cvsAnalogClock.Release  
        Catch  
            ' Canvas not yet initialized, ignore  
        End Try  
        cvsAnalogClock.Initialize(pnlAnalogClock)  
          
  
        If showInfoPanel Then  
            Dim overlayWidth As Double = Min(1180, w - 100)  
            Dim overlayHeight As Double = 280  
              
            pnlInfoOverlay.prefWidth = overlayWidth  
            pnlInfoOverlay.prefHeight = overlayHeight  
            pnlInfoOverlay.Left = (w - overlayWidth) / 2  
            pnlInfoOverlay.Top = (h * 0.6)  
              
            ' Make sure it doesn't go off screen bottom  
            If pnlInfoOverlay.Top + overlayHeight > h - 20 Then  
                pnlInfoOverlay.Top = h - overlayHeight - 20  
            End If  
              
  
            Dim weatherTotalWidth As Double = 670  
            Dim weatherStartX As Double = (overlayWidth - weatherTotalWidth) / 2  
              
            lblWeatherIcon.Left = weatherStartX  
            lblTemperature.Left = weatherStartX + 120  
            lblWeatherDetails.Left = weatherStartX + 270  
              
  
            Dim prayerTotalWidth As Double = 1095  
            Dim prayerCardsWidth As Double = Min(prayerTotalWidth, overlayWidth - 60)  
              
            pnlPrayerCards.prefWidth = prayerCardsWidth  
            pnlPrayerCards.Left = (overlayWidth - prayerCardsWidth) / 2  
              
            ' Recalculate card spacing if needed  
            If prayerCardsWidth < 1095 Then  
                RecreateScaledPrayerCards(prayerCardsWidth)  
            End If  
        End If  
          
  
        btnSettings.Left = w - 80  
        btnSettings.Top = 20  
          
  
        Dim settingsWidth As Double = Min(1200, w - 130)  ' Changed from 1150 to 1200  
        pnlSettings.prefWidth = settingsWidth  
        pnlSettings.Left = (w - settingsWidth) / 2  
          
          
          
        Log("Centered - InfoPanel: " & showInfoPanel & ", Analog size: " & analogSize & "px")  
    Catch  
        Log("CenterAllElements error: " & LastException.Message)  
    End Try  
End Sub  
  
  
  
  
  
' Create prayer time cards with fixed size  
Sub CreatePrayerTimeCards  
    Try  
        Dim prayerNames As List = Array As String("fajr", "sunrise", "dhuhr", "asr", "maghrib", "isha")  
        Dim prayerIcons As List = Array As String("🌅", "☀️", "🌞", "🌤️", "🌆", "🌙")  
        Dim cardWidth As Int = 170  
        Dim spacing As Int = 15  
          
        For i = 0 To 5  
            Dim pnlCard As Pane  
            pnlCard.Initialize("")  
            pnlCard.Style = "-fx-background-color: rgba(40, 40, 60, 0.8); -fx-background-radius: 10px; -fx-border-color: rgba(0, 200, 255, 0.4); -fx-border-width: 1px; -fx-border-radius: 10px;"  
            pnlPrayerCards.AddNode(pnlCard, i * (cardWidth + spacing), 0, cardWidth, 70)  
              
            ' Prayer icon  
            Dim lblIcon As Label  
            lblIcon.Initialize("")  
            lblIcon.Text = prayerIcons.Get(i)  
            lblIcon.TextSize = 24  
            lblIcon.Alignment = "CENTER"  
            pnlCard.AddNode(lblIcon, 5, 5, 40, 30)  
              
            ' Prayer name  
            Dim lblName As Label  
            lblName.Initialize("")  
            lblName.Text = GetTranslation(prayerNames.Get(i))  
            lblName.TextColor = fx.Colors.RGB(200, 200, 200)  
            lblName.TextSize = 12  
            lblName.Style = "-fx-font-weight: normal;"  
            lblName.Alignment = "CENTER_LEFT"  
            pnlCard.AddNode(lblName, 50, 5, 110, 25)  
              
            ' Prayer time  
            Dim lblTime As Label  
            lblTime.Initialize("")  
            lblTime.Text = "–:–"  
            lblTime.TextColor = fx.Colors.RGB(150, 255, 150)  
            lblTime.TextSize = 18  
            lblTime.Style = "-fx-font-weight: bold;"  
            lblTime.Alignment = "CENTER"  
            pnlCard.AddNode(lblTime, 5, 40, 160, 25)  
              
            ' Store time label reference  
            prayerLabels.Put(prayerNames.Get(i), lblTime)  
        Next  
    Catch  
        Log("CreatePrayerTimeCards error: " & LastException.Message)  
    End Try  
End Sub  
  
' Recreate prayer cards with scaled size for smaller screens  
Sub RecreateScaledPrayerCards(availableWidth As Double)  
    Try  
        ' Remove existing cards  
        pnlPrayerCards.RemoveAllNodes  
          
        Dim prayerNames As List = Array As String("fajr", "sunrise", "dhuhr", "asr", "maghrib", "isha")  
        Dim prayerIcons As List = Array As String("🌅", "☀️", "🌞", "🌤️", "🌆", "🌙")  
          
        ' Calculate scaled card width  
        Dim spacing As Int = 10  
        Dim cardWidth As Int = Floor((availableWidth - (5 * spacing)) / 6)  
          
        For i = 0 To 5  
            Dim pnlCard As Pane  
            pnlCard.Initialize("")  
            pnlCard.Style = "-fx-background-color: rgba(40, 40, 60, 0.8); -fx-background-radius: 10px; -fx-border-color: rgba(0, 200, 255, 0.4); -fx-border-width: 1px; -fx-border-radius: 10px;"  
            pnlPrayerCards.AddNode(pnlCard, i * (cardWidth + spacing), 0, cardWidth, 70)  
              
            ' Prayer icon  
            Dim lblIcon As Label  
            lblIcon.Initialize("")  
            lblIcon.Text = prayerIcons.Get(i)  
            lblIcon.TextSize = 20  
            lblIcon.Alignment = "CENTER"  
            pnlCard.AddNode(lblIcon, 5, 5, cardWidth - 10, 25)  
              
            ' Prayer name  
            Dim lblName As Label  
            lblName.Initialize("")  
            lblName.Text = GetTranslation(prayerNames.Get(i))  
            lblName.TextColor = fx.Colors.RGB(200, 200, 200)  
            lblName.TextSize = 10  
            lblName.Style = "-fx-font-weight: normal;"  
            lblName.Alignment = "CENTER"  
            pnlCard.AddNode(lblName, 5, 30, cardWidth - 10, 15)  
              
            ' Prayer time  
            Dim lblTime As Label  
            lblTime.Initialize("")  
            lblTime.Text = "–:–"  
            lblTime.TextColor = fx.Colors.RGB(150, 255, 150)  
            lblTime.TextSize = 14  
            lblTime.Style = "-fx-font-weight: bold;"  
            lblTime.Alignment = "CENTER"  
            pnlCard.AddNode(lblTime, 5, 45, cardWidth - 10, 20)  
              
            ' Store time label reference  
            prayerLabels.Put(prayerNames.Get(i), lblTime)  
        Next  
          
        Log("Prayer cards rescaled for width: " & availableWidth)  
    Catch  
        Log("RecreateScaledPrayerCards error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub SetupTranslations  
    Try  
        ' English translations  
        Dim enMap As Map  
        enMap.Initialize  
        enMap.Put("loading_weather", "Loading weather…")  
        enMap.Put("loading_prayer", "Loading prayer times…")  
        enMap.Put("sunday", "Sunday")  
        enMap.Put("monday", "Monday")  
        enMap.Put("tuesday", "Tuesday")  
        enMap.Put("wednesday", "Wednesday")  
        enMap.Put("thursday", "Thursday")  
        enMap.Put("friday", "Friday")  
        enMap.Put("saturday", "Saturday")  
        enMap.Put("january", "January")  
        enMap.Put("february", "February")  
        enMap.Put("march", "March")  
        enMap.Put("april", "April")  
        enMap.Put("may", "May")  
        enMap.Put("june", "June")  
        enMap.Put("july", "July")  
        enMap.Put("august", "August")  
        enMap.Put("september", "September")  
        enMap.Put("october", "October")  
        enMap.Put("november", "November")  
        enMap.Put("december", "December")  
        enMap.Put("fajr", "Fajr")  
        enMap.Put("sunrise", "Sunrise")  
        enMap.Put("dhuhr", "Dhuhr")  
        enMap.Put("asr", "Asr")  
        enMap.Put("maghrib", "Maghrib")  
        enMap.Put("isha", "Isha")  
        translations.Put("en", enMap)  
          
        ' French translations  
        Dim frMap As Map  
        frMap.Initialize  
        frMap.Put("loading_weather", "Chargement météo…")  
        frMap.Put("loading_prayer", "Chargement horaires…")  
        frMap.Put("sunday", "Dimanche")  
        frMap.Put("monday", "Lundi")  
        frMap.Put("tuesday", "Mardi")  
        frMap.Put("wednesday", "Mercredi")  
        frMap.Put("thursday", "Jeudi")  
        frMap.Put("friday", "Vendredi")  
        frMap.Put("saturday", "Samedi")  
        frMap.Put("january", "Janvier")  
        frMap.Put("february", "Février")  
        frMap.Put("march", "Mars")  
        frMap.Put("april", "Avril")  
        frMap.Put("may", "Mai")  
        frMap.Put("june", "Juin")  
        frMap.Put("july", "Juillet")  
        frMap.Put("august", "Août")  
        frMap.Put("september", "Septembre")  
        frMap.Put("october", "Octobre")  
        frMap.Put("november", "Novembre")  
        frMap.Put("december", "Décembre")  
        frMap.Put("fajr", "Fajr")  
        frMap.Put("sunrise", "Lever")  
        frMap.Put("dhuhr", "Dhuhr")  
        frMap.Put("asr", "Asr")  
        frMap.Put("maghrib", "Maghrib")  
        frMap.Put("isha", "Isha")  
        translations.Put("fr", frMap)  
          
        ' Arabic translations  
        Dim arMap As Map  
        arMap.Initialize  
        arMap.Put("loading_weather", "تحميل الطقس…")  
        arMap.Put("loading_prayer", "تحميل الصلاة…")  
        arMap.Put("sunday", "الأحد")  
        arMap.Put("monday", "الاثنين")  
        arMap.Put("tuesday", "الثلاثاء")  
        arMap.Put("wednesday", "الأربعاء")  
        arMap.Put("thursday", "الخميس")  
        arMap.Put("friday", "الجمعة")  
        arMap.Put("saturday", "السبت")  
        arMap.Put("january", "يناير")  
        arMap.Put("february", "فبراير")  
        arMap.Put("march", "مارس")  
        arMap.Put("april", "أبريل")  
        arMap.Put("may", "مايو")  
        arMap.Put("june", "يونيو")  
        arMap.Put("july", "يوليو")  
        arMap.Put("august", "أغسطس")  
        arMap.Put("september", "سبتمبر")  
        arMap.Put("october", "أكتوبر")  
        arMap.Put("november", "نوفمبر")  
        arMap.Put("december", "ديسمبر")  
        arMap.Put("fajr", "الفجر")  
        arMap.Put("sunrise", "الشروق")  
        arMap.Put("dhuhr", "الظهر")  
        arMap.Put("asr", "العصر")  
        arMap.Put("maghrib", "المغرب")  
        arMap.Put("isha", "العشاء")  
        translations.Put("ar", arMap)  
    Catch  
        Log("Translation setup error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub GetTranslation(key As String) As String  
    Try  
        Dim langMap As Map = translations.Get(currentLanguage)  
        Return langMap.GetDefault(key, key)  
    Catch  
        Return key  
    End Try  
End Sub  
  
Sub FetchPrayerTimes  
    Try  
        Dim now As Long = DateTime.Now  
        Dim currentMonth As Int = DateTime.GetMonth(now)  
        Dim currentDay As Int = DateTime.GetDayOfMonth(now)  
          
        Dim prayerTimes() As Object = GetReligious_times(currentMonth, currentDay, longitude, latitude, False, False)  
          
        If prayerTimes = Null Then  
            Log("Prayer times calculation failed")  
            Return  
        End If  
          
        ' Update individual prayer time cards  
        Dim prayerNames As List = Array As String("fajr", "sunrise", "dhuhr", "asr", "maghrib", "isha")  
          
        For i = 0 To 5  
            Dim lblTime As Label = prayerLabels.Get(prayerNames.Get(i))  
            lblTime.Text = prayerTimes(i)  
        Next  
          
        Log("Prayer times updated successfully")  
    Catch  
        Log("Prayer times error: " & LastException.Message)  
    End Try  
End Sub  
  
  
Sub GetReligious_times(Month As Int, Day As Int, longitude1 As Double, latitude1 As Double, Second_Show As Boolean, Official_time As Boolean) As Object()  
    Try  
        Dim currentYear As Int = DateTime.GetYear(DateTime.Now)  
        Dim jd As Double = GetJulianDate(currentYear, Month, Day)  
        Dim timezone As Double = 1.0  
        Dim fajrAngle As Double = 18.0  
        Dim ishaAngle As Double = 17.0  
        Dim asrJuristic As Int = 1  
          
        Dim sunDecl As Double = GetSunDeclination(jd)  
        Dim eqt As Double = GetEquationOfTime(jd)  
        Dim dhuhr As Double = 12.0 + timezone - longitude1 / 15.0 - eqt  
          
        Dim times(6) As String  
        times(0) = FormatTimeFromDecimal(GetTimeForAngle(jd, latitude1, longitude1, timezone, fajrAngle, True), Second_Show)  
        times(1) = FormatTimeFromDecimal(GetTimeForAngle(jd, latitude1, longitude1, timezone, 0.833, True), Second_Show)  
        times(2) = FormatTimeFromDecimal(dhuhr, Second_Show)  
        times(3) = FormatTimeFromDecimal(GetAsrTime(jd, latitude1, longitude1, timezone, asrJuristic), Second_Show)  
        times(4) = FormatTimeFromDecimal(GetTimeForAngle(jd, latitude1, longitude1, timezone, 0.833, False), Second_Show)  
        times(5) = FormatTimeFromDecimal(GetTimeForAngle(jd, latitude1, longitude1, timezone, ishaAngle, False), Second_Show)  
          
        Return times  
    Catch  
        Log("GetReligious_times error: " & LastException.Message)  
        Return Null  
    End Try  
End Sub  
  
Sub GetJulianDate(year As Int, month As Int, day As Int) As Double  
    If month <= 2 Then  
        year = year - 1  
        month = month + 12  
    End If  
    Dim A As Int = Floor(year / 100.0)  
    Dim B As Int = 2 - A + Floor(A / 4.0)  
    Dim JD As Double = Floor(365.25 * (year + 4716)) + Floor(30.6001 * (month + 1)) + day + B - 1524.5  
    Return JD  
End Sub  
  
Sub GetEquationOfTime(jd As Double) As Double  
    Dim d As Double = jd - 2451545.0  
    Dim g As Double = FixAngle(357.529 + 0.98560028 * d)  
    Dim q As Double = FixAngle(280.459 + 0.98564736 * d)  
    Dim L As Double = FixAngle(q + 1.915 * dsin(g) + 0.020 * dsin(2 * g))  
    Dim e As Double = 23.439 - 0.00000036 * d  
    Dim RA As Double = datan2(dcos(e) * dsin(L), dcos(L)) / 15.0  
    RA = FixHour(RA)  
    Dim EqT As Double = q / 15.0 - RA  
    Return FixHour(EqT)  
End Sub  
  
Sub GetSunDeclination(jd As Double) As Double  
    Dim d As Double = jd - 2451545.0  
    Dim g As Double = FixAngle(357.529 + 0.98560028 * d)  
    Dim q As Double = FixAngle(280.459 + 0.98564736 * d)  
    Dim L As Double = FixAngle(q + 1.915 * dsin(g) + 0.020 * dsin(2 * g))  
    Dim e As Double = 23.439 - 0.00000036 * d  
    Dim D As Double = dasin(dsin(e) * dsin(L))  
    Return D  
End Sub  
  
Sub GetTimeForAngle(jd As Double, lat As Double, lng As Double, timezone As Double, angle As Double, isBefore As Boolean) As Double  
    Dim decl As Double = GetSunDeclination(jd)  
    Dim noon As Double = 12.0 + timezone - lng / 15.0 - GetEquationOfTime(jd)  
    Dim cosH As Double = (dcos(90.0 + angle) - dsin(decl) * dsin(lat)) / (dcos(decl) * dcos(lat))  
    If cosH > 1.0 Then cosH = 1.0  
    If cosH < -1.0 Then cosH = -1.0  
    Dim hourAngle As Double = dacos(cosH) / 15.0  
    Dim time As Double  
    If isBefore Then  
        time = noon - hourAngle  
    Else  
        time = noon + hourAngle  
    End If  
    Return time  
End Sub  
  
Sub GetAsrTime(jd As Double, lat As Double, lng As Double, timezone As Double, asrFactor As Int) As Double  
    Dim decl As Double = GetSunDeclination(jd)  
    Dim noon As Double = 12.0 + timezone - lng / 15.0 - GetEquationOfTime(jd)  
    Dim tanAlt As Double = 1.0 / (asrFactor + dtan(Abs(lat - decl)))  
    Dim altitude As Double = datan(tanAlt)  
    Dim angle As Double = 90.0 - altitude  
    Dim cosH As Double = (dcos(angle) - dsin(decl) * dsin(lat)) / (dcos(decl) * dcos(lat))  
    If cosH > 1.0 Then cosH = 1.0  
    If cosH < -1.0 Then cosH = -1.0  
    Dim hourAngle As Double = dacos(cosH) / 15.0  
    Dim time As Double = noon + hourAngle  
    Return time  
End Sub  
  
Sub datan(x As Double) As Double  
    Return ATan(x) * 180.0 / cPI  
End Sub  
  
Sub FormatTimeFromDecimal(time As Double, showSeconds As Boolean) As String  
    time = FixHour(time + 0.5 / 60.0)  
    Dim hours As Int = Floor(time)  
    Dim minutes As Double = (time - hours) * 60.0  
    Dim mins As Int = Floor(minutes)  
    Dim secs As Int = Floor((minutes - mins) * 60.0)  
    Dim h As String = NumberFormat(hours, 2, 0)  
    Dim m As String = NumberFormat(mins, 2, 0)  
    If showSeconds Then  
        Dim s As String = NumberFormat(secs, 2, 0)  
        Return h & ":" & m & ":" & s  
    Else  
        Return h & ":" & m  
    End If  
End Sub  
  
Private Sub fmod(s1 As Double, s2 As Double) As Double  
    Return s1 Mod s2  
End Sub  
  
Sub SetupColorSchemes  
    colorSchemes.Add(CreateMap("name": "Cyan", "paint": fx.Colors.RGB(0, 255, 255), "int": xui.Color_RGB(0, 255, 255)))  
    colorSchemes.Add(CreateMap("name": "White", "paint": fx.Colors.RGB(255, 255, 255), "int": xui.Color_RGB(255, 255, 255)))  
    colorSchemes.Add(CreateMap("name": "Yellow", "paint": fx.Colors.RGB(255, 255, 0), "int": xui.Color_RGB(255, 255, 0)))  
    colorSchemes.Add(CreateMap("name": "Orange", "paint": fx.Colors.RGB(255, 165, 0), "int": xui.Color_RGB(255, 165, 0)))  
    colorSchemes.Add(CreateMap("name": "Magenta", "paint": fx.Colors.RGB(255, 0, 255), "int": xui.Color_RGB(255, 0, 255)))  
    colorSchemes.Add(CreateMap("name": "Lime", "paint": fx.Colors.RGB(0, 255, 0), "int": xui.Color_RGB(0, 255, 0)))  
    colorSchemes.Add(CreateMap("name": "Pink", "paint": fx.Colors.RGB(255, 192, 203), "int": xui.Color_RGB(255, 192, 203)))  
    colorSchemes.Add(CreateMap("name": "Red", "paint": fx.Colors.RGB(255, 0, 0), "int": xui.Color_RGB(255, 0, 0)))  
    colorSchemes.Add(CreateMap("name": "Green", "paint": fx.Colors.RGB(0, 128, 0), "int": xui.Color_RGB(0, 128, 0)))  
    colorSchemes.Add(CreateMap("name": "Random", "paint": Null, "int": 0))  
End Sub  
  
Sub GetWeatherEmoji(code As Int) As String  
    If code = 0 Then Return "☀️"  
    If code <= 3 Then Return "🌤️"  
    If code <= 48 Then Return "🌫️"  
    If code <= 67 Then Return "🌧️"  
    If code <= 77 Then Return "🌨️"  
    If code <= 99 Then Return "⛈️"  
    Return "🌤️"  
End Sub  
  
Sub UpdateClock  
    Try  
        Dim now As Long = DateTime.Now  
        Dim timeStr As String = DateTime.Time(now)  
        Dim hour As Int = DateTime.GetHour(now)  
        Dim minute As Int = DateTime.GetMinute(now)  
          
        If hour = 0 And minute = 0 Then  
            FetchPrayerTimes  
        End If  
          
        Dim dayNames As List = Array As String("sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday")  
        Dim monthNames As List = Array As String("january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december")  
          
        Dim dayOfWeek As Int = DateTime.GetDayOfWeek(now)  
        Dim dayOfMonth As Int = DateTime.GetDayOfMonth(now)  
        Dim month As Int = DateTime.GetMonth(now)  
        Dim year As Int = DateTime.GetYear(now)  
          
        Dim dateStr As String  
        If currentLanguage = "ar" Then  
            dateStr = GetTranslation(dayNames.Get(dayOfWeek)) & "، " & dayOfMonth & " " & GetTranslation(monthNames.Get(month - 1)) & " " & year  
            lblDate.Style = "-fx-font-weight: normal; -fx-node-orientation: right-to-left;"  
        Else  
            dateStr = GetTranslation(dayNames.Get(dayOfWeek)) & ", " & GetTranslation(monthNames.Get(month - 1)) & " " & dayOfMonth & ", " & year  
            lblDate.Style = "-fx-font-weight: normal; -fx-node-orientation: left-to-right;"  
        End If  
          
        If isAnalogMode Then  
            DrawAnalogClock  
        Else  
            lblClock.Text = timeStr  
        End If  
          
        lblDate.Text = dateStr  
          
        ' Update weather UI  
        If weatherData.Size > 0 Then  
            Dim temp As String = weatherData.GetDefault("temperature", "N/A")  
            Dim hum As String = weatherData.GetDefault("humidity", "N/A")  
            Dim wind As String = weatherData.GetDefault("wind_speed", "N/A")  
              
            lblTemperature.Text = temp & "°C"  
            lblWeatherIcon.Text = weatherEmoji  
            lblWeatherDetails.Text = cityName & CRLF & "💧 Humidity: " & hum & "%" & CRLF & "💨 Wind: " & wind & " km/h"  
        End If  
    Catch  
        Log("Clock error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub DrawAnalogClock  
    Try  
        Dim now As Long = DateTime.Now  
        Dim hour As Int = DateTime.GetHour(now)  
        Dim minute As Int = DateTime.GetMinute(now)  
        Dim second As Int = DateTime.GetSecond(now)  
          
        ' Get current analog clock size  
        Dim size As Double = pnlAnalogClock.prefWidth  
        Dim center As Double = size / 2  
        Dim radius As Double = center - 10  
          
        ' CRITICAL: Clear entire canvas first  
        Dim rect As B4XRect  
        rect.Initialize(0, 0, size, size)  
        cvsAnalogClock.ClearRect(rect)  
          
        ' Draw clock face  
        cvsAnalogClock.DrawCircle(center, center, radius, xui.Color_ARGB(180, 0, 0, 0), True, 0)  
        cvsAnalogClock.DrawCircle(center, center, radius, currentClockColor, False, 3)  
          
        ' Draw hour numbers (scaled)  
        Dim textFont As B4XFont = xui.CreateDefaultFont(size * 0.045) ' Scale font with clock size  
        For i = 1 To 12  
            Dim angle As Double = cPI / 6 * (i - 3)  
            Dim x As Double = center + Cos(angle) * (radius * 0.75)  
            Dim y As Double = center + Sin(angle) * (radius * 0.75)  
            cvsAnalogClock.DrawText(i, x, y, textFont, currentClockColor, "CENTER")  
        Next  
          
        ' Center dot  
        cvsAnalogClock.DrawCircle(center, center, size * 0.02, currentClockColor, True, 0)  
          
        ' Calculate hand angles  
        hour = hour Mod 12  
        Dim hourAngle As Double = (cPI / 6) * hour + (cPI / 360) * minute - cPI / 2  
        Dim minuteAngle As Double = (cPI / 30) * minute + (cPI / 1800) * second - cPI / 2  
        Dim secondAngle As Double = (cPI / 30) * second - cPI / 2  
          
        ' Draw hands (scaled)  
        Dim hourX As Double = center + Cos(hourAngle) * (radius * 0.4)  
        Dim hourY As Double = center + Sin(hourAngle) * (radius * 0.4)  
        cvsAnalogClock.DrawLine(center, center, hourX, hourY, currentClockColor, Max(2, size * 0.015))  
          
        Dim minuteX As Double = center + Cos(minuteAngle) * (radius * 0.65)  
        Dim minuteY As Double = center + Sin(minuteAngle) * (radius * 0.65)  
        cvsAnalogClock.DrawLine(center, center, minuteX, minuteY, currentClockColor, Max(2, size * 0.01))  
          
        Dim secondX As Double = center + Cos(secondAngle) * (radius * 0.75)  
        Dim secondY As Double = center + Sin(secondAngle) * (radius * 0.75)  
        cvsAnalogClock.DrawLine(center, center, secondX, secondY, xui.Color_RGB(255, 0, 0), Max(1, size * 0.005))  
          
        ' CRITICAL: Call Invalidate to commit the drawing  
        cvsAnalogClock.Invalidate  
    Catch  
        Log("Analog draw error: " & LastException.Message)  
    End Try  
End Sub  
  
  
  
Sub timUpdate_Tick  
    UpdateClock  
End Sub  
  
Sub timImageChange_Tick  
    Try  
        If currentImageInterval > 0 And showImage Then  
            Dim elapsed As Long = (DateTime.Now / 1000) - lastImageChangeTime  
            Dim interval As Int = imageIntervals.Get(currentImageInterval)  
            If elapsed >= interval Then  
                LoadBackgroundImage  
                lastImageChangeTime = DateTime.Now / 1000  
            End If  
        End If  
    Catch  
        Log("Timer error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub btnSettings_Click  
    settingsVisible = Not(settingsVisible)  
    pnlSettings.Visible = settingsVisible  
End Sub  
  
Sub btnClockMode_Click  
    Try  
        isAnalogMode = Not(isAnalogMode)  
          
        If isAnalogMode Then  
            btnClockMode.Text = "🕐 Analog"  
              
            ' Clear digital clock display  
            lblClock.Visible = False  
            lblClock.Text = ""  
              
            ' Show analog clock  
            pnlAnalogClock.Visible = True  
              
            ' Recenter and resize based on current state  
            CenterAllElements  
              
            ' Draw analog clock immediately  
            DrawAnalogClock  
              
        Else  
            btnClockMode.Text = "🔢 Digital"  
              
            ' Clear analog clock completely  
            Dim rect As B4XRect  
            rect.Initialize(0, 0, pnlAnalogClock.prefWidth, pnlAnalogClock.prefHeight)  
            cvsAnalogClock.ClearRect(rect)  
            cvsAnalogClock.Invalidate  
            pnlAnalogClock.Visible = False  
              
            ' Show digital clock  
            lblClock.Visible = True  
              
            ' Recenter and resize  
            CenterAllElements  
              
            ' Update digital clock immediately  
            UpdateClock  
        End If  
          
        Log("Clock mode changed to: " & IIf(isAnalogMode, "Analog", "Digital"))  
    Catch  
        Log("Clock mode error: " & LastException.Message)  
    End Try  
End Sub  
  
  
  
  
  
Sub btnTheme_Click  
    currentThemeIndex = (currentThemeIndex + 1) Mod colorSchemes.Size  
    Dim scheme As Map = colorSchemes.Get(currentThemeIndex)  
    Dim themeName As String = scheme.Get("name")  
    Dim themePaint As Object = scheme.Get("paint")  
    Dim themeInt As Int = scheme.Get("int")  
      
    If themeName = "Random" Then  
        Dim r As Int = Rnd(0, 256)  
        Dim g As Int = Rnd(0, 256)  
        Dim b As Int = Rnd(0, 256)  
        themePaint = fx.Colors.RGB(r, g, b)  
        themeInt = xui.Color_RGB(r, g, b)  
    End If  
      
    lblClock.TextColor = themePaint  
    currentClockColor = themeInt  
    btnTheme.Text = "🎨 " & themeName  
End Sub  
  
Sub btnImageTimer_Click  
    currentImageInterval = (currentImageInterval + 1) Mod imageIntervals.Size  
    btnImageTimer.Text = "⏱️ " & imageIntervalNames.Get(currentImageInterval)  
    If currentImageInterval = 0 Then  
        timImageChange.Enabled = False  
    Else  
        timImageChange.Enabled = True  
        lastImageChangeTime = DateTime.Now / 1000  
    End If  
End Sub  
  
Sub btnBackground_Click  
    showImage = Not(showImage)  
    If showImage Then  
        btnBackground.Text = "🖼️ Image ON"  
        btnBgColor.Enabled = False  
        LoadBackgroundImage  
        lastImageChangeTime = DateTime.Now / 1000  
    Else  
        btnBackground.Text = "🌈 Image OFF"  
        btnBgColor.Enabled = True  
        imgView.SetImage(Null)  
        timImageChange.Enabled = False  
    End If  
End Sub  
  
Sub btnBgColor_Click  
    Try  
        Dim bgColorHex As List = Array As String("#000000", "#404040", "#00008B", "#006400", "#8B0000")  
        Dim bgNames As List = Array As String("Black", "Gray", "Blue", "Green", "Red")  
        currentBgIndex = (currentBgIndex + 1) Mod bgColorHex.Size  
        pnlBackground.Style = "-fx-background-color: " & bgColorHex.Get(currentBgIndex) & ";"  
        Log("BG Color: " & bgNames.Get(currentBgIndex))  
    Catch  
        Log("BG error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub btnPrayerToggle_Click  
    Try  
        showPrayerTimes = Not(showPrayerTimes)  
        pnlPrayerCards.Visible = showPrayerTimes  
        If showPrayerTimes Then  
            btnPrayerToggle.Text = "🕌 Prayer ON"  
        Else  
            btnPrayerToggle.Text = "🕌 Prayer OFF"  
        End If  
        Log("Prayer times visibility: " & showPrayerTimes)  
    Catch  
        Log("Prayer toggle error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub btnLanguage_Click  
    Try  
        Select currentLanguage  
            Case "en"  
                currentLanguage = "fr"  
                btnLanguage.Text = "🌐 FR"  
            Case "fr"  
                currentLanguage = "ar"  
                btnLanguage.Text = "🌐 AR"  
            Case "ar"  
                currentLanguage = "en"  
                btnLanguage.Text = "🌐 EN"  
        End Select  
          
        FetchPrayerTimes  
        UpdateClock  
          
        ' Update prayer card names  
        Dim prayerNames As List = Array As String("fajr", "sunrise", "dhuhr", "asr", "maghrib", "isha")  
        For i = 0 To 5  
            If pnlPrayerCards.NumberOfNodes > 0 Then  
                Dim pnlCard As Pane = pnlPrayerCards.GetNode(i)  
                If pnlCard.NumberOfNodes > 1 Then  
                    Dim lblName As Label = pnlCard.GetNode(1)  
                    lblName.Text = GetTranslation(prayerNames.Get(i))  
                End If  
            End If  
        Next  
          
        Log("Language changed to: " & currentLanguage)  
    Catch  
        Log("Language switch error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub btnInfoPanel_Click  
    Try  
        showInfoPanel = Not(showInfoPanel)  
        pnlInfoOverlay.Visible = showInfoPanel  
          
        If showInfoPanel Then  
            btnInfoPanel.Text = "📋 Info"  
        Else  
            btnInfoPanel.Text = "📋 Show"  
        End If  
          
        ' IMPORTANT: Recenter and resize clock when toggling info panel  
        CenterAllElements  
          
        ' Redraw analog clock if in analog mode  
        If isAnalogMode Then  
            DrawAnalogClock  
        End If  
          
        Log("Info panel toggled: " & showInfoPanel)  
    Catch  
        Log("Info panel toggle error: " & LastException.Message)  
    End Try  
End Sub  
  
' Clear all clock displays before switching modes or resizing  
Sub ClearAllClocks  
    Try  
        ' Clear digital clock  
        lblClock.Text = ""  
          
        ' Clear analog clock canvas completely  
        Try  
            Dim rect As B4XRect  
            rect.Initialize(0, 0, pnlAnalogClock.prefWidth, pnlAnalogClock.prefHeight)  
            cvsAnalogClock.ClearRect(rect)  
            cvsAnalogClock.Invalidate  
        Catch  
            ' Canvas not yet initialized, ignore  
        End Try  
          
        Log("All clocks cleared")  
    Catch  
        Log("ClearAllClocks error: " & LastException.Message)  
    End Try  
End Sub  
  
  
Sub LoadBackgroundImage  
    Try  
        If Not(showImage) Then Return  
        Dim url As String = "https://picsum.photos/1280/800?random=" & Rnd(1, 10000)  
        job.Initialize("bg", Me)  
        job.Download(url)  
        Wait For (job) JobDone(j As HttpJob)  
        If j.Success Then  
            Dim tempFile As String = "temp_bg.jpg"  
            Dim out As OutputStream = File.OpenOutput(File.DirTemp, tempFile, False)  
            File.Copy2(j.GetInputStream, out)  
            out.Close  
            Dim bmp As Image = fx.LoadImage(File.DirTemp, tempFile)  
            imgView.SetImage(bmp)  
            imgView.prefWidth = MainForm.Width  
            imgView.prefHeight = MainForm.Height  
            File.Delete(File.DirTemp, tempFile)  
        End If  
        job.Release  
    Catch  
        Log("Image error: " & LastException.Message)  
        If job <> Null Then job.Release  
    End Try  
End Sub  
  
Sub FetchWeather  
    Try  
        Dim url As String = "https://api.open-meteo.com/v1/forecast?latitude=" & latitude & "&longitude=" & longitude & "&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&timezone=auto"  
        job.Initialize("weather", Me)  
        job.Download(url)  
        Wait For (job) JobDone(j As HttpJob)  
        If j.Success Then  
            Dim jp As JSONParser  
            jp.Initialize(j.GetString)  
            Dim data As Map = jp.NextObject  
            Dim current As Map = data.Get("current")  
            weatherData.Put("temperature", NumberFormat2(current.Get("temperature_2m"), 1, 1, 1, False))  
            weatherData.Put("humidity", current.Get("relative_humidity_2m"))  
            weatherData.Put("wind_speed", NumberFormat2(current.Get("wind_speed_10m"), 1, 1, 1, False))  
            Dim wCode As Int = current.Get("weather_code")  
            weatherEmoji = GetWeatherEmoji(wCode)  
            Log("Weather updated: " & weatherEmoji)  
        End If  
        job.Release  
    Catch  
        Log("Weather error: " & LastException.Message)  
        If job <> Null Then job.Release  
    End Try  
End Sub  
  
Sub MainForm_Resize (Width As Double, Height As Double)  
    CenterAllElements  
End Sub  
  
Sub MainForm_KeyPressed (KeyCode As Int, Modifiers As Int)  
    If KeyCode = 27 Then  
        MainForm.Close  
    Else If KeyCode = 122 Then  
        Dim isFull As Object = jStage.RunMethod("isFullScreen", Null)  
        jStage.RunMethod("setFullScreen", Array(Not(isFull)))  
        CenterAllElements  
    End If  
End Sub  
  
Sub MainForm_Close  
    timUpdate.Enabled = False  
    timImageChange.Enabled = False  
    If job <> Null Then job.Release  
End Sub  
  
Sub dsin(d As Double) As Double  
    Return Sin(d * cPI / 180.0)  
End Sub  
  
Sub dcos(d As Double) As Double  
    Return Cos(d * cPI / 180.0)  
End Sub  
  
Sub dtan(d As Double) As Double  
    Return Tan(d * cPI / 180.0)  
End Sub  
  
Sub dasin(x As Double) As Double  
    Return ASin(x) * 180.0 / cPI  
End Sub  
  
Sub dacos(x As Double) As Double  
    Return ACos(x) * 180.0 / cPI  
End Sub  
  
Sub datan2(y As Double, x As Double) As Double  
    Return ATan2(y, x) * 180.0 / cPI  
End Sub  
  
Sub FixAngle(angle As Double) As Double  
    angle = angle - 360.0 * Floor(angle / 360.0)  
    If angle < 0 Then angle = angle + 360.0  
    Return angle  
End Sub  
  
Sub FixHour(hour As Double) As Double  
    hour = hour - 24.0 * Floor(hour / 24.0)  
    If hour < 0 Then hour = hour + 24.0  
    Return hour  
End Sub  
  
' ========== SETTINGS MANAGEMENT ==========  
  
Sub LoadSettings  
    Try  
        If File.Exists(File.DirApp, settingsFile) Then  
            Dim settings As List = File.ReadList(File.DirApp, settingsFile)  
            If settings.Size >= 3 Then  
                cityName = settings.Get(0)  
                latitude = settings.Get(1)  
                longitude = settings.Get(2)  
                Log("Settings loaded: " & cityName & " (" & latitude & ", " & longitude & ")")  
            Else  
                Log("Invalid settings file, using defaults")  
            End If  
        Else  
            Log("No settings file found, using default location: " & cityName)  
        End If  
    Catch  
        Log("LoadSettings error: " & LastException.Message)  
        ' Keep default values if loading fails  
    End Try  
End Sub  
  
Sub SaveSettings  
    Try  
        Dim settings As List  
        settings.Initialize  
        settings.Add(cityName)  
        settings.Add(latitude)  
        settings.Add(longitude)  
        File.WriteList(File.DirApp, settingsFile, settings)  
        Log("Settings saved: " & cityName & " (" & latitude & ", " & longitude & ")")  
    Catch  
        Log("SaveSettings error: " & LastException.Message)  
    End Try  
End Sub  
  
' ========== CITY SEARCH FUNCTIONALITY ==========  
  
Sub btnChangeCity_Click  
    Try  
        ' Show input dialog for city search  
        Dim inputDialog As JavaObject  
        inputDialog.InitializeNewInstance("javafx.scene.control.TextInputDialog", Array(""))  
        inputDialog.RunMethod("setTitle", Array("Change City"))  
        inputDialog.RunMethod("setHeaderText", Array("Search for your city"))  
        inputDialog.RunMethod("setContentText", Array("Enter city name:"))  
          
        ' Set current city as default  
        Dim editor As JavaObject = inputDialog.RunMethod("getEditor", Null)  
        editor.RunMethod("setText", Array(cityName))  
          
        Dim result As JavaObject = inputDialog.RunMethod("showAndWait", Null)  
        Dim isPresent As Boolean = result.RunMethod("isPresent", Null)  
          
        If isPresent Then  
            Dim searchQuery As String = result.RunMethod("get", Null)  ' Changed variable name  
            If searchQuery.Trim.Length > 0 Then  
                SearchCity(searchQuery.Trim)  ' Now no conflict  
            End If  
        End If  
    Catch  
        Log("City dialog error: " & LastException.Message)  
    End Try  
End Sub  
  
  
Sub SearchCity(cityQuery As String)  
    Try  
        Log("Searching for city: " & cityQuery)  
          
        ' Use Open-Meteo Geocoding API (free, no API key needed)  
        Dim url As String = "https://geocoding-api.open-meteo.com/v1/search?name=" & _  
            cityQuery.Replace(" ", "%20") & "&count=10&language=en&format=json"  
          
        job.Initialize("geocode", Me)  
        job.Download(url)  
        Wait For (job) JobDone(j As HttpJob)  
          
        If j.Success Then  
            Dim jp As JSONParser  
            jp.Initialize(j.GetString)  
            Dim response As Map = jp.NextObject  
              
            If response.ContainsKey("results") Then  
                Dim results As List = response.Get("results")  
                  
                If results.Size > 0 Then  
                    ' Show selection dialog if multiple results  
                    If results.Size > 1 Then  
                        ShowCitySelectionDialog(results)  
                    Else  
                        ' Only one result, use it directly  
                        SelectCity(results.Get(0))  
                    End If  
                Else  
                    ShowAlert("City Not Found", "No results found for: " & cityQuery)  
                End If  
            Else  
                ShowAlert("Search Error", "No results found. Please try a different city name.")  
            End If  
        Else  
            ShowAlert("Network Error", "Failed to search for city. Please check your internet connection.")  
        End If  
          
        job.Release  
    Catch  
        Log("SearchCity error: " & LastException.Message)  
        If job <> Null Then job.Release  
    End Try  
End Sub  
  
Sub ShowCitySelectionDialog(results As List)  
    Try  
        ' Build choice list  
        Dim choices As List  
        choices.Initialize  
          
        For i = 0 To Min(results.Size - 1, 9) ' Show max 10 results  
            Dim city As Map = results.Get(i)  
            Dim name As String = city.Get("name")  
            Dim country As String = city.GetDefault("country", "")  
            Dim admin1 As String = city.GetDefault("admin1", "")  
              
            Dim displayName As String = name  
            If admin1.Length > 0 Then displayName = displayName & ", " & admin1  
            If country.Length > 0 Then displayName = displayName & ", " & country  
              
            choices.Add(displayName)  
        Next  
          
        ' Show choice dialog  
        Dim choiceDialog As JavaObject  
        choiceDialog.InitializeNewInstance("javafx.scene.control.ChoiceDialog", Array(choices.Get(0), choices))  
        choiceDialog.RunMethod("setTitle", Array("Select City"))  
        choiceDialog.RunMethod("setHeaderText", Array("Multiple cities found"))  
        choiceDialog.RunMethod("setContentText", Array("Choose your city:"))  
          
        Dim result As JavaObject = choiceDialog.RunMethod("showAndWait", Null)  
        Dim isPresent As Boolean = result.RunMethod("isPresent", Null)  
          
        If isPresent Then  
            Dim selected As String = result.RunMethod("get", Null)  
            Dim selectedIndex As Int = choices.IndexOf(selected)  
            If selectedIndex >= 0 Then  
                SelectCity(results.Get(selectedIndex))  
            End If  
        End If  
    Catch  
        Log("ShowCitySelectionDialog error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub SelectCity(cityData As Map)  
    Try  
        ' Extract city information  
        Dim name As String = cityData.Get("name")  
        Dim country As String = cityData.GetDefault("country", "")  
        Dim admin1 As String = cityData.GetDefault("admin1", "")  
          
        latitude = cityData.Get("latitude")  
        longitude = cityData.Get("longitude")  
          
        ' Build full city name  
        cityName = name  
        If admin1.Length > 0 Then cityName = cityName & ", " & admin1  
        If country.Length > 0 Then cityName = cityName & ", " & country  
          
        ' Save settings  
        SaveSettings  
          
        ' Update weather and prayer times  
        FetchWeather  
        FetchPrayerTimes  
          
        Log("City changed to: " & cityName & " (lat: " & latitude & ", lon: " & longitude & ")")  
          
        ' Show confirmation  
        ShowAlert("City Updated", "Location set to: " & cityName)  
    Catch  
        Log("SelectCity error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub ShowAlert(title As String, message As String)  
    Try  
        Dim alert As JavaObject  
        alert.InitializeNewInstance("javafx.scene.control.Alert", Array(GetAlertType("INFORMATION")))  
        alert.RunMethod("setTitle", Array(title))  
        alert.RunMethod("setHeaderText", Array(Null))  
        alert.RunMethod("setContentText", Array(message))  
        alert.RunMethod("showAndWait", Null)  
    Catch  
        Log("ShowAlert error: " & LastException.Message)  
    End Try  
End Sub  
  
Sub GetAlertType(alertType As String) As Object  
    Dim jo As JavaObject  
    jo.InitializeStatic("javafx.scene.control.Alert.AlertType")  
    Return jo.GetField(alertType)  
End Sub
```