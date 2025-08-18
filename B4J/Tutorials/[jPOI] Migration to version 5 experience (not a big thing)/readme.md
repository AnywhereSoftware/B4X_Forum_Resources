### [jPOI] Migration to version 5 experience (not a big thing) by KMatle
### 06/13/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131588/)

Just a short note how my experience was migrating to JPOI5. Not worth a tutorial - more a "all easy note" when you migrate an important app (like mine which is used by a company).  
  
I needed to remove the Packager property (The B4J-packager does it on it's own with the new version)  
  

```B4X
'#PackagerProperty: AdditionalModuleInfoString =provides org.apache.poi.extractor.ExtractorProvider with org.apache.poi.extractor.MainExtractorFactory, org.apache.poi.ooxml.extractor.POIXMLExtractorFactory; provides org.apache.poi.sl.draw.ImageRenderer with org.apache.poi.sl.draw.BitmapImageRenderer, org.apache.poi.xslf.draw.SVGImageRenderer; provides org.apache.poi.ss.usermodel.WorkbookProvider with org.apache.poi.hssf.usermodel.HSSFWorkbookFactory, org.apache.poi.xssf.usermodel.XSSFWorkbookFactory;opens org.apache.xmlbeans.metadata.system.sXMLTOOLS; opens org.apache.xmlbeans.metadata.system.sXMLSCHEMA;opens org.apache.xmlbeans.metadata.system.sXMLLANG;opens org.apache.xmlbeans.metadata.system.sXMLCONFIG;opens org.apache.poi.schemas.ooxml.system.ooxml;
```

  
  
In the code I had to change  
  

```B4X
titleStyle.ForegroundColor = fx.Colors.LightGray
```

  
  
to  
  

```B4X
titleStyle.ForegroundColor =3435973887
```

  
  
As it is an integer value now (fx.colors.xxx gives a hex value). So just log the value and convert it to integer.  
  
Last thing:  
  

```B4X
MyWorkbook.InitializeExistingAsync("MyWorkbook",FParent,FName,"",True)
```

  
  
Here the last parm (read only) was added.  
  
So that's it