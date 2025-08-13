### B4J Codeviewer with simple search supporting multiple file extensions. by PaulMeuris
### 08/21/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/142461/)

In this tutorial you can learn how to make a codeviewer application.  
The application uses a webview for the viewing part and a textarea for the search part.  
In the webview the code is presented with the help of prism.css and prism.js (link: [Prism](https://prismjs.com/index.html)) or with w3.css (link: [W3Schools](https://www.w3schools.com/w3css/w3css_downloads.asp)).  
In the textarea the occurences of the search word list are displayed using the setselection method. This means that each occurence is selected one at a time. You can go to the next or previous occurence using the buttons. If the search is done on a non-html text then you can select the language 'html' and the css 'w3css' and press the view button to see all the occurences of the search.  
The content of the 0\_app\_description html text will first be shown in the viewer (using language 'html' and css 'w3css'). If you change the css to 'prism' then the markup of the text will be shown.  
The reset button takes the first filename in the combobox list and shows the code (or the content if it's the app\_description text).  
This is what it looks like:  
![](https://www.b4x.com/android/forum/attachments/132784)  
Searching for 'container' in the 0\_app\_description.html text… 8 occurences found…  
![](https://www.b4x.com/android/forum/attachments/132785)  
Searching for 'File' (case sensitive!) in the codeviewer.b4j file text showing all the occurences in the webview…  
![](https://www.b4x.com/android/forum/attachments/132786)  
Download the attached zip-file and unpack it to study how everything is done.  
Assignment question: there are 2 extensions in the code that are not described. Can you find out which 2 and what is so special about those 2 extensions?  
Happy coding!  
Paul.