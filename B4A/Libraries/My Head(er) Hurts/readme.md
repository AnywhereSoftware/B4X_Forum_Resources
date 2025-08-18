### My Head(er) Hurts by drgottjr
### 12/11/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/136745/)

in working on my covid (and similar) reader, i discovered that issuers of these certificates not only used various encoding schemes as well as encryption methods, they also use  
compression, presumably to ensure the data fit in the qr code. although, compression does add yet another layer of obfuscation.  
  
if not all encoding and encryption is the same, there is no 1-size-compression-fits-all scheme. in fact, if you're using the java zip class, using the wrong "inflater" to uncompress  
your data will cause an exception. of course, you can trap for that exception and turn around and try a different method until you get it right (which may never happen if you've not found the correct compression scheme that was used). or you could look at the data and perhaps see how it was compressed.  
  
compressed data will indicate the method that was used to carry out the compression. it appears as a "header" in the data. it you check that first, you might find out which  
uncompression scheme you should use. this may not be convenient without an available library.  
  
the same is true for a number of files that we see regularly (images, pdf, apks, various types of zipped archives, etc). simply appending ".jpg" to a block of data and saving it  
doesn't make it a jpeg image.  
  
in my tradition of creating libraries which provide a solution in search of a problem, i introduce ghdr. give it at least the first 4 bytes of some data block to see if it recognizes the format of the data. you can give it raw bytes or a hex string.  
  
i've initially limited the file types to those we see regularly on android. my own interest relates soley to compression schemes and my interaction with them, but we have seen  
cases where general data processing fails because an incorrect assumption is made about the underlying data format.  
  
i realize there are a number of java classes dealing with file types.  
1) having access to a file is not necessarily the same as dealing with a byte array not in a file,  
2) these classes are not necessarily based on the actual data in a file (some just use the extension),  
and 3) if new headers are found or current ones modified, good luck getting oracle to drop everything and release an update for you. (i, on the other hand, am usually at the beck and call of the forum.)  
  
download and unzip (or copy) the included .jar and .xml to your additional libraries folder. add to your project, initialize and select from 1 of 2 methods available (pass byte array or hex string). take note of the tool tips regarding the methods.  
  
typical use (for a file) might be:  
  

```B4X
dim ghdr as ghdr  
ghdr.initialize("")  
  
dim bytes() as byte = file.readbytes( …… )  
log( ghdr.headerType( bytes ) )
```

  
  
if you just have the raw bytes, run the same method - ghdr.headerType( bytes ). no file needed.  
  
UPDATE: version 1.5 attached  
you don't even have to bother opening and reading the file; just point the library to it (ghdr.headerType3( path, filename )).