###  [XUI] SD CreativeBackground by Star-Dust
### 03/08/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/125011/)

![](https://www.b4x.com/android/forum/attachments/103731)![](https://www.b4x.com/android/forum/attachments/103845)  
  
This new library is based on my latest work ([**here**](https://www.b4x.com/android/forum/threads/new-effects-for-views.123959/)) of gradual backgrounds and [USER=33472]@JordiCP[/USER] 's code ([**here**](https://www.b4x.com/android/forum/threads/neumorphism-ui-how-would-you-do-this.112503/post-716860)) that gave me permission to rework it and insert it in a custom view.  
  
**SD\_CreativeBackground  
  
Author:** Star-Dust  
**Version:** 0.06  

- **GradientBackground**

- **Fields:**

- **Fill\_BL\_TR** As String
- **Fill\_BOTTOM\_TOP** As String
- **Fill\_BR\_TL** As String
- **Fill\_LEFT\_RIGHT** As String
- **Fill\_Radial** As String
- **Fill\_RIGHT\_LEFT** As String
- **Fill\_TL\_BR** As String
- **Fill\_TOP\_BOTTOM** As String
- **Fill\_TR\_BL** As String

- **Functions:**

- **Class\_Globals** As String
- **GenerateGradientRounded** (Width As Int, Height As Int, TintColor As Int(), Fill As String, BorderColor As Int, BorderWidth As Float, CornerRadius As Float) As B4XBitmap
 *es. GenerateGradientRounded(array as int(xui.Color\_Black,xui.Color\_White),ColorGradient.Fill\_Radial,10Dip)  
 Fill = RADIAL, TR\_BL , TL\_BR, BL\_TR , BR\_TL  
 TOP\_BOTTOM, BOTTOM\_TOP, RIGHT\_LEFT, LEFT\_RIGHT*- **GradientToView** (Vw As B4XView, TintColor As Int(), Fill As String, BorderColor As Int, BorderWidth As Float, CornerRadius As Float) As String
 *"RADIAL", "TR\_BL" , "TL\_BR", "BL\_TR" , "BR\_TL", "TOP\_BOTTOM", "BOTTOM\_TOP", "RIGHT\_LEFT", "LEFT\_RIGHT"  
 es. GradientToView(MyImageView,Array As Int(0xFF9F26E7,0xFFD287DA),"RADIAL",xui.Color\_Black,0dip,20dip)*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **PatternColor** (PatternNumber As Int) As Int()
 *PatternNumber (0..20)  
 0 = lilla; 1 = rosa; 2 = red; 3 = blue; 4 = blue2; 5 = cyan; 6 = yellow  
 7 = Green; 8 = Green2; 9 = Brown; 10 = Orange; 11 = none; 12 = Gold; 13 = Silver; 14 = Silver2  
 15 = Elettro; 16 = none; 17 = bronze; 18 = Rainbow; 19 = Rainbow; 20 = diamond*
- **NativeShadow**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NativeShadowToView** (Vw As B4XView, ShadowsWidth As Float) As String

- **ShadowEffectBackground**

- **Fields:**

- **DarkFactor** As Float
- **LightFactor** As Float
- **softness** As Int
- **TypeComics** As String
- **TypeDaisy4** As String
- **TypeDaisy5** As String
- **TypeDaisy8** As String
- **TypeHeart** As String
- **TypeHexagonShadow** As String
- **TypeRect** As String

- **Functions:**

- **Class\_Globals** As String
- **EffectBackgroundToView** (Vw As B4XView, Effect As String, InvertShadow As Boolean, Color As Int, DepthEdge As Int, cornerRadius As Int, Recursive As Int, AlternateShadow As Boolean) As String
 *Parameter  
 GenerateBackgound(View,Effect, InvertShadow, Color, DepthEdge, CornerRadius, Recursive, AlternateShadow, Rotate) As B4XBitmap  
 Vw as view,  
 Effect = Type of Effect,  
 InvertShadow (Light Down, Dark Up)  
 Color = Color of base  
 DepthEdge = Depth of shadow  
 CornerRadius = 0 for rectangle  
 Recursive = Shadows one inside the other (For single shadowd set=1)  
 AlternateShadow = If the recursive value is greater than 1 the invert shadows alternate*- **GenerateEffectBackground** (Vw As B4XView, Effect As String, InvertShadow As Boolean, Color As Int, DepthEdge As Int, cornerRadius As Int, Recursive As Int, AlternateShadow As Boolean) As B4XBitmap
- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **sePoint**

- **Fields:**

- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **X** As Float
- **Y** As Float

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*