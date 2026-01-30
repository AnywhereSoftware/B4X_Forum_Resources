### Marge AAR (Subpackage folder) and JAR together by Peter Simpson
### 01/25/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170097/)

Hello B4A wrappers,  
Including an AAR file alongside your wrapped JAR and XML files can be a bit of a pain to do every time, especially as you’ve already removed the classes.jar file to add to your wrapper’s **libs** folder, yet the AAR still contains its own classes.jar as well. There are, of course, a number of manual ways to merge the files you need from the AAR into your newly created JAR.  
  
**My solution:**  
Unlike other previous approaches I’ve used, this solution takes less than a minute to complete. I’ve tested this solution with four of my wrappers that rely on AAR files, and it passed with flying colours.  
  
**Please note:**  
This solution will **not** work if your wrapper relies on layouts, drawables or styles that are embedded within the AAR file. In those cases you must keep the original AAR included in the B4A AdditionalLibs folder.  
  
Apart from those specific scenario, the attached streamlined app approach should work reliably for your wrappers, which I believe will cover most cases.  
  
This merge solution comes with **absolutely no guarantees**. It works for me, so I wanted to share it with the community. I used this approach when releasing the USBSerialEnhanced library on the forum.  
  
**Merge AAR Jar screenshot**  
![](https://www.b4x.com/android/forum/attachments/1768179255372-png.169318/)  
  
**Instructions on how to use it:**  

1. Download the attached B4J project
2. Create your B4A library as usual (I use SLC), making sure that the aar files are in your additional libraries folder, and are referenced in the @DependsOn annotation in your xml file
3. Run the attached B4J code project
4. Select your project aar and jar files from your additional libraries folder
5. Type the **Subpackage** name from your B4A java wrapper code (the import related to the aar file), **look** at the image below
6. Click on the 'Merge AAR to Jar' button and that should be it

The **Subpackage name** '**hoho'** highlighted in red below, is the name that I used in the USBSerialEnhanced library.  
![](https://www.b4x.com/android/forum/attachments/1768179946579-png.169319/)  
  
The full code process is as follows, from the moment you click the merge button.  

1. **Validate inputs** (AAR, JAR, folder name).
2. **Create temporary folders.**
3. **Copy the selected AAR** into a temp folder as lib.aar.
4. **Call** jar xf lib.aar > extract the entire AAR.
5. **Copy** classes.jar out of that.
6. **Call** jar xf classes.jar com/<folder> > extract that package tree.
7. **Call** jar uf <your slc jar> … > merge the extracted classes into your SLC JAR.
8. **Edit the XML next to the JAR:** remove <dependsOn> for the AAR you just merged.
9. **Cleans** the temporary directories.
10. **Show success message**.

  
**Enjoy…**