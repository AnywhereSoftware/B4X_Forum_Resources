### MLKIT Barcode Scanning Class by drgottjr
### 06/11/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/161596/)

this is a b4a class for handling mlkit's standard barcode scanning.  
yes, yes, we have a barcode scanning class, but it's based on google's codescanning api, which is not exactly the same thing.  
  
the codescanning api has a camera activity built in, which means that you cannot use it to scan a bitmap or  
to incorporate it in a camera activity that you may already have and which activity uses google's deprecated mobile  
vision api. it also appears that the api does not recognize more than 1 barcode at a time. at least the class doesn't  
allow for it. my standard (google's term) barcode scanning class works pretty much like erel's codescanner class but  
allows for more than 1 barcode in a given image.  
  
this library's main purpose is to replace the deprecated mobile vision api. the deprecated api works just fine, but  
1) it is deprecated and 2) there is no more development by google for it. if it simply remains in deprecation and the  
barcodes currently recognized fulfill your needs, then you may have no reason to adopt mlkit's scanner.   
whether or not mlkit will learn to scan new barcode symbologies is unclear but such improvements are implied;  
in any case, mobile vision's barcode scanning will not go beyond what it does now.  
  
i initially built my project using inline java, but since erel has posted a number of mlkit-related api's as b4a classes,  
i decided to move the inline java back into a b4a class. i've tested it with android 12 and 14.  
  
the attached example shows how to use the class. make note of manifest statements and compiler options.  
also, it might be helpful to review erel's posts in order to understand some configuration steps you need to take  
relating to the sdk manager. there's a bunch of dependencies to download and additions to the manifest to be  
made. the dependencies and edits for the 2 scanning classes are slightly different, so be careful.  
  
for people who are serious about barcode scanning (beyond the occasional qr code), i need to remind you that  
both mobile vision and mlkit scanning api's are black boxes; there is no tweaking. a given barcode can be  
decoded or it can't. with zxing, although there is no "official" development (google took over zxing in 2016), it is  
being updated, and i often am able to decode barcodes with it that i cannot with mobile vision or mlkit.  
nothing replaces a hardware scanner, but a combination of the ease of google's scanning and zxing's lower level  
features make a powerful pair for mobile scanning.  
  
in addition to the project with its class, i'm attaching a copy of the class if you just want to look at it