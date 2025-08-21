### Print PDF library supports higher resolution by MitchBu
### 05/18/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/117914/)

I was trying to use the PDF printing library discussed at <https://www.b4x.com/android/forum/threads/printing-and-pdf-creation.76712/> but pictures were terrible.  
  
The values posted as example are for a resolution of 72dpi, which is quite inadequate.  
  
Here is what I do to get 300dpi printing:  

```B4X
pdf.StartPage((611/72) * 300, (765/72) * 300) 'Letter size  
'pdf.StartPage((595/72)*300, (842/72) * 300) 'A4 size
```

  
  
I picked 300dpi, since it is today the minimum resolution that regular printers offer.  
  
Of course, all values such as picture size, left and top, as well as text size for labels and EditText, must be modified the same way.  
An easier way to compute is to use the 4.166 factor. For instance:  

```B4X
left = left * 4.1666
```