### Set Author, Title and Category for Excel by aeric
### 03/20/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/139267/)

If you follow the [tutorial](https://www.b4x.com/android/forum/threads/xlutils-writing-excel-workbooks.130356/), the excel file is created with a default author "Apache POI".  
  

```B4X
Dim jo As JavaObject = Me  
jo.RunMethod("updateTitle", Array(File.Combine(File.DirApp, "Products.xlsx"), "Products"))  
jo.RunMethod("updateCategory", Array(File.Combine(File.DirApp, "Products.xlsx"), "Category"))  
jo.RunMethod("updateAuthor", Array(File.Combine(File.DirApp, "Products.xlsx"), "Aeric Poon"))  
  
#If Java  
    import java.io.File;  
    import java.io.FileNotFoundException;  
    import java.io.FileInputStream;  
    import java.io.FileOutputStream;  
    import org.apache.poi.ss.usermodel.Workbook;  
    import org.apache.poi.xssf.usermodel.XSSFWorkbook;  
   
    public static void updateAuthor(String FileName, String Author) throws Exception {  
        File f = new File(FileName);  
        FileInputStream in = new FileInputStream(f);  
        XSSFWorkbook workbook = new XSSFWorkbook(in);  
        workbook.getProperties().getCoreProperties().setCreator(Author);  
         
          try (FileOutputStream out = new FileOutputStream(FileName) ) {  
               workbook.write(out);  
          }  
        workbook.close();  
    }  
     
    public static void updateTitle(String FileName, String Title) throws Exception {  
        File f = new File(FileName);  
        FileInputStream in = new FileInputStream(f);  
        XSSFWorkbook workbook = new XSSFWorkbook(in);  
        workbook.getProperties().getCoreProperties().setTitle(Title);  
         
          try (FileOutputStream out = new FileOutputStream(FileName) ) {  
               workbook.write(out);  
          }  
        workbook.close();  
    }  
     
    public static void updateCategory(String FileName, String Category) throws Exception {  
        File f = new File(FileName);  
        FileInputStream in = new FileInputStream(f);  
        XSSFWorkbook workbook = new XSSFWorkbook(in);  
        workbook.getProperties().getCoreProperties().setCategory(Category);  
         
          try (FileOutputStream out = new FileOutputStream(FileName) ) {  
               workbook.write(out);  
          }  
        workbook.close();  
    }    
#End If
```