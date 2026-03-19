### Shelly PlugS Gen3 B4A Bluetooth by Wolli013
### 03/17/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/170612/)

Hi everyone,  
Here's a class for turning the Shelly PlugS Gen3 on and off in B4A via Bluetooth.  
  
  

```B4X
Dim ShellyBT As ShellyBluetoothController
```

  
  

```B4X
    If FirstTime Then  
        ShellyBT.Initialize  
        Sleep(500)     
        ShellyBT.StartController  
    End If
```

  
  
The class is called as follows:  
  

```B4X
Sub PhoneEvents_BatteryChanged (Level As Int, Scale As Int, Plugged As Boolean, Intent As Intent)  
' Diese Methode wird aufgerufen, wenn sich der Batteriestatus ändert  
    batteryPercentage = (Level / Scale) * 100  
    'Log($"Batteriestatus: ${batteryPercentage}%"$)  
          
        'Prüfe erst ab einem bestimmten Bereich  
                If batteryPercentage <= 20 Or batteryPercentage >= 80 Then  
                    ShellyBT.SetBattery(batteryPercentage)  
                End If  
End Sub
```

  
  
Here is the class:  
  

```B4X
'Klasse: ShellyBluetoothController  
'Zweck: Automatisches Laden via Shelly BLE (Scan -> Connect -> Switch -> Disconnect)  
Sub Class_Globals  
    Private ShellyBLE As BleManager2  
    Private ConnectedDevice As String = ""  
    Private CanWrite As Boolean = False  
      
    ' Deine spezifischen Shelly UUIDs  
    Private ServiceUUID As String = "5f6d4f53-5f52-5043-5f53-56435f49445f"  
    Private CharUUID As String = "5f6d4f53-5f52-5043-5f64-6174615f5f5f"  
      
    ' Status-Variablen  
    Private Charging As Boolean = False  
    Private LastBattery As Int = -1  
    Private TimerCheck As Timer  
    Private LastSwitchTime As Long = 0  
    Private MinSwitchInterval As Long = 60000  
    Private IsWorking As Boolean = False  
      
    ' Schwellwerte für die Automatik  
    Private LadenAnschalten As Int = 20  
    Private LadenAbschalten As Int = 80  
    Private NotLadenAnschalten As Int = 18  
    Private NotLadenAbschalten As Int = 82  
End Sub  
  
' Initialisierung  
Public Sub Initialize  
    ShellyBLE.Initialize("ShellyBLE")  
    TimerCheck.Initialize("TimerCheck", 60000) ' Alle 60 Sekunden prüfen  
End Sub  
  
' Controller starten  
Public Sub StartController  
    Log("Shelly BLE Controller aktiv.")  
    TimerCheck.Enabled = True  
End Sub  
  
' Controller stoppen  
Public Sub StopController  
    TimerCheck.Enabled = False  
    ResetBLE  
End Sub  
  
' Batterie-Wert von außen füttern  
Public Sub SetBattery(batteryPercentage As Int)  
    LastBattery = batteryPercentage  
End Sub  
  
' — Kern-Logik: Timer Event —  
Private Sub TimerCheck_Tick  
    ' Falls wir gerade schon arbeiten oder kein Batteriewert da ist: Abbruch  
    If IsWorking Or LastBattery < 0 Then Return  
      
    ' Prüfen: Besteht Handlungsbedarf?  
    Dim AktionNötig As Boolean = False  
      
    If LastBattery <= LadenAnschalten And Charging = False Then AktionNötig = True  
    If LastBattery >= LadenAbschalten And Charging = True Then AktionNötig = True  
    If LastBattery <= NotLadenAnschalten Then AktionNötig = True  
    If LastBattery >= NotLadenAbschalten Then AktionNötig = True  
      
    If AktionNötig Then  
        ' Schaltintervall Schutz prüfen  
        If DateTime.Now - LastSwitchTime < MinSwitchInterval Then  
            Log("Aktion nötig, aber Sicherheits-Intervall läuft noch.")  
            Return  
        End If  
          
        IsWorking = True  
        SucheUndSchalte  
    Else  
        Log("Batterie ok (" & LastBattery & "%). Keine BLE-Aktion nötig.")  
    End If  
End Sub  
  
' — Der Ablauf-Prozess (Resumable Sub) —  
Private Sub SucheUndSchalte  
    Log("Starte BLE-Ablauf…")  
      
    ' Falls noch Reste einer alten Verbindung da sind  
    ResetBLE  
    IsWorking = True ' ResetBLE setzt es auf False, wir brauchen es hier True  
      
    ' 1. Scan starten  
    ShellyBLE.Scan2(Null, False)  
      
    ' 2. Timeout abwarten (10 Sekunden suchen)  
    Sleep(10000)  
      
    ' 3. Ergebnis prüfen  
    If ConnectedDevice = "" Then  
        Log("Timeout: Shelly nicht gefunden.")  
        ShellyBLE.StopScan  
        IsWorking = False  
    Else  
        ' Wir sind verbunden. ble_Connected hat bereits SwitchShelly getriggert.  
        ' Wir warten noch kurz, bis der Disconnect durch ist.  
        Sleep(2000)  
        IsWorking = False  
        Log("Ablauf beendet, Bluetooth wieder im Tiefschlaf.")  
    End If  
End Sub  
  
' — BLE Events —  
  
Private Sub ShellyBLE_DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)  
    If Name = Null Then Return  
    If Name.ToLowerCase.Contains("shelly") Then  
        Log("Shelly gefunden: " & Name)  
        ShellyBLE.StopScan  
        ConnectedDevice = Id  
        ShellyBLE.Connect(Id)  
    End If  
End Sub  
  
Private Sub ShellyBLE_Connected (Services As List)  
    Log("✓ Verbunden. Initialisiere…")  
    ShellyBLE.RequestMtu(128)  
    Sleep(500)  
      
    Try  
        ' Benachrichtigungen aktivieren  
        ShellyBLE.SetNotify(ServiceUUID, CharUUID, True)  
        CanWrite = True  
          
        ' Sofort Schalten  
        ProcessBatteryLogic  
    Catch  
        Log("Fehler beim Setup der Services: " & LastException)  
        ResetBLE  
    End Try  
End Sub  
  
Private Sub ShellyBLE_Disconnected  
    Log("Verbindung getrennt.")  
    ConnectedDevice = ""  
    CanWrite = False  
End Sub  
  
' — Schaltvorgang —  
  
Private Sub ProcessBatteryLogic  
    ' Hier entscheiden wir final über den Status  
    Dim TargetState As Boolean = Charging  
      
    If LastBattery <= LadenAnschalten Then TargetState = True  
    If LastBattery >= LadenAbschalten Then TargetState = False  
      
    ' Notfall-Werte  
    If LastBattery <= NotLadenAnschalten Then TargetState = True  
    If LastBattery >= NotLadenAbschalten Then TargetState = False  
      
    SwitchShelly(TargetState)  
End Sub  
  
Private Sub SwitchShelly(State As Boolean)  
    If Not(CanWrite) Then Return  
      
    Dim json As String = $"{"id":1,"src":"app","method":"Switch.Set","params":{"id":0,"on":${State}}}"$  
    Dim bytes() As Byte = json.GetBytes("UTF8")  
      
    Try  
        Log("Sende RPC: " & json)  
        ShellyBLE.WriteData(ServiceUUID, CharUUID, bytes)  
        Charging = State  
        LastSwitchTime = DateTime.Now  
          
        ' Warten auf Verarbeitung, dann kappen  
        Sleep(1500)  
        Log("Schaltbefehl fertig. Trenne…")  
        ResetBLE  
    Catch  
        Log("Schreibfehler: " & LastException)  
        ResetBLE  
    End Try  
End Sub  
  
' Datenempfang (optional, falls du die Antwort loggen willst)  
Private Sub ShellyBLE_DataAvailable (Service As String, Characteristics As Map)  
    If Characteristics.ContainsKey(CharUUID) Then  
        Dim Value() As Byte = Characteristics.Get(CharUUID)  
        Log("Shelly Antwort: " & BytesToString(Value, 0, Value.Length, "UTF8"))  
    End If  
End Sub  
  
' Hilfs-Sub für sauberen Status  
Private Sub ResetBLE  
    If ConnectedDevice <> "" Then  
        Try  
            ShellyBLE.Disconnect  
        Catch  
            Log("ResetBLE")  
        End Try  
    End If  
    ShellyBLE.StopScan  
    ConnectedDevice = ""  
    CanWrite = False  
    IsWorking = False  
End Sub  
  
' UI Info Helper  
Public Sub GetStatusText As String  
    Return "Batterie: " & LastBattery & "% | Laden: " & Charging & " | Aktiv: " & IsWorking  
End Sub
```