B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Type TikaParseResult (Text As String, Metadata As Map, Success As Boolean, Exception As Exception)
	Public BodyContentLengthLimit As Int = 100000
	Public Const OUTPUT_PLAIN = 1, OUTPUT_XHTML = 2 As Int
	Public OutputTextFormat As Int = OUTPUT_PLAIN
	Public Password As String
End Sub

Public Sub Initialize
	Me.as(JavaObject).RunMethod("warmUp", Null)
End Sub

'Converts a string to an InputStream.
Public Sub StringToInputStream (s As String) As InputStream
	Dim in As InputStream
	Dim b() As Byte = s.GetBytes("utf8")
	in.InitializeFromBytesArray(b, 0, b.Length)
	Return in
End Sub

'Parses the document and closes the input stream.
'<code>Wait For (tik.Parse(File.OpenInput("C:\...", "filename.doc"))) Complete (Result As TikaParseResult)</code>
Public Sub Parse (Input As InputStream) As ResumableSub
	Dim Metadata As JavaObject
	Metadata.InitializeNewInstance("org.apache.tika.metadata.Metadata", Null)
	Dim ContentHandler As JavaObject = GetContentHandler
	Dim parser As JavaObject
	parser.InitializeNewInstance("org.apache.tika.parser.AutoDetectParser", Null)
	Dim e(1) As Object
	Dim sf As Object = Me.as(JavaObject).RunMethod("parse", Array(ContentHandler, parser, Input, Metadata, e, Password))
	Wait For (sf) parse_completed(Success As Boolean)
	Input.Close
	Dim result As TikaParseResult = CreateTikaParseResult("", False)
	result.Text = ContentHandler.RunMethod("toString", Null)
	result.Metadata = MetadataToMap(Metadata)
	result.Success = True
	If Success = False Then result.Exception = e(0)
	Return result
End Sub

Private Sub GetContentHandler As JavaObject
	Dim ContentHandler As JavaObject
	Select OutputTextFormat
		Case OUTPUT_PLAIN
			ContentHandler.InitializeNewInstance("org.apache.tika.sax.BodyContentHandler", Array(BodyContentLengthLimit))
		Case OUTPUT_XHTML
			ContentHandler.InitializeNewInstance("org.apache.tika.sax.ToXMLContentHandler", Null)
	End Select
	Return ContentHandler
End Sub

Private Sub MetadataToMap (meta As JavaObject) As Map
	Dim res As Map
	res.Initialize
	Dim names() As String = meta.RunMethod("names", Null)
	For Each name As String In names
		Dim values() As String = meta.RunMethod("getValues", Array(name))
		Dim v As List = values
		res.Put(name, v)
	Next
	Return res
End Sub


Private Sub CreateTikaParseResult (Text As String, Success As Boolean) As TikaParseResult
	Dim t1 As TikaParseResult
	t1.Initialize
	t1.Text = Text
	t1.Success = Success
	Return t1
End Sub

#if Java
import java.util.concurrent.Callable;
import org.apache.tika.parser.PasswordProvider;
public void warmUp() {
	BA.runAsync(getBA(), null, "ignore", new Object[] {false}, 
		new Callable<Object[]>() {
			public Object[] call() throws Exception {
				try {
				new org.apache.tika.metadata.Metadata();
				new org.apache.tika.parser.AutoDetectParser();
					return new Object[] {true};
				} catch (Exception e) {
					BA.Log("" + e);
					throw e;
				}
			}
		}
	);
}
public Object parse(org.xml.sax.ContentHandler contentHandler, org.apache.tika.parser.Parser parser, java.io.InputStream input, org.apache.tika.metadata.Metadata metadata, Object[] exceptionOut, String password) {
	Object sender = new Object();
	BA.runAsync(getBA(), sender, "parse_completed", new Object[] {false}, 
		new Callable<Object[]>() {
			public Object[] call() throws Exception {
				try {
					org.apache.tika.parser.ParseContext context = new org.apache.tika.parser.ParseContext();
					if (password.length() > 0)
						context.set(PasswordProvider.class, new PasswordProvider() {
			                @Override
			                public String getPassword(org.apache.tika.metadata.Metadata metadata) {
			                    return password;
			                }
           			 });
					parser.parse(input, contentHandler, metadata,context);
					return new Object[] {true};
				} catch (Exception e) {
					BA.Log("" + e);
					exceptionOut[0] = e;
					throw e;
				}
			}
		}
	);
	return sender;
}
#End If