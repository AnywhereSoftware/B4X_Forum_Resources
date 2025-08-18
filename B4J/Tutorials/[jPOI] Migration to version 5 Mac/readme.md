### [jPOI] Migration to version 5 Mac by MarcoRome
### 07/07/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132264/)

**For Mac**  
as already suggested by the good [USER=35245]@KMatle[/USER]  
  
I needed to remove the Packager property (The B4J-packager does it on it's own with the new version)  
  
Note 1\*  

```B4X
'#PackagerProperty: AdditionalModuleInfoString =provides org.apache.poi.extractor.ExtractorProvider with org.apache.poi.extractor.MainExtractorFactory, org.apache.poi.ooxml.extractor.POIXMLExtractorFactory; provides org.apache.poi.sl.draw.ImageRenderer with org.apache.poi.sl.draw.BitmapImageRenderer, org.apache.poi.xslf.draw.SVGImageRenderer; provides org.apache.poi.ss.usermodel.WorkbookProvider with org.apache.poi.hssf.usermodel.HSSFWorkbookFactory, org.apache.poi.xssf.usermodel.XSSFWorkbookFactory;opens org.apache.xmlbeans.metadata.system.sXMLTOOLS; opens org.apache.xmlbeans.metadata.system.sXMLSCHEMA;opens org.apache.xmlbeans.metadata.system.sXMLLANG;opens org.apache.xmlbeans.metadata.system.sXMLCONFIG;opens org.apache.poi.schemas.ooxml.system.ooxml;
```

  
  
In the code I had to change:  
  

```B4X
titleStyle.ForegroundColor = fx.Colors.LightGray 'or xui.Color_LightGray
```

  
  
Ultil here is the same as for windows ( and work Note 1\* ) **if you build using "Build standalone Package"**  
  
But if you like using the command line ( for MAC you havent Build standalone Package ) you need to put the following code in the json file  

```B4X
{  
   InputJar: "/Users/youruser/Desktop/yourfolder/MYAPP/Objects/MyApp.jar",  
   IconFile: "/Users/youruser/Desktop/yourfolder/MYAPP/icona.ico",  
IncludedModules: ["jdk.charsets","jdk.crypto.ec"],  
   AdditionalModuleInfoString: "provides org.apache.poi.extractor.ExtractorProvider with org.apache.poi.extractor.MainExtractorFactory, org.apache.poi.ooxml.extractor.POIXMLExtractorFactory; provides org.apache.poi.sl.draw.ImageRenderer with org.apache.poi.sl.draw.BitmapImageRenderer, org.apache.poi.xslf.draw.SVGImageRenderer; provides org.apache.poi.ss.usermodel.WorkbookProvider with org.apache.poi.hssf.usermodel.HSSFWorkbookFactory, org.apache.poi.xssf.usermodel.XSSFWorkbookFactory;opens org.apache.xmlbeans.metadata.system.sXMLTOOLS; opens org.apache.xmlbeans.metadata.system.sXMLSCHEMA;opens org.apache.xmlbeans.metadata.system.sXMLLANG;opens org.apache.xmlbeans.metadata.system.sXMLCONFIG;opens org.apache.poi.schemas.ooxml.system.ooxml;"  
}
```

  
  
Once this is done you can compile with the usual commands, like:  
  
> /Users/youruser/Desktop/yourfolder/jdk-14.0.1/Contents/Home/bin/java -jar B4JPackager14.jar compila.json

  
  
**For Windows look [USER=35245]@KMatle[/USER] Thread**  
  
> <https://www.b4x.com/android/forum/threads/jpoi-migration-to-version-5-experience-not-a-big-thing.131588/#content>