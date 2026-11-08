B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals

End Sub

Public Sub Initialize
	
End Sub

' Mode: AUTOMATIC, FIT_EXACT, FIT_TO_HEIGHT, and FIT_TO_WIDTH
' Method: AUTOMATIC
Public Sub ResizeImage (InputDir As String, OutputDir As String, Filename As String, Width As Int, Height As Int, Mode As String)
	If File.Exists(InputDir, Filename) = False Then
		LogError("File not found")
		Return
	End If
	Dim FileExt As String = Filename.SubString2(Filename.LastIndexof("."), Filename.Length)
	Select FileExt.ToUpperCase
		Case ".JPG", ".JPEG", ".BMP", ".WBMP", ".PNG" ' , ".GIF" ' <-- GIF not working
			Select Mode.ToUpperCase
				Case "FIT_EXACT"
					ResizeExact(File.Combine(InputDir, Filename), File.Combine(OutputDir, $"${Filename.SubString2(0, Filename.IndexOf("."))}_resized${FileExt}"$), Width, Height, FileExt.SubString(1).ToUpperCase)
				Case "FIT_TO_WIDTH"
					ResizeToWidth(File.Combine(InputDir, Filename), File.Combine(OutputDir, $"${Filename.SubString2(0, Filename.IndexOf("."))}_resized${FileExt}"$), Width, Height, FileExt.SubString(1).ToUpperCase)
				Case "FIT_TO_HEIGHT"
					ResizeToHeight(File.Combine(InputDir, Filename), File.Combine(OutputDir, $"${Filename.SubString2(0, Filename.IndexOf("."))}_resized${FileExt}"$), Width, Height, FileExt.SubString(1).ToUpperCase)
				Case Else ' AUTOMATIC
					Resize(File.Combine(InputDir, Filename), File.Combine(OutputDir, $"${Filename.SubString2(0, Filename.IndexOf("."))}_resized${FileExt}"$), Width, Height, FileExt.SubString(1).ToUpperCase)
			End Select
		Case Else
			LogError("Unsupported format")
			Return
	End Select
End Sub

Private Sub jo As JavaObject
	Return Me
End Sub

Private Sub Resize (input As String, output As String, width As Int, height As Int, filetype As String)
	jo.RunMethod("Resize", Array(input, output, width, height, filetype))
End Sub

Private Sub ResizeExact (input As String, output As String, width As Int, height As Int, filetype As String)
	jo.RunMethod("ResizeExact", Array(input, output, width, height, filetype))
End Sub

Private Sub ResizeToWidth (input As String, output As String, width As Int, height As Int, filetype As String)
	jo.RunMethod("ResizeToWidth", Array(input, output, width, height, filetype))
End Sub

Private Sub ResizeToHeight (input As String, output As String, width As Int, height As Int, filetype As String)
	jo.RunMethod("ResizeToHeight", Array(input, output, width, height, filetype))
End Sub

#If Java
	import java.io.File;
	import org.imgscalr.Scalr;
	import javax.imageio.ImageIO;
	import java.awt.image.BufferedImage;

	/**
	* Mode – used to define the resizing modes that the algorithm will use. 
	* For example, we can define whether we would like to keep proportions of the image 
	* Possible options are AUTOMATIC, FIT_EXACT, FIT_TO_HEIGHT, and FIT_TO_WIDTH
	* Method – instructs the resizing process so that its focus is on speed, quality, or both. 
	* Possible values are AUTOMATIC, BALANCED, QUALITY, SPEED, ULTRA_QUALITY
	**/
	
    //public static BufferedImage simpleResizeImage(BufferedImage originalImage, int targetWidth) {
    //    return Scalr.resize(originalImage, targetWidth);
    //}
	
    //public static BufferedImage resizeImage(BufferedImage originalImage, int targetWidth, int targetHeight) {
    //    return Scalr.resize(originalImage, Scalr.Method.AUTOMATIC, Scalr.Mode.AUTOMATIC, targetWidth, targetHeight, Scalr.OP_ANTIALIAS);
    //}
	
	public static void Resize (String input, String output, int width, int height, String filetype) throws Exception
	{
		BufferedImage originalImage = ImageIO.read(new File(input));
		BufferedImage outputImage = Scalr.resize(originalImage, Scalr.Method.AUTOMATIC, Scalr.Mode.AUTOMATIC, width, height, Scalr.OP_ANTIALIAS);
		ImageIO.write(outputImage, filetype, new File(output));
	}

	public static void ResizeExact (String input, String output, int width, int height, String filetype) throws Exception
	{
		BufferedImage originalImage = ImageIO.read(new File(input));
		BufferedImage outputImage = Scalr.resize(originalImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_EXACT, width, height, Scalr.OP_ANTIALIAS);
		ImageIO.write(outputImage, filetype, new File(output));
	}
	
	public static void ResizeToWidth (String input, String output, int width, int height, String filetype) throws Exception
	{
		BufferedImage originalImage = ImageIO.read(new File(input));
		BufferedImage outputImage = Scalr.resize(originalImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_WIDTH, width, height, Scalr.OP_ANTIALIAS);
		ImageIO.write(outputImage, filetype, new File(output));
	}
	
	public static void ResizeToHeight (String input, String output, int width, int height, String filetype) throws Exception
	{
		BufferedImage originalImage = ImageIO.read(new File(input));
		BufferedImage outputImage = Scalr.resize(originalImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, width, height, Scalr.OP_ANTIALIAS);
		ImageIO.write(outputImage, filetype, new File(output));
	}		
#End If