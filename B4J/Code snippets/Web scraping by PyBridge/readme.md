### Web scraping by PyBridge by jkhazraji
### 05/20/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167081/)

Here we get the trending movies' names from IMDb.  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Public Py As PyBridge  
End Sub  
  
Public Sub Initialize  
    
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Py.Initialize(Me, "Py")  
    Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")  
    Py.Start(opt)  
    Wait For Py_Connected (Success As Boolean)  
    If Success = False Then  
        LogError("Failed to start Python process.")  
        Return  
    End If  
  
    extractMoviesData  
  
End Sub  
  
  
Private Sub extractMoviesData  
Dim code As String =$"  
from selenium import webdriver  
from selenium.webdriver.common.by import By  
from selenium.webdriver.chrome.service import Service  
  
# Specify ChromeDriver path directly (update this path)  
driver_path = 'f:/chromedriver-win64/chromedriver.exe'  # or r'f:\chromedriver-win64\chromedriver.exe'  
driver = webdriver.Chrome(service=Service(driver_path))  
print('Trying to  fetch…')  
try:  
    driver.get('https://www.imdb.com/chart/moviemeter/')  
    driver.implicitly_wait(5)  
    
    # Modern IMDb selectors (updated May 2024)  
    movies = driver.find_elements(By.CSS_SELECTOR, 'a.ipc-title-link-wrapper')  # Primary selector  
    
    if not movies:  
        movies = driver.find_elements(By.CSS_SELECTOR, 'h3.ipc-title__text')  # Fallback  
    
    if movies:  
        print("\nTop Trending Movies:\n")  
        for i, movie in enumerate(movies[:20], 1):  
            print(f"{i}. {movie.text}")  
    else:  
        print("No movies found. Try manual inspection for updated selectors.")  
        
except Exception as e:  
    print('Error:', e)  
finally:  
    driver.quit()  
    "$  
Py.RunNoArgsCode(code)
```

  
  
You will need the necessary packages : selenium and you should download chrome webdriver and change path in the above code according to the place where you put it.  
Output:![](https://www.b4x.com/android/forum/attachments/164181)