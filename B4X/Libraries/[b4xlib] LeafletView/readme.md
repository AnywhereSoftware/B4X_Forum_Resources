###    [b4xlib] LeafletView by Abdull Cadre
### 03/14/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170589/)

[HEADING=1]![](https://www.b4x.com/android/forum/attachments/170596)![](https://www.b4x.com/android/forum/attachments/170598)  
[/HEADING]  
LeafletView is a cross-platform wrapper for **Leaflet.js**, providing a lightweight alternative to Google Maps. It uses OpenStreetMap by default, meaning no API keys are required for basic mapping.  
  
This version is distributed as a **.b4xlib**, making it easy to include in any B4A or B4J project.  
  
[HEADING=2]Key Features:[/HEADING]  

- **Zero Configuration:** No Google Play Services or API keys required.
- **Road Routing:** Calculate and draw routes with distance and ETA data via Leaflet Routing Machine.
- **B4X Unified:** Identical API for B4A and B4J.
- **Interactive:** Built-in events for map interaction, marker clicks, and routing results.
- **Fully Customizable:** Toggle zoom controls, attributions, and persistent distance labels via the Designer.

---

  
[HEADING=2]Events:[/HEADING]  

- **MarkerClick** (Data As Map) - Returns ID and ExtraData.
- **MarkerPopupClick** (Data As Map) - Triggered when the popup action is clicked.
- **MapClick** (Data As Map) - Returns Lat/Lon of the clicked point.
- **ZoomChanged** (Data As Map) - Returns current zoom and center.
- **RoutingFound** (Data As Map) - Returns distance (km) and car\_eta.
- **RouteClick** (Data As Map) - Triggered when tapping the route line.

---

  
[HEADING=2]How to install:[/HEADING]  

1. Download the attached LeafletView.b4xlib and place it in your **Additional Libraries** folder.
2. In the B4X IDE, refresh the Libraries tab and check **LeafletView**.
3. Add a **CustomView** in the Abstract Designer and set its **Custom Class** to LeafletView.
4. Ensure your project has the JavaObject and JSON libraries selected.

[HEADING=2]Included in the Download:[/HEADING]  

- **LeafletView.b4xlib:** The compiled library.
- **Example Project:** A demo showing markers, routing, and event handling.

**Credits:** - [Leaflet.js](https://leafletjs.com/)  
  
[HEADING=2]Support[/HEADING]  
If this library is useful to you and you'd like to support my work, feel free to buy me a coffee!  
**PayPal:** [EMAIL]yusrahassamo@gmail.com[/EMAIL]