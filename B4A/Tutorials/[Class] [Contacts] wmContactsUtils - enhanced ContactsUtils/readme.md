###  [Class] [Contacts] wmContactsUtils - enhanced ContactsUtils by walt61
### 10/12/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/130274/)

This is an enhanced version based on [USER=1]@Erel[/USER] 's [ContactsUtils v1.20](https://www.b4x.com/android/forum/threads/class-contactsutils-provides-read-write-access-to-the-stored-contacts.30824/).  
  
NOTE: DeleteContact didn't work on an Amazon Fire tablet with Android 5.1.1 but did on a Moto X Style phone with Android 7. I wasn't able to find the cause; possibly it's related to the ROM I installed on that tablet or to the older Android version - no idea. No error was returned and 'cr.Delete' returned 1 indicating that the deletion had taken place; the contact was just still there after the call.  
  
**Changes to ContactsUtils v1.20 code (all changes are marked with a 'WM' comment in the code):**  
- Private Sub GetKeyFromValue: changed the lookup to be case-insensitive  
- Private Sub SetData: small changes that don't impact existing code  
- Public Sub DeleteContact: added return type Int that shows how many contacts were deleted  
  
**New public methods from or based on ddahan's code from <https://www.b4x.com/android/forum/threads/create-contact-missing-fields.40791/>:**  
- AddOrganization: Adds an organisation to a contact  
- AddPhoto: Adds a photo to a contact from a bitmap  
- AddPostalAddress: Adds an unstructured postal address for a contact  
- AddPostalAddress1: Adds an unstructured postal address for a contact  
- GetDetailedName: Returns Detailed Contact Name as cuContactName  
- GetOrganization: Returns a contact's organisation data as a cuOrganization item  
- GetPostalAddresses: Returns a List with cuPostalAddr items  
- GetPostalAddresses1: Returns a Map with the postal addresses as keys and the address types as values  
- InsertContactWithDetailedName: Inserts a new contact and returns the cuContact object of this contact  
- SetOrganization: Sets a contact's organisation  
- SetPhoto: Sets a contact's photo from a bitmap  
- SetPostalAddress: Sets an unstructured postal address for a contact  
  
**New public methods added by me:**  
- AddEvent: Adds an event field to the given contact id; Events are only available as of Android API level 5  
- AddIM: Adds an IM field to the given contact id  
- AddNickname: Adds a nickname field to the given contact id  
- AddPostalAddress2: Adds a structured postal address  
- AddWebsite: Adds a website field to the given contact id  
- DeleteContact2: Deletes the contact with the given id and catches errors  
- DeleteWebsite: Deletes the given website  
- FindContactsByGroupName: Returns all contacts that are member of the specified group name  
- FindContactsByGroupRowId: Returns all contacts that are member of the specified group Row ID  
- GetAllGroupsByRowId: Returns a map with all groups; the key is the group's Row ID, the value is the group name  
- GetAllGroupsByRowName: Returns a map with all groups; the key is the group name, the value is the group Row ID  
- GetAllGroupsBySourceId: Returns a map with all groups; the key is the group's source ID, the value is the group name (you probably shouldn't be using this one, but use GetAllGroupsByRowId instead)  
- GetAllGroupsBySourceName: Returns a map with all groups; the key is the group name, the value is the group source ID (you probably shouldn't be using this one, but use GetAllGroupsByRowName instead)  
- GetAllContactsThunderbird: Returns all contacts as a list of cuContactDetailsThunderbird items (this is a Type I added which I needed for another project)  
- GetContactDetailsThunderbird: Returns a contact's data as a cuContactDetailsThunderbird item  
- GetFullSizePhoto: Returns the full size photo of the given contact; returns an uninitialized bitmap if no photo is available  
- GetIMs: Returns a List with cuIM items  
- GetNicknames: Returns a List with cuNickname items  
- GetWebsites: Returns a List with cuWebsite items  
- SetDisplayName: Sets an existing contact's DisplayName  
- SetPhotoFromFile: Sets a contact's photo from a file  
  
Enjoy !  
  
**Updates:**  
- 2021-10-12: bug fix in the new methods, attached class updated  
- 2021-10-12: added methods FindContactsByGroupRowId, FindContactsByGroupName, GetAllGroupsByRowId, GetAllGroupsByRowName, GetAllGroupsBySourceId, GetAllGroupsBySourceName  
- 2021-06-24: added method DeleteContact2