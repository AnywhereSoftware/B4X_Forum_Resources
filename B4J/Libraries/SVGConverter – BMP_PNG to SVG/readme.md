### SVGConverter – BMP/PNG to SVG by zed
### 03/02/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170474/)

**SVGConverter** is a B4J library that allows you to convert any bitmap image (BMP, PNG, B4XBitmap, etc.) to vector SVG directly from your desktop applications.  
It is based on Potrace but adds a complete layer of image processing, color quantization, PBM generation, and optimized SVG reconstruction.  
  
The goal: to offer a simple, robust, and fully integrated solution for B4X to vectorize images, logos, icons, drawings, or signatures.  
  
**Main Features :  
  
1. Monochrome Vectorization**  

- Converts an image to black and white SVG.
- Automatic ink detection (significant pixels).
- Optimized luminance threshold for drawings and signatures.

  
**2. Single-Color Vectorization**  

- Automatic detection of the dominant color (excluding white).
- SVG path extraction and automatic recoloring.
- Generates a clean SVG, with transformation and scaling.

  
**3. Multi-Color Vectorization** (16-color palette)  

- Color quantization in 32 levels - compact and stable palette.
- Layer-by-layer processing (1 PBM per color).
- Merging of SVG paths with individual fills.
- Accurate, clean, and optimized final result.

  
4. **SVG to PNG Conversion**  

- Automatic handling of dimensions declared in the SVG.
- High-quality PNG export.

  
5. **Integrated Error Handling**  

- Callback via SetErrorHandler.
- Detailed messages (Potrace, snapshot, missing files, etc.).
- No interruption of the main workflow.

  
  
**Example of use :**  

```B4X
Dim v As SVGConverter  
v.Initialize(MainForm, "C:\Tools\potrace.exe")  
v.SetErrorHandler(Me, "SVG_Error")  
  
Dim svg As String = v.VectorizeColor(MyBitmap, True)  
File.WriteString(C:\myFolder, "output.svg", svg)  
   
….  
  
Sub SVG_Error(Message As String)  
    Log("SVG ERROR : " & Message)  
End Sub
```

  
  
**What the library brings to the B4X community**  

- A complete solution for vectorizing images without complex external dependencies.
- A simple, consistent API adapted to the B4X ecosystem.
- A direct bridge between the bitmap and vector worlds.
- A solid foundation for projects involving:
- dynamic logos,
- image processing,
- graphic tools,
- automation,
- UI asset generation.

  
**Prerequisites**  

- B4J 10.30+
- Potrace (executable) <https://potrace.sourceforge.net/>
- Java 11+ recommended

  
Have fun