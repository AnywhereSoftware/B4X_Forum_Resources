### Is IP in my network On and active? آیا یک آیپی در شبکه وجود دارد و فعال است by modiranghaneipour
### 05/06/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/166892/)

i want check my ip in my network. is Run this IP now?  
we can check this in 3 way:  
way1: Ping ip  
way2: Port checking  
way3: library Network  
  
in persian: به فارسی  
از هوش مصنوعی کمک گرفتم اگه اشکال املایی یا انشایی داره ببخشید هوش مصنوعی رو  
  
برای بررسی اینکه آیا یک آیپی در شبکه **وجود دارد و فعال است** (مثلاً دستگاه یا سروری به آن متصل است)، می‌توانید از روش‌های زیر در بیسیک فور اندروید استفاده کنید:  
  
  
[HEADING=2]**1. استفاده از Ping (ساده‌ترین روش)**[/HEADING]  
با فرستادن یک **Ping** به آیپی مورد نظر، می‌توانید بررسی کنید که آیا دستگاه پاسخ می‌دهد یا نه.  
  
[HEADING=3]**کد B4A برای Ping کردن آیپی:**[/HEADING]  
  

```B4X
Sub CheckIPActive(ip As String) As Boolean  
    Dim su As Shell  
    Dim cmd As String = "ping -c 1 -W 1 " & ip ' برای لینوکس/اندروید (1 بار Ping با timeout 1 ثانیه)  
    Dim result As String  
    
    ' اجرای دستور Ping  
    su.Initialize("su", "sh", Array As String("-c", cmd))  
    result = su.RunSynchronous  
'  یا     result = su.RunSynchronous(5000) ' زمان انتظار 5 ثانیه  
  
  
    ' بررسی پاسخ  
    If result.Contains("1 received") Or result.Contains("bytes from")  Or result.Contains("from") Then  
        Return True ' آیپی پاسخ داد  
    Else  
        Return False ' آیپی پاسخ نداد  
    End If  
End Sub
```

  
  
البته ممکنه خطای دسترسی بده که  
  
 Dim cmd As String = "ping " & ip ' بدون گزینه‌های خاص  
  
استفاده کنید  
[HEADING=3]**طریقه استفاده:**[/HEADING]  
  

```B4X
Dim ip As String = "192.168.1.5"  
If CheckIPActive(ip) Then  
    ToastMessageShow("آیپی فعال است!", True)  
Else  
    ToastMessageShow("آیپی پاسخ نمی‌دهد!", True)  
End If
```

  
  
  
[HEADING=2]**2. اسکن پورت (اگر می‌خواهید بررسی کنید که سرویس خاصی اجراست)**[/HEADING]  
اگر می‌خواهید بفهمید که **پورت خاصی باز است** (مثلاً پورت 80 برای وبسرور)، می‌توانید از سوکت استفاده کنید.  
  
[HEADING=3]**کد B4A برای چک کردن پورت:**[/HEADING]  
  

```B4X
Sub CheckPortOpen(ip As String, port As Int) As Boolean  
    Dim sock As Socket  
    sock.Initialize("sock")  
    
    Try  
        sock.Connect(ip, port, 2000) ' Timeout 2 ثانیه  
        Wait For sock_Connected (Success As Boolean)  
        If Success Then  
            sock.Close  
            Return True  
        Else  
            Return False  
        End If  
    Catch  
        Return False  
    End Try  
End Sub
```

  
  
[HEADING=3]**مثال استفاده:**[/HEADING]  
  
If CheckPortOpen("192.168.1.5", 80) Then  
 ToastMessageShow("پورت 80 باز است!", True)  
Else  
 ToastMessageShow("پورت 80 بسته است!", True)  
End If  
  
  
  
  
  
  
  
[HEADING=2]**3. استفاده از کتابخانه Network در B4A**[/HEADING]  
اگر می‌خواهید اطلاعات بیشتری از دستگاه  
 (مثل MAC Address)  
 بگیرید، می‌توانید از  
**ARP** یا **Network Discovery**  
استفاده کنید.  
  

```B4X
Dim n As Network  
Dim devices As Map  
devices = n.GetNetworkDevices ' لیست دستگاه‌های شبکه  
  
If devices.ContainsKey("192.168.1.5") Then  
    ToastMessageShow("دستگاه پیدا شد!", True)  
Else  
    ToastMessageShow("دستگاه وجود ندارد!", True)  
End If
```

  
  
  
  

---

  
[HEADING=2]**نتیجه‌گیری:**[/HEADING]  
[TABLE]  
[TR]  
[TH]روش[/TH]  
[TH]کاربرد[/TH]  
[/TR]  
[TR]  
[TD]**Ping**[/TD]  
[TD]بررسی آنلاین بودن آیپی[/TD]  
[/TR]  
[TR]  
[TD]**Port Check**[/TD]  
[TD]بررسی باز بودن پورت خاص[/TD]  
[/TR]  
[TR]  
[TD]**Network Discovery**[/TD]  
[TD]پیدا کردن دستگاه‌های شبکه[/TD]  
[/TR]  
[/TABLE]  
اگر **فقط می‌خواهید بفهمید آیپی پاسخ می‌دهد یا نه**، پینگ کردن ساده‌ترین راه است. 🚀  
  
اگر سوالی دارید بپرسید قانعی پور