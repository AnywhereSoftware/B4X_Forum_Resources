### [Web][SithasoDaisy5] Low Code Compact UI Design using Preference Dialog by Mashiane
### 09/18/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168688/)

Hi Fam  
  
A look at this third iteration..  
  
[MEDIA=youtube]LnnTPvhG9w0[/MEDIA]  
  
[Check the Demo Here](https://sithaso-daisy5-low-code-address-boo.vercel.app/)  
  
  
![](https://www.b4x.com/android/forum/attachments/167011)  
  
Preference Dialog nicely hosted on the right…  
  
![](https://www.b4x.com/android/forum/attachments/167012)  
  
Building user-friendly applications often means balancing **screen real estate** with **data entry efficiency**. In the third iteration of the Low Code Address Book, we’ve taken a major step toward creating a **compact, elegant design** — powered by **preference dialogs** and **IndexedDB**.  
  
This release focuses on improving usability for developers and end users who need quick data access without leaving the context of their work.  
  
  

---

  
  
[HEADING=1]From Modals to Preference Dialogs[/HEADING]  
  
In the first version of this project, we used a modal dialog. In the second version, we moved toward full-screen forms for large data entry scenarios. Now, in version three, we’re introducing a **preference dialog approach** — ideal for applications where space is limited, but data input must remain efficient.  
  
[HEADING=2]What Is a Preference Dialog?[/HEADING]  
  
A preference dialog is a lightweight, column-based panel that appears alongside your main table. Rather than blocking the entire UI, it **slides in from the right**, allowing users to keep their data table visible while they add or edit records.  
  
This pattern is perfect for:  

- **Quick edits** without losing context.
- **Compact layouts** where the user can keep an eye on existing data while entering new information.
- **Applications like help desks**, where agents need to switch between lists and forms rapidly.

  

---

  
  
[HEADING=1]Key Features in Version 3[/HEADING]  
  
Here’s what’s new and improved:  
  
[HEADING=2]🔄 Column-Aware Layouts[/HEADING]  
  
When you click **Add**, the table automatically resizes to show only the first column and make space for the preference dialog. This keeps the layout compact while giving enough room for data entry.  
  
[HEADING=2]🧭 Enhanced Navigation & Search on Main Page[/HEADING]  

- **Dynamic Search Bar:** The search field now adapts based on the active table (Contacts, Categories, Provinces).
- **Key Event Handling:** We can trap key-up events, backspace, and clear events to provide a responsive search experience.
- **Right-Side Components:** We’ve added the ability to place buttons, text, or select boxes on the right side of the navigation bar for extra functionality.

  
[HEADING=2]🖼 Visual & UX Enhancements[/HEADING]  

- **Drawer Improvements:** Items now have icons and a matching activation color based on the navigation bar background.
- **Rounded Drawer Items:** Cleaner, modern look with soft corner radius.
- **Responsive Drawer Behavior:** Opens automatically on medium and large screens; toggleable on small devices with a hamburger button.

[HEADING=2]♻️ Refresh Column Visibility for Tables[/HEADING]  
  
A new **RefreshColumnVisibility** method restores column visibility to its default state after modifications — helpful when users hide or show columns manually and then refreshes.  
  
[HEADING=2]📋 Data Entry Enhancements - Add functionality on Preference Dialog.[/HEADING]  

- **Inline Category/Province Creation:** Adding a new category or province automatically updates both the table and the dropdowns.
- **Validation Improvements:** Required fields are clearly marked, and validation ensures all mandatory data is captured.
- **Cloning Support:** Records can be cloned with a single click, then modified as needed.

  

---

  
  
[HEADING=1]Developer Experience Updates - updates on the Low Code Generator[/HEADING]  
  
We’ve also made improvements for developers working with the Low Code Generator:  

- **UsePreferences Option:** Developers can now choose between modal-based, full-screen, or preference-dialog layouts when generating code.
- **Consistent Naming:** Methods are written in human-readable, descriptive names (buildPreferencesDialog, refreshColumnVisibility, computeCategoryName), making the code self-explanatory.
- **Generated Code as a Starting Point:** While the tool provides working source code, developers are encouraged to enhance and customize it to suit their project’s needs (e.g., adding data integrity checks or unique constraints).

  

---

  
  
[HEADING=1]Why This Matters[/HEADING]  
  
This iteration is all about **compact design and developer flexibility**. By keeping the table visible while editing, users can:  
  

- Work faster with less context switching.
- View reference data while entering new records.
- Use smaller devices more effectively thanks to responsive resizing.

  
Meanwhile, developers get a **consistent, low-code-friendly codebase** with clear extensibility points.  
  
  

---

  
  
[HEADING=1]What’s Next[/HEADING]  
  
Our next step will be to:  
  
  

- Add **data integrity rules** to prevent duplicates.
- Improve **responsiveness for small devices** (ensuring the drawer toggles cleanly).
- Provide **additional layout presets** so developers can pick the best UX pattern for their use case.

  
The ultimate goal remains the same: enable developers to focus on **business logic**, not boilerplate code, while delivering a polished, professional user experience.  
  
Enjoy and have fun!