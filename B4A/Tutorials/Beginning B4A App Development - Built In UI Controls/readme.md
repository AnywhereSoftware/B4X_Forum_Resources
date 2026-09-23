### Beginning B4A App Development - Built In UI Controls by Mashiane
### 09/13/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172053/)

Hi gang  
  
[B4A Github Repo](https://github.com/AnywhereSoftware/B4A)  
  
For anyone beginning with b4a, they would want to know what UI components are available that come built in with b4a and can be used right out of the box?  
  
So Iv'e compiled this based on the latest version of b4a for anyone to be up to speed. Hope its helpful.  
  
**Rule:** **Designer = Yes** means the control can be dropped on a layout in the Abstract Designer (configurable properties in the Designer). **Designer = No** means code-only (**Initialize** + **AddView**).  
  
[SIZE=4]**Core views (Core library)**[/SIZE]  
[TABLE]  
[TR][TH]Control[/TH][TH]Based On[/TH][TH]Category[/TH][TH]Designer[/TH][/TR]  
[TR][TD]**Button**[/TD][TD]android.widget.Button[/TD][TD]Actions[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**Label**[/TD][TD]android.widget.TextView[/TD][TD]Text[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**EditText**[/TD][TD]android.widget.EditText[/TD][TD]Forms[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**AutoCompleteEditText**[/TD][TD]android.widget.AutoCompleteTextView[/TD][TD]Forms[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ImageView**[/TD][TD]android.widget.ImageView[/TD][TD]Media[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**Panel**[/TD][TD]android.view.ViewGroup (layout container, base for custom views)[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**CheckBox**[/TD][TD]android.widget.CheckBox[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**RadioButton**[/TD][TD]android.widget.RadioButton[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ToggleButton**[/TD][TD]android.widget.ToggleButton[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ListView**[/TD][TD]android.widget.ListView[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**Spinner**[/TD][TD]android.widget.Spinner[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ScrollView**[/TD][TD]android.widget.ScrollView[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**HorizontalScrollView**[/TD][TD]android.widget.HorizontalScrollView[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**SeekBar**[/TD][TD]android.widget.SeekBar[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ProgressBar**[/TD][TD]android.widget.ProgressBar[/TD][TD]Feedback[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**WebView**[/TD][TD]android.webkit.WebView[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**TabHost**[/TD][TD]android.widget.TabHost[/TD][TD]Navigation[/TD][TD]Yes[/TD][/TR]  
[/TABLE]  
  
[SIZE=4]**Custom views (ViewsEx, TabStripViewPager, ExoPlayer, xCustomListView)**[/SIZE]  
[TABLE]  
[TR][TH]Control[/TH][TH]Based On[/TH][TH]Category[/TH][TH]Designer[/TH][/TR]  
[TR][TD]**Switch**[/TD][TD]ViewsEx · android.widget.Switch[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**RatingBar**[/TD][TD]ViewsEx · android.widget.RatingBar[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**FloatLabeledEditText**[/TD][TD]ViewsEx · FloatLabeledEditText third-party view over a native EditText[/TD][TD]Forms[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**TabStrip**[/TD][TD]TabStripViewPager · androidx.viewpager.widget.ViewPager + sliding tab strip[/TD][TD]Navigation[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**VideoView**[/TD][TD]Audio · android.widget.VideoView (+ MediaController)[/TD][TD]Media[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**AdView**[/TD][TD]FirebaseAdMob · com.google.android.gms.ads.AdView banner (NativeExpressAdView sibling; InterstitialAd / RewardedVideoAd are full-screen, not layout controls)[/TD][TD]Communication[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**SimpleExoPlayerView**[/TD][TD]ExoPlayer · androidx.media3.ui.PlayerView (SimpleExoPlayer is the non-visual controller)[/TD][TD]Media[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**CustomListView**[/TD][TD]xCustomListView · B4A class over ScrollView / HorizontalScrollView with item panels[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**GameView**[/TD][TD]GameView · custom canvas-drawn View (Bitmap + Canvas + Paint loop)[/TD][TD]Game / Canvas[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**TouchPanel**[/TD][TD]ViewsEx · code-created touch-intercept Panel[/TD][TD]Containment[/TD][TD]No (code)[/TD][/TR]  
[/TABLE]  
  
[SIZE=4]**B4X custom views (XUI Views + satellites)**[/SIZE]  
Added via Designer → Add View → CustomView. All render into a base Panel (B4XView); canvas-drawn ones paint via B4XCanvas / BitmapCreator.  
[TABLE]  
[TR][TH]Control[/TH][TH]Based On[/TH][TH]Category[/TH][TH]Designer[/TH][/TR]  
[TR][TD]**AnimatedCounter**[/TD][TD]XUI Views · B4XCanvas frame animation over labels (digit ticker)[/TD][TD]Feedback[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**AnotherProgressBar**[/TD][TD]XUI Views · BitmapCreator + B4XCanvas bar on an ImageView container[/TD][TD]Feedback[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XBreadCrumb**[/TD][TD]XUI Views · B4XCanvas-drawn crumb path on a Panel with touch handling[/TD][TD]Navigation[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XComboBox**[/TD][TD]XUI Views · native Spinner + action button[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XFloatTextField**[/TD][TD]XUI Views · native EditText + canvas-drawn floating hint, clear/accept/reveal buttons[/TD][TD]Forms[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XImageView**[/TD][TD]XUI Views · ImageView + bitmap (resize modes, round, corners)[/TD][TD]Media[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XLoadingIndicator**[/TD][TD]XUI Views · B4XCanvas-drawn animated indicator (7 styles)[/TD][TD]Feedback[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XPlusMinus**[/TD][TD]XUI Views · label stepper on a Panel (orientation, cyclic, rapid change)[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XRadioButton**[/TD][TD]XUI Views · BitmapCreator-drawn glyph on an ImageView container[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XSeekBar**[/TD][TD]XUI Views · B4XCanvas-drawn track + touch Panel (min/max/interval)[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XSwitch**[/TD][TD]XUI Views · BitmapCreator-drawn track/thumb on an ImageView container[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**RoundSlider**[/TD][TD]XUI Views · B4XCanvas-drawn circular track on a Panel[/TD][TD]Selection[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ScrollingLabel**[/TD][TD]XUI Views · B4XCanvas-drawn auto-scrolling text[/TD][TD]Text[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**SwiftButton**[/TD][TD]XUI Views · B4XCanvas-drawn 3D button (primary/secondary/disabled, side height)[/TD][TD]Actions[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**MadeWithLove**[/TD][TD]XUI Views · static Label badge[/TD][TD]Text[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XTable**[/TD][TD]B4XTable · CustomListView rows + header Panels over a SQLite query[/TD][TD]Containment[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**BBCodeView**[/TD][TD]BCTextEngine · BCTextEngine + BitmapCreator rich-text rendering on a ScrollView[/TD][TD]Text[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**BBLabel**[/TD][TD]BCTextEngine · BCTextEngine + BitmapCreator rich-text rendering on a Panel[/TD][TD]Text[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XGifView**[/TD][TD]B4XGifView · FLAnimatedImageView animated drawable on a Panel (ImageView fallback, SetGif / SetGif2)[/TD][TD]Media[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**B4XTurtle**[/TD][TD]B4XTurtle · BitmapCreator canvas layers composited into an ImageView[/TD][TD]Game / Canvas[/TD][TD]Yes[/TD][/TR]  
[TR][TD]**ScoreLabel**[/TD][TD]X2 · game HUD Labels on a Panel[/TD][TD]Game / Canvas[/TD][TD]Yes[/TD][/TR]  
[/TABLE]  
  
[SIZE=4]**B4X cross-platform types (helpers and foundation)**[/SIZE]  
Non-view B4X\* types from the same libraries — code-only, shared across B4A / B4i / B4J. (View-type B4X\* controls live in the tables above.)  
[TABLE]  
[TR][TH]Type[/TH][TH]Based On[/TH][TH]Category[/TH][TH]Designer[/TH][/TR]  
[TR][TD]**B4XView**[/TD][TD]XUI · universal wrapper over the native View[/TD][TD]Framework[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XCanvas**[/TD][TD]XUI · android.graphics.Canvas via the Core canvas implementation (see Foundation below)[/TD][TD]Drawing[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XPath / B4XRect / B4XFont / B4XBitmap**[/TD][TD]XUI · companion types of B4XView (Path / Rect / Typeface / Bitmap)[/TD][TD]Drawing[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XSet**[/TD][TD]B4XCollections · ordered set (Add / Remove / Contains)[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XOrderedMap**[/TD][TD]B4XCollections · insertion-ordered key-to-value map[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XCollections**[/TD][TD]B4XCollections · factory (CreateSet / CreateOrderedMap / CreateBitSet)[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XComparatorSort**[/TD][TD]B4XCollections · quicksort with custom comparator[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XCache**[/TD][TD]B4XCollections · size-capped cache (Get / Put / MaxSize)[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XBytesBuilder**[/TD][TD]B4XCollections · growable byte array (Append / ChangeLength)[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XBitSet**[/TD][TD]B4XCollections · bit array (Set / Get / Size)[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**CopyOnWriteList / CopyOnWriteMap**[/TD][TD]B4XCollections · thread-safe list / map[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XFormatter**[/TD][TD]B4XFormatter · number/date format definitions (drives B4XPlusMinus)[/TD][TD]Format[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XSerializator**[/TD][TD]RandomAccessFile · cross-platform object serializer[/TD][TD]Data[/TD][TD]No (code)[/TD][/TR]  
[TR][TD]**B4XCipher**[/TD][TD]B4XEncryption · symmetric cipher[/TD][TD]Security[/TD][TD]No (code)[/TD][/TR]  
[/TABLE]  
Not shipped types: B4XMainPage (implemented by the app, not a library), B4XTypes (debug bridge internals).  
  
[SIZE=4]**Code-only UI managers**[/SIZE]  
Built and wired in code — not Designer surfaces.  
[TABLE]  
[TR][TH]Feature[/TH][TH]Based On[/TH][TH]Category[/TH][TH]Use[/TH][/TR]  
[TR][TD]**B4XDrawer**[/TD][TD]B4XDrawer · left/center/dim Panels with gesture handling[/TD][TD]Navigation[/TD][TD]side drawer: Initialize + panels + Resize[/TD][/TR]  
[TR][TD]**PreoptimizedCLV**[/TD][TD]PreoptimizedCLV · CustomListView + B4XSeekBar fast-scroll overlay[/TD][TD]Containment[/TD][TD]performance helper wrapping a CustomListView[/TD][/TR]  
[TR][TD]**B4XDialog + templates**[/TD][TD]XUI Views · Panels + CustomListView / text fields (Date, Input, List, Color, Search, Signature, Timed, LongText, progress)[/TD][TD]Communication / Pickers / Forms[/TD][TD]modal ShowDialog pattern[/TD][/TR]  
[TR][TD]**PreferencesDialog**[/TD][TD]B4XPreferencesDialog · CustomListView + B4XDialog + item templates with built-in item layouts[/TD][TD]Communication / Forms[/TD][TD]settings form generator (AddBooleanItem / AddTextItem / … / ShowDialog)[/TD][/TR]  
[TR][TD]**BCToast**[/TD][TD]BCToast · BBLabel (BCTextEngine rendering) on a Panel[/TD][TD]Communication[/TD][TD]transient Show message[/TD][/TR]  
[TR][TD]**SimpleMediaManager**[/TD][TD]SimpleMediaManager · async bitmap loader + SimpleExoPlayerView / video views[/TD][TD]Media[/TD][TD]media loader wired to existing panels/ImageViews in code[/TD][/TR]  
[TR][TD]**B4XPages**[/TD][TD]B4XPages · Activity/Form page framework (B4XPagesManager)[/TD][TD]Navigation[/TD][TD]page framework, not a control[/TD][/TR]  
[TR][TD]**X2 engine**[/TD][TD]X2 · BitmapCreator sprites + Box2D physics on GameView[/TD][TD]Game / Canvas[/TD][TD]sprite/tile engine, code-driven[/TD][/TR]  
[TR][TD]**MediaChooser**[/TD][TD]MediaChooser · camera capture + ContentChooser intents, runtime permission check, keep-alive service[/TD][TD]Media[/TD][TD]CaptureImage / CaptureVideo / ChooseImage / ChooseVideo (resumable, returns MediaChooserResult); temp-file cleanup[/TD][/TR]  
[TR][TD]**NB6**[/TD][TD]NB6 · Notification builder helper[/TD][TD]Communication[/TD][TD]notifications helper, not a View[/TD][/TR]  
[/TABLE]  
  
[SIZE=4]**Foundation: XUI drawing stack (XUI library)**[/SIZE]  
The canvas-drawn controls above share one cross-platform drawing stack.  

- **B4XView** — universal view wrapper. Every native view (Button, Label, Panel, …) is addressable through the same B4XView API, which is why B4X custom views accept any view as their base.
- **B4XCanvas** — drawing surface bound to a view via Initialize(View). Primitives: DrawLine / DrawRect / DrawCircle / DrawPath / DrawBitmap (each plain + rotated), DrawText (+ rotated), MeasureText, ClipPath / RemoveClip, ClearRect. Invalidate flushes to screen; Resize / Release manage its lifecycle. Companion types: B4XPath (lines, ovals, arcs, rounded rects), B4XRect, B4XFont, B4XBitmap. Based on: android.graphics.Canvas + Bitmap + Paint / Path / Rect, via the Core canvas implementation it delegates every draw call to (B4XCanvas → core canvas → native canvas, bound to the target view).
- **BitmapCreator** (BitmapCreator library) — offscreen bitmap + software canvas. Controls that pre-render (AnotherProgressBar, B4XSwitch, B4XRadioButton, B4XTurtle layers, BBCodeView / BBLabel text) draw into a BitmapCreator and blit the result to an ImageView container.
- Controls in this report built on this stack: AnimatedCounter, AnotherProgressBar, B4XBreadCrumb, B4XLoadingIndicator, B4XPlusMinus, B4XRadioButton, B4XSeekBar, B4XSwitch, RoundSlider, ScrollingLabel, SwiftButton, B4XFloatTextField (hint), B4XTurtle, BBCodeView, BBLabel.

  
[SIZE=4]**Notes**[/SIZE]  

- B4X custom views are added via Designer → Add View → CustomView; Java custom views (ViewsEx, TabStripViewPager, SimpleExoPlayerView, CustomListView) support the Visual Designer the same way.
- Non-visual libraries shipped alongside (Phone, GPS, BLE2, Serial, SQL, OkHttp, Firebase\* services, USB, Audio players, Camera, …) expose no layout controls and are excluded — same as the reference repo, which lists only widgets. Deliberately excluded UI-adjacent items: PreferenceScreen / PreferenceCategory (full-screen settings, not layout views), IME (keyboard helper), Camera preview (hosted on a Panel, no standalone View), ContentChooser (activity starter), full-screen ads, B4XMainPage (app-implemented) and B4XTypes (debug internals).
- Totals: 17 core + 10 custom views + 21 B4X Designer views + 14 B4X helper/foundation types + 10 code-only managers ≈ 72 entries.

You are welcome to extend if there is something incorrect/needs updating  
  
#SharingTheGoodness