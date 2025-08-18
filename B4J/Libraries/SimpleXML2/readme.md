### SimpleXML2 by tchart
### 05/05/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/130441/)

This is an update to the SimpleXMl library I posted here; <https://www.b4x.com/android/forum/threads/simplexml.75571/#post-748743>  
  
This update now allows reading and writing of XML files. The node traversal is now done via the XmlNodes so this is a new library.  
  
Example project attached.  
  
Quick example to create an XML;  
  

```B4X
    Dim doc As SimpleXMLWrapper  
    doc.Initialize("animals") 'Root node is animals  
   
    Dim root As XmlNode  
    root = doc.RootNode  
   
    Dim dog As XmlNode = root.appendChild("dog")  
    dog.SetAttribute("name","Ginger")  
   
    Dim dog As XmlNode = root.appendChild("dog")  
    dog.SetAttribute("name","Cheyenne")  
   
    Dim cat As XmlNode = root.appendChild("cat")  
    cat.SetAttribute("name","Polly")  
   
    Log(doc.toString)  
   
    doc.SaveDocument(File.DirApp&"\animals.xml")
```

  
  
Quick example to read (remember this is Xpath based). Notice that we dont include root in the Xpath query as GetNodes uses a node (in this case it is the root node itself).  
  

```B4X
Dim doc2 As SimpleXMLWrapper  
doc2.Initialize2(File.DirApp&"\animals.xml")  
  
Dim root As XmlNode  
root = doc2.RootNode     
  
Dim nodes As List  
nodes = root.GetNodes("cat/kitten")  
  
For Each kitten As XmlNode In nodes  
    Log(kitten.GetAttribute("name"))  
Next
```

  
  
animals.xml is as follows;  
  

```B4X
<animals>  
   <dog name="Ginger"/>  
   <dog name="Cheyenne"/>  
   <cat name="Polly">  
      <kitten name="Snowball 1"/>  
      <kitten name="Snowball 2"/>  
      <kitten name="Snowball 3"/>  
   </cat>  
   <hamster name="Gizmo">Furzilla</hamster>  
</animals>
```