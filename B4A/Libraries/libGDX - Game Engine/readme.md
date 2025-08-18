### libGDX - Game Engine by Informatix
### 02/02/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/32594/)

![](https://www.b4x.com/android/forum/attachments/19398)  
  
One of the best game engines for Android is now available to B4A users. Unleash your creativity!  
  
You can read a description of this library in [this guide](http://www.b4x.com/android/forum/threads/introduction-to-the-libgdx-library.32592/).  
  
[**Download for B4A v10.60 and older (4 MB)**](https://www.b4x.com/android/files/libgdx/LibGDX_1_13.zip)  
[**Download for B4A v10.70 and newer (4 MB)**](https://www.b4x.com/android/files/libgdx/LibGDX_1_14.zip)  
  
**Starting from version 1.13, the library is compiled with Java 8, and thus requires a recent version of B4A and Java 8+.**  
To install the library, copy the .jar file and the .xml file in your libraries folder.  
  
**This library is not compatible with the Debug mode.** Ensure that you always compile in Release mode.  
  
Download also the [**examples and templates**](http://www.b4x.com/android/files/libgdx/Examples_Templates_1_14.zip).  
  
You can reduce the weight of the library if you want to keep your APK file as small as possible. Read [this post](http://www.b4x.com/android/forum/threads/libgdx.32594/page-13#post-257648) to learn how to create your Lite version.  
  
Tutorials:  
[How to make games](http://www.b4x.com/android/forum/threads/how-to-make-games.32593/)  
[Introduction to the libGDX library](http://www.b4x.com/android/forum/threads/introduction-to-the-libgdx-library.32592/)  
[PacDroid: from scratch to fun](http://www.b4x.com/android/forum/threads/pacdroid-from-scratch-to-fun.32684/)  
[Shaders](http://www.b4x.com/android/forum/threads/shaders-in-libgdx.45441/)  
  
Take also a look at the [Cloney Bird tutorial](http://easyandroidcoding.wordpress.com/beginners-tutorials/) by andymc.  
  
Plugins:  
[Box2DLights](http://www.b4x.com/android/forum/threads/box2dlights.39384/)  
[SpecialFX](http://www.b4x.com/android/forum/threads/specialfx-for-libgdx.45753/)  
  
Versions:  
> v1.14:  
> - I fixed a bug when Looping was changed during the execution of a sound;  
> - I added the RenderImageLayerAt function to all map renderers;  
> - I added the support of the new packaging tool used by B4A v10.70 (this mainly fixes the problem of / in paths of internal assets);  
> - I updated the manifest of all examples.  
>   
> v1.13:  
> - I fixed a bug when the device was rotated (the Timer thread, for example, was not disposed which caused a problem in lgGestureDetector);  
> - I added two functions for Tiled maps: renderImageLayerAt and renderTileLayerAt.  
>   
> v1.12:  
> - I added the .so libraries for 64 bits CPU;  
> - I added the PinchStop event to lgGestureDetector;  
> - I added the Orientation property to lgBox2DTransform;  
> - I fixed minor bugs.  
>   
> v1.11:  
> - I fixed several bugs;  
> - I removed the unwanted delay after a change of screen in the Render event;  
> - I added the lgAsyncExecutor and lgAsyncTask classes;  
> - I added the missing file for the Progression demo;  
> - I updated the Freetype library (.so).  
>   
> v1.10:  
> - I fixed several bugs;  
> - I added the support of expansion files: classes lgZipResourceFile and lgZipEntry, functions lgFiles.SetAPKExpansion and lgFiles.ExpansionFile (untested);  
> - I added a HashCode function to all lg…Array classes;  
> - I added a dozen of predefined colors to lgColor;  
> - I added the "raw\_y" property to lgMapObjects;  
> - I added the grow, growX and growY functions to lgScn2DTableCell;  
> - I added the lerpAngle and lerpAngleDeg functions to lgMathUtils;  
> - I improved Atan2 in lgMathUtils;  
> - the collision objects of TMX tiles are now accessible via the Objects property of lgMapAnimatedTiledMapTile and lgMapStaticTiledMapTile;  
> - I added two new examples: Progression and Map\_Box2D;  
> - I updated the manifest of most examples and templates.  
>   
> v1.09:  
> - I fixed bugs, notably a major bug that crashed sometimes the game in the Render event handler when the current screen is changed;  
> - I added getColumnWidth and getRowHeight to lgScn2DTable and all classes that inherit from lgScn2DTable;  
> - I added the defaults function to lgScn2DTableCell;  
> - TMX files are loaded faster.  
>   
> 1.08:  
> - I fixed bugs;  
> - I added the lgFontGeneratorParameters class;  
> - I added CreateFontWithParam to lgFontGenerator;  
> - lgFontGenerator can add now a border and a shadow to the generated fonts (via CreateFontWithParam);  
> - I added Initialize2, LabelAlign and LineAlign to lgScn2DLabel;  
> - I added SetStateWithoutEvent to lgScn2DButton and lgScn2DTextButton;  
> - I added TitleLabel and TitleTable to lgScn2DWindow (this deprecates ButtonTable, Title, TitleWidth and TitleAlignment);  
> - I added getIndex to lgMapLayers and lgMapObjects;  
> - I added Target to actions of Scene2D;  
> - I removed Print from lgScn2DGroup (use Log(myGroup) instead);  
> - lgMapTiledMapImageLayer uses now float values for position;  
> - lgNinePatch uses now float values for paddings;  
> - lgPixmapPacker and lgPixmapPackerPage were rewritten (the many changes will break your existing code).  
>   
> 1.07:  
> - I fixed a few bugs, as usual;  
> - I added InitializeTransparentView to LibGDX;  
> - I added the lgKTXTextureData class to support the KTX and ZKTX file formats;  
> - I added a new demo: Format\_KTX;  
> - I added argb8888 and argb8888ToColor to lgColor  
> - I added the lgMapAtlasTmxMapLoaderParameters class;  
> - I added Initialize3 and Load2 to lgMapAtlasTmxMapLoader;  
> - I added LoadExternal and IsInitialized to lgMapTmxMapLoader;  
> - I added FrameTiles to lgMapAnimatedTiledMapTile;  
> - I added a Tag property to lgSprite;  
> - I added hasOppositeDirection, hasSameDirection, isCollinear, isOnLine, isPerpendicular, AngleRad and rotateRad to lgMathVector2;  
> - I added rotateRad to lgMathMatrix4;  
> - I added clamp4, log, log2, Randomize, randomInt, randomInt2, randomSign, randomTriangular and randomTriangular2 to lgMathUtils;  
> - the random number generator of lgMathUtils uses now the xorshift128+ algorithm;  
> - I renamed Create2 to Combine in lgMesh;  
> - I removed the Create and Create3 functions from lgMesh;  
> - I removed the deprecated Color property from lgVertexAttributesUsage;  
> - it is possible now to change the KeyFrames array of lgAnimation after its initialization.  
>   
> v1.06:  
> - I fixed a few bugs;  
> - I added a Texture property to lgSprite;  
> - I added the MotorJoint type to lgBox2DWorld;  
> - I added GetFixture to lgBox2DBody;  
> - I added Initialize3 to lgShapeRenderer to allow the use of custom shader programs;  
> - I added ScaleEffect to lgParticleEffect;  
> - I added CleanUpBlendFunction to lgParticleEmitter;  
> - I added scl2 to lgMathVector2;  
> - I added IsEnabled to lgGLProfiler;  
> - I added Percent, VisualPercent and VisualInterpolation to lgScn2DProgressBar;  
> - I added Percent, VisualPercent, VisualInterpolation and VisualInterpolationInverse to lgScn2DSlider;  
> - I added isLeftEdge, isRightEdge, isTopEdge, isBottomEdge to lgScn2DScrollPane;  
> - The Reset function of lgScn2DTableCell sets now all constraints to their default values;  
> - I modified the Map\_Hexagonal example to display the coordinates of the touched hex.  
>   
> v1.05:  
> - I fixed two bugs;  
> - the latest TMX format of Tiled Map Editor is now properly decoded (with support of animated tiles and image layers);  
> - I added the RenderImageLayer function to the map renderers;  
> - I added the lgMapTiledMapImageLayer class for the image layer of tiled maps;  
> - I added the OffsetX and OffsetY properties to lgMapAnimatedTiledMapTile and lgMapStaticTiledMapTile;  
> - I added the CurrentFrame and CurrentFrameIndex properties to lgMapAnimatedTiledMapTile;  
> - I added the FinishLoadingAsset function to lgAssetManager;  
> - I added the SetAlpha function to lgBitmapFontCache;  
> - I added FixtureCount and GetAllFixtures to lgBox2DWorld;  
> - I added the ResetOnTouchUp property to lgTouchpad;  
> - I removed Scale and Div from lgMathVector3 because these functions were deprecated.  
>   
> v1.04:  
> - I fixed various bugs, notably a bug affecting the Backspace key on the virtual keyboard of some devices;  
> - I added the missing OpenGL functions in lgGL;  
> - I added the KeepWithinStage function to lgDragAndDrop;  
> - I added the dampingRatio and frequencyHz fields to lgBox2DWeldJointDef;  
> - I added the DampingRatio and Frequency properties to lgBox2DWeldJoint;  
> - I added the Line6 function to lgShapeRenderer;  
> - I added VisualScrollPercentX, VisualScrollPercentY and FlickScrollTapSquareSize to lgScn2DScrollPane;  
> - the LineHeight property of BitmapFonts can be modified;  
> - I updated the .so files;  
> - I added an example: Sensors.  
>   
> v1.03:  
> - I fixed various bugs;  
> - I added the VertexColor property to lgPolygonSprite;  
> - I added the Equals function to lgArray;  
> - I renamed Ellipse to Ellipsis in lgScn2DLabel;  
> - I improved the code of lgPixmapIO (less memory used, PNG with compression);  
> - I fixed a problem with the fragment shaders of two examples.  
>   
> v1.02:  
> - I fixed 3 bugs in lgScn2dTable and a few others in other classes;  
> - I added 4 examples using shaders;  
> - I removed the lgDefaultGroupStrategy class because it was useless and changed the initialization of lgDecal objects;  
> - I added the SetRotation function to lgDecal;  
> - I added the Tint function to lgBitmapFontCache;  
> - I added the Cancel and Reset functions to lgGestureDetector;  
> - I added the IsKeyJustPressed function to lgInput;  
> - I added the Colinear and EnsureCCW functions to lgMathGeometryUtils;  
> - I added the Equals function to lgMathGridPoint2, lgMathGridPoint3 and lgMathRay;  
> - I added the IntersectRayRay and DistanceLinePoint2 functions to lgMathIntersector;  
> - I added the Extract4x3Matrix function to lgMathMatrix4;  
> - I added the WindowSize property to lgMathWindowedMean;  
> - I added the IsDrawing function to lgShapeRenderer;  
> - I added the ColorUnpacked field to lgVertexAttributesUsage;  
> - I added the Clear function to lgScn2DButtonGroup;  
> - I added the CancelTouchFocus property to lgScn2DDragAndDrop;  
> - I added the Rows, Columns, BackgroundTop, BackgroundLeft, BackgroundBottom, and BackgroundRight properties to lgScn2DTable;  
> - I added the ClearActor function to lgScn2dTableCell;  
> - I added the ActionsRequestRendering property to lgScn2DStage;  
> - I renamed CancelTouchFocus2 to CancelTouchFocusExcept in lgScn2DStage;  
> - I removed the Clear function from lgScn2dTableCell;  
> - The color markups are now supported by lgScn2dLabel and lgScn2dWindow (title).  
>   
> v1.01:  
> - I fixed a handful of minor bugs and a big bug affecting the screen events;  
> - I added IsDrawing in lgSpriteBatch.  
>   
> v1.0:  
> - I fixed bugs in various classes;  
> - I rewrote big chunks of internal graphics classes;  
> - the TMX map loaders are now able to read the Rotation property;  
> - the FrameDuration property of lgAnimation can now be changed during the animation;  
> - I added an Initialize function to lgMapAnimatedTiledMapTile to be able to set dynamically an animated tile;  
> - I added two new classes for debugging: lgGLProfiler and lgScn2DDebugRenderer;  
> - I added DebuggingEnabled and DebugColor to all actors of Scene2D;  
> - I added ChildrenDebuggingEnabled to all groups of Scene2D;  
> - I added CellDebugColor to lgScn2DTable and removed all its debug functions;  
> - I added SetCenterPosition, CenterX and CenterY to all actors of Scene2D;  
> - I replaced the Widget word by Actor in lgScn2DTableCell;  
> - I added the Equals and HashCode functions to a few lgMath classes;  
> - I added the ApproxLength function to lgMathBezier, lgMathBSpline and lgMathCatmullRomSpline;  
> - I added Set3, SetPosition2, Contains2, Circumference and Area to lgMathCircle;  
> - I added Set3, SetPosition2, Circumference and Area to lgMathEllipse;  
> - I added Merge2, Area and Perimeter to lgMathRectangle;  
> - I added Len and Len2 to lgMathSegment;  
> - I added Volume and SurfaceArea to lgMathSphere;  
> - I added Interpolate to lgMathVector2 and lgMathVector3;  
> - I added the following functions to lgMathMatrix4: mulLeft, Set2, Set3, Set4, Set5, Set6, ScaleX, ScaleY, ScaleZ, ScaleXSquared, ScaleYSquared, ScaleZSquared;  
> - I added a LoadMipMap event and replaced UseHardwareMipMap by Get/SetGenerationMethod in lgMipMapGenerator;  
> - Box2D has now its own .so library;  
> - I added Separations to lgBox2DWorldManifold;  
> - I added the following functions to lgBox2DEdgeShape: Vertex0, SetVertex0, SetVertex0\_xy, HasVertex0, Vertex3, SetVertex3, SetVertex3\_xy, HasVertex3;  
> - I added LocalAxisA to lgBox2DPrismaticJoint;  
> - I added two new classes to Box2D: lgBox2DMotorJoint and lgBox2DMotorJointDef;  
> - I added the LoadTextureWithParam function to lgAssetManager and the related lgTextureLoaderParam class;  
> - I added two new properties (Normalized, Type) and a function (HashCode) to lgVertexAttribute;  
> - I renamed Color to ColorPacked in lgVertexAttribute;  
> - I renamed Loop to Repeat in lgSound;  
> - I renamed consumeCompressedData to consumeCustomData in all TextureData classes;  
> - I protected some important classes against a repeated initialization to avoid memory leaks and side effects;  
> - I added a Scene2D\_EventsHierarchy demo and modified the following examples: BitmapFont, FrameBuffer, Map\_tIDE and Scene2D\_Table.  
>   
> v0.99:  
> - I fixed numerous bugs, especially in Scene2D where the listeners did not work as expected and actors were not fully re-initialized when Initialize was called again;  
> - I set to Null the internal objects of classes after a call to Dispose;  
> - I added the following functions:  
> [INDENT] + IsInitialized where it was still missing;[/INDENT]  
> [INDENT] + Move to lgArray;[/INDENT]  
> [INDENT] + ComputeScaleForPixelHeight to lgBitmapFont;[/INDENT]  
> [INDENT] + SetNameForColor, GetColorByName and SetAlpha to lgColor;[/INDENT]  
> [INDENT] + Clear to lgMapLayers;[/INDENT]  
> [INDENT] + Lerp to lgMathUtils;[/INDENT]  
> [INDENT] + Load3 and LoadEmitterImages3 to lgParticleEffect;[/INDENT]  
> [INDENT] + SetString to lgScn2DLabel;[/INDENT]  
> [INDENT] + Initialize4 to lgScn2DSpriteDrawable, lgScn2DTextureRegionDrawable and lgScn2DTiledDrawable;[/INDENT]  
> [INDENT] + UpdateMatrices to lgShapeRenderer;[/INDENT]  
> [INDENT] + SetCenterX, SetCenterY and SetCenter to lgSprite;[/INDENT]  
> - I added a ChildrenCount property to lgScn2DGroup;  
> - I added a Draw event to lgScn2DImage and lgScn2DLabel;  
> - I added a Disabled property to lgScn2DScrollPane;  
> - I added the following predefined colors to lgColor: Olive, Purple, Maroon, Teal, Navy;  
> - I renamed the alpha function to to255 in lgColor;  
> - lgBitmapFont and lgBitmapFontCache now support in-string colored text through a simple markup language (see the demo);  
> - I added the MarkupEnabled property to lgBitmapFont;  
> - I added a BitmapFont demo;  
> - I modified the FrameBuffer demo;  
> - I removed the yUp and yDown parameters from the tiled map loaders and renderers (yUp is now always true);  
> - I removed Rotation and rotateBy from lgScn2DLabel, lgScn2DList, lgScn2DSelectBox and lgScn2DTouchpad because they were not effective.  
>   
> v0.98:  
> - I fixed a bug affecting the scaling and rotation of lgScn2DImage;  
> - I fixed a bug in lgBox2DParticleEmitter;  
> - I fixed a bug in lgScn2DButton;  
> - I added the lgFrameBuffer class and a FrameBuffer demo;  
> - I added the IsInitialized function where it was missing;  
> - I added the PolygonRegion type to lgAssetManager;  
> - I added a Payload parameter to the SrcDragStop event of lgScn2DDragAndDrop;  
> - I added the Draw2 function to lgScn2DSpriteDrawable;  
> - I added the Set3 function to lgMathMatrix3.  
>   
> v0.97:  
> - I fixed a few bugs (the immersive mode works now as expected);  
> - I found a solution for the repetition of tiles, so I added two properties (RepeatX, RepeatY) to lgMapTiledMapLayer and I modified the Map demos.  
> - I added an IsInitialized function to 15 classes;  
> - I added a RemoveRange function to all the lgArray classes;  
> - I added the Fling function to lgScn2DScrollPane;  
> - I added the IsVisualPressed function and the VisualPressedDuration property to lgScn2DClickListener.  
>   
> v0.96: Major update!  
> In this version, I:  
> - removed all the code supporting OpenGL ES 1.x  
> - fixed a few bugs  
> - added new classes for decals (2D objects in 3D space): lgDecal, lgDecalBatch, lgCameraGroupStrategy, lgDefaultGroupStrategy, lgSimpleOrthoGroupStrategy  
> - added an example for decals  
> - removed the Mesh example as it cannot work with OpenGL 2 without being rewritten  
> - added the lgScn2DProgressBar class and modified the Scene2D\_TextFieldsAndSliders example to show how to use it  
> - added the IsInitialized function to a dozen of classes  
> - added these functions:  
> lgBox2DWheelJoint: isMotorEnabled  
> lgFontGenerator: CreateFont5, CreateFont6 (for mip maps and filters)  
> lgMathGeometryUtils: polygonArea, triangleArea  
> lgMathMatrix3: getScale, getTranslation, setToRotation2, setToRotation3, setToRotationRad, rotateRad  
> lgMathMatrix4: det3x3, setToRotationRad, setTranslation  
> lgMathUtils: isEqual, isEqual2, isZero, isZero2  
> lgMesh: CalculateRadius, CalculateRadius2, CalculateRadiusSquared  
> lgScn2DDragAndDrop: SetTouchOffset  
> lgSprite: SetOriginCenter  
> - added these properties:  
> lgBox2DJoint: CollideConnected  
> lgBox2DDistanceJoint, lgBox2DFrictionJoint, lgBox2DRopeJoint, lgBox2DWeldJoint: LocalAnchorA, LocalAnchorB  
> lgBox2DGearJoint: Joint1, Joint2  
> lgBox2DPrismaticJoint: LocalAnchorA, LocalAnchorB, MaxMotorForce, ReferenceAngle  
> lgBox2DWheelJoint: LocalAnchorA, LocalAnchorB, LocalAxisA  
> lgMathMatrix3: Rotation, RotationRad  
> lgScn2DActor: isTouchable  
> lgScn2DScrollPane: ScrollHeight, ScrollWidth, VariableSizeKnobs  
> lgScn2DWindow: ButtonTable, Resizable, ResizeBorder, TitleWidth  
> - renamed the functions Translate -> MoveBy, Rotate -> RotateBy and Size -> SizeBy of the lgScn2DActor class  
> - removed toScreenCoordinates from lgStage and toWindowCoordinates from lgScissorStack  
> - removed the yDown parameter from ComputePolygon and ComputePolygon2 in the lgMathConvexHull class  
> - improved a bit the help text of a few functions  
>   
> v0.95:  
> Bugfixes and minor improvements  
> New classes: lgFloatArray, lgIntArray, lgShortArray  
> The lgMathConvexHull and lgMathEarClippingTriangulator classes are now usable  
> New functions:  
> - lgPerspectiveCamera: GetPickRay  
> - lgScn2DStage: SetViewport2  
> - lgMathFrustum: pointInFrustum2, sphereInFrustum2, sphereInFrustumWithoutNearFar2  
> - lgBox2DChainShape: createLoop2  
> - lgMathIntersector: intersectSegments2  
> - lgMathVector2: isUnit, isUnit2, isZero, isZero2  
> - lgMathVector3: set2, isUnit2, isZero2  
> New configuration setting: useImmersiveMode (for Kitkat)  
>   
> v0.94:  
> Bugfixes (including a serious bug with the listeners of Scene2D)  
> New classes: lgMapTmxMapLoaderParameters and lgMipMapGenerator  
> New functions:  
> - lgAnimation: KeyFrames  
> - lgAssetManager: LoadTMXWithParam  
> - lgBitmapFontCache: SetColors, SetColors2, SetColorsRGBA  
> - lgGestureDetector: Initialize2  
> - lgMapTmxMapLoader: Initialize3, Load2  
> - lgMathVector2: Rotate90  
> - lgMesh: UpdateVertices, UpdateVertices2  
> - lgMusic: Duration, Position  
> - lgScn2DClickListener: inTapSquare2  
> - lgScn2DList: ItemHeight  
> - lgShapeRenderer: RectLine  
> - lgSocket: RemoteAddress  
> - lgSprite: Alpha, SetFlip  
> New parameters: ListBox and ScrollPane styles in lgScn2DSelectBoxStyle.Initialize  
> New example: Filters  
> Modified example: Map\_tIDE (I fixed the visual issues)  
> New configuration setting: disableAudio  
>   
> v0.93:  
> Bugfixes (including the problem reported for the Get…List functions of Box2D)  
> Class rewritten: lgTexture (some functions have been added, some have been removed)  
> New configuration setting: useGLSurfaceViewAPI18 (for Gingerbread and older versions)  
> New functions: lgFileHandle.equals, lgFileHandle.hashCode, lgShapeRenderer.Triangle2  
> New class: lgPerspectiveCamera (for 3D)  
> New example: ShapeRenderer  
> Modified example: Perf\_Skaters (the background scrolls endlessly now)  
>   
> 0.92:  
> Minor bugfixes  
> Internal changes for texture handling  
> Viewport parameters added to CalculateScissors in lgScissorStack  
> New function in lgScn2DScrollPane: setScrollBarPositions  
> New function in lgMathVector2: epsilonEquals2  
> New function in lgMathIntersector: intersectRectangles  
> Initialize3 and FindDirectionForIsoView functions removed from lgOrthographicCamera  
>   
> 0.91:  
> Bugfixes (including the problem reported for tIDE properties)  
> New event for gesture detector: PanStop  
> New Initialize function for Bitmapfont to allow to flip the font  
> New Rect functions for the ShapeRenderer  
> New class: lgMapIsometricStaggeredMapRenderer (for staggered isometric maps)  
> New function for lgScn2dScrollPane: Cancel  
> lgMathBezier and lgMathBresenham2 are now fully usable  
> New functions in lgMathIntersector  
> A few internal changes to improve performance and stability  
>   
> 0.9:  
> Bugfixes  
> New class: lgArray (ordered array with an initial capacity)  
> Many Lists have been replaced by lgArray for a better performance and more possibilities  
> Improved documentation (mainly in lgMath and lgSprite classes)  
> lgMathBSpline and lgMathCatmullRomSpline are now fully usable  
> New example: SplinePath  
> New function for particle effects and particle emitters: BoundingBox  
> New property for lgScn2DLabel: Ellipse  
>   
> 0.8:  
> First release