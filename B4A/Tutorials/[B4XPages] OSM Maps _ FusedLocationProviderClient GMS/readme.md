###  [B4XPages] OSM Maps / FusedLocationProviderClient GMS by Harris
### 05/07/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/160941/)

May 4, 2024 - Start of tutorial post…   
  
Based on:  
<https://www.b4x.com/android/forum/threads/open-street-map-viewer-gps.127827/#content>  
  
The original project was based on the GPS object / lib.. a power hungry outdated feature.  
This example uses the latest "Fused" location provider (GMS) to accomplish the same… and more…  
  
This tutorial shall evolve over a (short) time as discoveries are made clear to update / post. Hang in there…  
This project also includes an app to feed MOCK locations (lat/lon/etc..) into the FusedLocationProvderGMS - to test your final distribution.  
  
1) B4XPages  
Although introduced long time ago - and evolved since then - this is my first introduction. (been busy sowing and harvesting my garden).  
The first thing I notice is that **B4A** (pause and resume) complexities been (essentially) removed! Granted, there are some issues with Show and Hide ( show- B4XPages.ShowPage("destpag") hide - B4XPages.ShowPage("MainPage") but NOTHING that can't be overcome. It is all a matter of understanding what each does - and how each - PAGE - was implemented ( initialized / created / hidden).  
  
For cross platform - (A,i,J), this IS a great leap forward. My focus shall be on B4A, for my ease of explanation…   
  
![](https://www.b4x.com/android/forum/attachments/153420)  
  
All small[FONT=arial] Red Text[/FONT] are comments.   
The Milepost Number and Milepost Name are GPS locations, derived form a SQLlite DB (lat/lon), that are either in front / or behind you depending on your travel direction.   
There are much more intricacies to this project, but we shall leave it here for now until more can be defined in a clear and succinct manner.