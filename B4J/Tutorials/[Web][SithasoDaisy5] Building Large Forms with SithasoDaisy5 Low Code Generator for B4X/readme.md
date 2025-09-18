### [Web][SithasoDaisy5] Building Large Forms with SithasoDaisy5 Low Code Generator for B4X by Mashiane
### 09/17/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168669/)

Hi Fam  
  
[SithasoDaisy5 Low Code Address Book 2 Demo on Vercel](https://sithaso-daisy5-low-code-address-boo.vercel.app/)  
  
[Experience it for youself (SithasoDaisy5 Low Code Generator)](https://sithaso-daisy5-low-code.vercel.app/)  
  
In the latest update to **SithasoDaisy5 Low Code Generator**, we’ve focused on addressing a common challenge in application development: creating **large, full-screen forms** that allow for more comprehensive data input without sacrificing usability. If you’re building complex applications, like an address book with multiple fields, this version demonstrates how to effectively design forms that dominate the screen while keeping your layout intuitive.  
  
![](https://www.b4x.com/android/forum/attachments/166931)  
  
[SIZE=6]**Why Large Forms Matter**[/SIZE]  
  
Small modal forms are ideal for quick data entry, but when your forms need to capture a significant amount of information—such as full contact details, addresses, categories, and provinces—a small modal simply won’t suffice. Large forms offer:  
  

- **More space for fields**: Display all relevant inputs on one screen without overwhelming the user.
- **Better accessibility**: Users with vision or accessibility needs benefit from larger, clearer interfaces.
- **Smooth data management**: Embed the form in the page layout itself for seamless interaction.

  
[HEADING=1]New Form Design in SithasoDaisy5[/HEADING]  
  
Previously, forms in our low-code generator were modal-based. In this version, forms can now be **embedded as cards within the page** or displayed **full-screen** as needed. Here’s what’s new:  

- **Form as a card**: The form appears embedded in the page layout rather than floating above it. This makes the interface feel more integrated and natural.
- **Full-screen forms**: A single property allows forms to occupy the entire screen, ideal for data-heavy pages.
- **Dynamic hiding/showing of tables**: When a user clicks “Add,” the relevant form shows up, while the underlying table hides, keeping the interface clean and focused.
- **Fake data generation**: For testing and demonstration, the system can populate forms with realistic fake data, including names, phone numbers, emails, categories, and addresses. This ensures you can visualize the final app without manually entering records.

[SIZE=6]**Navigation and User Experience Updates**[/SIZE]  
  
To support the new forms, we restructured the navigation system for our Address Book Low Code example, which will be applicable to all apps.  
  

- **Contacts section**: Separate actions for “Add Contact” and “List Contacts.”
- **Category and Province management**: Add or list categories and provinces directly from the navigation menu.
- **Action-based rendering**: Pages now interpret actions (Add, List) and render the appropriate form or table dynamically.

![](https://www.b4x.com/android/forum/attachments/166932)  
  

```B4X
Sub CreateDrawerMenu  
    drawermenu.AddItemParent("", "contacts", "", "Contacts")  
    drawermenu.AddItemChild("contacts", "contacts-add", "", "Add Contact")  
    drawermenu.AddItemChild("contacts", "contacts-list", "", "List Contacts")  
    '  
      
    drawermenu.AddItemParent("", "categories", "", "Categories")  
    drawermenu.AddItemChild("categories", "categories-add", "", "Add Category")  
    drawermenu.AddItemChild("categories", "categories-list", "", "List Categories")  
    '  
    drawermenu.AddItemParent("", "provinces", "", "Provinces")  
    drawermenu.AddItemChild("provinces", "provinces-add", "", "Add Province")  
    drawermenu.AddItemChild("provinces", "provinces-list", "", "List Provinces")  
End Sub
```

  
  
  
This approach gives developers the flexibility to **control what users see**. For instance, some users may only have permissions to add entries, while others can view the full list.  
  
  
[HEADING=1]How It Works: The Code Behind the Scenes[/HEADING]  
  
The underlying code has been refactored to handle the new design:  
  

1. **Action variable**: Determines if the page is in ADD or LIST mode.
2. **Column-centered layout**: Ensures embedded forms are perfectly aligned.
3. **Model-to-card transformation**: The same components used in modals now work as embedded cards, maintaining consistent behavior while adapting to larger screens.
4. **Seamless toggling**: Clicking “Add” switches to the form view, while clicking “Cancel” returns to the table.

  
These changes make it easier to create **master-detail layouts** and **complex data entry workflows**.  
  

```B4X
Private Sub drawermenu_ItemClick (item As String)  
    appnavbar.Visible = True  
    'close the drawer  
    appdrawer.OpenDrawer(False)  
    'close the swap button  
    appnavbar.Hamburger.Active = False  
    pageView.PaddingAXYTBLR = "a:10px"  
    App.PageViewToFullScreenHeight(Array("appnavbar"))  
    '  
    Dim sprefix As String = App.UI.MvField(item, 1, "-")  
    Dim ssuffix As String = App.UI.MvField(item, 2, "-")  
    'only mark this item as active  
    BANano.Await(drawermenu.SetItemActive(item))  
    '          
    Select Case sprefix  
    Case "categories"  
        Select Case ssuffix  
        Case "add"  
            pgCategories.action = "A"  
            pgCategories.Show(App)  
            Return  
        Case "list"      
            pgCategories.action = "L"  
            pgCategories.Show(App)  
            Return  
        End Select  
    Case "provinces"  
        Select Case ssuffix  
        Case "add"  
            pgProvinces.Action = "A"  
            pgProvinces.Show(App)  
            Return  
        Case "list"  
            pgProvinces.Action = "L"  
            pgProvinces.Show(App)  
            Return  
        End Select  
    Case "contacts"  
        Select Case ssuffix  
        Case "add"  
            pgContacts.Action = "A"  
            pgContacts.Show(App)  
            Return  
        Case "list"  
            pgContacts.Action = "L"  
            pgContacts.Show(App)  
            Return  
        End Select  
    End Select  
End Sub
```

  
  
[HEADING=1]Benefits for B4X Developers[/HEADING]  

- **Improved testing**: The fake data generator lets you see how the app behaves with multiple records.
- **Flexible UI design**: Choose between modal, embedded card, or full-screen forms depending on the user experience you want.
- **Simplified code generation**: The low code tool generates updated B4X code reflecting all these changes automatically.
- **Enhanced user accessibility**: Full-screen forms cater to users who need larger, more readable interfaces.

```B4X
'lets generate fake data…  
    Dim fake As SDUI5FakeIT  
    fake.Initialize  
    fake.FullName = True  
    fake.Phone = True  
    fake.Gmail = True  
    fake.Street = True  
    fake.Street2 = True  
    fake.City = True  
    fake.Mobile = True  
    fake.ZipCode = True  
    fake.State = True  
    'get a single record  
    Dim fakeRec As FakeData = BANano.Await(fake.GetSingle)  
    Log(fakeRec)  
      
    Dim lcategories As List = App.UI.MapKeysToList(CategoriesObject)  
    Dim scategory As String = fake.Rand_Item(lcategories)  
      
    Dim lprovinces As List = App.UI.MapKeysToList(ProvincesObject)  
    Dim sprovince As String = fake.Rand_Item(lprovinces)  
      
    txtId.Value = -1  
    txtFullname.Value = fakeRec.fullname  
    txtMobile.Value = fakeRec.mobile  
    txtTelephone.Value = fakeRec.phone  
    txtEmailaddress.Value = fakeRec.gmail  
    cboCategory.Value = scategory  
    txtStreetaddress1.Value = fakeRec.Street  
    txtStreetaddress2.Value = fakeRec.Street2  
    txtCity.Value = fakeRec.city  
    cboProvince.Value = sprovince  
    txtPostalcode.Value = fakeRec.zipcode  
    txtState.Value = fakeRec.state
```

  
[HEADING=1][/HEADING]  
[HEADING=1]Conclusion[/HEADING]  
  
With **SithasoDaisy5 Low Code Generator**, B4X developers can now design more **robust, user-friendly forms** without manual coding. Version 2 of the *Address Book Low Code Example* demonstrates the power of combining **low code automation, fake data testing, and flexible UI layouts** to create professional applications efficiently.  
  
Whether you are building a detailed address book, a master-detail application, or any data-heavy interface, this update gives you the tools to deliver forms that are both **functional and visually appealing**.  
  
Have fun  
  
Mashy