B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	
	Type XMLConstruct (mp As Map,lst As List,xmlbld As XMLBuilder,errxsd As String,xmlstr As String,keymem As String,errors As String,warn As String)
 	
	Public XMLVars As XMLConstruct ' contains global variables
	
	Private ErrChars() As Int=Array As Int(128,169,174,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254)
	 
End Sub


Sub asJO(o As JavaObject) As JavaObject
	Return o
End Sub
			
Public Sub CheckDocXML(xmlstr As String,xsdfile As String) As String
	
	Dim r As String=""
	If File.Exists("",xsdfile) Then
		r=asJO(Me).RunMethod("validateAgainstXSD",Array As Object(xmlstr,xsdfile))
	End If
	Return r
	
End Sub

Public Sub IndentXML(xmlstr As String) As String
	
	Dim r As String=""
	 
	r=asJO(Me).RunMethod("IndentXML",Array As Object(xmlstr ))
	 
	Return r
	
End Sub

Public Sub RemoveClosedXMLKeys(str As String,clean As Int ) As String
	Dim ed As Int=str.IndexOf("/>")
	Do While  ed>0 
		If ed>0 Then
			Dim st As Int=str.LastIndexOf2("<",ed)
			If st>0 Then
				Dim wd As String=str.SubString2(st,ed+2)
				str=str.Replace(wd,"")
			End If
		End If
		Dim ed As Int=str.IndexOf("/>")
	Loop
 	  
	Return str
	
End Sub

Sub FinalProcessing(xsdfile As String,removeemptykeyval As Int,allowemptystr As Boolean) 
	
	Dim xmlstr As String= XMLVars.xmlbld.asString
	 
	If removeemptykeyval>0 Then		
		xmlstr=RemoveClosedXMLKeys(xmlstr,removeemptykeyval ) 	 
	End If
	 
	If allowemptystr Then
		xmlstr=Replace255(xmlstr)
	else if removeemptykeyval>1 Then
		xmlstr=RemoveEmptyKeyValues(xmlstr)
	End If
   
	XMLVars.xmlstr=xmlstr	
	XMLVars.errxsd=""
	If xsdfile.Length>0 Then
		If File.Exists("",xsdfile) Then
			Dim xmltxt As String=xmlstr
			XMLVars.errxsd=CheckDocXML(xmltxt,xsdfile)			 
		End If		
	End If
 
	XMLVars.xmlstr=$"<?xml version="1.0" encoding="UTF-8"?> "$ & IndentXML(xmlstr)

End Sub

Sub Replace255(str As String) As String
	
	Dim lst1 As List
	lst1.Initialize
	Dim lst2 As List
	lst2.Initialize
	
	Dim ct As Int
	Dim found As Boolean=True

	Do Until found=False
		Dim ct As Int=str.IndexOf(Chr(255))
	 
		If ct>0 Then
			 
			Dim st As Int=str.LastIndexOf2("<",ct)
			Dim ed As Int=str.IndexOf2(">",ct+1)
			If st>0 And ed>0 Then
			 
				Dim wd1 As String=str.SubString2(st+1,ct-1)
				Dim wd2 As String=str.SubString2(ct+3,ed)	
				If wd1=wd2 Then
					lst1.Add("<" & wd1 & ">" & Chr(255) & "</" & wd2 & ">")
					lst2.Add("<" & wd1 & "></" & wd2 & ">")					 			 
				End If	
				 				 
			End If			
			 	 
		End If
		
		If lst1.Size=0 Then
			found=False
		Else
			found=True
			For ct=0 To lst1.Size-1
				str=str.Replace(lst1.Get(ct),lst2.Get(ct))
			Next
			lst1.Initialize
			lst2.Initialize
		End If
	Loop
	Return str
	
End Sub

Sub RemoveEmptyKeyValues(str As String) As String
	Dim lst As List
	lst.Initialize
	Dim ct As Int
	Dim found As Boolean=True

	Do Until found=False
		For ct=0 To str.Length-3
			Dim tmp As String=str.SubString2(ct,ct+3)
			If tmp="></"   Then
				Dim st As Int=str.LastIndexOf2("<",ct)
				Dim ed As Int=str.IndexOf2(">",ct+1)
				If st>0 And ed>0 Then
				 
					Dim wd1 As String=str.SubString2(st+1,ct)
					Dim wd2 As String=str.SubString2(ct+3,ed)	
					If wd1=wd2 Then
						lst.Add("<" & wd1 & "></" & wd2 & ">")					 			 
					End If	
					 				 
				End If			
			End If		 
		Next
		
		If lst.Size=0 Then
			found=False
		Else
			found=True
			For ct=0 To lst.Size-1
				str=str.Replace(lst.Get(ct),"")
			Next
			lst.Initialize
		End If
	Loop
	Return str
End Sub

Sub CheckChars(Key As String,Value As String) As String
	Dim i As Int
	Dim errstr As String=""
	For i=0 To ErrChars.Length-1
		If Value.Contains(Chr(ErrChars(i)))  Then
			errstr=errstr & "Characters in '" & Key & "' not allowed '" & Chr(i) & "'"	& Chr(13) & Chr(10)	
		End If
	  
	Next
	Return errstr
End Sub

Sub GenXML(key As String,value As String,obj As Object,cdata As Object,AcceptEmptyStr As Object,Action As Int) As XMLConstruct
	
	Dim txt As String=""
	 
	Dim mp As Map
	mp.Initialize
	
	Dim lst As List
	lst.Initialize
 
	If Action=1 Then ' open
		XMLVars.keymem=XMLVars.keymem & "/" & key
		XMLVars.xmlbld=XMLVars.xmlbld.element(key)
	else If Action=2 Then ' close
		XMLVars.xmlbld=XMLVars.xmlbld.up()
		Dim x As Int=XMLVars.keymem.LastIndexOf("/")
		If x=0 Then ' at the start
			XMLVars.keymem=""
		Else 
			XMLVars.keymem=XMLVars.keymem.SubString2(0,x)
		End If
	else If Action=3 Then ' attrib		
		value=value.Replace("<","&lt;").Replace(">","&gt;").Replace("&","&amp;")
		XMLVars.errors=XMLVars.errors & CheckChars(key,value)
		XMLVars.xmlbld=XMLVars.xmlbld.attribute(key,value)		
	Else If Action=4 Or Action=5  Then ' element
		Dim valpresent As Boolean=False	 
		If obj Is Map Then ' element is in a map
			Dim mp As Map=obj
			If mp.IsInitialized Then				 
				If Action=5 Then
					If mp.ContainsKey(key) Then
						txt=mp.Get (key)
						valpresent=True
					End If
				Else
					If mp.ContainsKey(XMLVars.keymem & "/" & key) Then
						txt=mp.Get (XMLVars.keymem & "/" & key) ' prefix + key = 4
						valpresent=True
					End If					
				End If			
				txt=txt.trim	
		 	End If
		Else
			txt=value.trim
			valpresent=True
		End If
		
		If valpresent=True Then
			' escape xml & check
			txt=txt.Replace("<","&lt;").Replace(">","&gt;").Replace("&","&amp;")
			XMLVars.xmlbld=XMLVars.xmlbld.element(key)
			If cdata Then ' force
				XMLVars.xmlbld=XMLVars.xmlbld.cdata(txt).up()
			Else
				Dim chk As String=CheckChars(key,txt)
				If  chk="" Then
					If txt="" And AcceptEmptyStr=True Then 
						txt=Chr(255) ' dummy value - clear later
					End If
					XMLVars.xmlbld=XMLVars.xmlbld.text(txt).up()
				Else
					XMLVars.warn=XMLVars.warn & CheckChars(key,txt)  
					XMLVars.xmlbld=XMLVars.xmlbld.cdata(txt).up() ' switch to cdata					
				End If					
			End If
		 End If	
	else If Action=6 Or Action=7 Then ' only return the map or list		 
		
		If obj Is Map Then
			Dim mp As Map=obj
			If mp.IsInitialized Then
				If mp.ContainsKey(XMLVars.keymem & "/" & key) Then
					Dim obj2 As Object=mp.Get(XMLVars.keymem & "/" & key)
					 
					If obj2 Is Map And Action=6 Then  
						Dim mp As Map=obj2
					Else If obj2 Is List And Action=7 Then  
						Dim lst As List=obj2
					End If	
					 				
					XMLVars.lst=lst  ' return list that repeats		
				else If mp.ContainsKey(key) Then
					Dim obj2 As Object=mp.Get(key)
					 	 
					If obj2 Is Map And Action=6 Then  
						Dim mp As Map=obj2
					Else If obj2 Is List And Action=7 Then  
						Dim lst As List=obj2
					End If
					 
					XMLVars.mp=mp ' return map that repeats			
				End If
			End If
		End If
	End If
	
	XMLVars.lst=lst
	XMLVars.mp=mp
 	
	Return XMLVars
 
End Sub

'If you use xsd checks it's a good idea to save locally (including all internal references) , modify xsd and keep all xsd references local

' for example <xs:import namespace="http://www.w3.org/2000/09/xmldsig#" schemaLocation="xmldsig-core-schema.xsd" />

#if java

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import javax.xml.transform.*;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.dom.DOMSource;
import javax.xml.parsers.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;


import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXParseException;
import org.xml.sax.SAXException;

import org.w3c.dom.Document;

import java.io.*;
import java.io.Console;
import java.io.File;
import java.io.ByteArrayInputStream;

import java.nio.charset.StandardCharsets;

import org.w3c.dom.Document;
import org.w3c.dom.Element;



public static String validateAgainstXSD(String xml, String xsd) {
    try {
		
		Errors.Msg="";
		Errors.ErrCount=0;
		 
		SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
		Source schemaFile = new StreamSource(new File(xsd));
        Schema schema = factory.newSchema(schemaFile);
        Validator validator = schema.newValidator();		 
        validator.setErrorHandler(new XSDErrorHandler());		 
		validator.validate(new StreamSource(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8))));
		 	 
        return Errors.Msg;
		
    } catch (Exception ex) {
        // errorHandler.handle(ex);
		// ex.printStackTrace();
       return "Error";
    } 
}

public static String IndentXML(String xml) {
	try {
		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
			
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder builder = factory.newDocumentBuilder();
	    InputStream inputStream = new ByteArrayInputStream(xml.getBytes());
	    Document doc = builder.parse(inputStream);
		
		StringWriter writer = new StringWriter();
		StreamResult result = new StreamResult(writer);
	 
		DOMSource source = new DOMSource(doc);
		transformer.transform(source, result);
		String xmlString = result.getWriter().toString();
		System.out.println(xmlString);
		return xmlString;
	} catch (Exception ex) {
        // errorHandler.handle(ex);
		// ex.printStackTrace();
       return "Error";
    } 
}

private static class XSDErrorHandler implements ErrorHandler {
    public void warning(SAXParseException e) throws SAXException {
       //System.out.println("Warning: "); 
       printException(e);
    }
    public void error(SAXParseException e) throws SAXException {
       //System.out.println("Error: "); 
       printException(e);
    }
    public void fatalError(SAXParseException e) throws SAXException {
       //System.out.println("Fatal error: "); 
       printException(e);
    }
    private void printException(SAXParseException e) {
	  Errors.ErrCount++;
      //System.out.println("   Line number: "+e.getLineNumber());
      //System.out.println("   Column number: "+e.getColumnNumber());
      //System.out.println("   Message: "+e.getMessage());
      //System.out.println();
	  Errors.Msg=Errors.Msg+Errors.ErrCount+" : at " + e.getColumnNumber()+ " : " + e.getMessage()+"\r\n";
    }
}
  
public static class Errors {
    public static String Msg;
	public static Integer ErrCount;
}

#End If