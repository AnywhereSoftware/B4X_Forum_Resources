###  B4XDaisySteps - A modern, responsive, and highly customizable progress stepper by Mashiane
### 04/03/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170743/)

Hi everyone!  
  
I’m excited to share **B4XDaisySteps**, a new UI component designed to simplify how you manage multi-step processes in your B4X projects (B4A, B4i, B4J). Heavily inspired by the **DaisyUI** and **Tailwind CSS** ecosystems, this component brings a clean, modern aesthetic to your native applications.  
Whether you're building a checkout flow, a setup wizard, or a complex onboarding process, **B4XDaisySteps** provides the professional look and feel your users expect.  
  
![](https://www.b4x.com/android/forum/attachments/170998) ![](https://www.b4x.com/android/forum/attachments/170999) ![](https://www.b4x.com/android/forum/attachments/171000)  
  
**Key Features:**  

- **Fully Responsive:** Easily switch between **horizontal** and **vertical** orientations.
- **DaisyUI Color Variants:** Supports standard semantic colors like primary, secondary, accent, info, success, warning, and error.
- **Active Step Highlighting:** Automatically highlight completed steps up to a specific index using your chosen ActiveColor.
- **Custom Icons & SVGs:** Add text, emojis, or even **custom SVG icons** directly from your Files folder into the step circles.
- **Smart Scrolling:** If you have many steps, enable the Scrollable property to ensure they fit perfectly in any container.
- **Flexible Layouts:** Control padding, margins, and component sizing using familiar Tailwind-style spacing tokens.
- **Interactive:** Built-in StepClick event allows users to interact with specific steps in the process.

**Simple Usage Example:  
  

```B4X
' Initialize and add to your layout  
Dim stepsDemo As B4XDaisySteps  
stepsDemo.Initialize(Me, "steps")  
stepsDemo.AddToParent(Root, 10dip, 10dip, 300dip, 150dip)  
  
' Add steps with different styles and icons  
stepsDemo.AddStep("Register", "primary")  
stepsDemo.AddStepWithIcon("Plan", "primary", "📅")  
stepsDemo.AddStepWithSvgIcon("Payment", "secondary", "credit-card.svg")  
stepsDemo.AddStep("Done", "success")  
  
' Highlight the current progress (0-based index)  
' This highlights the first two steps with the "accent" color  
stepsDemo.ActiveStep = 1   
stepsDemo.ActiveColor = "accent"  
  
' Refresh the component to apply changes  
stepsDemo.Refresh
```

  
  
Check out the screenshots below to see it in action across different orientations and styles! I hope you find this useful! Let me know if you have any feedback or feature requests.  
  
  
[MEDIA=youtube]5T0Z7AQLVdc[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**