###  PlusCodes Library by mading1309
### 08/21/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/133602/)

![](https://www.b4x.com/android/forum/attachments/118062)  
  
This is an implementation of the Open Location Code, OLC, library in B4X.  
The class source is an adaption of the VBA source provided on [GITBUB VBA Source](http://https%3A//github.com/google/open-location-code/blob/main/visualbasic/OpenLocationCode.bas)  
  
I stay these days in rural province area, common postal addresses are not a given, usually the nick name is sufficient for a village.   
For example, in the time of Covid and travel restrictions, the number of online orders are grown up.  
Delivery of online orders by services from outside not familiar with the village run into a time problem, houses in satellite areas are difficult to find.  
The PlusCodes attached to the delivery addresses are often helpful in the last month, specially to deliver in satellite areas with minimum time delay.  
I implement the PlusCodes in an B4A and B4J application for support. The library decode and encode PlusCodes addresses in longitude and latitude coordinates with given accuracy.  
The coordinates are WGS84 compatible and can be used with other application. BTW Google Maps support PlusCodes Addresses directly.  
  
I implemented OLC as standard class. So before use the class must be initialized.  
  
For example running the test procedures  
  

```B4X
            Private PC As PlusCode  
            PC.Initialize  
            PC.TestOLCLibrary
```

  
  
I modified the code where necessary (string operation in most cases) and changed the MSGBOX calls to LOG and LOGERROR in case of B4J specially in the included test routine  
I did not test the library with B4I. There are no UI elements and the source code does not include platform relevant instructions.  
  
The following ist part of the GITHUB Documentation….  
  
> The intent Is To provide the core functions of encoding, decoding, shorten And recovery.  
> A full Plus Code Is a "Global Code" such As 7MJCH93V+7F having 8 characters before the “+” sign  
>   
> Plus Codes include a “+” so that they are easy To recognize, both For people And computers.  
> The “+” sign Is added after eight characters of the Plus Code For full codes;  
> it’s added after the first two characters For short Plus Codes.  
>   
> Description of public methods of the class PLUSCODES  
> For more details see the source code provided in the b4xLib file  
> The source code has more information in the header and includes the original VBA implementation  
>   
> Encoding  
> =========  
> OLCEncode(latitude, longitude, length)  
> This returns the Open Location Code For the passed latitude And longitude (in decimal degrees).  
>   
> If the length parameter Is Null, the standard precision length (CODE\_PRECISION\_NORMAL) will be used.  
> This provides an area that Is 1/8000 x 1/8000 degree in size, roughly 14x14 meters.  
> If CODE\_PRECISION\_EXTRA Is specified As length, the area of the code will be roughly 2x3 meters.  
>   
> Decoding  
> =========  
> Two decoding methods are provided. One returns a data structure, the other returns an Array And Is more suited To use within a spreadsheet.  
>   
> OLCDecode(code)  
> ===============  
> This decodes the passed Open Location Code, And returns an OLCArea data structure, which has the following fields:  
>   
> latLo: The latitude of the south-west corner of the code area.  
> lngLo: The longitude of the south-west corner of the code area.  
> latCenter: The latitude of the center of the code area.  
> lngCenter: The longitude of the center of the code area.  
> latHi: The latitude of the north-east corner of the code area.  
> lngHi: The longitude of the north-east corner of the code area.  
> codeLength: The number of digits in the code.  
>   
> OLCDecode2Array(code)  
> =====================  
> This returns a list of the fields from the OLCArea data structure, in the following order:  
>   
> latLo, lngLo, latCenter, lngCenter, latHi, lngHi, codeLength  
>   
> Shortening And Recovery  
> =======================  
> The codes returned by OLCEncode are globally unique, but often locally unique Is sufficient.  
> For example, 796RWF8Q+WF can be shortened To WF8Q+WF, relative To Praia, Cape Verde.  
>   
> This works because 796RWF8Q+WF Is the nearest match To the location.  
>   
> OLCShorten(code, latitude, longitude)  
> =====================================  
> This removes As many digits from the code As possible,  
> so that it Is still the nearest match To the passed location.  
> Even If six Or more digits can be removed, we suggest only removing four so that the codes are used consistently.  
>   
> OLCRecoverNearest(code, latitude, longitude)  
> =============================================  
> This uses the specified location To extend the short code And returns the nearest matching full length code.

  
Part of the library source is the protocol of the test run  
  
Any improvements of library or comments are welcome  
I have a weak internet connection here, so can happen I will answer delayed  
  
Version 210821.01 is attached