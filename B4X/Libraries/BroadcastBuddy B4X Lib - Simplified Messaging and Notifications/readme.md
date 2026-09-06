###  BroadcastBuddy B4X Lib - Simplified Messaging and Notifications by Claude Obiri Amadu
### 09/02/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164970/)

**Hello B4X Community,**  
  
We’re thrilled to introduce the official **BroadcastBuddy B4X SDK**, a modern cross-platform library (compatible with **B4A**, **B4J**, and **B4i**) that integrates with the BroadcastBuddy WhatsApp Gateway API.  
  
**What is BroadcastBuddy?**  
BroadcastBuddy is a high-speed WhatsApp Gateway platform that turns your WhatsApp number into an automated messaging hotline. Connect via 8-digit phone pairing (no QR code scanning required) or QR scan, and send transactional notifications, interactive polls, PDF invoices, images, and locations directly from your B4X apps.  
  
**Key Features:**  

- **100% B4X Multiplatform** — Works across B4A (Android), B4J (Desktop & Server apps), and B4i (iOS).
- **Async Resumable Subs** — Built on [ICODE]Wait For[/ICODE] with no UI freezing.
- **Text & Rich Formatting** — Bold, italic, strikethrough, and monospace message delivery.
- **Interactive Polls** — Send single-choice or multi-choice WhatsApp polls.
- **Media Streaming** — Send images (JPG/PNG/WebP), PDF invoices, audio voice notes, and documents from URLs or Base64.
- **GPS Pins & Contact Cards** — Send live location pins and vCards.
- **Number Verification** — Verify if a customer phone number is registered on WhatsApp before dispatching broadcasts.
- **Hotline Connection Status** — Monitor live connection states in real time.

  
—  
  
**Class Overview (BroadcastBuddy.bas):**  
  
[ICODE]Public Sub Initialize(apiKey As String)[/ICODE]  
[ICODE]Public Sub SendMessage(phone As String, message As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub SendPoll(phone As String, question As String, options As List, isMultiSelect As Boolean) As ResumableSub[/ICODE]  
[ICODE]Public Sub SendImage(phone As String, imageSource As String, caption As String, filename As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub SendDocument(phone As String, docSource As String, filename As String, caption As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub SendAudio(phone As String, audioSource As String, filename As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub SendLocation(phone As String, latitude As Double, longitude As Double, name As String, address As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub SendContact(phone As String, contactName As String, contactPhone As String, organization As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub ScheduleMessage(phone As String, message As String, scheduledIsoTime As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub SessionStatus As ResumableSub[/ICODE]  
[ICODE]Public Sub IsOnWhatsApp(phone As String) As ResumableSub[/ICODE]  
[ICODE]Public Sub GetNumberId(phone As String) As ResumableSub[/ICODE]  
  
—  
  
**How to Get Started:**  
1. Create an account on [Broadcast Buddy](https://broadcastbuddy.app).  
2. Link your WhatsApp hotline (via pairing code or QR scan).  
3. Copy your Session API Key from the dashboard.  
4. Add [ICODE]BroadcastBuddy.bas[/ICODE] to your B4X project and reference the [ICODE]jOkHttpUtils2[/ICODE] (or [ICODE]OkHttpUtils2[/ICODE]) and [ICODE]JSON[/ICODE] libraries.  
  
—  
  
**Example Usage:**  
  

```B4X
Sub Process_Globals  
    Private buddy As BroadcastBuddy  
End Sub  
  
Sub AppStart (Args() As String)  
    Dim apiKey As String = "bb_live_YOUR_API_KEY"  
      
    buddy.Initialize(apiKey)  
      
    ' 1. Check live hotline status  
    Wait For (buddy.SessionStatus) Complete (statusRes As Map)  
    Log("Hotline Status: " & statusRes)  
      
    ' 2. Verify recipient number on WhatsApp  
    Wait For (buddy.IsOnWhatsApp("233240001122")) Complete (checkRes As Map)  
    Log("Is on WhatsApp: " & checkRes.Get("exists"))  
      
    ' 3. Send a text message  
    Wait For (buddy.SendMessage("233240001122", "🚀 Hello from BroadcastBuddy B4X Library!")) Complete (msgRes As Map)  
    Log("Message Sent: " & msgRes.Get("success"))  
      
    ' 4. Send an interactive multi-choice poll  
    Dim pollOptions As List  
    pollOptions.Initialize  
    pollOptions.Add("Option A: B4A Mobile")  
    pollOptions.Add("Option B: B4J Server")  
    pollOptions.Add("Option C: B4i iOS")  
      
    Wait For (buddy.SendPoll("233240001122", "Which B4X platform do you use most?", pollOptions, False)) Complete (pollRes As Map)  
    Log("Poll Sent: " & pollRes.Get("success"))  
      
    ' 5. Send an image with caption  
    Wait For (buddy.SendImage("233240001122", "https://example.com/receipt.png", "Your Payment Receipt #1092", "receipt.png")) Complete (imgRes As Map)  
    Log("Image Sent: " & imgRes.Get("success"))  
      
    ' 6. Send a PDF invoice  
    Wait For (buddy.SendDocument("233240001122", "https://example.com/invoice.pdf", "Invoice_2026.pdf", "Your monthly invoice")) Complete (docRes As Map)  
    Log("Document Sent: " & docRes.Get("success"))  
End Sub
```

  
  
—  
  
**Official Links:**  
[Website: Broadcast Buddy](https://broadcastbuddy.app)  
[API Documentation](https://broadcastbuddy.app/docs)  
[GitHub Repository](https://github.com/Broadcast-Buddy/broadcast-buddy)