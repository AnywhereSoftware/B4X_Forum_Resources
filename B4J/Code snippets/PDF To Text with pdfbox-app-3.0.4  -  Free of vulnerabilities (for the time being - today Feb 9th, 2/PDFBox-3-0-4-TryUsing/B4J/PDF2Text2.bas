B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#Event: ParsedText(TextThatWasParsed As String)

Sub Class_Globals
	Private fx As JFX
	Private objPar As Object
	Private sEv As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As Object, Event As String)
	objPar = Parent
	sEv = Event
End Sub


Public Sub Parse(Dir As String, Filename As String)
	Dim jo As JavaObject
	jo = Me
	Dim sText As String
	sText = jo.RunMethod("DHQIParsePDF", Array As Object(File.Combine(Dir,Filename)))
	If SubExists(objPar, sEv & "_ParsedText") Then
		CallSub2(objPar, sEv & "_ParsedText", sText)
	End If
End Sub

#if java
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.io.RandomAccessReadBufferedFile;
import org.apache.pdfbox.Loader;

import java.io.IOException;


public static String DHQIParsePDF(String inputPdfPath){
        
		try {
			
            PDDocument document = Loader.loadPDF(new RandomAccessReadBufferedFile(inputPdfPath));

            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);

            document.close();  // Important: Close the document
            System.out.println("PDF converted to text successfully");
			
			return text;
			
        } catch (IOException e) {
            System.err.println("Error during PDF processing: " + e.getMessage());
            e.printStackTrace(); // Print the full stack trace For debugging
			return "--";
        }


}

#end if