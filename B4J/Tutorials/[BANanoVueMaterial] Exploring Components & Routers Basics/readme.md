### [BANanoVueMaterial] Exploring Components & Routers Basics by Mashiane
### 06/12/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/118959/)

Ola  
  
![](https://www.b4x.com/android/forum/attachments/95602)  
  
The current methodology of adding pages to the BVM app is throught .AddPage method and we are using the v-show directive to show and hide pages.  
  
So I decided to start on the basics of components and routers. In terms of the VueJS documentation, a component is a Vue instance that cane have its own methods, own data bindings etc,  
  
In this example we create 2 components and 2 routers. To display the router page we use a router view component. In one component we detect a mouse enter and mouse leave event and link that own methods for that component. To define each component, we use a B4J code module.  
  
Both the router page and component are based on the VMComponent class we have created.  
  
Note that with this we have indicated a history mode meaning that we can go back and forth based on the internet explorer navigation.