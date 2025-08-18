### Webp - new options by drgottjr
### 12/16/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/136850/)

this is an update to [USER=31308]@Pendrush[/USER]'s image conversion library.  
  
i had my own personal utility for webp images.  
i thought i might post it as a library, but, on checking, i saw  
that member [USER=31308]@Pendrush[/USER] already had one. as it turns out,  
our code is mostly identical (there really aren't too many  
different ways to convert a bitmap from one format to  
another). there was, however, one big difference: the  
deprecation by google of the (plain, one-size-fits-all) webp  
bitmap format. it was replaced by a choice between  
webp lossless and webp lossy formats. my utility uses the  
newer format options.  
   
the 2-format option works like the 1-option jpg conversion  
function we are already familiar with where we supply the level  
of compression desired. why google had to use 2 different  
formats to achieve the same end as jpg's 1 is not for me to judge.  
perhaps its programmers - not unlike dickens - get paid by the method.  
in any case, the reduction in size (while retaining image quality)  
when using the lossy format is pretty amazing.  
  
i altered my utility a little so as to behave like a drop-in replacement for  
[USER=31308]@Pendrush[/USER]'s in terms of parameter passing. as with conversions to  
png, the compression factor (quality setting) is ignored for lossless  
webp.   
  
if he feels like updating his library to reflect the new webp options, i'm  
happy to destroy all digital copies of mine in my possession and to burn the  
source.?