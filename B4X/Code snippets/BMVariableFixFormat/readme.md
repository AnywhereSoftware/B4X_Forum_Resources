###  BMVariableFixFormat by Brian Michael
### 06/23/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161757/)

**[UPDATE V1.1]**  
  
Hello everyone, today I come to you with a small tool that will help you better organize your projects, reduce the lines of code and in turn reduce the weight of your project.  
  
I called Variable Fix Format  
Which can reduce all this:  
  

```B4X
Private fx As JFX  
      
Private fx As JFX  
    Public Form As Form  
    Public Form2 As Form  
    Public xui As XUI  
    Type Commision_Class (TotalSales_Percent As String, Mix_Percent As String, Effective_Percent As Long, Products As List, Brands As List, Providers As List, Rutes As List)  
    Public Commision_List As List  
    Public JSON_G As JSONGenerator  
    Public JSON_P As JSONParser  
    Private btnSave As Button  
    Private btnSearchPBP As Button  
    Private Label1 As Label  
    Private Label2 As Label  
    Public Label3 As Label  
    Private Label4 As Label  
    Private Label8 As Label  
    Private lstPBP As CustomListView  
    Private lstRutes As CustomListView  
    Private Pane1 As Pane  
    Private spnEffective_Percent As Spinner  
    Private spnMix_Percent As Spinner  
    Private spnTotalSales_Percent As Spinner  
    Private txtSearchPBP As TextField  
    Private chk As CheckBox  
    Private spn As Spinner  
    Public oProducts As List  
    Public oBrands As List  
    Public oProviders As List  
    Public SelectedPBP As List  
    Public PBPList As List  
    Public PBPGeneralList As List  
    Public BonusBrandsGeneralList As List  
    Public SelectedRutes As List  
    Private tag As Label  
    Private chk2,chk3 As CheckBox  
    Private spnMix_Objetive As Spinner  
    Private txtMount As TextField  
    Private txtSearchBonusBrands As TextField  
    Private btnSearchBonusBrands As Button  
    Private lstBonusBrands As CustomListView  
    Private XL As XLUtils  
    Public ColumnLimit As Int = 17  
    Private JOFormulaEvaluator As JavaObject  
    Private JOWB As JavaObject  
    Private JOConditionalFormattingEvaluator As JavaObject  
    Private JODataFormatter As JavaObject  
    Private cbmBonusBrands1 As ComboBox  
    Private cbmBonusBrands2 As ComboBox  
    Private pnlBonusBrandsPanel As Pane  
    Private btnSaveBonusBrandsPanel As Button  
    Private btnCloseBonusBrandsPanel As Button  
    Private BonusBrand_Headers As List  
    Private BonusBrand_List As List  
    Private btnBonusBrandsTemplate As Button  
    Private lblDescription As Label  
    Private btnDelete As Label  
    Private lstCommisions As CustomListView  
    Private btnAdd As Button
```

  
  
  
Just to this:  

```B4X
#REGION BMVariableFixFormat v1.1  
'This tool is created by Brian Michael for B4X Forum.  
Private fx As JFX  
Private btnSave,btnSearchPBP,btnSearchBonusBrands,btnSaveBonusBrandsPanel,btnCloseBonusBrandsPanel,btnBonusBrandsTemplate,btnAdd As Button  
Private Label1,Label2,Label4,Label8,tag,lblDescription,btnDelete As Label  
Private lstPBP,lstRutes,lstBonusBrands,lstCommisions As CustomListView  
Private Pane1,pnlBonusBrandsPanel As Pane  
Private spnEffective_Percent,spnMix_Percent,spnTotalSales_Percent,spn,spnMix_Objetive As Spinner  
Private txtSearchPBP,txtMount,txtSearchBonusBrands As TextField  
Private chk,chk2,chk3 As CheckBox  
Private XL As XLUtils  
Private JOFormulaEvaluator,JOWB,JOConditionalFormattingEvaluator,JODataFormatter As JavaObject  
Private cbmBonusBrands1,cbmBonusBrands2 As ComboBox  
Private BonusBrand_Headers,BonusBrand_List As List  
Public Form,Form2 As Form  
Public xui As XUI  
Public Commision_List,oProducts,oBrands,oProviders,SelectedPBP,PBPList,PBPGeneralList,BonusBrandsGeneralList,SelectedRutes As List  
Public JSON_G As JSONGenerator  
Public JSON_P As JSONParser  
Public Label3 As Label  
Public ColumnLimit As Int  
Type Commision_Class (TotalSales_Percent As String, Mix_Percent As String, Effective_Percent As Long, Products As List, Brands As List, Providers As List, Rutes As List)  
#END REGION
```

  
  
  
Here I leave the project in B4J so you can use it