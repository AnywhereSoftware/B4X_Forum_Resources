### [Web][SithasoDaisy] Creating a Product Listing by Mashiane
### 10/16/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/155236/)

Hi  
  
By the end of this tutorial, you will be able to create this output.  
  
![](https://www.b4x.com/android/forum/attachments/146920)  
  
1. We use a grid with 3 columns so that we can have each product.  
  
Code Module is: pgBasicCardsMultiple on the SithasoDaisyDemo App.  
  
Add a SDUIPage in a layout and set these properties. Other properties should be blank/unchecked  

- Set the page name to be basiccards
- Set Gap = 3
- Grid should be checked
- Grid Cols = 1
- Set Device Grid Cols = xs=?; sm=12; md=3; lg=3; xl=3
- Set Paddings = a=5; x=?; y=?; t=?; b=?; l=?; r=?

We then create the layout for the product. We will use a single layout and then use BANano.**LoadLayoutArray**  
  
we call this layout, **eachcardlayout.** This is the basic card layout.  
  
![](https://www.b4x.com/android/forum/attachments/146921)  
  
Please note the settings for the controls.