###  B4XDaisyStatus - Animated Status Indicators inspired by DaisyUI by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170419/)

Hi Fam  
  
I am excited to share B4XDaisyStatus, a new cross-platform custom view for B4X (B4A, B4J, B4i) that brings modern, semantic status indicators to your applications. Inspired by the DaisyUI status component, this view is perfect for showing online/offline states, notification alerts, or system health with minimal setup.  
  
![](https://www.b4x.com/android/forum/attachments/170236)  
  
  
**Key Features**  
• **5 Sizes:** xs, sm, md (default), lg, xl.  
• **Semantic Variants:** neutral, primary, secondary, accent, info, success, warning, error.  
• **Built-in Animations:**  
 ◦ pulse: A "ping" effect ideal for server status or live indicators.  
 ◦ bounce: A gentle bounce effect for notifications (e.g., "Unread messages").  
• **Designer Support:** Fully configurable via the Designer property bag.  
**Usage**  
1. **Designer:** Add a B4XDaisyStatus to your layout. You can set the Variant (color), Size, and Animation directly in the properties window.  
2. **Code:** You can also add and manipulate the status view programmatically.  
  

```B4X
' Initialize the status view  
Dim status As B4XDaisyStatus  
status.Initialize(Me, "status")  
  
' Set properties  
status.setVariant("success") ' Options: success, warning, error, info, etc.  
status.setSize("md")         ' Options: xs, sm, md, lg, xl  
status.setAnimation("pulse") ' Options: none, pulse, bounce  
  
' Add to a parent view (e.g., a Panel)  
status.AddToParent(pnlContainer, 0, 0, 0, 0)   
status.CenterInParent(pnlContainer)  
  
Example: Server Status Indicator The following snippet demonstrates how to toggle a status indicator between "success" (online) and "error" (offline) states:  
' Toggle server state  
mServerOnline = Not(mServerOnline)  
  
' Update the status component  
If mServerOnline Then  
    MyStatusView.setVariant("success")  
    lblState.Text = "Server is Online"  
Else  
    MyStatusView.setVariant("error")  
    lblState.Text = "Server is Down"  
End If[/dode]  
  
  
  
https://youtu.be/dHrG0cxKK0M  
  
Related Content  
  
https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/
```