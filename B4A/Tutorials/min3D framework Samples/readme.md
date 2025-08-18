### min3D framework Samples by Johan Schoeman
### 01/30/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/138042/)

**Sample 1**  
  
A wrap for [this Github project](https://github.com/mengdd/min3d/blob/master/sampleProjects/min3dSampleProject1/src/min3d/sampleProject1/ExampleTextureOffset.java). Posting:  
1. B4A sample project  
2. Java Code - check the code inside the wrapper vs the Java sample code.  
3. B4A lib files  
  
***A nice spinning earth with clouds where the earth is rotating faster than the clouds - a sample of Texture Offset.***  
  
![](https://www.b4x.com/android/forum/attachments/124911)  
  
The wrapper wraps the ["RenderActivity"](https://github.com/mengdd/min3d/tree/master/src/min3d/core) and then uses the sample code in the java sample project in methods "*initScene*" and "*updateScene*" inside the wrapper:  
  

```B4X
    public void initScene()  
    {  
        Light light = new Light();  
        light.ambient.setAll((short)64, (short)64, (short)64, (short)255);  
        light.position.setAll(3, 3, 3);  
        scene.lights().add(light);  
  
        _earth = new Sphere(1.2f, 15, 10);  
        scene.addChild(_earth);  
  
        Bitmap b = Utils.makeBitmapFromResourceId(BA.applicationContext, R.drawable.earth);  
        Shared.textureManager().addTextureId(b, "jupiter", false);  
        b.recycle();  
  
        b = Utils.makeBitmapFromResourceId(BA.applicationContext, R.drawable.clouds_alpha2b);  
        Shared.textureManager().addTextureId(b, "clouds", false);  
        b.recycle();  
  
        TextureVo t = new TextureVo("jupiter");  
        _earth.textures().add(t);  
  
        _cloudTexture = new TextureVo("clouds");  
        _cloudTexture.textureEnvs.get(0).param = GL10.GL_DECAL;  
        _cloudTexture.repeatU = true; // .. this is the default, but just to be explicit  
  
        _earth.textures().add(_cloudTexture);  
  
        _count = 0;  
    }  
   
    @Override  
    public void updateScene()  
    {  
        _earth.rotation().y += 1.0f;  
       
        // Animate texture offset  
        _cloudTexture.offsetU += 0.001f;      
       
        _count++;  
    }
```

  
  
Change the wrapper code to your liking and compile your amended wrapper code into a B4A library - very easy to do with NotePad++ and [**SimpleLibraryCompiler (SLC)**](https://www.b4x.com/android/forum/threads/tool-simple-library-compiler-build-libraries-without-eclipse.29918/)  
  
I have no intention to support this whatsoever. This is just samples for those that maybe want to modify it and make use of it. I will post some additional samples as what time allows.