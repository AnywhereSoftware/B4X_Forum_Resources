### FormsBuilder View by spsp
### 05/03/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130237/)

Hi,  
  
This is a tool to preview Preferences dialogs designed with Erel's Tool FormsBuilder on one or more devices at the same time.  
A practical way to see the result on different screen size, resolution and scale.  
  
  
2 projects :  
- B4A FormsBuilder View : Preview a preferencesDialog  
- B4J FormsBuilder View : A modified version of Erel's Tool (add connection to the B4A device)  
  
How it works ?  
1) launch both applications (B4J and B4A)  
2) B4J Enter the ip adrress(es) of your device(s)  
3) B4J Load/create a preference dialog  
4) B4J set the dimensions (dimensions are shown on the B4A device)  
- 300 means 300px (bad idea)  
- 300dip means …… 300dip  
- 80%x means 80% of the activity's width  
- 80%y means 80% of the activity's height  
5) B4J menu File/Preview (Ctrl+E) to view the result on the B4A devices.  
  
  
spsp