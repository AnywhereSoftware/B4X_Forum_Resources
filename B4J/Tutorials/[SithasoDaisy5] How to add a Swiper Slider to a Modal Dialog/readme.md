### [SithasoDaisy5] How to add a Swiper Slider to a Modal Dialog by Mashiane
### 05/28/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171140/)

Hi Fam  
  
This is in response to a question I was asked via DM.  
  
![](https://www.b4x.com/android/forum/attachments/171705)  
  
Step 1: Define variables  
  

```B4X
Private modalSwiper As SDUI5Modal        'ignore  
    Private swiper8 As SDUI5Swiper        'ignore  
    Private slide81 As SDUI5SwiperSlide        'ignore  
    Private slide82 As SDUI5SwiperSlide        'ignore  
    Private slide83 As SDUI5SwiperSlide        'ignore  
    Private slide84 As SDUI5SwiperSlide        'ignore
```

  
  
Step 2: Creating the UI (this can be done via the abstract designer also, as long as you set the same properties)  
  

```B4X
'Modal with swiper inside  
    modalSwiper.Initialize(Me, "modalSwiper", "modalSwiper")  
    modalSwiper.ParentID = app.PageView  
    modalSwiper.Title = "Image Gallery"  
    modalSwiper.Width = "800px"  
    modalSwiper.ActionType = modalSwiper.ACTIONTYPE_YES  
    modalSwiper.YesCaption = "Close"  
    modalSwiper.YesColor = "primary"  
    modalSwiper.Backdrop = True  
    modalSwiper.MoveFrom = modalSwiper.MOVEFROM_MIDDLE  
    BANano.Await(modalSwiper.AddComponent)  
    '  
    'Swiper inside modal form body  
    swiper8.Initialize(Me, "swiper8", "swiper8")  
    swiper8.ParentID = "modalSwiper_form"  
    swiper8.Height = "400px"  
    swiper8.Effect = swiper8.EFFECT_FADE  
    swiper8.HasPagination = True  
    swiper8.HasNavigation = True  
    swiper8.AutoPlay = True  
    swiper8.AutoPlayDelay = 4000  
    swiper8.AutoPlayDisableOnInteraction = False  
    swiper8.Rounded = "lg"  
    BANano.Await(swiper8.AddComponent)  
    '  
    slide81.Initialize(Me, "slide81", "slide81")  
    slide81.ParentID = "swiper8_slides"  
    slide81.SwiperId = "swiper8"  
    slide81.Image = "./assets/swiper_41.jpg"  
    slide81.ImageCover = True  
    slide81.ImageClasses = "w-full h-full object-cover"  
    slide81.RefreshSwiper = False  
    slide81.Classes = "w-full"  
    BANano.Await(slide81.AddComponent)  
    '  
    slide82.Initialize(Me, "slide82", "slide82")  
    slide82.ParentID = "swiper8_slides"  
    slide82.SwiperId = "swiper8"  
    slide82.Image = "./assets/swiper_42.jpg"  
    slide82.ImageCover = True  
    slide82.ImageClasses = "w-full h-full object-cover"  
    slide82.RefreshSwiper = False  
    slide82.Classes = "w-full"  
    BANano.Await(slide82.AddComponent)  
    '  
    slide83.Initialize(Me, "slide83", "slide83")  
    slide83.ParentID = "swiper8_slides"  
    slide83.SwiperId = "swiper8"  
    slide83.Image = "./assets/swiper_43.jpg"  
    slide83.ImageCover = True  
    slide83.ImageClasses = "w-full h-full object-cover"  
    slide83.RefreshSwiper = False  
    slide83.Classes = "w-full"  
    BANano.Await(slide83.AddComponent)  
    '  
    slide84.Initialize(Me, "slide84", "slide84")  
    slide84.ParentID = "swiper8_slides"  
    slide84.SwiperId = "swiper8"  
    slide84.Image = "./assets/swiper_44.jpg"  
    slide84.ImageCover = True  
    slide84.ImageClasses = "w-full h-full object-cover"  
    slide84.RefreshSwiper = True  
    slide84.Classes = "w-full"  
    BANano.Await(slide84.AddComponent)
```

  
  
#SharingTheGoodness  
  
Version 55.90 will be uploaded asap, been doing some AI analysis for it and discovered some bugs.