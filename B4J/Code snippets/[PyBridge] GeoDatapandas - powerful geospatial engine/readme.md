### [PyBridge] GeoDatapandas - powerful geospatial engine by Erel
### 02/24/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165796/)

Just a tiny glimpse to this powerful framework: <https://geopandas.org/en/stable/>  
  
pip install geopandas  
pip install matplotlib  
  
Probably better to install in the global Python as this is a large framework.  
  

```B4X
Dim FileName As String = File.Combine(File.DirApp, "countries.zip")  
If File.Exists(FileName, "") = False Then  
    Wait For (DownloadFile("https://naciscdn.org/naturalearth/110m/cultural/ne_110m_admin_0_countries.zip", FileName)) Complete (Success As Boolean)  
    If Success = False Then Return  
End If  
Dim gpd As PyWrapper = Py.ImportModule("geopandas")  
Dim gdf As PyWrapper = gpd.Run("read_file").Arg(FileName)  
gdf.Run("head").Print  
Py.WrapObject(CRLF).Run("join").Arg(gdf.GetField("columns")).Print  
'add new column GDP / POP  
gdf.Set("gdp_md_per_capita", gdf.Get("GDP_MD").Run("div").Arg(gdf.Get("POP_EST")))  
gdf = gdf.Get(gdf.Get("CONTINENT").OprEqual("Asia")) 'gdf = gdf[gdf["CONTINENT] = "Asia"]  
Dim ax As PyWrapper = gdf.Run("plot").ArgNamed("figsize", Array(15, 15)).ArgNamed("column", "gdp_md_per_capita") _  
    .ArgNamed("cmap", "RdBu").ArgNamed("legend", True)  
ax.Run("axis").Arg("off")  
Dim plt As PyWrapper = Py.ImportModule("matplotlib.pyplot")  
plt.Run("show")
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/162032)  
  
Download file:  

```B4X
Private Sub DownloadFile (Url As String, Output As String) As ResumableSub  
    Log("Downloading file")  
    Dim j As HttpJob  
    j.Initialize("", Me)  
    j.Download(Url)  
    Wait For (j) JobDone (j As HttpJob)  
    If j.Success = False Then  
        Log(j.ErrorMessage)  
    Else  
        Dim out As OutputStream = File.OpenOutput(Output, "", False)  
        File.Copy2(j.GetInputStream, out)  
        out.Close  
    End If  
    j.Release  
    Return j.Success  
End Sub
```