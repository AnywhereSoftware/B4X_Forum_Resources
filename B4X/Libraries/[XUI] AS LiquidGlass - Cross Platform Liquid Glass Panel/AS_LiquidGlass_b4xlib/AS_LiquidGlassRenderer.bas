B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Native Android pixel loops with a shared B4X fallback for B4i/B4J.
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

'Shared blur for the menu transition. Radius is measured in bitmap pixels.
Public Sub BlurBitmap(Bitmap As B4XBitmap, Radius As Int) As B4XBitmap
	#If B4A
	Dim native As JavaObject = Me
	Return native.RunMethod("blurBitmapFast", Array(Bitmap, Radius))
	#Else
	Dim source As BitmapCreator
	source.Initialize(Bitmap.Width, Bitmap.Height)
	source.CopyPixelsFromBitmap(Bitmap)
	Return BoxBlur(source, Max(1, Min(32, Radius))).Bitmap
	#End If
End Sub

'All distances in render pixels. Input is an already aligned backdrop crop.
Public Sub Render(Backdrop As B4XBitmap, Width As Int, Height As Int, Radius As Float, Blur As Int, Refraction As Float, Bevel As Float, Dispersion As Float, Saturation As Float, Tint As Int, Highlight As Float, LightX As Float, LightY As Float) As B4XBitmap
	Return RenderWithLighting(Backdrop, Width, Height, Radius, Blur, Refraction, Bevel, Dispersion, Saturation, Tint, Highlight, LightX, LightY, 0)
End Sub

Public Sub RenderWithLighting(Backdrop As B4XBitmap, Width As Int, Height As Int, Radius As Float, Blur As Int, Refraction As Float, Bevel As Float, Dispersion As Float, Saturation As Float, Tint As Int, Highlight As Float, LightX As Float, LightY As Float, Rim As Float) As B4XBitmap
	#If B4A
	Dim native As JavaObject = Me
	Return native.RunMethod("renderGlassFast", Array(Backdrop, Width, Height, Radius, Blur, Refraction, Bevel, Dispersion, Saturation, Tint, Highlight, LightX, LightY, Rim))
	#Else
	Dim src, output As BitmapCreator
	src.Initialize(Width, Height)
	src.CopyPixelsFromBitmap(Backdrop)
	If Blur > 0 Then src = BoxBlur(src, Blur)
	output.Initialize(Width, Height)
	Dim c, red, blue, tintColor As ARGBColor
	src.ColorToARGB(Tint, tintColor)
	Dim tintAlpha As Float = tintColor.a / 255
	Radius = Max(0, Min(Radius, Min(Width, Height) / 2))
	Bevel = Max(1, Bevel)
	Dim halfW As Float = Width / 2, halfH As Float = Height / 2
	Dim lightLength As Float = Max(0.001, Sqrt(LightX * LightX + LightY * LightY))
	For y = 0 To Height - 1
		For x = 0 To Width - 1
			Dim px As Float = x + 0.5 - halfW, py As Float = y + 0.5 - halfH
			Dim qx As Float = Abs(px) - halfW + Radius, qy As Float = Abs(py) - halfH + Radius
			Dim ox As Float = Max(qx, 0), oy As Float = Max(qy, 0)
			Dim outsideLength As Float = Sqrt(ox * ox + oy * oy)
			Dim distance As Float = outsideLength + Min(Max(qx, qy), 0) - Radius
			Dim coverage As Float = Max(0, Min(1, 0.5 - distance))
			If coverage > 0 Then
				Dim nx As Float = 0, ny As Float = 0
				If outsideLength > 0 Then
					nx = ox / outsideLength * IIf(px < 0, -1, 1)
					ny = oy / outsideLength * IIf(py < 0, -1, 1)
				Else If qx > qy Then
					nx = IIf(px < 0, -1, 1)
				Else
					ny = IIf(py < 0, -1, 1)
				End If
				Dim depth As Float = Max(0, -distance)
				Dim edge As Float = Max(0, 1 - depth / Bevel)
				Dim displacement As Float = Refraction * edge * edge
				Dim sx As Float = x - nx * displacement, sy As Float = y - ny * displacement
				src.GetARGB(Clamp(sx, Width), Clamp(sy, Height), c)
				If Dispersion > 0 And edge > 0 Then
					src.GetARGB(Clamp(sx - nx * displacement * Dispersion, Width), Clamp(sy - ny * displacement * Dispersion, Height), red)
					src.GetARGB(Clamp(sx + nx * displacement * Dispersion, Width), Clamp(sy + ny * displacement * Dispersion, Height), blue)
					c.r = red.r
					c.b = blue.b
				End If
				Dim luminance As Float = c.r * 0.2126 + c.g * 0.7152 + c.b * 0.0722
				Dim shine As Float = Highlight * Power(Max(0, (nx * LightX + ny * LightY) / lightLength), 3) * Power(Max(0, 1 - depth / 2), 2)
				shine = Min(1, shine + Max(0, Rim) * Power(Max(0, 1 - depth / 1.5), 2))
				c.r = Channel((luminance + (c.r - luminance) * Saturation) * (1 - tintAlpha) + tintColor.r * tintAlpha, shine)
				c.g = Channel((luminance + (c.g - luminance) * Saturation) * (1 - tintAlpha) + tintColor.g * tintAlpha, shine)
				c.b = Channel((luminance + (c.b - luminance) * Saturation) * (1 - tintAlpha) + tintColor.b * tintAlpha, shine)
				c.a = c.a * coverage
				output.SetARGB(x, y, c)
			End If
		Next
	Next
	Return output.Bitmap
	#End If
End Sub

#If B4A
#If Java
private static int sampleIndex(float x, float y, int width, int height) {
    return Math.max(0, Math.min(height - 1, Math.round(y))) * width + Math.max(0, Math.min(width - 1, Math.round(x)));
}
private static int channel(float value, float shine) {
    return Math.max(0, Math.min(255, Math.round(value + (255f - value) * shine)));
}
private static int[] blurPixels(int[] source, int width, int height, int radius) {
    radius = Math.max(0, Math.min(128, radius));
    if (radius == 0) return source;
    int[] horizontal = new int[source.length];
    int[] result = new int[source.length];
    int count = radius * 2 + 1;
    for (int pass = 0; pass < 2; pass++) {
        int[] input = pass == 0 ? source : horizontal;
        int[] output = pass == 0 ? horizontal : result;
        int lines = pass == 0 ? height : width;
        int length = pass == 0 ? width : height;
        for (int line = 0; line < lines; line++) {
            int sa = 0, sr = 0, sg = 0, sb = 0;
            for (int k = -radius; k <= radius; k++) {
                int p = Math.max(0, Math.min(length - 1, k));
                int c = input[pass == 0 ? line * width + p : p * width + line];
                int a = c >>> 24;
                sa += a; sr += ((c >> 16) & 255) * a; sg += ((c >> 8) & 255) * a; sb += (c & 255) * a;
            }
            for (int pos = 0; pos < length; pos++) {
                int color = Math.round((float)sa / count) << 24;
                if (sa > 0) color |= Math.round((float)sr / sa) << 16 | Math.round((float)sg / sa) << 8 | Math.round((float)sb / sa);
                output[pass == 0 ? line * width + pos : pos * width + line] = color;
                int oldPos = Math.max(0, Math.min(length - 1, pos - radius));
                int newPos = Math.max(0, Math.min(length - 1, pos + radius + 1));
                int old = input[pass == 0 ? line * width + oldPos : oldPos * width + line];
                int next = input[pass == 0 ? line * width + newPos : newPos * width + line];
                int oa = old >>> 24, na = next >>> 24;
                sa += na - oa;
                sr += ((next >> 16) & 255) * na - ((old >> 16) & 255) * oa;
                sg += ((next >> 8) & 255) * na - ((old >> 8) & 255) * oa;
                sb += (next & 255) * na - (old & 255) * oa;
            }
        }
    }
    return result;
}
public android.graphics.Bitmap blurBitmapFast(android.graphics.Bitmap bitmap, int radius) {
    int w = bitmap.getWidth(), h = bitmap.getHeight();
    int[] pixels = new int[w * h];
    bitmap.getPixels(pixels, 0, w, 0, 0, w, h);
    return android.graphics.Bitmap.createBitmap(blurPixels(pixels, w, h, Math.max(1, Math.min(32, radius))), w, h, android.graphics.Bitmap.Config.ARGB_8888);
}
public android.graphics.Bitmap renderGlassFast(android.graphics.Bitmap backdrop, int width, int height, float radius, int blur,
    float refraction, float bevel, float dispersion, float saturation, int tint, float highlight, float lightX, float lightY, float rim) {
    android.graphics.Bitmap scaled = android.graphics.Bitmap.createScaledBitmap(backdrop, width, height, true);
    int[] pixels = new int[width * height];
    scaled.getPixels(pixels, 0, width, 0, 0, width, height);
    pixels = blurPixels(pixels, width, height, blur);
    int[] output = new int[pixels.length];
    float alpha = (tint >>> 24) / 255f, inverseAlpha = 1f - alpha;
    float tr = ((tint >> 16) & 255) * alpha, tg = ((tint >> 8) & 255) * alpha, tb = (tint & 255) * alpha;
    radius = Math.max(0, Math.min(radius, Math.min(width, height) / 2f));
    bevel = Math.max(1, bevel);
    float hw = width / 2f, hh = height / 2f;
    float lightLength = Math.max(.001f, (float)Math.sqrt(lightX * lightX + lightY * lightY));
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            float px = x + .5f - hw, py = y + .5f - hh;
            float qx = Math.abs(px) - hw + radius, qy = Math.abs(py) - hh + radius;
            float ox = Math.max(qx, 0f), oy = Math.max(qy, 0f);
            float length = (float)Math.sqrt(ox * ox + oy * oy);
            float distance = length + Math.min(Math.max(qx, qy), 0f) - radius;
            float coverage = Math.max(0f, Math.min(1f, .5f - distance));
            if (coverage <= 0f) continue;
            float nx = 0f, ny = 0f;
            if (length > 0f) { nx = ox / length * (px < 0 ? -1f : 1f); ny = oy / length * (py < 0 ? -1f : 1f); }
            else if (qx > qy) nx = px < 0 ? -1f : 1f;
            else ny = py < 0 ? -1f : 1f;
            float depth = Math.max(0f, -distance), edge = Math.max(0f, 1f - depth / bevel);
            float displacement = refraction * edge * edge;
            float sx = x - nx * displacement, sy = y - ny * displacement;
            int c = pixels[sampleIndex(sx, sy, width, height)];
            float r = (c >> 16) & 255, g = (c >> 8) & 255, b = c & 255;
            if (dispersion > 0f && edge > 0f) {
                r = (pixels[sampleIndex(sx - nx * displacement * dispersion, sy - ny * displacement * dispersion, width, height)] >> 16) & 255;
                b = pixels[sampleIndex(sx + nx * displacement * dispersion, sy + ny * displacement * dispersion, width, height)] & 255;
            }
            float luminance = r * .2126f + g * .7152f + b * .0722f;
            float light = Math.max(0f, (nx * lightX + ny * lightY) / lightLength);
            float litEdge = Math.max(0f, 1f - depth / 2f), rimEdge = Math.max(0f, 1f - depth / 1.5f);
            float shine = Math.min(1f, highlight * light * light * light * litEdge * litEdge + Math.max(0f, rim) * rimEdge * rimEdge);
            int rr = channel((luminance + (r - luminance) * saturation) * inverseAlpha + tr, shine);
            int gg = channel((luminance + (g - luminance) * saturation) * inverseAlpha + tg, shine);
            int bb = channel((luminance + (b - luminance) * saturation) * inverseAlpha + tb, shine);
            output[y * width + x] = Math.round((c >>> 24) * coverage) << 24 | rr << 16 | gg << 8 | bb;
        }
    }
    return android.graphics.Bitmap.createBitmap(output, width, height, android.graphics.Bitmap.Config.ARGB_8888);
}
#End If
#End If

#If Not(B4A)
Private Sub Channel(Value As Float, Shine As Float) As Int
	Return Max(0, Min(255, Value + (255 - Value) * Shine))
End Sub

Private Sub Clamp(Value As Float, Size As Int) As Int
	Return Max(0, Min(Size - 1, Round(Value)))
End Sub

'Separable sliding-window blur, O(width * height), with clamped boundaries.
'Accumulates premultiplied channels to avoid dark fringes at transparent pixels.
Private Sub BoxBlur(Source As BitmapCreator, Radius As Int) As BitmapCreator
	Dim horizontal, result As BitmapCreator
	horizontal.Initialize(Source.mWidth, Source.mHeight)
	result.Initialize(Source.mWidth, Source.mHeight)
	For pass = 0 To 1
		Dim input As BitmapCreator = Source, target As BitmapCreator = horizontal
		If pass = 1 Then
			input = horizontal
			target = result
		End If
		Dim lineCount As Int = IIf(pass = 0, Source.mHeight, Source.mWidth)
		Dim lineLength As Int = IIf(pass = 0, Source.mWidth, Source.mHeight)
		Dim count As Int = Radius * 2 + 1
		Dim c As ARGBColor
		For line = 0 To lineCount - 1
			Dim sa As Double = 0, sr As Double = 0, sg As Double = 0, sb As Double = 0
			For k = -Radius To Radius
				ReadPixel(input, pass, line, Clamp(k, lineLength), c)
				sa = sa + c.a
				sr = sr + c.r * c.a
				sg = sg + c.g * c.a
				sb = sb + c.b * c.a
			Next
			For pos = 0 To lineLength - 1
				Dim averaged As ARGBColor
				averaged.a = Round(sa / count)
				If sa > 0 Then
					averaged.r = Round(sr / sa)
					averaged.g = Round(sg / sa)
					averaged.b = Round(sb / sa)
				End If
				If pass = 0 Then target.SetARGB(pos, line, averaged) Else target.SetARGB(line, pos, averaged)
				ReadPixel(input, pass, line, Clamp(pos - Radius, lineLength), c)
				sa = sa - c.a
				sr = sr - c.r * c.a
				sg = sg - c.g * c.a
				sb = sb - c.b * c.a
				ReadPixel(input, pass, line, Clamp(pos + Radius + 1, lineLength), c)
				sa = sa + c.a
				sr = sr + c.r * c.a
				sg = sg + c.g * c.a
				sb = sb + c.b * c.a
			Next
		Next
	Next
	Return result
End Sub

Private Sub ReadPixel(Source As BitmapCreator, Pass As Int, Line As Int, Position As Int, Color As ARGBColor)
	If Pass = 0 Then Source.GetARGB(Position, Line, Color) Else Source.GetARGB(Line, Position, Color)
End Sub
#End If
