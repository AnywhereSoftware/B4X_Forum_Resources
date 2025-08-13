B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@

'Subs in this static code module will be accessible from all modules.

'Static code module
Private Sub Process_Globals
	Private mMimeType As Map
	Private mThemes As List
End Sub

Public Sub Initialize
	Log("INITIALIZE CMW_Utils")
	
	mMimeType = CreateMap( _
"APL":"text/apl", _
"B4X":"text/b4x", _
"B4S":"text/b4s", _
"PGP": "application/pgp", _
"PGP Encrypted": "application/pgp-encrypted", _
"PGP Keys": "application/pgp-keys", _
"PGP Signature": "application/pgp-signature", _
"ASN.1":"text/x-ttcn-asn", _
"Asterisk":"text/x-asterisk", _
"Brainfuck":"text/x-brainfuck", _
"C":"text/x-csrc", _
"C++":"text/x-c++src", _
"Cobol":"text/x-cobol", _
"C#":"text/x-csharp", _
"Clojure":"text/x-clojure", _
"ClojureScript":"text/x-clojurescript", _
"Closure Stylesheets (GSS)":"text/x-gss", _
"CMake":"text/x-cmake", _
"CoffeeScript":"application/vnd.coffeescript", _ ' "text/coffeescript": "text/x-coffeescript"], _
"Common Lisp":"text/x-common-lisp", _
"Cypher":"application/x-cypher-query", _
"Cython":"text/x-cython", _
"Crystal":"text/x-crystal", _
"CSS":"text/css", _
"CQL":"text/x-cassandra", _
"D":"text/x-d", _
"Dart": "application/dart", _ ': "text/x-dart"], _
"diff":"text/x-diff", _
"Django":"text/x-django", _
"Dockerfile":"text/x-dockerfile", _
"DTD":"application/xml-dtd", _
"Dylan":"text/x-dylan", _
"EBNF":"text/x-ebnf", _
"ECL":"text/x-ecl", _
"edn":"application/edn", _
"Eiffel":"text/x-eiffel", _
"Elm":"text/x-elm", _
"Embedded Javascript":"application/x-ejs", _
"Embedded Ruby":"application/x-erb", _
"Erlang":"text/x-erlang", _
"Esper":"text/x-esper", _
"Factor":"text/x-factor", _
"FCL":"text/x-fcl", _
"Forth":"text/x-forth", _
"Fortran":"text/x-fortran", _
"F#":"text/x-fsharp", _
"Gas":"text/x-gas", _
"Gherkin":"text/x-feature", _
"GitHub Flavored Markdown":"text/x-gfm", _
"Go":"text/x-go", _
"Groovy":"text/x-groovy", _
"HAML":"text/x-haml", _
"Haskell":"text/x-haskell", _
"Haskell (Literate)":"text/x-literate-haskell", _
"Haxe":"text/x-haxe", _
"HXML":"text/x-hxml", _
"ASP.NET":"application/x-aspx", _
"HTML":"text/html", _
"HTTP":"message/http", _
"IDL":"text/x-idl", _
"Pug":"text/x-pug", _
"Java":"text/x-java", _
"Java Server Pages":"application/x-jsp", _
"JavaScript":"application/javascript", _ ': "text/ecmascript": "text/javascript": "application/x-javascript": "application/ecmascript"],, _
"JSON": "application/json", _ ': "application/x-json"], _
"JSON-LD":"application/ld+json", _
"JSX":"text/jsx", _
"Jinja2":"text/jinja2", _
"Julia":"text/x-julia", _
"Kotlin":"text/x-kotlin", _
"LESS":"text/x-less", _
"LiveScript":"text/x-livescript", _
"Lua":"text/x-lua", _
"Markdown":"text/x-markdown", _
"mIRC":"text/mirc", _
"MariaDB SQL":"text/x-mariadb", _
"Mathematica":"text/x-mathematica", _
"Modelica":"text/x-modelica", _
"MUMPS":"text/x-mumps", _
"MS SQL":"text/x-mssql", _
"mbox":"application/mbox", _
"MySQL":"text/x-mysql", _
"Nginx":"text/x-nginx-conf", _
"NSIS":"text/x-nsis", _
"NTriples":"application/n-triples", _ ': "application/n-quads": "text/n-triples"],, _
"Objective-C":"text/x-objectivec", _
"Objective-C++":"text/x-objectivec++", _
"OCaml":"text/x-ocaml", _
"Octave":"text/x-octave", _
"Oz":"text/x-oz", _
"Pascal":"text/x-pascal", _
"PEG.js":"null", _
"Perl":"text/x-perl", _
"PHP": "text/x-php", _ ': "application/x-httpd-php": "application/x-httpd-php-open"], _
"Pig":"text/x-pig", _
"Plain Text":"text/plain", _
"PLSQL":"text/x-plsql", _
"PostgreSQL":"text/x-pgsql", _
"PowerShell":"application/x-powershell", _
"Properties files":"text/x-properties", _
"ProtoBuf":"text/x-protobuf", _
"Python":"text/x-python", _
"Puppet":"text/x-puppet", _
"Q":"text/x-q", _
"R":"text/x-rsrc", _
"reStructuredText":"text/x-rst", _
"RPM Changes":"text/x-rpm-changes", _
"RPM Spec":"text/x-rpm-spec", _
"Ruby":"text/x-ruby", _
"Rust":"text/x-rustsrc", _
"SAS":"text/x-sas", _
"Sass":"text/x-sass", _
"Scala":"text/x-scala", _
"Scheme":"text/x-scheme", _
"SCSS":"text/x-scss", _
"Shell": "text/x-sh", _ ': "application/x-sh"], _
"Sieve":"application/sieve", _
"Slim": "text/x-slim",  _ ': "application/x-slim"], _
"Smalltalk":"text/x-stsrc", _
"Smarty":"text/x-smarty", _
"Solr":"text/x-solr", _
"SML":"text/x-sml", _
"Soy":"text/x-soy", _
"SPARQL":"application/sparql-query", _
"Spreadsheet":"text/x-spreadsheet", _
"SQL":"text/x-sql", _
"SQLite":"text/x-sqlite", _
"Squirrel":"text/x-squirrel", _
"Stylus":"text/x-styl", _
"Swift":"text/x-swift", _
"sTeX":"text/x-stex", _
"LaTeX":"text/x-latex", _
"SystemVerilog":"text/x-systemverilog", _
"Tcl":"text/x-tcl", _
"Textile":"text/x-textile", _
"TiddlyWiki":"text/x-tiddlywiki", _
"Tiki wiki":"text/tiki", _
"TOML":"text/x-toml", _
"Tornado":"text/x-tornado", _
"troff":"text/troff", _
"TTCN":"text/x-ttcn", _
"TTCN_CFG":"text/x-ttcn-cfg", _
"Turtle":"text/turtle", _
"TypeScript":"application/typescript", _
"TypeScript-JSX":"text/typescript-jsx", _
"Twig":"text/x-twig", _
"Web IDL":"text/x-webidl", _
"VB.NET":"text/x-vb", _
"VBScript":"text/vbscript", _
"Velocity":"text/velocity", _
"Verilog":"text/x-verilog", _
"VHDL":"text/x-vhdl", _
"Vue.js Component": "script/x-vue", _ ': "text/x-vue"], _
"XML":"application/xml", _ ': "text/xml"], _
"XQuery":"application/xquery", _
"Yacas":"text/x-yacas", _
"YAML":"text/x-yaml", _ ': "text/yaml"], _
"Z80":"text/x-z80", _
"mscgen":"text/x-mscgen", _
"xu":"text/x-xu", _
"msgenny":"text/x-msgenny", _
"WebAssembly":"text/webassembly" _
)

	mThemes = Array As String( _
"default", _
"3024-day", _
"3024-night", _
"abcdef", _
"ambiance", _
"ayu-dark", _
"ayu-mirage", _
"base16-dark", _
"base16-light", _
"bespin", _
"blackboard", _
"cobalt", _
"colorforth", _
"darcula", _
"dracula", _
"duotone-dark", _
"duotone-light", _
"eclipse", _
"elegant", _
"erlang-dark", _
"gruvbox-dark", _
"hopscotch", _
"icecoder", _
"idea", _
"isotope", _
"lesser-dark", _
"liquibyte", _
"lucario", _
"material", _
"material-darker", _
"material-palenight", _
"material-ocean", _
"mbo", _
"mdn-like", _
"midnight", _
"monokai", _
"moxer", _
"neat", _
"neo", _
"night", _
"nord", _
"oceanic-next", _
"panda-syntax", _
"paraiso-dark", _
"paraiso-light", _
"pastel-on-dark", _
"railscasts", _
"rubyblue", _
"seti", _
"shadowfox", _
"solarizeddark", _
"solarizedlight", _
"the-matrix", _
"tomorrow-night-bright", _
"tomorrow-night-eighties", _
"ttcn", _
"twilight", _
"vibrant-ink", _
"xq-dark", _
"xq-light", _
"yeti", _
"yonce", _
"zenburn")
	
End Sub

Public Sub MimeType(Name As String) As String
	Return mMimeType.GetDefault(Name,"")
End Sub

Public Sub Languages As List
	Dim L As List
	L.Initialize
	For Each s As String In mMimeType.Keys
		L.Add(s)
	Next
	Return L
End Sub

Public Sub Themes As List
	Return mThemes
End Sub


