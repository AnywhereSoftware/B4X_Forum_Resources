###  Simple: Get the value of an HTML or XML tag. by TILogistic
### 04/13/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160456/)

Gets the value of an HTML or XML tag with regular expressions.  
  
sub:  

```B4X
Public Sub GetTagHtmlValue(Text As String, TagName As String) As List  
    Dim Pattern As String = $"<\s*${TagName}[^>]*>(.*?)<.*?\/${TagName}>"$  
    Dim Matcher As Matcher = Regex.Matcher(Pattern, Text)  
    Dim Result As List : Result.Initialize  
    Do While Matcher.Find  
        Result.Add(Matcher.Group(1))  
    Loop  
    Return Result  
End Sub
```

  
test;  

```B4X
    Dim Html As String = $"  
                       <div class="col-9 ml-auto text-right p-0">  
                              <span id="allPopulation" class=" allPopulation number-lg">32.519</span>  
                       </div>  
   
                       <div class="list-group">  
                       <input type="checkbox" dataid="101" />  
                       <a href="techno1">2023</a>  
                       <span> 615 <a href="techno"><i class="fa fa-chevron-circle-right"></i></a></span>  
                       </div>  
                                            
                       <div class="list-group">  
                       <input type="checkbox" dataid="102" />  
                       <a href="techno2">2023</a>  
                       <span> 715 <a href="techno"><i class="fa fa-chevron-circle-right"></i></a></span>  
                       </div>  
                        
                       "$  
      
    Log("—– HTML a ——")  
  
    For Each v As String In GetTagHtmlValue(Html, "a")  
        Log(v)  
    Next  
      
    Log("—– HTML span ——")  
      
    For Each v As String In GetTagHtmlValue(Html, "span")  
        Log(v)  
    Next  
  
    Log("—– XML NS Element ——")  
      
              
    Dim XML As String = $"<?xml version="1.0"?>  
                                <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">  
                                  <SOAP-ENV:Body SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:NS1="urn:wsNewGES2000Intf-IwsNewGES2000">  
                                    <NS1:PDA_DatosArticuloResponse xmlns:NS2="urn:wsNewGES2000Intf">  
                                      <NS2:PDADatosArticulo id="1" xsi:type="NS2:PDADatosArticulo">  
                                        <Codigo xsi:type="xsd:string">B1001</Codigo>  
                                        <Nombre xsi:type="xsd:string">PRIMO PAT. LISA FAMILIAR 260 GRS X 12 B.</Nombre>  
                                        <Existencias xsi:type="xsd:double">0</Existencias>  
                                        <Costo xsi:type="xsd:double">1.1</Costo>  
                                        <Margen0 xsi:type="xsd:double">3</Margen0>  
                                        <PVP0 xsi:type="xsd:double">1.212</PVP0>  
                                        <Margen1 xsi:type="xsd:double">2</Margen1>  
                                        <PVP1 xsi:type="xsd:double">1.224</PVP1>  
                                        <Margen2 xsi:type="xsd:double">0</Margen2>  
                                        <PVP2 xsi:type="xsd:double">1.236</PVP2>  
                                        <Margen3 xsi:type="xsd:double">4</Margen3>  
                                        <PVP3 xsi:type="xsd:double">1.248</PVP3>  
                                      </NS2:PDADatosArticulo>  
                                      <NS2:PDADatosArticulo id="2" xsi:type="NS2:PDADatosArticulo">  
                                        <Codigo xsi:type="xsd:string">B2002</Codigo>  
                                        <Nombre xsi:type="xsd:string">SECONDO PAT. LISA FAMILIAR 260 GRS X 12 B.</Nombre>  
                                        <Existencias xsi:type="xsd:double">0</Existencias>  
                                        <Costo xsi:type="xsd:double">1.2</Costo>  
                                        <Margen0 xsi:type="xsd:double">3</Margen0>  
                                        <PVP0 xsi:type="xsd:double">1.212</PVP0>  
                                        <Margen1 xsi:type="xsd:double">2</Margen1>  
                                        <PVP1 xsi:type="xsd:double">1.224</PVP1>  
                                        <Margen2 xsi:type="xsd:double">0</Margen2>  
                                        <PVP2 xsi:type="xsd:double">1.236</PVP2>  
                                        <Margen3 xsi:type="xsd:double">4</Margen3>  
                                        <PVP3 xsi:type="xsd:double">1.248</PVP3>  
                                      </NS2:PDADatosArticulo>  
                                      <NS2:PDADatosArticulo id="3" xsi:type="NS2:PDADatosArticulo">  
                                        <Codigo xsi:type="xsd:string">B3003</Codigo>  
                                        <Nombre xsi:type="xsd:string">TERZO PAT. LISA FAMILIAR 260 GRS X 12 B.</Nombre>  
                                        <Existencias xsi:type="xsd:double">0</Existencias>  
                                        <Costo xsi:type="xsd:double">1.3</Costo>  
                                        <Margen0 xsi:type="xsd:double">3</Margen0>  
                                        <PVP0 xsi:type="xsd:double">1.212</PVP0>  
                                        <Margen1 xsi:type="xsd:double">2</Margen1>  
                                        <PVP1 xsi:type="xsd:double">1.224</PVP1>  
                                        <Margen2 xsi:type="xsd:double">0</Margen2>  
                                        <PVP2 xsi:type="xsd:double">1.236</PVP2>  
                                        <Margen3 xsi:type="xsd:double">4</Margen3>  
                                        <PVP3 xsi:type="xsd:double">1.248</PVP3>  
                                      </NS2:PDADatosArticulo>  
                                      <NS2:PDADatosArticulo id="4" xsi:type="NS2:PDADatosArticulo">  
                                        <Codigo xsi:type="xsd:string">B4004</Codigo>  
                                        <Nombre xsi:type="xsd:string">QUARTO PAT. LISA FAMILIAR 260 GRS X 12 B.</Nombre>  
                                        <Existencias xsi:type="xsd:double">0</Existencias>  
                                        <Costo xsi:type="xsd:double">1.4</Costo>  
                                        <Margen0 xsi:type="xsd:double">3</Margen0>  
                                        <PVP0 xsi:type="xsd:double">1.212</PVP0>  
                                        <Margen1 xsi:type="xsd:double">2</Margen1>  
                                        <PVP1 xsi:type="xsd:double">1.224</PVP1>  
                                        <Margen2 xsi:type="xsd:double">0</Margen2>  
                                        <PVP2 xsi:type="xsd:double">1.236</PVP2>  
                                        <Margen3 xsi:type="xsd:double">4</Margen3>  
                                        <PVP3 xsi:type="xsd:double">1.248</PVP3>  
                                      </NS2:PDADatosArticulo>  
                                      <return href="#1"/>  
                                    </NS1:PDA_DatosArticuloResponse>  
                                  </SOAP-ENV:Body>  
                                </SOAP-ENV:Envelope>  
                                "$     
    For Each v As String In GetTagHtmlValue(XML, "Nombre")  
        Log(v)  
    Next  
      
    For Each v As String In GetTagHtmlValue(XML, "Costo")  
        Log(v)  
    Next
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/152652)  
  
topic discussion post.  
<https://www.b4x.com/android/forum/threads/parsing-span-element.160448/>  
<https://www.b4x.com/android/forum/threads/how-to-parse-strange-xml.159848/#post-981431>  
  
**Your comments are welcome.  
  
regards**