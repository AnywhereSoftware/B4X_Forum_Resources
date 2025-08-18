### French smartmeter Linky by MbedAndroid
### 08/31/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/133904/)

Some time ago the ugly yellow box from Enerdis was installed in my home. There are 3 terminals on the box where you will get a little power and data .  
here some info about the terminals: [Linky](https://blog.thestaticturtle.fr/linkylink-connecting-myself-to-the-energy-meter/)  
info about the protocol (1200 baud, 7 bits, 1 parity) [detailed protocol Ugly Linky](https://www.planete-domotique.com/notices/ERDF-NOI-CPT_O2E.pdf)  
![](https://reporterre.net/local/cache-vignettes/L720xH480/arton22157-04b1d.jpg?1615315448)  
This program runs on a Rasp Zero and send the data to my home automation.  
I only take the current energy value and Total Day/Night totals.  
But the Linky can provide more info if you contact Enerdis. Then the output will be 9600 baud.  
  
I made the same program for the ESP (wemos d1), but didnt install it, as the Poweroutput terminal of Linky cant supply the current for the ESP.  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
#Region  Project Attributes  
  
#End Region  
'ADCO 022076110359 ;        Adresse du compteur  
'OPTARIF HC.. <              Option tarifaire choisie  
'ISOUSC 15 <                Intensité souscrite  
'HCHC 000087557 &             Heures Creuses (w/h)  
'HCHP 000098985 :             Heures Pleines (w/h)  
'PTEC HP..                  Période Tarifaire en cours  
'IINST1 000 H                 Intensité Instantanée pour les 3 phases 1, 2 et 3 (amp)  
'IINST2 000 I  
'IINST3 000 J  
'IMAX1 060 6                   Intensité maximale par phase 1, 2 et 3 (amp)  
'IMAX2 060 7  
'IMAX3 060 8  
'PMAX 05330 1  
'PAPP 00360 *                 Puissance apparente  (w/h)  
'HHPHC A ,                    Horaire Heures Pleines Heures Creuses  
'MOTDETAT 000000 B            Mot d'Etat du compteur  
'PPOT 00 #                    Présence des potentiels  
Sub Process_Globals  
  
    Private sp As Serial  
    Private astreams As AsyncStreamsText  
    Private HCHC=003808.351 As Float  
    Private HCHP=002948.827  As Float  
  
    Private Pwtr1=0  As Float  
    Private Pwtr2=0  As Float  
  
    Private Pwar=0  As Float  
    Private Gast=0  As Float  
    Private PAPP=01.193  As Float  
    Private Water=0  As Float  
    Private OneLiterBucket=0  As String  
    Private GasAverage=0  As String  
    Private tarif=0  As String  
    Public usocket As UDPSocket  
  
    Private port As Int = 5000  
    Private data() As Byte  
    Private Packet1 As UDPPacket  
  
    Private refreshcounter=0 As Int  
    Private const refresh=25 As Int  
    Private MacAddress="00:00:00:00:00:00" As String  
    Dim l As List  
  
End Sub  
  
Sub AppStart ( Args() As String)  
  
    l=sp.listports  
    For i=0 To l.Size-1  
        Log(l.get(i))  
    Next  
     
    RedirectOutput(File.DirApp, "logs.txt")  
    Log("SerialPortSMS Init"&  DateTime.Date(DateTime.Now) & DateTime.Time(DateTime.Now))  
    Try  
        sp.Open("/dev/SMS")  
     
        sp.SetParams(1200,7,1,2)  
        sp.RTS=True  
        sp.DTR=True  
    Catch  
        Log("commport init error")  
    End Try  
  
    Try  
     
        usocket.Initialize("usocket", 0, 500)  
    Catch  
        Log ("cannot init UPD port")  
    End Try  
  
    Log("app start")  
    Log(DateTime.Date(DateTime.now))  
    CallSubDelayed(Me,"OpenCommPort")  
  
    StartMessageLoop  
    ''sendpacket  
End Sub  
Sub RedirectOutput (Dir As String, FileName As String) 'ignore  
   #if RELEASE  
    Dim out As OutputStream = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs  
    Dim ps As JavaObject  
    ps.InitializeNewInstance("java.io.PrintStream", Array(out, True, "utf8"))  
    Dim jo As JavaObject  
    jo.InitializeStatic("java.lang.System")  
    jo.RunMethod("setOut", Array(ps))  
    jo.RunMethod("setErr", Array(ps))  
   #end if  
End Sub  
  
Sub OpenCommPort  
  
    astreams.Initialize( Me ,"astream",sp.GetInputStream,sp.GetOutputStream )  
End Sub  
  
  
Sub AStream_NewText ( cData As String)  
  
    Private st As JStringFunctions  
    st.Initialize  
    Private l As List  
    l.Initialize  
    If cData.Contains("PTEC") Then  
  
        l=st.Split(cData," ")  
        tarif=l.Get(1)  
        If tarif.Contains("HP") Then tarif="1" Else tarif="0"  
    End If  
    If cData.Contains("HCHC") Then  
  
        l=st.Split(cData," ")  
        HCHC=l.Get(1)/1000  
     
     
    End If  
    If cData.Contains("HCHP") Then  
  
        l=st.Split(cData," ")  
        HCHP=l.Get(1)/1000  
     
     
    End If  
    If cData.Contains("PAPP") Then  
  
        l=st.Split(cData," ")  
        PAPP=l.Get(1)/1000  
         
        refreshcounter=refreshcounter+1  
        If refreshcounter>refresh Then  
            Log("HP: "& NumberFormat2(HCHP,1,1,1,False)&"kwh")  
            Log("HC: "& NumberFormat2(HCHC,1,1,1,False)&"kwh")  
     
            If DateTime.Time(DateTime.Now).Contains("00:00:") Then  
                DateTime.DateFormat="dd/MM/yyyy"  
                Log (DateTime.Date(DateTime.Now))  
            End If  
            Log("average: "& NumberFormat2(l.Get(1),1,3,1,False)&"wh" & "Tijd:" & DateTime.Time(DateTime.Now))  
            sendpacket  
            refreshcounter=0  
        End If  
     
    End If  
  
     
End Sub  
  
Sub sendpacket  
  
    Private buffer="192.168.1.50" & ",P1" & "," & MacAddress & "," & NumberFormat2(HCHC,1,1,1,False) & "," _  
    & NumberFormat2(HCHP,1,1,1,False) & ","  & NumberFormat2(Pwtr1,1,1,1,False) & ","  & NumberFormat2(Pwtr2,1,1,1,False) & "," _  
    & NumberFormat2(PAPP,1,3,1,False) & "," & NumberFormat(Pwar,1,3) & "," & NumberFormat2(Gast,1,3,1,False)& "," _  
    & NumberFormat(tarif,1,0) & "," & NumberFormat2(GasAverage,1,3,1,False) & "," & NumberFormat2(Water,1,3,1,False) & "," _  
    & NumberFormat(OneLiterBucket,1,0) As String  
'    Log(buffer)  
    data=buffer.GetBytes("UTF8")  
    Packet1.Initialize(data, "192.168.1.62",port)  
    usocket.Send(Packet1)  
'            Dim buffer As String=JoinStrings(Array As String(wifi.LocalIp ,",","P1",",",bc.HexFromBytes(MacAddress),",",NumberFormat(Pwt1,1,1),",",NumberFormat(Pwt2,1,1),",",NumberFormat(Pwtr1,1,1),",",NumberFormat(Pwtr2,1,1),",",NumberFormat(Pwa,1,3),",",NumberFormat(Pwar,1,3),",",NumberFormat(Gast,1,3),",",NumberFormat(tarif,1,0),",",NumberFormat(GasAverage,1,3),",",NumberFormat(Water,1,3),",",NumberFormat(OneLiterBucket,1,0)))  
'        
'            usocket.BeginPacket(ip, port)  
'            usocket.Write(buffer)  
'            usocket.SendPacket  
End Sub  
  
  
  
Sub usocket_PacketArrived (Packet As UDPPacket)  
  
End Sub
```