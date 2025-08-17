### [BANano] How to Edit / Sign existing PDF Documents? by Mashiane
### 09/01/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/162854/)

Hi Fam  
  
I wanted to sign PDF documents in my product. So.. I used the [PDF-LIB](https://pdf-lib.js.org/) for this.  
  
1. I designed a screen to enter the signature and initials.  
  
![](https://www.b4x.com/android/forum/attachments/156514)  
  
2. The canvas we use stores the entered signature and initials as DataURL and I save it in the database. In actual sense this is just a collection of images that we will store in the database.  
  
3. We read the signature signed on the canvas as a DataURL and then pass it to the class below.  
  
4. Download the signed document.  
  
5. Below is an example of a signature made on an existing contract pdf document.  
  
![](https://www.b4x.com/android/forum/attachments/156515)