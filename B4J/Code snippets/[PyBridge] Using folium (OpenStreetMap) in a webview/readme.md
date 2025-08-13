### [PyBridge] Using folium (OpenStreetMap) in a webview by Daestrum
### 03/02/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165910/)

As requested in another thread here is how to setup a B4XPages app to use PyBridge and Folium in a webview.  
  
Download latest beta version of B4J with PyBridge.  
  
Make sure PyBridge is selected in the Libraries Manager Tab  
  
Add folium to Python (pip install folium in a command prompt window for ypur Python, or use the Open local Python shell line below if python not installed)  
  
B4X Code (B4XMainPage)  

```B4X
#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests  
  
'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E  
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe  
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.  
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Public Py As PyBridge  
    Private WebView1 As WebView  
    Private Button1 As Button  
End Sub  
  
Public Sub Initialize  
     
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Py.Initialize(Me, "Py")  
    Dim opt As PyOptions = Py.CreateOptions("d:/python.3.12.8/python.exe") ' change to where your python is if required  
    Py.Start(opt)  
    Wait For Py_Connected (Success As Boolean)  
    If Success = False Then  
        LogError("Failed to start Python process.")  
        Return  
    End If  
End Sub  
  
Sub Button1_Click  
    folium_test  
End Sub  
  
Private Sub B4XPage_Background  
    Py.KillProcess  
End Sub  
  
Private Sub Py_Disconnected  
    Log("PyBridge disconnected")  
End Sub  
  
Sub folium_test  
    ' I read from dir assets but the code could be a string in-line.  
    ' change the Array to contain a string of where you want the map to open eg "London, UK" from "Toronto, CA"  
    wait for ((Py.RunCode("start",Array("Toronto, CA"),File.ReadString(File.DirAssets,"folium_test.py")).Fetch)) Complete (res As PyWrapper)  
    ' load the produced html file into a webview (it is fully functional web page and will open in  browser too if you want)  
    WebView1.LoadHtml(File.ReadString("../objects",res.value))  
End Sub
```

  
  
The Python code (either in-line or in a file)  
Note in the following code the line with 'an email address' - the lookup requires an email address  

```B4X
import folium  
import requests  
def get_lat_lon(place_name):  
    url = f"https://nominatim.openstreetmap.org/search?q={place_name}&format=json"  
    headers = {  
        'User-Agent': 'AddressLookup/1.0 (an email address)'  
    }  
    response = requests.get(url, headers=headers)  
    if response.status_code == 200:  
        try:  
            data = response.json()  
            if data:  
                lat = data[0]['lat']  
                lon = data[0]['lon']  
                return lat, lon  
            else:  
                print("No data found for the specified place name.")  
                return None  
        except ValueError:  
            print("Invalid JSON response.")  
            return None  
    else:  
        print(f"Error: {response.status_code}")  
        return  
def start(place):  
    lat,lon = get_lat_lon(place)  
    # Create a map centered around Lat/Lon  
    map_london = folium.Map(location=[lat,lon], zoom_start=12)  
    # Add a marker for Home  
    folium.Marker(  
        location=[lat,lon],  
        popup="Marker",  
        icon=folium.Icon(icon="Marker")).add_to(map_london)  
     
    # Save the map to an HTML file – change the name to what you want, it will be saved in /Objects folder  
    map_london.save("london_map.html")  
    # return the name of the file to B4J  
    return "london_map.html"
```