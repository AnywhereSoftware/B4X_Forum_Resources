### [BANanoVuetifyAD3] Tree-Shaking your BVAD3 project with the BVAD3 Package Manager by Mashiane
### 02/21/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/138417/)

Hi there  
  
**[BETA]**  
  
[Download BANanoVuetifyAD3 Library Source Code](https://github.com/Mashiane/BANanoVuetifyAD3/blob/main/Library/BANanoVuetifyAD3.zip)  
[Download BANanoVuetifyAD3 Package Manager Source Code](https://github.com/Mashiane/BANanoVuetifyAD3/blob/main/Mashy%20Teaches%20BANanoVuetifyAD3/BVAD3PackageManager.zip)  
  
To avoid this topic being lost in translation, its standing alone.  
  
**What is the BVAD3 Package Manager?**  
  
The BANanoVuetifyAD3 library is quite large and at the current moment, even if your project does not include Google Maps for example, the css, js and component files for GMaps is included. This goes without saying for other Vuetify based components that you might not use. With that said, the plugins to BVAD3 compose about 5% or so as compared to more than 100 components that make BVAD3.  
  
Lets say you are creating a project, it does not need a VStepper or VTabs or VFAB etc, how do you ensure that these are not included in your final pack, whilst ensuring that you have a working project? Comes in the BVAD3 Package Manager. With the BVAD3 Package Manager, you choose what you will use on your project and it produces a b4xlib that is suitable for your project. You can create a default b4xlib schema and use this for most of your projects.  
  
Yes, it will create a b4xlib. Smaller. Faster, just to meet your needs. Lets say you created a project and named it **HelloWeb**. After running your project using the master BVAD3 b4xlib and your library, the newly created b4xlib will be **BVAD3HelloWeb.b4xlib**. You can then refer it on your libraries folder and continue using it to develop your project, after having chosen which components, js, css, images etc resources it will use.  
  
As this is a web application, due to security reasons it cannot access your PC directly, thus there is a final manual process that needs to be undertaken. This is downloading the generated b4xlib, adding it to your additional libraries folder and re-referencing it on your project (and remove the reference to the master b4xlib on your project).  
  
You can quickly get into the hang on the BVAD3 Package Manager in 5 simple steps.  
  
#SharingTheGoodness.  
  
PS: For now projects using VField are not fully supported out of the box. Equivalent of VField will have to be selected manually in Step 4. For example, if you used a VField and chose a TextField as a component type, in step 4, ensure you choose VTextField under form components.  
  
**Step 1**  
  
You can [download](https://github.com/Mashiane/BANanoVuetifyAD3/blob/main/External%20Libraries/BANanoVuetifyAD3.b4xlib) the latest b4xlib from Github or run it to compile the latest b4xlib. This is what you will have to upload to the package manager in Step 1.  
  
NB. The **actual b4xlib should be uploaded** and not the BANanoVuetifyAD3.zip library source.  
  
![](https://www.b4x.com/android/forum/attachments/125468)  
  
After uploading the b4xlib, click Next.  
  
**Ceveats**  
  

- The package manager will pick up items that are related. For example, if your project uses the VueTable, it will pick up the JSPDF classes because these are related.
- If your project uses the BANanoDataSource, it will pick up the FireBase related classes, BANanoPHP classes etc as these are related.
- In your subs signatures in your Project, add 'IgnoreDeadCode (just like 'ignore)
- Activate the RemoveDeadCode transpiler option.
- The generated b4xlib DOES NOT WORK (Not sure why as yet), thus download the zip and then run it to generate a b4xlib