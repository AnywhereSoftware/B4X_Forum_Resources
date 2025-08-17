### [B4X, B4xPages]Using the Standard B4XPreferenceDialog Library with B4XPages to Create Effective Forms by William Lancee
### 01/27/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/145731/)

If you are in a hurry, or if you don't want to design your own form, you can use the standard PreferencDialog  
in combination with FormsBuilder to create a pretty nice form, one form per B4XPage.  
<https://www.b4x.com/android/forum/threads/b4x-forms-builder-designer-for-b4xpreferencesdialog.104670/>  
  
This work was inspired by the recent wish expressed by [USER=105784]@José J. Aguilar[/USER]  
<https://www.b4x.com/android/forum/threads/adapt-b4xpreferences-forms-to-load-into-a-b4xpage-instead-into-a-dialog.145685/>  
  
The principle behind this technique is to find ways of hiding the dialog foundation of the preferences CLV,  
as well as to have more control over verification of answers.  
  
This tutorial will show you how.  
  
Here is my sample form. The B4XPage class is called ExampleForm, titled "Sample Form". I created example.json with FormsBuilder.  
  
![](https://www.b4x.com/android/forum/attachments/138547)  
  
It doesn't look like a standard PreferenceDialog, but it is.  
The title and buttons are empty strings. The colors are all set to the color of the form.  
  
How can you Press OK when it isn't shown? How does the PreferenceDialog know it is finished?  
When the B4XPage\_CloseRequest is fired, I call prefdialog.Dialog.Close.  
Before leaving the page, verification of answers takes place and if not valid the PreferenceDialog is shown again.  
  
All of this is seemless. The user is informed of invalid answers, when OK to that message is pressed, a nifty wiggling  
of the prompt draws attention to the item. I copied the wiggling sub from the PreferenceDialog source.  
  
If all answers are present and valid, the form closes and the Example\_Closed sub is called in the calling program.  
This Sub can access the data and decide on further actions.  
  
In the sample form I choose to leave the navigation to B4XPages, but you can remove the title panel and add your own buttons.  
Search the Forum for information how to do that.  
  
There are some bells and whistles that show how to make specific validity tests.  
These tests are done inside the form module, keeping most of the logic in one module.  
I have implemented a Maximum Tries parameter. Otherwise the user could not leave an invalid form (at least in B4J without using Task Manager).  
  
You can unzip the B4XPages project and run it. It works in B4J and B4A (set for landscape or set for portrait).  
Take a close look at the ExampleForm module. It has some features you may like to use in other situations.