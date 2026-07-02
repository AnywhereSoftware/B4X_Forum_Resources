B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' B4X MyInvois Class
' Version 1.00
Sub Class_Globals
	Type Document (name As String, schema As Schema, schema2 As Schema2, invoice As Invoice)
	Type AccountingCustomerParty (Party As Party)
	Type AccountingSupplierParty (AdditionalAccountID As AdditionalAccountID, Party As Party)
	Type AdditionalAccountID (Value As String, schemeAgencyName As String)
	Type AdditionalDocumentReference (List As List)
	Type AdditionalDocumentReferenceProp (ID As ID, DocumentType As DocumentType, DocumentDescription As DocumentDescription)
	Type AddressLine (List As List)
	Type AddressLineProp (Line As Line)
	Type AllowanceCharge (List As List)
	Type AllowanceChargeProp (ChargeIndicator As ChargeIndicator, AllowanceChargeReason As AllowanceChargeReason, MultiplierFactorNumeric As MultiplierFactorNumeric, Amount As Amount)
	Type AllowanceChargeReason (Value As String)
	Type AllowanceTotalAmount (Value As Double, currencyID As String)
	Type Amount (Value As Double, currencyID As String)
	Type BillingReference (AdditionalDocumentReference As AdditionalDocumentReference)
	Type CanonicalizationMethod (Algorithm As String)
	Type Cert (CertDigest As CertDigest, IssuerSerial As IssuerSerial)
	Type CertDigest (DigestMethod As DigestMethod, DigestValue As DigestValue)
	Type ChargeIndicator (Value As Boolean)
	Type ChargeTotalAmount (Value As Double, currencyID As String)
	Type CityName (Value As String)
	Type CommodityClassification (List As List)
	Type CommodityClassificationProp (ItemClassificationCode As ItemClassificationCode)
	Type Contact (Telephone As Telephone, ElectronicMail As ElectronicMail)
	Type Country (IdentificationCode As IdentificationCode)
	Type CountrySubentityCode (Value As String)
	Type Delivery (DeliveryParty As DeliveryParty, Shipment As Shipment)
	'Type DeliveryParty (IndustryClassificationCode As IndustryClassificationCode, PartyIdentification As PartyIdentification, PostalAddress As PostalAddress, PartyLegalEntity As PartyLegalEntity, List As List, ID As ID)
	Type DeliveryParty (PartyIdentification As PartyIdentification, PostalAddress As PostalAddress, PartyLegalEntity As PartyLegalEntity)
	Type Description (Value As String)
	Type DigestMethod (Value As String, Algorithm As String)
	Type DigestValue (Value As String)
	Type DigitalSignature (Id As String, schema As String, SignatureObject As SignatureObject, KeyInfo As KeyInfo, SignatureValue As SignatureValue, SignedInfo As SignedInfo)
	Type DocumentCurrencyCode (Value As String)
	Type DocumentDescription (Value As String)
	Type DocumentType (Value As String)
	Type ElectronicMail (Value As String)
	Type EndDate (Value As String)
	Type ExtensionContent (UBLDocumentSignatures As UBLDocumentSignatures)
	Type ExtensionURI (Value As String)
	Type FreightAllowanceCharge (ChargeIndicator As ChargeIndicator, AllowanceChargeReason As AllowanceChargeReason, Amount As Amount)
	Type ID (Value As String, schemeID As String, schemeAgencyID As String)
	Type IdentificationCode (Value As String, listID As String, listAgencyID As String)
	Type IndustryClassificationCode (Value As String, name As String)
	Type Item (CommodityClassification As CommodityClassification, Description As Description, OriginCountry As OriginCountry)
	Type InvoicedQuantity (Value As Int, unitCode As String)
	Type InvoiceLine (List As List)
	Type InvoiceLineProp (ID As ID, InvoicedQuantity As InvoicedQuantity, LineExtensionAmount As LineExtensionAmount, AllowanceCharge As AllowanceCharge, TaxTotal As TaxTotal, Item As Item, Price As Price, ItemPriceExtension As ItemPriceExtension)
	Type InvoicePeriod (StartDate As StartDate, EndDate As EndDate, Description As Description)
	Type InvoiceTypeCode (Value As String, listVersionID As String)
	Type IssueDate (Value As String)
	Type IssuerSerial (X509IssuerName As X509IssuerName, X509SerialNumber As X509SerialNumber)
	Type IssueTime (Value As String)
	Type ItemClassificationCode (Value As String, listID As String)
	Type ItemPriceExtension (Amount As Amount)
	Type KeyInfo (X509Data As X509Data)
	Type LegalMonetaryTotal (LineExtensionAmount As LineExtensionAmount, TaxExclusiveAmount As TaxExclusiveAmount, TaxInclusiveAmount As TaxInclusiveAmount, AllowanceTotalAmount As AllowanceTotalAmount, ChargeTotalAmount As ChargeTotalAmount, PayableRoundingAmount As PayableRoundingAmount, PayableAmount As PayableAmount)
	Type Line (Value As String)
	Type LineExtensionAmount (Value As Double, currencyID As String)
	Type MultiplierFactorNumeric (Value As Double)
	Type Note (Value As String)
	Type OriginCountry (IdentificationCode As IdentificationCode)
	Type PaidAmount (Value As Double, currencyID As String)
	Type PaidDate (Value As String)
	Type PaidTime (Value As String)
	Type Party (IndustryClassificationCode As IndustryClassificationCode, PartyIdentification As PartyIdentification, PostalAddress As PostalAddress, PartyLegalEntity As PartyLegalEntity, Contact As Contact, List As List)
	'Type Party (List As List)
	Type PartyProp (ID As ID, DocumentType As DocumentType, DocumentDescription As DocumentDescription)
	Type PartyIdentification (List As List)
	Type PartyIdentificationProp (ID As ID)
	Type PartyLegalEntity (RegistrationName As RegistrationName)
	Type PayableAmount (Value As Double, currencyID As String)
	Type PayableRoundingAmount (Value As Double, currencyID As String)
	Type PayeeFinancialAccount (ID As ID)
	Type PaymentMeans (PaymentMeansCode As PaymentMeansCode, PayeeFinancialAccount As PayeeFinancialAccount)
	Type PaymentMeansCode (Value As String)
	Type PaymentTerms (Note As Note)
	Type Percent (Value As Double)
	Type PostalAddress (CityName As CityName, PostalZone As PostalZone, CountrySubentityCode As CountrySubentityCode, AddressLine As AddressLine, Country As Country)
	Type PostalZone (Value As String)
	Type PrepaidPayment (ID As ID, PaidAmount As PaidAmount, PaidDate As PaidDate, PaidTime As PaidTime)
	Type Price (PriceAmount As PriceAmount)
	Type PriceAmount (Value As Double, currencyID As String)
	Type QualifyingProperties (schema As String, Target As String, SignedProperties As SignedProperties)
	Type Reference (List As List)
	Type ReferenceProp (ReferenceId As String, ReferenceType As String, ReferenceURI As String, DigestMethod As DigestMethod, DigestValue As DigestValue, Transforms As Transforms)
	Type ReferencedSignatureID (Value As String)
	Type RegistrationName (Value As String)
	Type Shipment (ID As ID, FreightAllowanceCharge As FreightAllowanceCharge)
	Type SignatureInformation (ID As ID, ReferencedSignatureID As ReferencedSignatureID, Signature As DigitalSignature)
	Type SignatureMethod (Value As String, Algorithm As String)
	Type SignatureObject (QualifyingProperties As QualifyingProperties)
	Type SignatureValue (Value As String)
	Type SignedInfo (CanonicalizationMethod As CanonicalizationMethod, SignatureMethod As SignatureMethod, Reference As Reference)
	Type SignedProperties (Id As String, SignedSignatureProperties As SignedSignatureProperties)
	Type SignedSignatureProperties (SigningTime As SigningTime, SigningCertificate As SigningCertificate)
	Type SigningCertificate (Cert As Cert)
	Type SigningTime (Value As String)
	Type StartDate (Value As String)
	Type TaxableAmount (Value As Double, currencyID As String)
	Type TaxAmount (Value As Double, currencyID As String)
	Type TaxCategory (ID As ID, TaxExemptionReason As TaxExemptionReason, TaxScheme As TaxScheme)
	Type TaxCurrencyCode (Value As String)
	Type TaxExclusiveAmount (Value As Double, currencyID As String)
	Type TaxExemptionReason (Value As String)
	Type TaxInclusiveAmount (Value As Double, currencyID As String)
	Type TaxScheme (ID As ID)
	Type TaxSubtotal (TaxableAmount As TaxableAmount, TaxAmount As TaxAmount, TaxCategory As TaxCategory, Percent As Percent)
	Type TaxTotal (TaxAmount As TaxAmount, TaxSubtotal As TaxSubtotal)
	Type Telephone (Value As String)
	Type Transform (Algorithm As String, XPath As XPath)
	Type TransformProp (Transform As Transform)
	Type Transforms (List As List)
	Type UBLDocumentSignatures (schema As Schema2, SignatureInformation As SignatureInformation)
	Type UBLExtension (ExtensionURI As ExtensionURI, ExtensionContent As ExtensionContent)
	Type UBLExtensions (UBLExtension As UBLExtension)
	Type UBLSignature (ID As ID, SignatureMethod As SignatureMethod)
	Type X509Certificate (Value As String)
	Type X509Data (X509Certificate As X509Certificate, X509SubjectName As X509SubjectName, X509IssuerSerial As X509IssuerSerial)
	Type X509IssuerName (Value As String)
	Type X509IssuerSerial (X509IssuerName As X509IssuerName, X509SerialNumber As X509SerialNumber)
	Type X509SerialNumber (Value As String)
	Type X509SubjectName (Value As String)
	Type XPath (Value As String)
	
	Type Invoice ( _
	ID As ID, _
	IssueDate As IssueDate, _
	IssueTime As IssueTime, _
	InvoiceTypeCode As InvoiceTypeCode, _
	DocumentCurrencyCode As DocumentCurrencyCode, _
	TaxCurrencyCode As TaxCurrencyCode, _
	InvoicePeriod As InvoicePeriod, _
	BillingReference As BillingReference, _
	AdditionalDocumentReference As AdditionalDocumentReference, _
	AccountingSupplierParty As AccountingSupplierParty, _
	AccountingCustomerParty As AccountingCustomerParty, _
	Delivery As Delivery, _
	PaymentMeans As PaymentMeans, _
	PaymentTerms As PaymentTerms, _
	PrepaidPayment As PrepaidPayment, _
	AllowanceCharge As AllowanceCharge, _
	TaxTotal As TaxTotal, _
	LegalMonetaryTotal As LegalMonetaryTotal, _
	InvoiceLine As InvoiceLine, _
	UBLExtensions As UBLExtensions, _
	UBLSignature As UBLSignature)
	Type Element (Value As Object, Attributes As Map)
	Type Schema (Inv As String, CAC As String, CBC As String, EXT As String) ' CAC, CBC, EXT
	Type Schema2 (CSC As String, SAC As String, SBC As String)
	'Type Schema2 (CEC As String)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

' Generate XML Invoice
Public Sub GenerateInvoiceXML (Document As Document, Compact As Boolean) As String
	Dim doc As Document = Document
	Dim inv As Invoice = doc.invoice
	Dim XB As XMLBuilder
	XB = XB.create(doc.name) _
			.attribute("xmlns", doc.schema.INV) _
			.attribute("xmlns:cac", doc.schema.CAC) _
			.attribute("xmlns:cbc", doc.schema.CBC) _
			.attribute("xmlns:ext", doc.schema.EXT)
	'XB = XB.comment("   This is a test comment   ")
	If doc.invoice.UBLExtensions.IsInitialized Then
		XB = XB.element("ext:UBLExtensions")
		XB = XB.element("ext:UBLExtension")
		XB = XB.element("ext:ExtensionURI") _
			.text(doc.invoice.UBLExtensions.UBLExtension.ExtensionURI.Value)
		XB = XB.up ' /ExtensionURI
		XB = XB.element("ext:ExtensionContent")
		'XB = XB.comment("   Please note that the signature values are sample values only   ")
		Dim UBLDocumentSignatures1 As UBLDocumentSignatures = doc.invoice.UBLExtensions.UBLExtension.ExtensionContent.UBLDocumentSignatures
		XB = XB.element("sig:UBLDocumentSignatures") _
			.attribute("xmlns:sig", UBLDocumentSignatures1.schema.CSC) _
			.attribute("xmlns:sac", UBLDocumentSignatures1.schema.SAC) _
			.attribute("xmlns:sbc", UBLDocumentSignatures1.schema.SBC)
		XB = XB.element("sac:SignatureInformation")
		Dim SignatureInformation1 As SignatureInformation = UBLDocumentSignatures1.SignatureInformation
		XB = XB.element("cbc:ID").text(SignatureInformation1.ID.Value).up
		XB = XB.element("sbc:ReferencedSignatureID").text(SignatureInformation1.ReferencedSignatureID.Value).up
		Dim Signature1 As DigitalSignature = SignatureInformation1.Signature
		XB = XB.element("ds:Signature") _
			.attribute("xmlns:ds", Signature1.schema) _
			.attribute("Id", Signature1.Id)
		XB = XB.element("ds:SignedInfo")
		Dim SignedInfo1 As SignedInfo = Signature1.SignedInfo
		XB = XB.element("ds:CanonicalizationMethod").attribute("Algorithm", SignedInfo1.CanonicalizationMethod.Algorithm).up
		XB = XB.element("ds:SignatureMethod").attribute("Algorithm", SignedInfo1.SignatureMethod.Algorithm).up
		If SignedInfo1.Reference.IsInitialized Then
			For Each ref1 As ReferenceProp In SignedInfo1.Reference.List
				XB = XB.element("ds:Reference")
				If ref1.ReferenceId <> "" Then
					XB = XB.attribute("Id", ref1.ReferenceId)
				End If
				If ref1.ReferenceType <> "" Then
					XB = XB.attribute("Type", ref1.ReferenceType)
				End If
				XB = XB.attribute("URI", ref1.ReferenceURI)
				If ref1.Transforms.IsInitialized Then
					XB = XB.element("ds:Transforms")
					For Each tra1 As TransformProp In ref1.Transforms.List
						XB = XB.element("ds:Transform") _
							.attribute("Algorithm", tra1.Transform.Algorithm)
						If tra1.Transform.XPath.IsInitialized Then
							XB = XB.element("ds:XPath") _
								.text(tra1.Transform.XPath.Value).up
						End If
						XB = XB.up ' /ds:Transform
					Next
					XB = XB.up ' /ds:Transforms
				End If
				XB = XB.element("ds:DigestMethod") _
					.attribute("Algorithm", ref1.DigestMethod.Algorithm).up
				XB = XB.element("ds:DigestValue") _
					.text(ref1.DigestValue.Value).up
				XB = XB.up ' /ds:Reference
			Next
		End If
		XB = XB.up ' /ds:SignedInfo
		XB = XB.element("ds:SignatureValue") _
			.text(Signature1.SignatureValue.Value)
		XB = XB.up ' /ds:SignatureValue
		XB = XB.element("ds:KeyInfo")
		XB = XB.element("ds:X509Data")
		XB = XB.element("ds:X509Certificate") _
			.text(Signature1.KeyInfo.X509Data.X509Certificate.Value)
		XB = XB.up ' /ds:X509Certificate
		XB = XB.up ' /ds:X509Data
		XB = XB.up ' /ds:KeyInfo
		XB = XB.element("ds:Object")
		Dim QualifyingProperties1 As QualifyingProperties = Signature1.SignatureObject.QualifyingProperties
		XB = XB.element("xades:QualifyingProperties") _
			.attribute("xmlns:xades", QualifyingProperties1.schema) _
			.attribute("Target", QualifyingProperties1.Target)
		Dim SignedProperties1 As SignedProperties = QualifyingProperties1.SignedProperties
		XB = XB.element("xades:SignedProperties") _
			.attribute("Id", SignedProperties1.Id)
		Dim SignedSignatureProperties1 As SignedSignatureProperties = SignedProperties1.SignedSignatureProperties
		XB = XB.element("xades:SignedSignatureProperties")
		XB = XB.element("xades:SigningTime") _
			.text(SignedSignatureProperties1.SigningTime.Value).up
		XB = XB.element("xades:SigningCertificate")
		XB = XB.element("xades:Cert")
		XB = XB.element("xades:CertDigest")
		XB = XB.element("ds:DigestMethod") _
			.attribute("Algorithm", SignedSignatureProperties1.SigningCertificate.Cert.CertDigest.DigestMethod.Algorithm)
		XB = XB.up ' /ds:DigestMethod
		XB = XB.element("ds:DigestValue") _
			.text(SignedSignatureProperties1.SigningCertificate.Cert.CertDigest.DigestValue.Value)
		XB = XB.up ' /ds:DigestValue
		XB = XB.up ' /xades:CertDigest
		XB = XB.element("xades:IssuerSerial")
		XB = XB.element("ds:X509IssuerName") _
			.text(SignedSignatureProperties1.SigningCertificate.Cert.IssuerSerial.X509IssuerName.Value)
		XB = XB.up ' /ds:X509IssuerName
		XB = XB.element("ds:X509SerialNumber") _
			.text(SignedSignatureProperties1.SigningCertificate.Cert.IssuerSerial.X509SerialNumber.Value)
		XB = XB.up ' /ds:X509SerialNumber
		XB = XB.up ' /xades:IssuerSerial
		XB = XB.up ' /xades:Cert
		XB = XB.up ' /xades:SigningCertificate
		XB = XB.up ' /xades:SignedSignatureProperties
		XB = XB.up ' /xades:SignedProperties
		XB = XB.up ' /xades:QualifyingProperties
		XB = XB.up ' /ds:Object
		XB = XB.up ' /ds:Signature
		XB = XB.up ' /sac:SignatureInformation
		XB = XB.up ' /sig:UBLDocumentSignatures
		XB = XB.up ' /ext:ExtensionContent
		XB = XB.up ' /ext:UBLExtension
		XB = XB.up ' /ext:UBLExtensions
	End If
	XB = XB.element("cbc:ID").text(inv.ID.Value).up
	XB = XB.element("cbc:IssueDate").text(inv.IssueDate.Value).up
	XB = XB.element("cbc:IssueTime").text(inv.IssueTime.Value).up
	XB = XB.element("cbc:InvoiceTypeCode") _
		.attribute("listVersionID", inv.InvoiceTypeCode.listVersionID) _
		.text(inv.InvoiceTypeCode.Value).up
	XB = XB.element("cbc:DocumentCurrencyCode").text(inv.DocumentCurrencyCode.Value).up
	XB = XB.element("cbc:TaxCurrencyCode").text(inv.TaxCurrencyCode.Value).up
	XB = XB.element("cac:InvoicePeriod")
	XB = XB.element("cbc:StartDate").text(inv.InvoicePeriod.StartDate.Value).up
	XB = XB.element("cbc:EndDate").text(inv.InvoicePeriod.EndDate.Value).up
	XB = XB.element("cbc:Description").text(inv.InvoicePeriod.Description.Value).up
	XB = XB.up
	If inv.BillingReference.IsInitialized Then ' OPTIONAL
		XB = XB.element("cac:BillingReference")
		For Each prop1 As AdditionalDocumentReferenceProp In inv.BillingReference.AdditionalDocumentReference.List
			XB = XB.element("cac:AdditionalDocumentReference")
			XB = XB.element("cbc:ID").text(prop1.ID.Value).up
			XB = XB.up
		Next
		XB = XB.up
	End If
	If inv.AdditionalDocumentReference.IsInitialized Then ' OPTIONAL
		For Each prop1 As AdditionalDocumentReferenceProp In inv.AdditionalDocumentReference.List
			XB = XB.element("cac:AdditionalDocumentReference")
			XB = XB.element("cbc:ID").text(prop1.ID.Value).up
			If prop1.DocumentType.IsInitialized Then
				XB = XB.element("cbc:DocumentType").text(prop1.DocumentType.Value).up
			End If
			If prop1.DocumentDescription.IsInitialized Then
				XB = XB.element("cbc:DocumentDescription").text(prop1.DocumentDescription.Value).up
			End If
			XB = XB.up
		Next
	End If
	If doc.invoice.UBLSignature.IsInitialized Then
		Dim UBLSignature1 As UBLSignature = doc.invoice.UBLSignature
		XB = XB.element("cac:Signature")
		XB = XB.element("cbc:ID") _
			.text(UBLSignature1.ID.Value).up
		XB = XB.element("cbc:SignatureMethod") _
			.text(UBLSignature1.SignatureMethod.Value).up
		XB = XB.up ' /cac:Signature
	End If
	
	XB = XB.element("cac:AccountingSupplierParty")
	'Optional [For export only]
	If inv.AccountingSupplierParty.AdditionalAccountID.IsInitialized Then
		XB = XB.element("cbc:AdditionalAccountID") _
			.attribute("schemeAgencyName", inv.AccountingSupplierParty.AdditionalAccountID.schemeAgencyName) _
			.text(inv.AccountingSupplierParty.AdditionalAccountID.Value).up
		'If inv.AccountingSupplierParty.AdditionalAccountID.Value <> "" Then
		'	XB = XB.element("cbc:AdditionalAccountID") _
		'		.attribute("schemeAgencyName", inv.AccountingSupplierParty.AdditionalAccountID.schemeAgencyName) _
		'		.text(inv.AccountingSupplierParty.AdditionalAccountID.Value).up
		'Else
		'	XB = XB.element("cbc:AdditionalAccountID") _
		'		.attribute("schemeAgencyName", inv.AccountingSupplierParty.AdditionalAccountID.schemeAgencyName).up
		'End If
	End If
	XB = XB.element("cac:Party")
	If inv.AccountingSupplierParty.Party.IndustryClassificationCode.IsInitialized Then
		Dim prop2 As IndustryClassificationCode = inv.AccountingSupplierParty.Party.IndustryClassificationCode
		XB = XB.element("cbc:IndustryClassificationCode") _
			.attribute("name", prop2.name) _
			.text(prop2.Value).up
	End If
	For Each prop3 As PartyIdentificationProp In inv.AccountingSupplierParty.Party.PartyIdentification.List
		XB = XB.element("cac:PartyIdentification")
		Dim prop4 As ID = prop3.ID
		XB = XB.element("cbc:ID") _
			.attribute("schemeID", prop4.schemeID) _
			.text(prop4.Value).up
		XB = XB.up ' /PartyIdentification
	Next
	XB = XB.element("cac:PostalAddress")
	XB = XB.element("cbc:CityName")
	Dim prop5 As CityName = inv.AccountingSupplierParty.Party.PostalAddress.CityName
	XB = XB.text(prop5.Value).up
	XB = XB.element("cbc:PostalZone")
	Dim prop6 As PostalZone = inv.AccountingSupplierParty.Party.PostalAddress.PostalZone
	XB = XB.text(prop6.Value).up
	Dim prop7 As CountrySubentityCode = inv.AccountingSupplierParty.Party.PostalAddress.CountrySubentityCode
	XB = XB.element("cbc:CountrySubentityCode")
	XB = XB.text(prop7.Value).up
	For Each prop8 As AddressLineProp In inv.AccountingSupplierParty.Party.PostalAddress.AddressLine.List
		XB = XB.element("cac:AddressLine")
		XB = XB.element("cbc:Line")
		XB = XB.text(prop8.Line.Value).up
		XB = XB.up ' /AddressLine
	Next
	Dim prop9 As IdentificationCode = inv.AccountingSupplierParty.Party.PostalAddress.Country.IdentificationCode
	XB = XB.element("cac:Country")
	XB = XB.element("cbc:IdentificationCode") _
		.attribute("listID", prop9.listID) _
		.attribute("listAgencyID", prop9.listAgencyID) _
		.text(prop9.Value).up
	XB = XB.up ' /Country
	XB = XB.up ' /PostalAddress
	XB = XB.element("cac:PartyLegalEntity")
	XB = XB.element("cbc:RegistrationName")
	Dim prop10 As RegistrationName = inv.AccountingSupplierParty.Party.PartyLegalEntity.RegistrationName
	XB = XB.text(prop10.Value).up
	XB = XB.up ' /PartyLegalEntity
	XB = XB.element("cac:Contact")
	XB = XB.element("cbc:Telephone")
	Dim prop11 As Telephone = inv.AccountingSupplierParty.Party.Contact.Telephone
	XB = XB.text(prop11.Value).up
	XB = XB.element("cbc:ElectronicMail")
	Dim prop12 As ElectronicMail = inv.AccountingSupplierParty.Party.Contact.ElectronicMail
	XB = XB.text(prop12.Value).up
	XB = XB.up ' /Contact
	XB = XB.up ' /Party
	XB = XB.up ' /AccountingSupplierParty
	XB = XB.element("cac:AccountingCustomerParty")
	XB = XB.element("cac:Party")
	If inv.AccountingCustomerParty.Party.IndustryClassificationCode.IsInitialized Then
		Dim prop2 As IndustryClassificationCode = inv.AccountingCustomerParty.Party.IndustryClassificationCode
		XB = XB.element("cbc:IndustryClassificationCode") _
			.attribute("name", prop2.name) _
			.text(prop2.Value).up
	End If
	For Each prop3 As PartyIdentificationProp In inv.AccountingCustomerParty.Party.PartyIdentification.List
		XB = XB.element("cac:PartyIdentification")
		Dim prop4 As ID = prop3.ID
		XB = XB.element("cbc:ID") _
			.attribute("schemeID", prop4.schemeID) _
			.text(prop4.Value).up
		XB = XB.up ' /PartyIdentification
	Next
	XB = XB.element("cac:PostalAddress")
	XB = XB.element("cbc:CityName")
	Dim prop5 As CityName = inv.AccountingCustomerParty.Party.PostalAddress.CityName
	XB = XB.text(prop5.Value).up
	XB = XB.element("cbc:PostalZone")
	Dim prop6 As PostalZone = inv.AccountingCustomerParty.Party.PostalAddress.PostalZone
	XB = XB.text(prop6.Value).up
	Dim prop7 As CountrySubentityCode = inv.AccountingCustomerParty.Party.PostalAddress.CountrySubentityCode
	XB = XB.element("cbc:CountrySubentityCode")
	XB = XB.text(prop7.Value).up
	For Each prop8 As AddressLineProp In inv.AccountingCustomerParty.Party.PostalAddress.AddressLine.List
		XB = XB.element("cac:AddressLine")
		XB = XB.element("cbc:Line")
		XB = XB.text(prop8.Line.Value).up
		XB = XB.up ' /AddressLine
	Next
	Dim prop9 As IdentificationCode = inv.AccountingCustomerParty.Party.PostalAddress.Country.IdentificationCode
	XB = XB.element("cac:Country")
	XB = XB.element("cbc:IdentificationCode") _
		.attribute("listID", prop9.listID) _
		.attribute("listAgencyID", prop9.listAgencyID) _
		.text(prop9.Value).up
	XB = XB.up ' /Country
	XB = XB.up ' /PostalAddress
	XB = XB.element("cac:PartyLegalEntity")
	XB = XB.element("cbc:RegistrationName")
	Dim prop10 As RegistrationName = inv.AccountingCustomerParty.Party.PartyLegalEntity.RegistrationName
	XB = XB.text(prop10.Value).up
	XB = XB.up ' /PartyLegalEntity
	XB = XB.element("cac:Contact")
	XB = XB.element("cbc:Telephone")
	Dim prop11 As Telephone = inv.AccountingCustomerParty.Party.Contact.Telephone
	XB = XB.text(prop11.Value).up
	If inv.AccountingCustomerParty.Party.Contact.ElectronicMail.IsInitialized Then
		XB = XB.element("cbc:ElectronicMail")
		Dim prop12 As ElectronicMail = inv.AccountingCustomerParty.Party.Contact.ElectronicMail
		XB = XB.text(prop12.Value).up
	End If
	XB = XB.up ' /Contact
	XB = XB.up ' /Party
	XB = XB.up ' /AccountingCustomerParty
	If inv.Delivery.IsInitialized Then
		XB = XB.element("cac:Delivery")
		XB = XB.element("cac:DeliveryParty")
		For Each prop3 As PartyIdentificationProp In inv.Delivery.DeliveryParty.PartyIdentification.List
			XB = XB.element("cac:PartyIdentification")
			Dim prop4 As ID = prop3.ID
			XB = XB.element("cbc:ID") _
				.attribute("schemeID", prop4.schemeID) _
				.text(prop4.Value).up
			XB = XB.up ' /PartyIdentification
		Next
		XB = XB.element("cac:PostalAddress")
		XB = XB.element("cbc:CityName")
		Dim prop5 As CityName = inv.Delivery.DeliveryParty.PostalAddress.CityName
		XB = XB.text(prop5.Value).up
		XB = XB.element("cbc:PostalZone")
		Dim prop6 As PostalZone = inv.Delivery.DeliveryParty.PostalAddress.PostalZone
		XB = XB.text(prop6.Value).up
		Dim prop7 As CountrySubentityCode = inv.Delivery.DeliveryParty.PostalAddress.CountrySubentityCode
		XB = XB.element("cbc:CountrySubentityCode")
		XB = XB.text(prop7.Value).up
		For Each prop8 As AddressLineProp In inv.Delivery.DeliveryParty.PostalAddress.AddressLine.List
			XB = XB.element("cac:AddressLine")
			XB = XB.element("cbc:Line")
			XB = XB.text(prop8.Line.Value).up
			XB = XB.up ' /AddressLine
		Next
		Dim prop9 As IdentificationCode = inv.Delivery.DeliveryParty.PostalAddress.Country.IdentificationCode
		XB = XB.element("cac:Country")
		XB = XB.element("cbc:IdentificationCode") _
			.attribute("listID", prop9.listID) _
			.attribute("listAgencyID", prop9.listAgencyID) _
			.text(prop9.Value).up
		XB = XB.up ' /Country
		XB = XB.up ' /PostalAddress
		XB = XB.element("cac:PartyLegalEntity")
		XB = XB.element("cbc:RegistrationName")
		Dim prop10 As RegistrationName = inv.Delivery.DeliveryParty.PartyLegalEntity.RegistrationName
		XB = XB.text(prop10.Value).up
		XB = XB.up ' /PartyLegalEntity
		XB = XB.up ' /DeliveryParty
		XB = XB.element("cac:Shipment")
		Dim prop13 As ID = inv.Delivery.Shipment.ID
		XB = XB.element("cbc:ID")
		XB = XB.text(prop13.Value).up
		Dim prop14 As FreightAllowanceCharge = inv.Delivery.Shipment.FreightAllowanceCharge
		XB = XB.element("cac:FreightAllowanceCharge")
		XB = XB.element("cbc:ChargeIndicator").text(prop14.ChargeIndicator.Value).up
		XB = XB.element("cbc:AllowanceChargeReason").text(prop14.AllowanceChargeReason.Value).up
		XB = XB.element("cbc:Amount") _
			.attribute("currencyID", prop14.Amount.currencyID) _
			.text(NumberFormat2(prop14.Amount.Value, 1, 2, 2, False)).up
		XB = XB.up ' /FreightAllowanceCharge
		XB = XB.up ' /Shipment
		XB = XB.up ' /Delivery
	End If
	If inv.PaymentMeans.IsInitialized Then
		XB = XB.element("cac:PaymentMeans")
		Dim prop15 As PaymentMeansCode = inv.PaymentMeans.PaymentMeansCode
		XB = XB.element("cbc:PaymentMeansCode").text(prop15.Value).up
		XB = XB.element("cac:PayeeFinancialAccount")
		Dim prop16 As PayeeFinancialAccount = inv.PaymentMeans.PayeeFinancialAccount
		XB = XB.element("cbc:ID").text(prop16.ID.Value).up
		XB = XB.up ' /PayeeFinancialAccount
		XB = XB.up ' /PaymentMeans
	End If
	If inv.PaymentTerms.IsInitialized Then
		XB = XB.element("cac:PaymentTerms")
		Dim prop17 As Note = inv.PaymentTerms.Note
		XB = XB.element("cbc:Note").text(prop17.Value).up
		XB = XB.up ' /PaymentTerms
	End If
	If inv.PrepaidPayment.IsInitialized Then
		XB = XB.element("cac:PrepaidPayment")
		Dim prop18 As PrepaidPayment = inv.PrepaidPayment
		XB = XB.element("cbc:ID").text(prop18.ID.Value).up
		XB = XB.element("cbc:PaidAmount") _
			.attribute("currencyID", prop18.PaidAmount.currencyID) _
			.text(NumberFormat2(prop18.PaidAmount.Value, 1, 2, 2, False)).up
		XB = XB.element("cbc:PaidDate").text(prop18.PaidDate.Value).up
		XB = XB.element("cbc:PaidTime").text(prop18.PaidTime.Value).up
		XB = XB.up ' /PrepaidPayment
	End If
	If inv.AllowanceCharge.IsInitialized Then
		For Each prop19 As AllowanceChargeProp In inv.AllowanceCharge.List
			XB = XB.element("cac:AllowanceCharge")
			XB = XB.element("cbc:ChargeIndicator").text(prop19.ChargeIndicator.Value).up
			XB = XB.element("cbc:AllowanceChargeReason").text(prop19.AllowanceChargeReason.Value).up
			XB = XB.element("cbc:Amount") _
				.attribute("currencyID", prop19.Amount.currencyID) _
				.text(NumberFormat2(prop19.Amount.Value, 1, 2, 2, False)).up
			XB = XB.up ' /AllowanceCharge
		Next
	End If
	XB = XB.element("cac:TaxTotal")
	Dim prop20 As TaxTotal = inv.TaxTotal
	XB = XB.element("cbc:TaxAmount") _
		.attribute("currencyID", prop20.TaxAmount.currencyID) _
		.text(NumberFormat2(prop20.TaxAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cac:TaxSubtotal")
	Dim prop21 As TaxSubtotal = prop20.TaxSubtotal
	XB = XB.element("cbc:TaxableAmount") _
		.attribute("currencyID", prop21.TaxableAmount.currencyID) _
		.text(NumberFormat2(prop21.TaxableAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:TaxAmount") _
		.attribute("currencyID", prop21.TaxAmount.currencyID) _
		.text(NumberFormat2(prop21.TaxAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cac:TaxCategory")
	Dim prop22 As TaxCategory = prop21.TaxCategory
	XB = XB.element("cbc:ID").text(prop22.ID.Value).up
	XB = XB.element("cac:TaxScheme")
	Dim prop23 As TaxScheme = prop22.TaxScheme
	XB = XB.element("cbc:ID") _
		.attribute("schemeID", prop23.ID.schemeID) _
		.attribute("schemeAgencyID", prop23.ID.schemeAgencyID) _
		.text(prop23.ID.Value).up
	XB = XB.up ' /TaxScheme
	XB = XB.up ' /TaxCategory
	XB = XB.up ' /TaxSubtotal
	XB = XB.up ' /TaxTotal
	XB = XB.element("cac:LegalMonetaryTotal")
	Dim prop24 As LegalMonetaryTotal = inv.LegalMonetaryTotal
	XB = XB.element("cbc:LineExtensionAmount") _
		.attribute("currencyID", prop24.LineExtensionAmount.currencyID) _
		.text(NumberFormat2(prop24.LineExtensionAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:TaxExclusiveAmount") _
		.attribute("currencyID", prop24.TaxExclusiveAmount.currencyID) _
		.text(NumberFormat2(prop24.TaxExclusiveAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:TaxInclusiveAmount") _
		.attribute("currencyID", prop24.TaxInclusiveAmount.currencyID) _
		.text(NumberFormat2(prop24.TaxInclusiveAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:AllowanceTotalAmount") _
		.attribute("currencyID", prop24.AllowanceTotalAmount.currencyID) _
		.text(NumberFormat2(prop24.AllowanceTotalAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:ChargeTotalAmount") _
		.attribute("currencyID", prop24.ChargeTotalAmount.currencyID) _
		.text(NumberFormat2(prop24.ChargeTotalAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:PayableRoundingAmount") _
		.attribute("currencyID", prop24.PayableRoundingAmount.currencyID) _
		.text(NumberFormat2(prop24.PayableRoundingAmount.Value, 1, 2, 2, False)).up
	XB = XB.element("cbc:PayableAmount") _
		.attribute("currencyID", prop24.PayableAmount.currencyID) _
		.text(NumberFormat2(prop24.PayableAmount.Value, 1, 2, 2, False)).up
	XB = XB.up ' /LegalMonetaryTotal
	For Each prop25 As InvoiceLineProp In inv.InvoiceLine.List
		XB = XB.element("cac:InvoiceLine")
		XB = XB.element("cbc:ID").text(prop25.ID.Value).up
		XB = XB.element("cbc:InvoicedQuantity") _
			.attribute("unitCode", prop25.InvoicedQuantity.unitCode) _
			.text(prop25.InvoicedQuantity.Value).up
		XB = XB.element("cbc:LineExtensionAmount") _
			.attribute("currencyID", prop25.LineExtensionAmount.currencyID) _
			.text(NumberFormat2(prop25.LineExtensionAmount.Value, 1, 2, 2, False)).up
		If prop25.AllowanceCharge.IsInitialized Then
			For Each prop26 As AllowanceChargeProp In prop25.AllowanceCharge.List
				XB = XB.element("cac:AllowanceCharge")
				XB = XB.element("cbc:ChargeIndicator").text(prop26.ChargeIndicator.Value).up
				XB = XB.element("cbc:AllowanceChargeReason").text(prop26.AllowanceChargeReason.Value).up
				XB = XB.element("cbc:MultiplierFactorNumeric").text(NumberFormat2(prop26.MultiplierFactorNumeric.Value, 1, 2, 2, False)).up
				XB = XB.element("cbc:Amount") _
				.attribute("currencyID", prop26.Amount.currencyID) _
				.text(prop26.Amount.Value).up
				'.text(NumberFormat2(prop26.Amount.Value, 1, 2, 2, False)).up
				XB = XB.up ' /AllowanceCharge
			Next
		End If
		XB = XB.element("cac:TaxTotal")
		Dim prop27 As TaxTotal = prop25.TaxTotal
		XB = XB.element("cbc:TaxAmount") _
			.attribute("currencyID", prop27.TaxAmount.currencyID) _
			.text(prop27.TaxAmount.Value).up
		'.text(NumberFormat2(prop27.TaxAmount.Value, 1, 2, 2, False)).up
		XB = XB.element("cac:TaxSubtotal")
		Dim prop28 As TaxSubtotal = prop27.TaxSubtotal
		XB = XB.element("cbc:TaxableAmount") _
			.attribute("currencyID", prop28.TaxableAmount.currencyID) _
			.text(NumberFormat2(prop28.TaxableAmount.Value, 1, 2, 2, False)).up
		XB = XB.element("cbc:TaxAmount") _
			.attribute("currencyID", prop28.TaxAmount.currencyID) _
			.text(prop28.TaxAmount.Value).up
		'.text(NumberFormat2(prop28.TaxAmount.Value, 1, 2, 2, False)).up
		XB = XB.element("cbc:Percent") _
			.text(NumberFormat2(prop28.Percent.Value, 1, 2, 2, False)).up
		XB = XB.element("cac:TaxCategory")
		Dim prop29 As TaxCategory = prop28.TaxCategory
		XB = XB.element("cbc:ID").text(prop29.ID.Value).up
		XB = XB.element("cbc:TaxExemptionReason").text(prop29.TaxExemptionReason.Value).up
		XB = XB.element("cac:TaxScheme")
		Dim prop30 As TaxScheme = prop29.TaxScheme
		XB = XB.element("cbc:ID") _
			.attribute("schemeID", prop30.ID.schemeID) _
			.attribute("schemeAgencyID", prop30.ID.schemeAgencyID) _
			.text(prop30.ID.Value).up
		XB = XB.up ' /TaxScheme
		XB = XB.up ' /TaxCategory
		XB = XB.up ' /TaxSubtotal
		XB = XB.up ' /TaxTotal
		XB = XB.element("cac:Item")
		Dim prop31 As Item = prop25.Item
		XB = XB.element("cbc:Description").text(prop31.Description.Value).up
		XB = XB.element("cac:OriginCountry")
		XB = XB.element("cbc:IdentificationCode").text(prop31.OriginCountry.IdentificationCode.Value).up
		XB = XB.up ' /OriginCountry
		For Each prop32 As CommodityClassificationProp In prop31.CommodityClassification.List
			XB = XB.element("cac:CommodityClassification")
			XB = XB.element("cbc:ItemClassificationCode") _
				.attribute("listID", prop32.ItemClassificationCode.listID) _
				.text(prop32.ItemClassificationCode.Value).up
			XB = XB.up ' /CommodityClassification
		Next
		XB = XB.up ' /Item
		XB = XB.element("cac:Price")
		Dim prop33 As Price = prop25.Price
		XB = XB.element("cbc:PriceAmount") _
			.attribute("currencyID", prop33.PriceAmount.currencyID) _
			.text(prop33.PriceAmount.Value).up
		'.text(NumberFormat2(prop33.PriceAmount.Value, 1, 2, 2, False)).up
		XB = XB.up ' /Price
		XB = XB.element("cac:ItemPriceExtension")
		Dim prop34 As ItemPriceExtension = prop25.ItemPriceExtension
		XB = XB.element("cbc:Amount") _
			.attribute("currencyID", prop34.Amount.currencyID) _
			.text(prop34.Amount.Value).up
		'.text(NumberFormat2(prop34.Amount.Value, 1, 2, 2, False)).up
		XB = XB.up ' /ItemPriceExtension
		XB = XB.up ' /InvoiceLine
	Next
	If Compact Then
		Return XB.asString
	Else
		Dim props As Map
		props.Initialize
		props.Put("omit-xml-declaration", "yes")
		props.Put("{http://xml.apache.org/xslt}indent-amount", "4")
		props.Put("indent", "yes")
		'Log(XB.asString2(props))
		Return XB.asString2(props)
	End If
End Sub

' Generate JSON Invoice
Public Sub GenerateInvoiceJSON (Document As Document, Compact As Boolean) As String
	Dim doc As Document = Document
	Dim inv As Invoice = doc.invoice
	Dim JM As Map
	JM.Initialize
	JM.Put("ID", GetValue(inv.ID))
	JM.Put("IssueDate", GetValue(inv.IssueDate))
	JM.Put("IssueTime", GetValue(inv.IssueTime))
	JM.Put("InvoiceTypeCode", GetValue2(inv.InvoiceTypeCode))
	JM.Put("DocumentCurrencyCode", GetValue(inv.DocumentCurrencyCode))
	JM.Put("TaxCurrencyCode", GetValue(inv.TaxCurrencyCode))
	JM.Put("InvoicePeriod", GetValues(inv.InvoicePeriod))
	If inv.BillingReference.IsInitialized Then
		JM.Put("BillingReference", GetValues(inv.BillingReference))
	End If
	If inv.AdditionalDocumentReference.IsInitialized Then
		JM.Put("AdditionalDocumentReference", GetValues(inv.AdditionalDocumentReference))
	End If
	JM.Put("AccountingSupplierParty", GetValues(inv.AccountingSupplierParty))
	JM.Put("AccountingCustomerParty", GetValues(inv.AccountingCustomerParty))
	If inv.Delivery.IsInitialized Then
		JM.Put("Delivery", GetValues(inv.Delivery))
	End If
	If inv.PaymentMeans.IsInitialized Then
		JM.Put("PaymentMeans", GetValues(inv.PaymentMeans))
	End If
	If inv.PaymentTerms.IsInitialized Then
		JM.Put("PaymentTerms", GetValues(inv.PaymentTerms))
	End If
	If inv.PrepaidPayment.IsInitialized Then
		JM.Put("PrepaidPayment", GetValues(inv.PrepaidPayment))
	End If
	If inv.AllowanceCharge.IsInitialized Then
		JM.Put("AllowanceCharge", GetValues(inv.AllowanceCharge))
	End If
	JM.Put("TaxTotal", GetValues(inv.TaxTotal))
	JM.Put("LegalMonetaryTotal", GetValues(inv.LegalMonetaryTotal))
	JM.Put("InvoiceLine", GetValues(inv.InvoiceLine))
	If inv.UBLExtensions.IsInitialized Then
		JM.Put("UBLExtensions", GetValues(inv.UBLExtensions))
	End If
	If inv.UBLSignature.IsInitialized Then
		JM.Put("Signature", GetValues(inv.UBLSignature))
	End If
	Dim Invoice As List
	Invoice.Initialize
	Invoice.Add(JM)
	
	Dim JG As Map
	JG.Initialize
	JG.Put("_D", doc.schema.Inv)
	JG.Put("_A", doc.schema.CAC)
	JG.Put("_B", doc.schema.CBC)
	JG.Put("Invoice", Invoice)
	
	If Compact Then
		Return JG.As(JSON).ToCompactString
	End If
	'Return JG.As(JSON).ToString
	Dim gen As JSONGenerator
	gen.Initialize(JG)
	Return gen.ToPrettyString(2)
End Sub

Public Sub GetValue (CustomClass As Object) As List
	Dim value As Object
	Dim col As Map
	col.Initialize
	Select True
		Case CustomClass Is ID
			value = CustomClass.As(ID).Value
		Case CustomClass Is IssueDate
			value = CustomClass.As(IssueDate).Value
		Case CustomClass Is IssueTime
			value = CustomClass.As(IssueTime).Value
		Case CustomClass Is InvoiceTypeCode
			value = CustomClass.As(InvoiceTypeCode).Value
		Case CustomClass Is DocumentCurrencyCode
			value = CustomClass.As(DocumentCurrencyCode).Value
		Case CustomClass Is TaxCurrencyCode
			value = CustomClass.As(TaxCurrencyCode).Value
		Case CustomClass Is StartDate
			value = CustomClass.As(StartDate).Value
		Case CustomClass Is Description
			value = CustomClass.As(Description).Value
		Case CustomClass Is EndDate
			value = CustomClass.As(EndDate).Value
		Case CustomClass Is DocumentType
			value = CustomClass.As(DocumentType).Value
		Case CustomClass Is DocumentDescription
			value = CustomClass.As(DocumentDescription).Value
		Case CustomClass Is CityName
			value = CustomClass.As(CityName).Value
		Case CustomClass Is PostalZone
			value = CustomClass.As(PostalZone).Value
		Case CustomClass Is CountrySubentityCode
			value = CustomClass.As(CountrySubentityCode).Value
		Case CustomClass Is Line
			value = CustomClass.As(Line).Value
		Case CustomClass Is RegistrationName
			value = CustomClass.As(RegistrationName).Value
		Case CustomClass Is Telephone
			value = CustomClass.As(Telephone).Value
		Case CustomClass Is ElectronicMail
			value = CustomClass.As(ElectronicMail).Value
		Case CustomClass Is ChargeIndicator
			value = CustomClass.As(ChargeIndicator).Value
		Case CustomClass Is AllowanceChargeReason
			value = CustomClass.As(AllowanceChargeReason).Value
		Case CustomClass Is PaymentMeansCode
			value = CustomClass.As(PaymentMeansCode).Value
		Case CustomClass Is PaidDate
			value = CustomClass.As(PaidDate).Value
		Case CustomClass Is PaidTime
			value = CustomClass.As(PaidTime).Value
		Case CustomClass Is TaxExemptionReason
			value = CustomClass.As(TaxExemptionReason).Value
		Case CustomClass Is IdentificationCode
			value = CustomClass.As(IdentificationCode).Value
		Case CustomClass Is Percent
			value = CustomClass.As(Percent).Value
		Case CustomClass Is MultiplierFactorNumeric
			value = CustomClass.As(MultiplierFactorNumeric).Value
		Case CustomClass Is Note
			value = CustomClass.As(Note).Value
		Case CustomClass Is ExtensionURI
			value = CustomClass.As(ExtensionURI).Value
		Case CustomClass Is ReferencedSignatureID
			value = CustomClass.As(ReferencedSignatureID).Value
		Case CustomClass Is SigningTime
			value = CustomClass.As(SigningTime).Value
		Case CustomClass Is DigestValue
			value = CustomClass.As(DigestValue).Value			
		Case CustomClass Is SignatureMethod
			value = CustomClass.As(SignatureMethod).Value
		Case CustomClass Is SignatureValue
			value = CustomClass.As(SignatureValue).Value
		Case CustomClass Is X509Certificate
			value = CustomClass.As(X509Certificate).Value
		Case CustomClass Is X509SubjectName
			value = CustomClass.As(X509SubjectName).Value
		Case CustomClass Is X509IssuerName
			value = CustomClass.As(X509IssuerName).Value
		Case CustomClass Is X509SerialNumber
			value = CustomClass.As(X509SerialNumber).Value
	End Select
	col.Put("_", value)
	Dim lst As List
	lst.Initialize
	lst.Add(col)
	Return lst
End Sub

' Get value and 1 attribute
Public Sub GetValue2 (CustomClass As Object) As List
	Dim col As Map
	col.Initialize
	Select True
		Case CustomClass Is InvoiceTypeCode
			Dim cls1 As InvoiceTypeCode = CustomClass
			col.Put("_", cls1.Value)
			col.Put("listVersionID", cls1.listVersionID)
		Case CustomClass Is AdditionalAccountID
			Dim cls2 As AdditionalAccountID = CustomClass
			col.Put("_", cls2.Value)
			col.Put("schemeAgencyName", cls2.schemeAgencyName)
		Case CustomClass Is Party
			Dim cls3 As Party = CustomClass
			col.Put("IndustryClassificationCode", GetValue2(cls3.IndustryClassificationCode))
		Case CustomClass Is IndustryClassificationCode
			Dim cls4 As IndustryClassificationCode = CustomClass
			col.Put("_", cls4.Value)
			col.Put("name", cls4.name)
		Case CustomClass Is ID
			Dim cls6 As ID = CustomClass
			col.Put("_", cls6.Value)
			col.Put("schemeID", cls6.schemeID)
		Case CustomClass Is Amount
			Dim cls7 As Amount = CustomClass
			col.Put("_", cls7.Value)
			col.Put("currencyID", cls7.currencyID)
		Case CustomClass Is PaidAmount
			Dim cls8 As PaidAmount = CustomClass
			col.Put("_", cls8.Value)
			col.Put("currencyID", cls8.currencyID)
		Case CustomClass Is TaxAmount
			Dim cls9 As TaxAmount = CustomClass
			col.Put("_", cls9.Value)
			col.Put("currencyID", cls9.currencyID)
		Case CustomClass Is TaxableAmount
			Dim cls10 As TaxableAmount = CustomClass
			col.Put("_", cls10.Value)
			col.Put("currencyID", cls10.currencyID)
		Case CustomClass Is LineExtensionAmount
			Dim cls11 As LineExtensionAmount = CustomClass
			col.Put("_", cls11.Value)
			col.Put("currencyID", cls11.currencyID)
		Case CustomClass Is TaxExclusiveAmount
			Dim cls12 As TaxExclusiveAmount = CustomClass
			col.Put("_", cls12.Value)
			col.Put("currencyID", cls12.currencyID)
		Case CustomClass Is TaxInclusiveAmount
			Dim cls13 As TaxInclusiveAmount = CustomClass
			col.Put("_", cls13.Value)
			col.Put("currencyID", cls13.currencyID)
		Case CustomClass Is AllowanceTotalAmount
			Dim cls14 As AllowanceTotalAmount = CustomClass
			col.Put("_", cls14.Value)
			col.Put("currencyID", cls14.currencyID)
		Case CustomClass Is ChargeTotalAmount
			Dim cls15 As ChargeTotalAmount = CustomClass
			col.Put("_", cls15.Value)
			col.Put("currencyID", cls15.currencyID)
		Case CustomClass Is PayableRoundingAmount
			Dim cls16 As PayableRoundingAmount = CustomClass
			col.Put("_", cls16.Value)
			col.Put("currencyID", cls16.currencyID)
		Case CustomClass Is PayableAmount
			Dim cls17 As PayableAmount = CustomClass
			col.Put("_", cls17.Value)
			col.Put("currencyID", cls17.currencyID)
		Case CustomClass Is InvoicedQuantity
			Dim cls18 As InvoicedQuantity = CustomClass
			col.Put("_", cls18.Value)
			col.Put("unitCode", cls18.unitCode)
		Case CustomClass Is ItemClassificationCode
			Dim cls19 As ItemClassificationCode = CustomClass
			col.Put("_", cls19.Value)
			col.Put("listID", cls19.listID)
		Case CustomClass Is PriceAmount
			Dim cls20 As PriceAmount = CustomClass
			col.Put("_", cls20.Value)
			col.Put("currencyID", cls20.currencyID)
		Case CustomClass Is DigestMethod
			Dim cls21 As DigestMethod = CustomClass
			col.Put("_", cls21.Value)
			col.Put("Algorithm", cls21.Algorithm)
		Case CustomClass Is SignatureMethod
			Dim cls22 As SignatureMethod = CustomClass
			col.Put("_", cls22.Value)
			col.Put("Algorithm", cls22.Algorithm)
	End Select
	Dim lst As List
	lst.Initialize
	lst.Add(col)
	Return lst
End Sub

' Get value and up to 2 attributes
Public Sub GetValue3 (CustomClass As Object) As List
	Dim col As Map
	col.Initialize
	Select True
		Case CustomClass Is ID
			Dim cls1 As ID = CustomClass
			col.Put("_", cls1.Value)
			col.Put("schemeID", cls1.schemeID)
			col.Put("schemeAgencyID", cls1.schemeAgencyID)
		Case CustomClass Is IdentificationCode
			Dim cls2 As IdentificationCode = CustomClass
			col.Put("_", cls2.Value)
			col.Put("listID", cls2.listID)
			col.Put("listAgencyID", cls2.listAgencyID)
	End Select
	Dim lst As List
	lst.Initialize
	lst.Add(col)
	Return lst
End Sub

' Get all attributes
Public Sub GetValues (CustomClass As Object) As List
	Dim lst As List
	lst.Initialize
	Select True
		Case CustomClass Is InvoicePeriod
			Dim cls1 As InvoicePeriod = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("StartDate", GetValue(cls1.StartDate))
			col.Put("Description", GetValue(cls1.Description))
			col.Put("EndDate", GetValue(cls1.EndDate))
			lst.Add(col)
		Case CustomClass Is BillingReference
			Dim cls2 As BillingReference = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("AdditionalDocumentReference", GetValues(cls2.AdditionalDocumentReference))
			lst.Add(col)
		Case CustomClass Is Party
			Dim cls3 As Party = CustomClass
			Dim col As Map
			col.Initialize
			If CustomClass.As(Party).IndustryClassificationCode.IsInitialized Then
				col.Put("IndustryClassificationCode", GetValue2(cls3.IndustryClassificationCode))
			Else
				'Log("Not initialized")
			End If
			col.Put("PartyIdentification", GetValues(cls3.PartyIdentification))
			col.Put("PostalAddress", GetValues(cls3.PostalAddress))
			col.Put("PartyLegalEntity", GetValues(cls3.PartyLegalEntity))
			col.Put("Contact", GetValues(cls3.Contact))
			lst.Add(col)
		Case CustomClass Is AdditionalDocumentReference
			Dim cls4 As AdditionalDocumentReference = CustomClass
			For Each prop4 As AdditionalDocumentReferenceProp In cls4.List
				Dim col As Map
				col.Initialize
				col.Put("ID", GetValue(prop4.ID))
				If prop4.DocumentType.IsInitialized Then
					col.Put("DocumentType", GetValue(prop4.DocumentType))
				Else
					'Log("Not initialized")
				End If
				If prop4.DocumentDescription.IsInitialized Then
					col.Put("DocumentDescription", GetValue(prop4.DocumentDescription))
				Else
					'Log("Not initialized")
				End If
				lst.Add(col)
			Next
		Case CustomClass Is PartyIdentification
			Dim cls5 As PartyIdentification = CustomClass
			For Each prop2 As PartyIdentificationProp In cls5.List
				Dim col As Map
				col.Initialize
				col.Put("ID", GetValue2(prop2.ID))
				lst.Add(col)
			Next
		Case CustomClass Is PostalAddress
			Dim cls6 As PostalAddress = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("CityName", GetValue(cls6.CityName))
			col.Put("PostalZone", GetValue(cls6.PostalZone))
			col.Put("CountrySubentityCode", GetValue(cls6.CountrySubentityCode))
			col.Put("AddressLine", GetValues(cls6.AddressLine))
			col.Put("Country", GetValues(cls6.Country))
			lst.Add(col)
		Case CustomClass Is AddressLine
			Dim cls7 As AddressLine = CustomClass
			For Each prop3 As AddressLineProp In cls7.List
				Dim col As Map
				col.Initialize
				col.Put("Line", GetValue(prop3.Line))
				lst.Add(col)
			Next
		Case CustomClass Is PartyLegalEntity
			Dim cls8 As PartyLegalEntity = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("RegistrationName", GetValue(cls8.RegistrationName))
			lst.Add(col)
		Case CustomClass Is Contact
			Dim cls9 As Contact = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Telephone", GetValue(cls9.Telephone))
			If cls9.ElectronicMail.IsInitialized Then
				col.Put("ElectronicMail", GetValue(cls9.ElectronicMail))
			End If
			lst.Add(col)
		Case CustomClass Is Country
			Dim cls10 As Country = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("IdentificationCode", GetValue3(cls10.IdentificationCode))
			lst.Add(col)
		Case CustomClass Is AccountingSupplierParty
			Dim cls11 As AccountingSupplierParty = CustomClass
			Dim col As Map
			col.Initialize
			If cls11.AdditionalAccountID.IsInitialized Then
				col.Put("AdditionalAccountID", GetValue2(cls11.AdditionalAccountID))
			End If
			col.Put("Party", GetValues(cls11.Party))
			lst.Add(col)
		Case CustomClass Is AccountingCustomerParty
			Dim cls12 As AccountingCustomerParty = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Party", GetValues(cls12.Party))
			lst.Add(col)
		Case CustomClass Is Delivery
			Dim cls13 As Delivery = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("DeliveryParty", GetValues(cls13.DeliveryParty))
			col.Put("Shipment", GetValues(cls13.Shipment))
			lst.Add(col)
		Case CustomClass Is DeliveryParty
			Dim cls14 As DeliveryParty = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("PartyLegalEntity", GetValues(cls14.PartyLegalEntity))
			col.Put("PostalAddress", GetValues(cls14.PostalAddress))
			col.Put("PartyIdentification", GetValues(cls14.PartyIdentification))
			lst.Add(col)
		Case CustomClass Is Shipment
			Dim cls15 As Shipment = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue(cls15.ID))
			col.Put("FreightAllowanceCharge", GetValues(cls15.FreightAllowanceCharge))
			lst.Add(col)
		Case CustomClass Is FreightAllowanceCharge
			Dim cls16 As FreightAllowanceCharge = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ChargeIndicator", GetValue(cls16.ChargeIndicator))
			col.Put("AllowanceChargeReason", GetValue(cls16.AllowanceChargeReason))
			col.Put("Amount", GetValue2(cls16.Amount))
			lst.Add(col)
		Case CustomClass Is PaymentMeans
			Dim cls17 As PaymentMeans = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("PaymentMeansCode", GetValue(cls17.PaymentMeansCode))
			col.Put("PayeeFinancialAccount", GetValues(cls17.PayeeFinancialAccount))
			lst.Add(col)
		Case CustomClass Is PayeeFinancialAccount
			Dim cls18 As PayeeFinancialAccount = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue(cls18.ID))
			lst.Add(col)
		Case CustomClass Is PaymentTerms
			Dim cls19 As PaymentTerms = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Note", GetValue(cls19.Note))
			lst.Add(col)
		Case CustomClass Is PrepaidPayment
			Dim cls20 As PrepaidPayment = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue(cls20.ID))
			col.Put("PaidAmount", GetValue2(cls20.PaidAmount))
			col.Put("PaidDate", GetValue(cls20.PaidDate))
			col.Put("PaidTime", GetValue(cls20.PaidTime))
			lst.Add(col)
		Case CustomClass Is AllowanceCharge
			Dim cls21 As AllowanceCharge = CustomClass
			For Each prop5 As AllowanceChargeProp In cls21.List
				Dim col As Map
				col.Initialize
				col.Put("ChargeIndicator", GetValue(prop5.ChargeIndicator))
				col.Put("AllowanceChargeReason", GetValue(prop5.AllowanceChargeReason))
				If prop5.MultiplierFactorNumeric.IsInitialized Then
					col.Put("MultiplierFactorNumeric", GetValue(prop5.MultiplierFactorNumeric))
				Else
					'Log("Not initialized")
				End If
				col.Put("Amount", GetValue2(prop5.Amount))
				lst.Add(col)
			Next
		Case CustomClass Is TaxTotal
			Dim cls22 As TaxTotal = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("TaxAmount", GetValue2(cls22.TaxAmount))
			col.Put("TaxSubtotal", GetValues(cls22.TaxSubtotal))
			lst.Add(col)
		Case CustomClass Is TaxSubtotal
			Dim cls23 As TaxSubtotal = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("TaxableAmount", GetValue2(cls23.TaxableAmount))
			col.Put("TaxAmount", GetValue2(cls23.TaxAmount))
			If cls23.Percent.IsInitialized Then
				col.Put("Percent", GetValue(cls23.Percent))
			Else
				'Log("Not initialized")
			End If
			col.Put("TaxCategory", GetValues(cls23.TaxCategory))
			lst.Add(col)
		Case CustomClass Is TaxCategory
			Dim cls24 As TaxCategory = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue(cls24.ID))
			If cls24.TaxExemptionReason.IsInitialized Then
				col.Put("TaxExemptionReason", GetValue(cls24.TaxExemptionReason))
			Else
				'Log("Not initialized")
			End If
			col.Put("TaxScheme", GetValues(cls24.TaxScheme))
			lst.Add(col)
		Case CustomClass Is TaxScheme
			Dim cls25 As TaxScheme = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue3(cls25.ID))
			lst.Add(col)
		Case CustomClass Is LegalMonetaryTotal
			Dim cls26 As LegalMonetaryTotal = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("LineExtensionAmount", GetValue2(cls26.LineExtensionAmount))
			col.Put("TaxExclusiveAmount", GetValue2(cls26.TaxExclusiveAmount))
			col.Put("TaxInclusiveAmount", GetValue2(cls26.TaxInclusiveAmount))
			col.Put("AllowanceTotalAmount", GetValue2(cls26.AllowanceTotalAmount))
			col.Put("ChargeTotalAmount", GetValue2(cls26.ChargeTotalAmount))
			col.Put("PayableRoundingAmount", GetValue2(cls26.PayableRoundingAmount))
			col.Put("PayableAmount", GetValue2(cls26.PayableAmount))
			lst.Add(col)
		Case CustomClass Is InvoiceLine
			Dim cls27 As InvoiceLine = CustomClass
			For Each prop6 As InvoiceLineProp In cls27.List
				Dim col As Map
				col.Initialize
				col.Put("ID", GetValue(prop6.ID))
				col.Put("InvoicedQuantity", GetValue2(prop6.InvoicedQuantity))
				col.Put("LineExtensionAmount", GetValue2(prop6.LineExtensionAmount))
				If prop6.AllowanceCharge.IsInitialized Then
					col.Put("AllowanceCharge", GetValues(prop6.AllowanceCharge))
				End If
				col.Put("TaxTotal", GetValues(prop6.TaxTotal))
				col.Put("Item", GetValues(prop6.Item))
				col.Put("Price", GetValues(prop6.Price))
				col.Put("ItemPriceExtension", GetValues(prop6.ItemPriceExtension))
				lst.Add(col)
			Next
		Case CustomClass Is Item
			Dim cls28 As Item = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("CommodityClassification", GetValues(cls28.CommodityClassification))
			col.Put("Description", GetValue(cls28.Description))
			col.Put("OriginCountry", GetValues(cls28.OriginCountry))
			lst.Add(col)
		Case CustomClass Is CommodityClassification
			Dim cls29 As CommodityClassification = CustomClass
			For Each prop7 As CommodityClassificationProp In cls29.List
				Dim col As Map
				col.Initialize
				col.Put("ItemClassificationCode", GetValue2(prop7.ItemClassificationCode))
				lst.Add(col)
			Next
		Case CustomClass Is OriginCountry
			Dim cls30 As OriginCountry = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("IdentificationCode", GetValue(cls30.IdentificationCode))
			lst.Add(col)
		Case CustomClass Is Price
			Dim cls31 As Price = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("PriceAmount", GetValue2(cls31.PriceAmount))
			lst.Add(col)
		Case CustomClass Is ItemPriceExtension
			Dim cls32 As ItemPriceExtension = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Amount", GetValue2(cls32.Amount))
			lst.Add(col)
		Case CustomClass Is UBLExtensions
			Dim cls33 As UBLExtensions = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("UBLExtension", GetValues(cls33.UBLExtension))
			lst.Add(col)
		Case CustomClass Is UBLExtension
			Dim cls34 As UBLExtension = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ExtensionURI", GetValue(cls34.ExtensionURI))
			col.Put("ExtensionContent", GetValues(cls34.ExtensionContent))
			lst.Add(col)
		Case CustomClass Is ExtensionContent
			Dim cls35 As ExtensionContent = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("UBLDocumentSignatures", GetValues(cls35.UBLDocumentSignatures))
			lst.Add(col)
		Case CustomClass Is UBLDocumentSignatures
			Dim cls36 As UBLDocumentSignatures = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("SignatureInformation", GetValues(cls36.SignatureInformation))
			lst.Add(col)
		Case CustomClass Is SignatureInformation
			Dim cls37 As SignatureInformation = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue(cls37.ID))
			col.Put("ReferencedSignatureID", GetValue(cls37.ReferencedSignatureID))
			col.Put("Signature", GetValues(cls37.Signature))
			lst.Add(col)
		Case CustomClass Is DigitalSignature
			Dim cls38 As DigitalSignature = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Id", cls38.Id)
			col.Put("Object", GetValues(cls38.SignatureObject))
			col.Put("KeyInfo", GetValues(cls38.KeyInfo))
			col.Put("SignatureValue", GetValue(cls38.SignatureValue))
			col.Put("SignedInfo", GetValues(cls38.SignedInfo))
			lst.Add(col)
		Case CustomClass Is SignatureObject
			Dim cls39 As SignatureObject = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("QualifyingProperties", GetValues(cls39.QualifyingProperties))
			lst.Add(col)
		Case CustomClass Is QualifyingProperties
			Dim cls40 As QualifyingProperties = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Target", cls40.Target)
			col.Put("SignedProperties", GetValues(cls40.SignedProperties))
			lst.Add(col)
		Case CustomClass Is SignedProperties
			Dim cls41 As SignedProperties = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Id", cls41.Id)
			col.Put("SignedSignatureProperties", GetValues(cls41.SignedSignatureProperties))
			lst.Add(col)
		Case CustomClass Is SignedSignatureProperties
			Dim cls42 As SignedSignatureProperties = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("SigningTime", GetValue(cls42.SigningTime))
			col.Put("SigningCertificate", GetValues(cls42.SigningCertificate))
			lst.Add(col)
		Case CustomClass Is SigningCertificate
			Dim cls43 As SigningCertificate = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("Cert", GetValues(cls43.Cert))
			lst.Add(col)
		Case CustomClass Is Cert
			Dim cls44 As Cert = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("CertDigest", GetValues(cls44.CertDigest))
			col.Put("IssuerSerial", GetValues(cls44.IssuerSerial))
			lst.Add(col)
		Case CustomClass Is CertDigest
			Dim cls45 As CertDigest = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("DigestMethod", GetValue2(cls45.DigestMethod))
			col.Put("DigestValue", GetValue(cls45.DigestValue))
			lst.Add(col)
		Case CustomClass Is IssuerSerial
			Dim cls46 As IssuerSerial = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("X509IssuerName", GetValue(cls46.X509IssuerName))
			col.Put("X509SerialNumber", GetValue(cls46.X509SerialNumber))
			lst.Add(col)
		Case CustomClass Is KeyInfo
			Dim cls47 As KeyInfo = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("X509Data", GetValues(cls47.X509Data))
			lst.Add(col)
		Case CustomClass Is X509Data
			Dim cls48 As X509Data = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("X509Certificate", GetValue(cls48.X509Certificate))
			col.Put("X509SubjectName", GetValue(cls48.X509SubjectName))
			col.Put("X509IssuerSerial", GetValues(cls48.X509IssuerSerial))
			lst.Add(col)
		Case CustomClass Is X509IssuerSerial
			Dim cls49 As X509IssuerSerial = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("X509IssuerName", GetValue(cls49.X509IssuerName))
			col.Put("X509SerialNumber", GetValue(cls49.X509SerialNumber))
			lst.Add(col)					
		Case CustomClass Is SignedInfo
			Dim cls50 As SignedInfo = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("SignatureMethod", GetValue2(cls50.SignatureMethod))
			col.Put("Reference", GetValues(cls50.Reference))
			lst.Add(col)
		Case CustomClass Is Reference
			Dim cls51 As Reference = CustomClass
			For Each ref1 As ReferenceProp In cls51.List
				Dim col As Map
				col.Initialize
				col.Put("Type", ref1.ReferenceType)
				col.Put("URI", ref1.ReferenceURI)
				col.Put("DigestMethod", GetValue2(ref1.DigestMethod))
				col.Put("DigestValue", GetValue(ref1.DigestValue))
				lst.Add(col)
			Next
		Case CustomClass Is UBLSignature
			Dim cls52 As UBLSignature = CustomClass
			Dim col As Map
			col.Initialize
			col.Put("ID", GetValue(cls52.ID))
			col.Put("SignatureMethod", GetValue(cls52.SignatureMethod))
			lst.Add(col)
	End Select
	Return lst
End Sub

'Create a List with 1 value
Public Sub PutValue (Value As Object) As List
	Dim List1 As List
	List1.Initialize
	List1.Add(CreateMap("_": Value))
	Return List1
End Sub

'Create a List with a map
Public Sub PutValues (Items As Map) As List
	Dim List1 As List
	List1.Initialize
	List1.Add(Items)
	Return List1
End Sub