### Snipped Manager Part 2 by Guenter Becker
### 03/02/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/128187/)

As requested from some forum friends now I like to explain how to adopt the Snipped-Manager programm.  
  
1. Install the programm (copy all programm files to a desired directory)  
2. Got to the Directory: SnippedManager/SyntaxFiles  
3. Make a Backup of the directory content  
4. Use a Texteditor like Notepad and open the file B4A.syn  
  

```B4X
<?xml version="1.0" encoding="utf-8" ?>  
<Language Name="B4A" Startblock="CS Code">  
<FileTypes>  
    <FileType Extension=".bas" Name="B4A Module"/>  
</FileTypes>  
  
    <Block Name="CS Code" Style="CS Code" PatternStyle="CS Keyword" EscapeChar="" IsMultiline="true">  
  
  
  
        <!– Keywords that can exist inside this block –>  
        <Keywords>  
            <PatternGroup Name="Keywords" Style="CS Keyword">  
                <Patterns>  
Sub  
Function  
Property  
Declare  
Public  
Private  
Friend  
Dim  
Global  
Option  
Explicit  
Not  
And  
Xor  
Or  
String  
Long  
Integer  
Boolean  
Currency  
Date  
Byte  
Single  
Double  
Static  
As  
Const  
  
  
  
  
                </Patterns>  
            </PatternGroup>  
            <PatternGroup Name="Constants" Style="CS Constant">  
                <Patterns>  
VbCrLf  
VbCr  
VbLf  
                </Patterns>  
            </PatternGroup>  
            <PatternGroup Name="Numbers" Style="CS Number">  
                <Pattern Text="(&amp;h[0-9,a-f,A-F]+)" IsComplex="true" />  
                <Pattern Text="(&amp;H[0-9,a-f,A-F]+)" IsComplex="true" />  
                <Pattern Text="([0-9]+)" IsComplex="true" />  
  
            </PatternGroup>  
            <!– Datatypes for c# –>  
            <PatternGroup Name="DataTypes" Style="CS Datatype" CaseSensitive="true">  
  
            </PatternGroup>  
        </Keywords>  
        <!– Operators that can exist inside this block –>  
        <Operators>  
            <PatternGroup name="Operators" Style="CS Operator">  
                <Pattern Text="." />  
                <Pattern Text="!" />  
                <Pattern Text=":" />  
                <Pattern Text="^" />  
                <Pattern Text="*" />  
                <Pattern Text="/" />  
                <Pattern Text="+" />  
                <Pattern Text="-" />  
                <Pattern Text="=" />  
                <Pattern Text=";" />  
                <Pattern Text="|" />  
                <Pattern Text="&gt;" />  
                <Pattern Text="&lt;" />  
  
            </PatternGroup>  
        </Operators>  
        <!– Blocks that can exist inside this block –>  
        <ChildBlocks>  
            <Child Name="CS Singleline Comment" />  
            <Child Name="CS String" />  
            <Child Name="CS Sub" />  
        </ChildBlocks>  
    </Block>  
  
    <Block Name="CS Sub" Style="CS Code" PatternStyle="CS Keyword" EscapeChar="" IsMultiline="true">  
  
        <Scope Start="((?i)(?&lt;!(declare)(\s)+)(sub))" End="((?i)(end)(\s)+(sub))" StartIsComplex="true" EndIsComplex="true"     EndIsSeparator="true"    Style="CS Keyword" Text="Sub *** …" CauseIndent="true"/>  
        <Scope Start="((?i)(?&lt;!(declare)(\s)+)(function))" End="((?i)(end)(\s)+(function))" StartIsComplex="true" EndIsComplex="true"     EndIsSeparator="true"    Style="CS Keyword" Text="Sub *** …" CauseIndent="true"/>  
  
        <Scope Start="Property"     End="((?i)(end)(\s)+(property))" EndIsComplex="true"     EndIsSeparator="true"    Style="CS Keyword" Text="Propery *** …" CauseIndent="true"/>  
        <Scope Start="type"         End="((?i)(end)(\s)+(type))"      EndIsComplex="true"     EndIsSeparator="true"    Style="CS Keyword" Text="Type *** …" CauseIndent="true"/>  
        <Scope Start="enum"         End="((?i)(end)(\s)+(enum))"     EndIsComplex="true"     EndIsSeparator="true"    Style="CS Keyword" Text="Enum *** …" CauseIndent="true"/>  
  
  
  
        <!– Keywords that can exist inside this block –>  
        <Keywords>  
            <PatternGroup Name="Keywords" Style="CS Keyword">  
                <Patterns>  
  
Public  
Private  
Friend  
Dim  
Global  
Option  
Explicit  
For  
If  
End  
Next  
Do  
Loop  
While  
Wend  
Not  
And  
Xor  
Or  
Select  
Case  
Else  
GoTo  
GoSub  
String  
Long  
Integer  
Boolean  
Currency  
Date  
Byte  
Single  
Double  
Then  
Static  
As  
Exit  
Function  
Sub  
Property  
Nothing  
Set  
Get  
Let  
LSet  
On  
Error  
Resume  
Const  
Is  
  
  
  
  
  
                </Patterns>  
            </PatternGroup>  
            <PatternGroup Name="Constants" Style="CS Constant">  
                <Patterns>  
VbCrLf  
VbCr  
VbLf  
                </Patterns>  
            </PatternGroup>  
            <PatternGroup Name="Numbers" Style="CS Number">  
                <Pattern Text="(&amp;h[0-9a-fA-F]+)" IsComplex="true" />  
                <Pattern Text="(&amp;H[0-9a-fA-F]+)" IsComplex="true" />  
                <Pattern Text="([0-9]+)" IsComplex="true" />  
            </PatternGroup>  
            <!– Datatypes for c# –>  
            <PatternGroup Name="DataTypes" Style="CS Datatype" CaseSensitive="true">  
  
            </PatternGroup>  
        </Keywords>  
        <!– Operators that can exist inside this block –>  
        <Operators>  
            <PatternGroup name="Operators" Style="CS Operator">  
                <Pattern Text="." />  
                <Pattern Text="!" />  
                <Pattern Text=":" />  
                <Pattern Text="^" />  
                <Pattern Text="*" />  
                <Pattern Text="/" />  
                <Pattern Text="+" />  
                <Pattern Text="-" />  
                <Pattern Text="=" />  
                <Pattern Text=";" />  
                <Pattern Text="|" />  
                <Pattern Text="&gt;" />  
                <Pattern Text="&lt;" />  
  
            </PatternGroup>  
        </Operators>  
        <!– Blocks that can exist inside this block –>  
        <ChildBlocks>  
            <Child Name="CS Singleline Comment" />  
            <Child Name="CS String" />  
        </ChildBlocks>  
    </Block>  
  
  
    <Block Name="CS Singleline Comment" Style="CS Comment" PatternStyle="" EscapeChar="" IsMultiline="false">  
        <Scope Start="'" End=""     Style="CS Comment"  Text="" />  
    </Block>  
  
    <Block Name="CS String" Style="CS String" PatternStyle="" IsMultiline="false">  
        <Scope Start="&quot;" End="&quot;"     Style="CS String"  Text="" />  
        <Operators>  
            <PatternGroup name="URL" Style="CS URL">  
                <Pattern Text="http://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" IsComplex="true" />  
            </PatternGroup>  
        </Operators>  
    </Block>  
      
    <Style Name="CS Code" ForeColor="" BackColor="" Bold="false" Italic="false" Underline="false" />  
    <Style Name="CS Constant" ForeColor="Magenta" BackColor="" Bold="true" Italic="false" Underline="false" />  
    <Style Name="CS Code Pattern" ForeColor="" BackColor="" Bold="true" Italic="false" Underline="false" />  
    <Style Name="CS Comment" ForeColor="green" BackColor="" Bold="false" Italic="true" Underline="false" />  
    <Style Name="CS String" ForeColor="Teal" BackColor="" Bold="false" Italic="false" Underline="false" />  
    <Style Name="CS Number" ForeColor="Teal" BackColor="" Bold="true" Italic="false" Underline="false" />  
    <Style Name="CS Operator" ForeColor="Red" BackColor="" Bold="false" Italic="false" Underline="false" />  
    <Style Name="CS Keyword" ForeColor="Blue" BackColor="" Bold="true" Italic="false" Underline="false" />  
    <Style Name="CS Datatype" ForeColor="DarkBlue" BackColor="" Bold="true" Italic="false" Underline="false" />  
    <Style Name="CS URL" ForeColor="Blue" BackColor="" Bold="false" Italic="false" Underline="true" />  
</Language>
```

  
  
Change:  
  
**<Language Name="B4A" Startblock="B4A Code">**  
<FileTypes>  
 <**FileType Extension=".bas" Name="B4A Module"**/>  
</FileTypes>  
  
Leave the rest unchanged except the listed language command words.  
  
4. Save the File with a new name like B4A.syn  
  
If you do not want to have a long selection list delete all .syn Files for othe languages like this:  
  
Name Größe Typ Geändert Attr  
B4A.syn 6,07 KiB SYN-Datei Heute, 11:01 A  
B4i.syn 6,07 KiB SYN-Datei Heute, 10:47 A  
B4J.syn 6,07 KiB SYN-Datei Heute, 10:47 A  
B4XPages.syn 6,08 KiB SYN-Datei Heute, 10:48 A  
Java.syn 6,14 KiB SYN-Datei 04.03.2008, 18:20 A  
JavaScript.syn 8,11 KiB SYN-Datei 04.03.2008, 18:20 A  
MySQL\_SQL.syn 5,02 KiB SYN-Datei 04.03.2008, 18:20 A  
StopWords.txt 9,61 KiB Textdokument 07.03.2010, 22:33 A  
SystemPolicies.syn 4,83 KiB SYN-Datei 04.03.2008, 18:20 A  
Template.syn 2,95 KiB SYN-Datei 04.03.2008, 18:20 A  
Text.syn 1,63 KiB SYN-Datei 04.03.2008, 18:20 A  
XML.syn 15,8 KiB SYN-Datei 04.03.2008, 18:20 A  
  
That' s all, good luck.