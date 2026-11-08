B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
End Sub

'Implementation of <link>JavaFxSVG|https://github.com/codecentric/javafxsvg </link> from github
'Requires additionaljars
'<code>#AdditionalJar: javafxSVG\javafxsvg-1.3.0
'#AdditionalJar: javafxSVG\xmlgraphics-commons-2.6
'#AdditionalJar: javafxSVG\batik-all-1.14
'#AdditionalJar: javafxSVG\batik-ext-1.6.1
'
''The next two are For Java 11 & 14 only, Comment if using Java 8
''#VirtualMachineArgs: --add-opens javafx.graphics/com.sun.javafx.iio.common=ALL-UNNAMED --add-opens javafx.graphics/com.sun.javafx.iio=ALL-UNNAMED
''#PackagerProperty: VMArgs = --add-opens javafx.graphics/com.sun.javafx.iio.common=b4j --add-opens javafx.graphics/com.sun.javafx.iio=b4j
'</code>
'Downloadable from <link>Dropbox|https://www.dropbox.com/s/pow6oasic70av9y/javafxSVG.zip?dl=0</link>
'Interesting <link>Blog post|https://blog.codecentric.de/en/2015/03/adding-custom-image-renderer-javafx-8/ </link>
Public Sub Initialize(TrySizeFromFile As Boolean)
	Dim TJO As JavaObject
	TJO.InitializeStatic("de.codecentric.centerdevice.javafxsvg.SvgImageLoaderFactory")
	If TrySizeFromFile Then
		Dim DP As JavaObject
		DP.InitializeNewInstance("de.codecentric.centerdevice.javafxsvg.dimension.PrimitiveDimensionProvider",Null)
		TJO.RunMethod("install",Array(DP))
	Else
		TJO.RunMethod("install",Null)
	End If
End Sub