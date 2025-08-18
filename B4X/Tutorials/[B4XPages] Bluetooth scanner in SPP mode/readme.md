###  [B4XPages] Bluetooth scanner in SPP mode by Dave G
### 09/11/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/122203/)

**Introduction**  
  
I've been developing mobile application for over 25 years (Telxon, Symbol, Windows Mobile, Xamarin, CF.net). Up until now the barcode scanners were integrated into the mobile device. I decided to see if I could develop an architecture as robust and flexible as I did on integrated mobile devices. So here's my adventure with B4XPages and separate scanners. This is an advanced topic and assumes familiarity with B4X and B4XPages. Rather than go on for pages with code samples. I'm expecting the user to have the project open and reviewing the actual code from the attached sample.  
  
**Some requirements**  
1. Direct the barcode scans to the correct input field on the correct Page  
2. Be able to logically turn the scanner off and on (may physically scan the barcode but not 'send' it to the application)  
3. Preferably have the scanner provide the symbology of the barcode e.g. EAN 8, UPC\_A, etc  
4. Application can indicate which symbologies are to be allowed and tell scanner which routine of the Page is to receive the scans  
5. The scan handler will enforce symbologies and give user an error and not send the barcode to the application  
6. Easily incorporate new scanners (current example supports Socket Mobile and Scan Avenger in SPP mode  
  
**B4XPages advantage**  
I had started to do this in B4a (iOS doesn't support SPP). I've developed around 25,000 lines of code with Xamarin Android. I have spent a great deal of time contending with Activities and all of their foibles. So I decided to make my first B4XPages application to be the prototype for the Bluetooth Scanner.  
  
It's 'flatness' (everything is an object) is amazing yet simple. I was able to easily meet all of the above requirements using standard B4XPages. Instead of obscure concepts such as PutExtra to an Intent before calling another Activity and then catching the OnActivityResult and doing a huge switch statement, I can pass a pointer to 'me' and the routine to callback as a String. The ability to provide a delegate/callback makes everything so much easier.  
  
**How it all works**  
Item 1 and 2  
Look at ScanSet in B4XMainPage and then ScanSet being called from the various Pages. ScanSet associates and disassociates Pages with the scanner.  
  
Items 3-5  
The routine AStream\_NewData in M4XMainPage receives scans from the Bluetooth scanner via serial and AStream libraries. When the scan arrives, AStream\_NewData determines if the scanner is supported and if so it determines the symbology. If the scanned symbology is appropriate (List from ScanSet) it then uses CallSubDelayed2 to pass the barcode back to the appropriate Page and Routine. If not, it plays a sound "Wrong Barcode" and the doesn't bother the Page. If the scanner is not supported it will just return the barcode.  
  
Item 6  
AStream\_NewData looks at the Name of the scanner and if it's supported it calls a routine specific to the scanner e.g. decodeScanAvenger. That routine knows where the symbology ID is in the scanner message and how to translate the ID e.g. integer of 99 to the symbology name e.g. EAN\_8. It also know where the barcode is located within the scanner message.  
  
**Summary**  
I hope this provides a foundation for application development using Bluetooth scanners for Android devices.