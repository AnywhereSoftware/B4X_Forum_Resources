### 🚗 How to Get the Google Maps and OpenRouteService API Keys by fernando1987
### 10/10/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172240/)

Hello everyone 👋  
This example uses two different services:  
🗺️ Google Maps SDK for Android → displays the map  
🚗 OpenRouteService → calculates the driving route  
So before running the example, you need two API keys.  
The demo does not use Google Directions API or Google Routes API. OpenRouteService is responsible for calculating the route. Google\_Maps\_API\_Key\_Tutorial  

---

  
🗺️ 1. Create the Google Maps API Key  
Open Google Cloud Console:  

```B4X
https://console.cloud.google.com/
```

  
Create or select a project.  
Then enable:  

```B4X
Maps SDK for Android
```

  
For this example, Google Directions API and Google Routes API are not required. Google\_Maps\_API\_Key\_Tutorial  

---

  
🔑 2. Create the API key  
Go to:  
Google Maps Platform → Credentials  
Then select:  
Create credentials → API key  
Copy the generated key.  

---

  
📱 3. Add the Google Maps key to B4A  
Open the Manifest Editor in the project.  
Find the Google Maps metadata and replace the placeholder:  

```B4X
REPLACE_WITH_YOUR_RESTRICTED_MAPS_API_KEY
```

  
Example:  

```B4X
AddApplicationText(  
    <meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_GOOGLE_MAPS_API_KEY"/>  
)
```

  
The Google Maps SDK reads the key from the Android manifest. Google\_Maps\_API\_Key\_Tutorial  

---

  
🌍 4. Create the OpenRouteService API Key  
Now create the second key.  
Open:  

```B4X
https://account.heigit.org/
```

  
Create an account and open the API key dashboard.  
Create a key with access to OpenRouteService Directions. Google\_Maps\_API\_Key\_Tutorial  
Copy the generated key.  

---

  
🚗 5. Add the OpenRouteService key to the project  
Open:  

```B4X
Rute.b4a
```

  
Find:  

```B4X
Private Const OPENROUTESERVICE_API_KEY As String = "REPLACE_WITH_YOUR_OPENROUTESERVICE_API_KEY"
```

  
Replace it with your key:  

```B4X
Private Const OPENROUTESERVICE_API_KEY As String = "YOUR_OPENROUTESERVICE_API_KEY"
```

  

---

  
🌐 6. Endpoint used by the example  
The route is requested from:  

```B4X
https://api.heigit.org/openrouteservice/v2/directions/driving-car/geojson
```

  
Coordinates are sent using:  

```B4X
[longitude, latitude]
```

  
The OpenRouteService key is sent through the HTTP Authorization header. Google\_Maps\_API\_Key\_Tutorial  

---

  
🚀 7. Run the example  
Once both keys are configured:  
1️⃣ Compile the project  
2️⃣ Install it on the Android device  
3️⃣ Wait for Google Maps to load  
4️⃣ Long-press the map to create a destination  
5️⃣ Tap the marker  
6️⃣ Press:  

```B4X
Start route
```

  
7️⃣ Allow location access  
The example will use:  
🗺️ Google Maps to display the map  
📍 GPS to obtain your current position  
🚗 OpenRouteService to calculate the driving route  
The blue route will then be drawn on the map. Google\_Maps\_API\_Key\_Tutorial  

---

  
🧭 What the demo does  
The example includes:  
📍 Current GPS location  
📌 Destination markers  
🚗 Driving route calculation  
🗺️ Route drawing on Google Maps  
📏 Remaining distance  
⏱️ Estimated remaining time  
🎯 Arrival detection  
🔵 Route progress as the user moves  
⚡ R8 enabled  

---

  
🎯 Quick summary  
You only need two keys.  
🗺️ Google Maps:  

```B4X
Google Cloud Console  
→ Enable Maps SDK for Android  
→ Create API Key  
→ Add it to the B4A Manifest Editor
```

  
🚗 OpenRouteService:  

```B4X
Create HeiGIT account  
→ Create OpenRouteService API key  
→ Add it to Rute.b4a
```

  
And that's it 😄🚀  
The example is ready to calculate and display routes using Google Maps + OpenRouteService from B4A.  
  
  
![](https://www.b4x.com/android/forum/attachments/173985)