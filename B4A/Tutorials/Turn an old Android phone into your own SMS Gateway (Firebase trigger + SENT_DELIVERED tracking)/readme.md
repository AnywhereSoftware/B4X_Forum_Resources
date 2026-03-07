### Turn an old Android phone into your own SMS Gateway (Firebase trigger + SENT/DELIVERED tracking) by scsjc
### 03/02/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/170468/)

[HEADING=2]Turn an Old Android Phone into Your Own SMS Gateway[/HEADING]  
(Firebase trigger + SENT / DELIVERED tracking – Minimal example)  
  
For a long time I was using **Firebase Phone Auth** to validate access to my app via SMS (OTP).  
However, after updating B4A and modernizing parts of the project, I ran into compatibility issues and decided to try something I had been thinking about for a while:  
👉 Using an old Android phone with a SIM card (unlimited SMS) as a **self-hosted SMS server**.  
Sometimes we have great ideas but no time to “play” and explore the powerful tools that B4A gives us. This was one of those experiments — and it turned out to be very interesting.  
  
  
**Sample real data collected from MySQL**  
  
![](https://www.b4x.com/android/forum/attachments/170344)  
  

---

  
  
[HEADING=2]⚠ Important[/HEADING]  
This code does **NOT** work directly by copy & paste.  
You must configure:  

- Firebase Cloud Messaging
- Firebase project
- Manifest entries
- Runtime permissions

The idea here is to share a **minimal structural concept**, not a plug-and-play solution.  
  

---

  
  
[HEADING=2]The Core Idea[/HEADING]  
The Android device acts as a “zombie terminal” (in a good way):  

- It sits there quietly with a SIM card.
- It listens for Firebase Cloud Messaging (FCM).
- When a message arrives, it wakes up.
- It sends a real SMS using SmsManager.
- It captures the delivery status (SENT / FAILED / DELIVERED).

  
So:  
  
**FCM = Trigger  
Android SIM = Real SMS sender**  
  
  
No external SMS provider needed.  
  

---

  
  
[HEADING=2]How It Works – Step by Step[/HEADING]  
  
[HEADING=2]1️⃣ FirebaseMessaging Receiver (the “wake up” trigger)[/HEADING]  
The device subscribes to a topic (for example "enviarsms").  
When an FCM message arrives:  

- sms\_number
- sms\_message
- id\_sms (your internal DB id)

  
are extracted from the data payload.  
Then:  
  
  
SendSmsImmutable(id\_sms, sms\_number, sms\_message)  
  
  
is called.  
FCM simply delivers *what to send* and *to whom*.  
  
  

---

  
  
[HEADING=2]2️⃣ Sending the SMS with SENT / DELIVERED tracking[/HEADING]  
  
Inside SendSmsImmutable():  

- SmsManager.sendTextMessage() is used.
- Two PendingIntents are created:

- One for **SENT**
- One for **DELIVERED**

A Map (Starter.SmsPending) is used to correlate:  
  
  
req → id\_sms  
  
  
This allows us to know exactly which SMS triggered each callback.  
  
  

---

  
  
[HEADING=2]3️⃣ smsstatusreceiver (status tracking)[/HEADING]  
  
The smsstatusreceiver receives the broadcast events.  
It retrieves:  

- req
- ev (SENT or DELIVERED)
- GetResultCode

  
From this it determines:  

- SENT (accepted by modem/network)
- DELIVERED (carrier confirmation)
- FAILED (error with code)

  
This is where you can:  

- Update your backend
- Write logs
- Store validation results

  

---

  
  
[HEADING=2]Why This Is Interesting[/HEADING]  
This approach gives you full control and traceability:  
  
✔ Know which messages were accepted by the network  
✔ Know which were delivered (if supported)  
✔ Detect failures and reasons  
✔ Maintain your own validation logs  
  
  
If connected to MySQL (or even a local database), you can build a very robust OTP tracking system.  
I’m not explaining SQL or backend connections here because that would make the post too long. The goal is to share the minimal Android “SMS server” concept.  
  

---

  
  
[HEADING=2]Required Permissions (Critical)[/HEADING]  
  
You MUST:  
  
  
[HEADING=3]1️⃣ Declare permission in Manifest:[/HEADING]  
  
AddPermission(android.permission.SEND\_SMS)  
  
  
[HEADING=3]2️⃣ Register the receiver:[/HEADING]  
  
AddReceiverText(smsstatusreceiver,<intent-filter></intent-filter>)  
  
  
[HEADING=3]3️⃣ Request permission at runtime (Android 6+):[/HEADING]  
  
rp.CheckAndRequest(rp.PERMISSION\_SEND\_SMS)  
  
  
  
If any of these steps are missing:  

- SMS sending will fail
- SENT / DELIVERED callbacks will not work

  
Runtime permission alone is NOT enough.  
  

---

  
  
[HEADING=2]Complete Flow Example[/HEADING]  

1. Your backend decides to send an OTP.
2. It calls send.php.
3. send.php performs:

- Rate limiting
- Phone validation
- Temporary bans if needed

4. If valid, send.php sends an FCM message.
5. Android device receives FCM.
6. Device sends real SMS.
7. smsstatusreceiver captures status.
8. Backend logs result (via status.php).
9. User enters OTP.
10. Backend validates via check.php.

  

---

  
  
[HEADING=2]My Backend Structure (Concept Only)[/HEADING]  
  
I use:  

- send.php → validation + send FCM
- status.php → store SMS status in MySQL
- check.php → validate user OTP

  
I’m not sharing those files because they are quite complex and customized.  
The goal of this post is simply to share the **minimal Android SMS gateway concept**.  
  

---

  
  
[HEADING=2]Final Thoughts[/HEADING]  
This setup allows you to:  

- Avoid external SMS providers
- Use an unlimited SMS SIM
- Fully control validation logic
- Build your own OTP system

  
It’s not meant to replace professional SMS gateways in production at scale — but for controlled environments or internal systems, it can be very powerful.  
  
  
I hope someone finds this useful 🙂  
Best regards.