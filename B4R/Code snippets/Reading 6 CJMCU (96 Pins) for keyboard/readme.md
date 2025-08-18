### Reading 6 CJMCU (96 Pins) for keyboard by Hans- Joachim Krahe
### 03/29/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/139487/)

```B4X
    Dim myport(12) As Byte  
    Dim getmyport(12) As Byte  
    Dim tiI2C As Timer  
  
'—————————————-  
  
private Sub AppStart  
  
master.Initialize  ' ————————–clk pin1 - sda pin2  
    For i = 0 To 11 ' ————————-set all bytes to Input and pull up, prefill status  
        Dim ioCounter As UInt = 0x20 + i/2  'calculate chip address'  
        Dim ioSide As UInt = Bit.Get(i,0) 'calculate upper/lower byte'  
      
        master.WriteTo(ioCounter, Array As  Byte(ioSide, 0xFF)) '—- input  
        master.WriteTo(ioCounter, Array As  Byte(0x0C + ioSide, 0xFF)) '— pull up  
          
        getmyport(i) = DigitalRead(ioCounter,ioSide)  
        If getmyport(i) <> myport(i) Then  
            myport(i) = getmyport(i)  
        End If  
    Next  
  
     tiI2C.Initialize("myTiTick",10) ' normal 10 to 30 ms  
     tiI2C.Enabled = True  
end sub  
  
private Sub myTiTick  
  
    For i = 0 To 11  
        Dim ioCounter As UInt = 0x20 + i/2  
        Dim ioSide As UInt = Bit.Get(i,0)  
        getmyport(i) = DigitalRead(ioCounter,ioSide)  
       
        If getmyport(i) <> myport(i) Then  
            If i < 6 Then ' only necessary for 2 channel play  
                intent = 0x81  
            Else  
               intent = 0x80  
            End If  
  
            'Log(ioCounter," ",ioSide," ",getmyport(i))  
            For ii = 0 To 7  
                If Bit.Get(myport(i),ii) <> Bit.Get(getmyport(i),ii) Then  
                    If Bit.Get(getmyport(i),ii) = 0 Then intent = intent + 0x10  ' —————–tone is on. 0x90 for chanel 0, 0x91 for chanel 1  
                    sendTone(ii + 1 + (i*8)," A",intent) ' —————————-output of pin Nr 0 - 95 for tone definition  
                End If  
            Next  
            myport(i) = getmyport(i)  
        End If  
    Next
```

  
  
  
  
  
… and have fun:)  
  
[MEDIA=youtube]ap2rUmkNuMs[/MEDIA]