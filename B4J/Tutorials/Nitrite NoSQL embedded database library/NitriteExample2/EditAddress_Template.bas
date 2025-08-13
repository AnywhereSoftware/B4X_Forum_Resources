B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	Private XUI As XUI
	Private mBase As B4XView
	Private xDialog As B4XDialog


	
	Public lblKeyComb As B4XView
	Private tfFirstName As B4XView
	Private tfLastName As B4XView
	Private tfCompanyName As B4XView
	Private tfAddress As B4XView
	Private tfCity As B4XView
	Private tfCounty As B4XView
	Private tfPostcode As B4XView
	Private tfPhone1 As B4XView
	Private tfPhone2 As B4XView
	Private tfEmail As B4XView
	Private tfWeb As B4XView
	
	Private mDoc As NitriteDocument
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(F As Form)
	mBase = XUI.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 600dip, 500dip)
	mBase.LoadLayout("EditAddress")
End Sub

Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog)
	xDialog = Dialog
	
End Sub

Private Sub DialogClosed(Result As Int)

End Sub

Public Sub setInitialData(Doc As NitriteDocument)
	mDoc = Doc
	tfFirstName.Text = Doc.GetDefault(AccessDB.DOC_FIRST_NAME,"")
	tfLastName.Text = Doc.GetDefault(AccessDB.DOC_LAST_NAME,"")
	tfCompanyName.Text = Doc.GetDefault(AccessDB.DOC_COMPANY_NAME,"")
	tfAddress.Text = Doc.GetDefault(AccessDB.DOC_ADDRESS,"")
	tfCity.Text = Doc.GetDefault(AccessDB.DOC_CITY,"")
	tfCounty.Text = Doc.GetDefault(AccessDB.DOC_COUNTY,"")
	tfPostcode.Text = Doc.GetDefault(AccessDB.DOC_POSTCODE,"")
	tfPhone1.Text = Doc.GetDefault(AccessDB.DOC_PHONE1,"")
	tfPhone2.Text = Doc.GetDefault(AccessDB.DOC_PHONE2,"")
	tfEmail.Text = Doc.GetDefault(AccessDB.DOC_EMAIL,"")
	tfWeb.Text = Doc.GetDefault(AccessDB.DOC_WEB,"")
End Sub

Public Sub getUpdatedData As NitriteDocument
	
	mDoc.Put(AccessDB.DOC_FIRST_NAME,tfFirstName.Text)
	mDoc.Put(AccessDB.DOC_LAST_NAME,tfLastName.Text)
	mDoc.Put(AccessDB.DOC_COMPANY_NAME,tfCompanyName.Text)
	mDoc.Put(AccessDB.DOC_ADDRESS,tfAddress.Text)
	mDoc.Put(AccessDB.DOC_CITY,tfCity.Text)
	mDoc.Put(AccessDB.DOC_COUNTY,tfCounty.Text)
	mDoc.Put(AccessDB.DOC_POSTCODE,tfPostcode.Text)
	mDoc.Put(AccessDB.DOC_PHONE1,tfPhone1.Text)
	mDoc.Put(AccessDB.DOC_PHONE2,tfPhone2.Text)
	mDoc.Put(AccessDB.DOC_EMAIL,tfEmail.Text)
	mDoc.Put(AccessDB.DOC_WEB,tfWeb.Text)
	
	Return mDoc
End Sub
