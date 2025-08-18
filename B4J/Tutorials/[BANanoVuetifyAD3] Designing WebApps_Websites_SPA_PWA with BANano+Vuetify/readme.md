### [BANanoVuetifyAD3] Designing WebApps/Websites/SPA/PWA with BANano+Vuetify by Mashiane
### 01/11/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/137525/)

Hi there  
  
This is a response to a thread post and I think it deserves its own place just to clarify something and give a background.  
  
1. Almost everything of what you see in the kitchen sink is done via the abstract designer without coding.  
  
![](https://www.b4x.com/android/forum/attachments/124064)  
  
<https://mashiane.github.io/BANanoVuetifyAD3/#/>  
  
2. Each custom view in the BVAD3 system is done based on the Vuetify API. For example, the API for an VAlert is here, <https://vuetifyjs.com/en/api/v-alert/#links>.  
This describes each attribute and what it does. This documentation already exists is available from the Vuetify Website.  
  
![](https://www.b4x.com/android/forum/attachments/124065)  
  
For example, producing this  
  
![](https://www.b4x.com/android/forum/attachments/124066)  
  
is possible through this code.  
  
![](https://www.b4x.com/android/forum/attachments/124067)  
  
3. This Vuetify API has been re-created as custom views which by changing properties you are able to produce the same result.  
  
![](https://www.b4x.com/android/forum/attachments/124068)  
  
As an example, check the **Dark** property comments (bottom) and also compare from the VuetifyAPI.  
  
![](https://www.b4x.com/android/forum/attachments/124071)  
  
  
4. The Vuetify Website has all the components with example source code. One clicks the <> button to view the source of any component.  
  
![](https://www.b4x.com/android/forum/attachments/124069)  
  
5. All of the Vuetify components (including additional ones) as available for the abstract designer. You design your UI based on the schema provided by Vuetify, e.g. put components inside another and set properties and after that generate events.  
  
![](https://www.b4x.com/android/forum/attachments/124070)  
  
6. To get an understanding of how BANano works, you can start here.  
  
<https://www.b4x.com/android/forum/threads/banano-for-dummies-by-example.108722/#content>  
  
**Original Post**  
  
<https://www.b4x.com/android/forum/threads/my-new-pwa-banano-vuetify.137474/post-870282>