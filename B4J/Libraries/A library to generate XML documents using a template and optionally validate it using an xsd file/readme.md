### A library to generate XML documents using a template and optionally validate it using an xsd file by andrewmp
### 11/18/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/136134/)

More and more we getting asked to create xml documents in projects, here is a lib to generate XML documents in an ordered way using a template and optionally check it using an xsd file.  
This lib is my attempt at a standard lib that will allow the creation and sharing of XML templates in an easy way.  
  
To use it you will need the XMLBuilder library  
  
See notes in source code for explanations , there are two examples included, one complicated and one simple  
  
It sould be fairly clear how it works here some more notes for GenXML  
   
key is the element or attribute name (only elements and attrib are used for the moment )  
value is the value of the element (can also be empty if it is the start of a new level)  
obj can be null,map,list o string , if it is null then value is used, map or list then key is used to access the value, if sting then this string is used and not value  
cdata - force value to cdata  
AcceptEmptyStr - allow empty strings in the xml  
  
Action can be one of:  
  
XMLOPEN = to open an element ( tree) - key is the element name  
XMLCLOSE = to close the element (tree) - key can be empty used for clarity only  
XMLATTRIB = value is an attribute , key is attribute key, obj = null, cdata false  
XMLELEMPREF = element name is key , value="", obj contains map, cdata = false , note key is prefixed with tree level (similar to xpath) eg. /FatturaElettronicaHeader/DatiTrasmissione/IdTrasmittente/IdCodice"  
XMLELEM = element name is key , value="", obj contains map, cdata = false, note key is not prefixed with tree level eg "IdCodice" - used in lists  
GETMAP = the element contains a map instead of a value  
GETLIST = the element contains a list instead of a value  
  
If you like it and use it remember share your XML templates as well!