### ContactsUtils v2.00 : redesigned, recoded and enhanced new version by Alain75
### 06/04/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/148312/)

Hi everybody,  
  
[JUSTIFY]I worked a lot on ContactsUtils library (from [USER=55689]@walt61[/USER]) since [my last post at the end of January](https://www.b4x.com/android/forum/threads/add-firstname-lastname-in-contactsutils-and-add-sort-column-in-findallcontacts.144373/#post-924573). I redesigned, recoded and enhanced the library. Below is a summary of the modifications:[/JUSTIFY]  

1. **Initialize has now 4 (string) parameters**which can all be passed empty:

- [JUSTIFY]**AccountType** and **AccountName** allow to filter automatically all find and get functions and are also used when creating a contact or group.[/JUSTIFY]
- [JUSTIFY]**CustomFilter** enables to set a particular selection which will be added to selection of find and get functions (when not empty, the 2 previous parameters will not be used in find and get functions).[/JUSTIFY]
- [JUSTIFY]**CustomDisplay** enables to replace standard Android DisplayName. The parameter must contain “%firstname” and/or “%lastname”.[/JUSTIFY]

2. New function **SetTypes**allows to change "map Types" labels, enabling translation.

- [JUSTIFY]First parameter should be one among "address", "email", "event", "phone" and "website".[/JUSTIFY]
- [JUSTIFY]Second parameter defines values given in a string "xx1=value1,xx2=value2, …", first xx being the default. To reset all maps, if needed, Initialize function can be recalled. ContactsUtils uses this function itself to initialize map types. Just have a look at the end of the file ![/JUSTIFY]

3. [JUSTIFY]New functions **AddCustom**, **SetCustom** and **DeleteCustom** have been added to manage **Google personalized fields**.[/JUSTIFY]
4. [JUSTIFY]New function **GetContactInfos** delivers part or all information on a contact in a map parameter which keys identify the items: "address", "custom", "email", "event", "group", "job", "name", "note", "phone" and "website".[/JUSTIFY]
5. [JUSTIFY]Address, email, event, phone and website now support **Google personalized labels**: type value is zero and label is stored in "data3" field.[/JUSTIFY]
6. **Find functions** returning lists have been simplified (*sort option was suppressed because cursor sorting is not performant*) and now have only one string parameter “SelXXXX” which accepts joker characters (*operator is automatically set to LIKE in this case*):

- [JUSTIFY]**xxx%** to find items starting with xxx,[/JUSTIFY]
- [JUSTIFY]**%xxx** to find items ending with xxx (not very useful I agree),[/JUSTIFY]
- [JUSTIFY]**%xxx%** to find items containing xxx.[/JUSTIFY]

7. [JUSTIFY]**Most elementary items** are now defined with a cuXXXX object and include a **DataId** field which is the Id of the item, facilitating and securing its update or deletion.[/JUSTIFY]
8. [JUSTIFY]**SetNote** manages the standard Google note (*Android sets for each contact a note record whose text is set to null if not used*). Field DataId of cuNote is not used. Set field Text to empty to reset the note. **AddNote2**, **DeleteNote2** and **SetNote2** enable to manage as many other notes as desired.[/JUSTIFY]
9. **Most set and delete functions** now have only one parameter: the cuXXXX object associated with the field. Whereas add functions now have 2 parameters : the ContactId and the cuXXXX object
10. Most functions return **a return code:** the result of add, update or delete cursor action, except for the functions returning a list, its size being implicitly a return code.
11. **SetDisplayName function** has been deleted since the new parameter CustomDisplay of Initialize function and also because this field is deeply managed by Android.
12. Library has been a more "reorganized" in sections: definitions, find functions, add functions, create functions, delete functions, get functions, set functions and at least init functions. In each section, functions are in alphabetic order, public ones first then private ones.