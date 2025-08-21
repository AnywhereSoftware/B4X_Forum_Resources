### Two geodesic features on a web page using B4J+Python (with sources) by MichalK73
### 05/05/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/117355/)

Hello.  
  
I haven't seen the available B4X libraries for geodetic conversion, and rewriting them is very complicated computationally. Since at work, I often uses the transformation between coordinate systems, i decided to make it easier for myself and my colleagues at work. I used ABMaterial and Python for this. ABMaterial is responsible for the web page, python is responsible for converting between coordinate systems. Additionally, the function of searching for the coordinates of the specified address is added. The site operates in Polish language and are included coordinate systems that are most often used in my country. Python scripts I wrote myself and work with b4x code. The python script is over shell with parameters.  
  

```B4X
Public Sub find(adres As String)As ResumableSub  
    Log(adres)  
    Dim shl As Shell  
    #if release  
    shl.Initialize("shl", "python3", _  
     Array As String("adres.py", adres))  
    #else  
    shl.Initialize("shl", "python", _  
     Array As String("adres.py", adres))  
    #end if  
    shl.WorkingDirectory = File.DirApp  
    shl.Run(10000) 'set a timeout of 10 seconds  
    Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
  
    Dim j As JSONParser  
    j.Initialize(StdOut)  
    Dim m As Map  
    m.Initialize  
    m = j.NextObject  
    Dim out As StringBuilder  
    out.Initialize  
  
    out.Append("Adres: "&m.Get("adres")).Append(CRLF).Append(CRLF)  
    m.Remove("adres")  
    
    For i=0 To m.Size-1  
  
        Dim m1 As Map = m.GetValueAt(i)  
  
        out.Append("{B}"&m.GetKeyAt(i)&"{/B}").Append(" :     ").Append(m1.GetValueAt(0)).Append(" , ").Append(m1.GetValueAt(1)).Append(CRLF)  
    Next  
    Dim jj As JSONGenerator  
    jj.Initialize(m)  
    If StdErr <> "" Then  
        Return StdErr  
    Else  
        Return out.ToString  
        
    End If  
End Sub
```

  
  

```B4X
'src- uklad z ktorego jest konwersja  
'out - uklad na ktory ma byc dokonana zamiana  
'zamiana - zamiana X z Y  
public Sub convertData(value As String, src As String, out As String, zamiana As String) As ResumableSub  
    Dim nazwa As String = Rnd(10000,50000)  
    File.WriteString(File.DirApp, nazwa,value)  
    Dim shl As Shell  
    
    Dim paramerty As String = """"& nazwa & "," & src & "," & out & "," &zamiana &""""  
  
    #if release  
    shl.Initialize("shl", "python3", _  
     Array As String("convert.py", paramerty))  
    #else  
    shl.Initialize("shl", "python", Array As String("convert.py", paramerty ))  
'    shl.Initialize("shl", "python", Array As String("convert.py", paramerty))  
    #end if  
    shl.WorkingDirectory = File.DirApp  
    shl.Run(10000) 'set a timeout of 10 seconds  
    Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
  
'    
    Return StdOut  
  
End Sub
```

  
  
  

```B4X
    Dim rs As ResumableSub = ap.convertData(dane.Text, inp.GetActiveItemId, out.GetActiveItemId, z)  
    Wait For(rs) Complete (Result As String)  
    Dim lab As ABMLabel = page.Component("out")  
    lab.Text = Result  
    lab.Refresh
```

  
  

```B4X
    page.ShowToast("ok", "", "Szukam …", 2000, False)  
    Dim rs As ResumableSub = ap.find(value)  
    Wait For(rs) Complete (Result As String)  
    Dim lab As ABMLabel = page.Component("out")  
    lab.Text = Result  
    lab.Refresh
```

  
  

```B4X
#!/usr/bin/env python  
# coding: utf-8  
  
  
  
##Układ współrzędnych 1965 (strefa I) – EPSG:3120  
##Układ współrzędnych 1965 (strefa II) – EPSG:2172  
##Układ współrzędnych 1965 (strefa III) – EPSG:2173  
##Układ współrzędnych 1965 (strefa IV) – EPSG:2174  
##Układ współrzędnych 1965 (strefa V) – EPSG:2175  
##  
##Układ 1992 EPSG:2180  
##  
##Układ współrzędnych 2000 (strefa V) – EPSG:2176  
##Układ współrzędnych 2000 (strefa VI) – EPSG2177  
##Układ współrzędnych 2000 (strefa VII) – EPSG:2178  
##Układ współrzędnych 2000 (strefa VIII) – EPSG:2179  
  
  
from geopy.geocoders import ArcGIS  
from pyproj import Transformer  
import sys  
import json  
import re  
  
  
nom =ArcGIS()  
  
WEJSCIE =''  
WYJSCIE =''  
  
  
def trans(adres):  
    uklad = {  
                '65/1':'3120',  
              '65/2' : '2172',  
              '65/3' : '2173',  
              '65/4' : '2174',  
              '65/5' : '2175',  
              '1992' : '2180',  
              '2000/5' : '2176',  
              '2000/6' : '2177',  
              '2000/7' : '2178',  
              '2000/8' : '2179'  
              }  
  
    result = nom.geocode(adres)  
    adress = result[0]  
    ws = result[1]  
    x1 = ws[0]  
    y1 = ws[1]  
  
    out={}  
    out['adres'] = adress  
    for k,v in uklad.items():  
        transformer = Transformer.from_crs("epsg:4326", "epsg:"+v)  
        x0,y0 = transformer.transform(x1, y1)  
        x0 = ('%.2f' %x0)  
        y0 = ('%.2f' %y0)  
        out[k]= {'x':x0, 'y':y0}  
  
    j = json.dumps(out)  
    print(j)  
  
if __name__ == '__main__':  
  
    par  = sys.argv[1]  
    trans(par)
```

  
  

```B4X
#!/usr/bin/env python  
# coding: utf-8  
  
  
  
##Układ współrzędnych 1965 (strefa I) – EPSG:3120  
##Układ współrzędnych 1965 (strefa II) – EPSG:2172  
##Układ współrzędnych 1965 (strefa III) – EPSG:2173  
##Układ współrzędnych 1965 (strefa IV) – EPSG:2174  
##Układ współrzędnych 1965 (strefa V) – EPSG:2175  
##  
##Układ 1992 EPSG:2180  
##  
##Układ współrzędnych 2000 (strefa V) – EPSG:2176  
##Układ współrzędnych 2000 (strefa VI) – EPSG2177  
##Układ współrzędnych 2000 (strefa VII) – EPSG:2178  
##Układ współrzędnych 2000 (strefa VIII) – EPSG:2179  
  
  
from geopy.geocoders import ArcGIS  
from pyproj import Transformer  
import sys, os  
import json  
import re  
  
  
nom =ArcGIS()  
  
WEJSCIE =''  
WYJSCIE =''  
  
  
def trans(adres):  
    uklad = {  
                '65/1':'3120',  
              '65/2' : '2172',  
              '65/3' : '2173',  
              '65/4' : '2174',  
              '65/5' : '2175',  
              '1992' : '2180',  
              '2000 V' : '2176',  
              '2000 VI' : '2177',  
              '2000 VII' : '2178',  
              '2000 VIII' : '2179'  
               }  
  
    result = nom.geocode(adres)  
    adress = result[0]  
    ws = result[1]  
    x1 = ws[0]  
    y1 = ws[1]  
  
    out={}  
    out['adres'] = adress  
    for k,v in uklad.items():  
        transformer = Transformer.from_crs("epsg:4326", "epsg:"+v)  
        x0,y0 = transformer.transform(x1, y1)  
        x0 =int(x0)  
        y0 = int(y0)  
        out[k]= {'x':x0, 'y':y0}  
  
    j = json.dumps(out)  
    print(j)  
  
def setUklad(wejscie, wyjscie):  
    global WEJSCIE, WYJSCIE  
    if wejscie == 'WGS84':  
        WEJSCIE = 'epsg:4326'  
    elif wejscie == '65/1':  
        WEJSCIE = 'epsg:3120'  
    elif wejscie == '2000/5':  
        WEJSCIE = 'epsg:2176'  
    elif wejscie == '2000/6':  
        WEJSCIE = 'epsg:2177'  
    elif wejscie == '2000/7':  
        WEJSCIE = 'epsg:2178'  
    elif wejscie == '2000/8':  
        WEJSCIE = 'epsg:2179'  
    elif wejscie == '1992':  
        WEJSCIE = 'epsg:2180'  
  
    if wyjscie == 'WGS84':  
        WYJSCIE = 'epsg:4326'  
    elif wyjscie == '65/1':  
        WYJSCIE = 'epsg:3120'  
    elif wyjscie == '65/2':  
        WYJSCIE = 'epsg:2172'  
    elif wyjscie == '65/3':  
        WYJSCIE = 'epsg:2173'  
    elif wyjscie == '65/4':  
        WYJSCIE = 'epsg:2174'  
    elif wyjscie == '65/5':  
        WYJSCIE = 'epsg:2175'  
    elif wyjscie == '1992':  
        WYJSCIE = 'epsg:2180'  
    return  
  
def oneTransorm(x, y):  
    global WEJSCIE, WYJSCIE  
    transformer = Transformer.from_crs(WEJSCIE, WYJSCIE)  
    x0,y0 = transformer.transform(x,y)  
    out=[]  
    out.append(x0)  
    out.append(y0)  
    return out  
  
def convertData(value):  
    lista = value.split(",")  
    setUklad(lista[1], lista[2])  
    zamiana = lista[3]  
    out =''  
    value = open(lista[0] , 'r').read()  
##    value.close()  
    os.remove(lista[0])  
    lista = value.split('\n')  
    for line in lista:  
        if len(line) > 10:  
            line = line.split(',')  
            if str(zamiana) == 'true':  
                y = line[1]  
                x = line[2]  
            else:  
                x = line[1]  
                y = line[2]  
            result = oneTransorm(x,y)  
            x0 = ('%.2f' %result[0])  
            y0 = ('%.2f' %result[1])  
            out = out+('%s,%s,%s,1' %(line[0],x0,y0))+'\n'  
  
    print(out)  
  
par  = sys.argv[1]  
convertData(par)
```

  
  
You can recalculate one point or multiple point rows.  
Input structure:  
sequence number,x position,y position, height  
(height is not relevant here).  
Eg. (2000/7 input)  
1,56800629.93,7404869.63,1  
![](https://www.b4x.com/android/forum/attachments/93364) ![](https://www.b4x.com/android/forum/attachments/93365)  
  
To fully compile, you need to upload the contents of the 'www' package from ABMaterial to the Objects folder.  
The address of the working page described as an example of a B4X connection to Python.  
Everyone can see how this works with b4x with python in the attached sources.  
  
**[SIZE=6]The address of the working page. [Working Page](https://adres.012345.best/adres/home/)[/SIZE]**