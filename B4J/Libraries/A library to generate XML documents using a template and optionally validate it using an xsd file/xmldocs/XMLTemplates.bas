B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
  
End Sub

Public Sub GenInvXMLIT(mpdata As Map,version As String,xsdfile As String,removeemptykeyval As Int,allowemptystr As Boolean) As XMLConstruct 
 	
	'This is the XML Template for Italian XML Invoices, build your template based in your xml structure
	
   'https://fex-app.com/FatturaElettronica contains our structure and rules for this template
  
	Dim XMLOPEN, XMLCLOSE, XMLATTRIB, XMLELEM,XMLELEMPREF,GETMAP,GETLIST  As Int
	XMLOPEN = 1
	XMLCLOSE = 2
	XMLATTRIB = 3
	XMLELEMPREF = 4
	XMLELEM = 5
	GETMAP = 6
	GETLIST = 7
	
	Dim n,n2 As Int
	
	Dim xml As XMLBuilder
	
	XMLLib.XMLVars.xmlbld=xml.create("p:FatturaElettronica") ' this is our main root name
	XMLLib.XMLVars.keymem=""
	XMLLib.XMLVars.errors=""
	XMLLib.XMLVars.warn=""
	   
	XMLLib.GenXML("versione",version,Null,False,allowemptystr,XMLATTRIB) 
	
	XMLLib.GenXML("xmlns:ds","http://www.w3.org/2000/09/xmldsig#",Null,False,allowemptystr,XMLATTRIB)  
	XMLLib.GenXML("xmlns:p","http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2",Null,False,allowemptystr,XMLATTRIB)  
	XMLLib.GenXML("xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance",Null,False,allowemptystr,XMLATTRIB)  
	XMLLib.GenXML("xsi:schemaLocation","http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2 http://www.fatturapa.gov.it/export/fatturazione/sdi/fatturapa/v1.2/Schema_del_file_xml_FatturaPA_versione_1.2.xsd",Null,False,allowemptystr,XMLATTRIB)
	
	XMLLib.GenXML("FatturaElettronicaHeader","",Null,Null,Null,XMLOPEN) ' open a level        
		XMLLib.GenXML("DatiTrasmissione","",Null,Null,Null,XMLOPEN)   ' open next level
			XMLLib.GenXML("IdTrasmittente","",Null,Null,Null,XMLOPEN)  ' open next level
				XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) ' get the value in the map with a key that contains the full path e.g. "FatturaElettronicaBody/DatiGenerali/DatiGeneraliDocumento/TipoDocumento"
				XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) ' idem 
			XMLLib.GenXML("IdTrasmittente","",Null,Null,Null,XMLCLOSE) ' close the level we opened (key name not neccesary) only for clarity    
			XMLLib.GenXML("ProgressivoInvio","",mpdata,False,allowemptystr,XMLELEMPREF)
			XMLLib.GenXML("FormatoTrasmissione","",mpdata,False,allowemptystr,XMLELEMPREF)
			XMLLib.GenXML("CodiceDestinatario","",mpdata,False,allowemptystr,XMLELEMPREF)
			XMLLib.GenXML("ContattiTrasmittente","",Null,Null,Null,XMLOPEN)  
				XMLLib.GenXML("Telefono","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("Email","",mpdata,False,allowemptystr,XMLELEMPREF) 
			XMLLib.GenXML("ContattiTrasmittente","",Null,Null,Null,XMLCLOSE) 			
			XMLLib.GenXML("PECDestinatario","",mpdata,False,allowemptystr,XMLELEMPREF)
        XMLLib.GenXML("DatiTrasmissione","",Null,Null,Null,XMLCLOSE)    
        
		XMLLib.GenXML("CedentePrestatore","",Null,Null,Null,XMLOPEN) 
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLOPEN)
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLOPEN) 
                    XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) 
                    XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLCLOSE)   
               	XMLLib.GenXML("CodiceFiscale","",mpdata,False,allowemptystr,XMLELEMPREF)                                            
                XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("Denominazione","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Nome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Cognome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Titolo","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("CodEORI","",mpdata,False,allowemptystr,XMLELEMPREF)
               	XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLCLOSE) 
				XMLLib.GenXML("AlboProfessionale","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("ProvinciaAlbo","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("NumeroIscrizioneAlbo","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("DataIscrizioneAlbo","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("RegimeFiscale","",mpdata,False,allowemptystr,XMLELEMPREF)
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLCLOSE) 
           	XMLLib.GenXML("Sede","",Null,Null,Null,XMLOPEN)
                XMLLib.GenXML("Indirizzo","",mpdata,False,allowemptystr,XMLELEMPREF)    
                XMLLib.GenXML("NumeroCivico","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("CAP","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("Comune","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Provincia","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Nazione","",mpdata,False,allowemptystr,XMLELEMPREF)
           	XMLLib.GenXML("Sede","",Null,Null,Null,XMLCLOSE)    
			XMLLib.GenXML("StabileOrganizzazione","",Null,Null,Null,XMLOPEN)
                XMLLib.GenXML("Indirizzo","",mpdata,False,allowemptystr,XMLELEMPREF)    
                XMLLib.GenXML("NumeroCivico","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("CAP","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("Comune","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Provincia","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Nazione","",mpdata,False,allowemptystr,XMLELEMPREF)
           	XMLLib.GenXML("StabileOrganizzazione","",Null,Null,Null,XMLCLOSE)    
			XMLLib.GenXML("IscrizioneREA","",Null,Null,Null,XMLOPEN)
				XMLLib.GenXML("Ufficio","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("NumeroREA","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("CapitaleSociale","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("SocioUnico","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("StatoLiquidazione","",mpdata,False,allowemptystr,XMLELEMPREF) 
            XMLLib.GenXML("IscrizioneREA","",Null,Null,Null,XMLCLOSE)   
			XMLLib.GenXML("Contatti","",Null,Null,Null,XMLOPEN)
				XMLLib.GenXML("Telefono","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("Fax","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("Email","",mpdata,False,allowemptystr,XMLELEMPREF) 
            XMLLib.GenXML("Contatti","",Null,Null,Null,XMLCLOSE)    
			XMLLib.GenXML("RiferimentoAmministrazione","",mpdata,False,allowemptystr,XMLELEMPREF)			
        XMLLib.GenXML("CedentePrestatore","",Null,Null,Null,XMLCLOSE)   
		
		XMLLib.GenXML("RappresentanteFiscale","",Null,Null,Null,XMLOPEN) 
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLOPEN)  
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLOPEN) 
                    XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) 
                    XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLCLOSE) 
                XMLLib.GenXML("CodiceFiscale","",mpdata,False,allowemptystr,XMLELEMPREF)  
				 XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("Denominazione","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Nome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Cognome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Titolo","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("CodEORI","",mpdata,False,allowemptystr,XMLELEMPREF)
               	XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLCLOSE) 				
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLCLOSE)   			 
        XMLLib.GenXML("RappresentanteFiscale","",Null,Null,Null,XMLCLOSE)     
 	
       	XMLLib.GenXML("CessionarioCommittente","",Null,Null,Null,XMLOPEN) 
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLOPEN)  
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLOPEN) 
                    XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) 
                    XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLCLOSE) 
                XMLLib.GenXML("CodiceFiscale","",mpdata,False,allowemptystr,XMLELEMPREF)  
				 XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("Denominazione","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Nome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Cognome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Titolo","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("CodEORI","",mpdata,False,allowemptystr,XMLELEMPREF)
               	XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLCLOSE) 				
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLCLOSE)   
			XMLLib.GenXML("Sede","",Null,Null,Null,XMLOPEN)
                XMLLib.GenXML("Indirizzo","",mpdata,False,allowemptystr,XMLELEMPREF)    
                XMLLib.GenXML("NumeroCivico","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("CAP","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("Comune","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Provincia","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Nazione","",mpdata,False,allowemptystr,XMLELEMPREF)
           	XMLLib.GenXML("Sede","",Null,Null,Null,XMLCLOSE)     
			XMLLib.GenXML("StabileOrganizzazione","",Null,Null,Null,XMLOPEN)
                XMLLib.GenXML("Indirizzo","",mpdata,False,allowemptystr,XMLELEMPREF)    
                XMLLib.GenXML("NumeroCivico","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("CAP","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("Comune","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Provincia","",mpdata,False,allowemptystr,XMLELEMPREF)
                XMLLib.GenXML("Nazione","",mpdata,False,allowemptystr,XMLELEMPREF)
           	XMLLib.GenXML("StabileOrganizzazione","",Null,Null,Null,XMLCLOSE) 
			XMLLib.GenXML("RappresentanteFiscale","",Null,Null,Null,XMLOPEN)  
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLOPEN) 
                    XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) 
                    XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLCLOSE) 
				XMLLib.GenXML("Denominazione","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("Nome","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("Cognome","",mpdata,False,allowemptystr,XMLELEMPREF)
			XMLLib.GenXML("RappresentanteFiscale","",Null,Null,Null,XMLCLOSE)               
        XMLLib.GenXML("CessionarioCommittente","",Null,Null,Null,XMLCLOSE)     

		XMLLib.GenXML("TerzoIntermediarioOSoggettoEmittente","",Null,Null,Null,XMLOPEN)
		 	XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLOPEN)  
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLOPEN) 
                    XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) 
                    XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) 
                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLCLOSE) 
                XMLLib.GenXML("CodiceFiscale","",mpdata,False,allowemptystr,XMLELEMPREF)  
				 XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("Denominazione","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Nome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Cognome","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Titolo","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("CodEORI","",mpdata,False,allowemptystr,XMLELEMPREF)
               	XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLCLOSE) 				
            XMLLib.GenXML("DatiAnagrafici","",Null,Null,Null,XMLCLOSE) 		 
		XMLLib.GenXML("TerzoIntermediarioOSoggettoEmittente","",Null,Null,Null,XMLCLOSE)   
		
		XMLLib.GenXML("SoggettoEmittente","",mpdata,False,allowemptystr,XMLELEMPREF) 
	
	XMLLib.GenXML("FatturaElettronicaHeader","",Null,Null,Null,XMLCLOSE)    

	XMLLib.GenXML("FatturaElettronicaBody","",Null,Null,Null,XMLOPEN)    
		XMLLib.GenXML("DatiGenerali","",Null,Null,Null,XMLOPEN)  
           	XMLLib.GenXML("DatiGeneraliDocumento","",Null,Null,Null,XMLOPEN)
				XMLLib.GenXML("TipoDocumento","",mpdata,False,allowemptystr,XMLELEMPREF)  
				XMLLib.GenXML("Divisa","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("Data","",mpdata,False,allowemptystr,XMLELEMPREF) 
				XMLLib.GenXML("Numero","",mpdata,False,allowemptystr,XMLELEMPREF) 
				Dim lst As List=XMLLib.GenXML("DatiRitenuta","",mpdata,Null,Null,GETLIST).lst	' get the list that contains maps , the keyname will be a full path		
				For n=0 To lst.Size-1 ' now process the list
					Dim mp2 As Map= lst.Get(n)	
					XMLLib.GenXML("DatiRitenuta","",Null,Null,Null,XMLOPEN)
						XMLLib.GenXML("TipoRitenuta","",mp2,False,allowemptystr,XMLELEM) ' here the key is not the full path anymore , in this case "TipoRitenuta"    
						XMLLib.GenXML("ImportoRitenuta","",mp2,False,allowemptystr,XMLELEM)   
						XMLLib.GenXML("AliquotaRitenuta","",mp2,False,allowemptystr,XMLELEM)   
						XMLLib.GenXML("CausalePagamento","",mp2,False,allowemptystr,XMLELEM)  
					XMLLib.GenXML("DatiRitenuta","",Null,Null,Null,XMLCLOSE) 
				Next 
				XMLLib.GenXML("DatiBollo","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("BolloVirtuale","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("ImportoBollo","",mpdata,False,allowemptystr,XMLELEMPREF)				
				XMLLib.GenXML("DatiBollo","",Null,Null,Null,XMLCLOSE) 
				
				Dim lst As List=XMLLib.GenXML("DatiCassaPrevidenziale","",mpdata,Null,Null,GETLIST).lst				
				For n=0 To lst.Size-1
					Dim mp2 As Map= lst.Get(n)	
					XMLLib.GenXML("DatiCassaPrevidenziale","",Null,Null,Null,XMLOPEN)				
						XMLLib.GenXML("TipoCassa","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("AlCassa","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("ImportoContributoCassa","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("ImponibileCassa","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("AliquotaIVA","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("Ritenuta","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("Natura","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("RiferimentoAmministrazione","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("DatiCassaPrevidenziale","",Null,Null,Null,XMLCLOSE) 
				Next				
				Dim lst As List=XMLLib.GenXML("ScontoMaggiorazione","",mpdata,Null,Null,GETLIST).lst 
				For n=0 To lst.Size-1
					Dim mp2 As Map= lst.Get(n)	
					XMLLib.GenXML("ScontoMaggiorazione","",Null,Null,Null,XMLOPEN)
						XMLLib.GenXML("Tipo","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("Percentuale","",mp2,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("Importo","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("ScontoMaggiorazione","",Null,Null,Null,XMLCLOSE) 				
				Next
				 
				XMLLib.GenXML("ImportoTotaleDocumento","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("Arrotondamento","",mpdata,False,allowemptystr,XMLELEMPREF)  
				Dim lst As List=XMLLib.GenXML("Causale","",mpdata,Null,Null,GETLIST).lst
				If lst.Size=0 Then
					XMLLib.GenXML("Causale","",mpdata,False,allowemptystr,XMLELEMPREF) 
				Else	
					For n=0 To lst.size-1
 						Dim str As String= lst.Get(n)	
						XMLLib.GenXML("Causale",str,Null,False,allowemptystr,XMLELEM) 
					Next 	
				End If				      
				XMLLib.GenXML("Art73","",mpdata,False,allowemptystr,XMLELEMPREF)
           	XMLLib.GenXML("DatiGeneraliDocumento","",Null,Null,Null,XMLCLOSE)    
			
			Dim lst As List=XMLLib.GenXML("DatiOrdineAcquisto","",mpdata,Null,Null,GETLIST).lst 						
			For n=0 To  lst.Size-1
				Dim mp2 As Map= lst.Get(n)
				XMLLib.GenXML("DatiOrdineAcquisto","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("RiferimentoNumeroLinea","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("IdDocumento","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Data","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("NumItem","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCommessaConvenzione","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCUP","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCIG","",mp2,False,allowemptystr,XMLELEM)				
				XMLLib.GenXML("DatiOrdineAcquisto","",Null,Null,Null,XMLCLOSE)   
			Next  
			Dim lst As List=XMLLib.GenXML("DatiContratto","",mpdata,Null,Null,GETLIST).lst 	 					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				XMLLib.GenXML("DatiContratto","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("RiferimentoNumeroLinea","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("IdDocumento","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Data","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("NumItem","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCommessaConvenzione","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCUP","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCIG","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DatiContratto","",Null,Null,Null,XMLCLOSE)   
			Next  
			Dim lst As List=XMLLib.GenXML("DatiConvenzione","",mpdata,Null,Null,GETLIST).lst 	 					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				XMLLib.GenXML("DatiConvenzione","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("RiferimentoNumeroLinea","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("IdDocumento","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Data","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("NumItem","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCommessaConvenzione","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCUP","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCIG","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DatiConvenzione","",Null,Null,Null,XMLCLOSE)   
			Next  
			Dim lst As List=XMLLib.GenXML("DatiRicezione","",mpdata,Null,Null,GETLIST).lst				
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				XMLLib.GenXML("DatiRicezione","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("RiferimentoNumeroLinea","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("IdDocumento","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Data","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("NumItem","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCommessaConvenzione","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCUP","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCIG","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DatiRicezione","",Null,Null,Null,XMLCLOSE)   
			Next  
			Dim lst As List=XMLLib.GenXML("DatiFattureCollegate","",mpdata,Null,Null,GETLIST).lst					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				XMLLib.GenXML("DatiFattureCollegate","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("RiferimentoNumeroLinea","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("IdDocumento","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Data","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("NumItem","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCommessaConvenzione","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCUP","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("CodiceCIG","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DatiFattureCollegate","",Null,Null,Null,XMLCLOSE)   
			Next  
			Dim lst As List=XMLLib.GenXML("DatiSAL","",mpdata,Null,Null,GETLIST).lst					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				XMLLib.GenXML("DatiSAL","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("RiferimentoFase","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DatiSAL","",Null,Null,Null,XMLCLOSE)   
			Next  
			Dim lst As List=XMLLib.GenXML("DatiDDT","",mpdata,Null,Null,GETLIST) .lst			
			For n=0 To lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				XMLLib.GenXML("DatiDDT","",Null,Null,Null,XMLOPEN) 				
					XMLLib.GenXML("NumeroDDT","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("DataDDT","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("RiferimentoNumeroLinea","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DatiDDT","",Null,Null,Null,XMLCLOSE)   
			Next 
			 
			XMLLib.GenXML("DatiTrasporto","",Null,Null,Null,XMLOPEN) 				
				XMLLib.GenXML("DatiAnagraficiVettore","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLOPEN) 
	                    XMLLib.GenXML("IdPaese","",mpdata,False,allowemptystr,XMLELEMPREF) 
	                    XMLLib.GenXML("IdCodice","",mpdata,False,allowemptystr,XMLELEMPREF) 
	                XMLLib.GenXML("IdFiscaleIVA","",Null,Null,Null,XMLCLOSE) 
	                XMLLib.GenXML("CodiceFiscale","",mpdata,False,allowemptystr,XMLELEMPREF)  
					 XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLOPEN)
						XMLLib.GenXML("Denominazione","",mpdata,False,allowemptystr,XMLELEMPREF)
						XMLLib.GenXML("Nome","",mpdata,False,allowemptystr,XMLELEMPREF)
						XMLLib.GenXML("Cognome","",mpdata,False,allowemptystr,XMLELEMPREF)
						XMLLib.GenXML("Titolo","",mpdata,False,allowemptystr,XMLELEMPREF)
						XMLLib.GenXML("CodEORI","",mpdata,False,allowemptystr,XMLELEMPREF)
	               	XMLLib.GenXML("Anagrafica","",Null,Null,Null,XMLCLOSE) 	
					XMLLib.GenXML("NumeroLicenzaGuida","",mpdata,False,allowemptystr,XMLELEMPREF)	
				XMLLib.GenXML("DatiAnagraficiVettore","",Null,Null,Null,XMLCLOSE)   				
				XMLLib.GenXML("MezzoTrasporto","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("CausaleTrasporto","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("NumeroColli","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("Descrizione","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("UnitaMisuraPeso","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("PesoLordo","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("PesoNetto","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("DataOraRitiro","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("DataInizioTrasporto","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("TipoResa","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("IndirizzoResa","",Null,Null,Null,XMLOPEN)
					XMLLib.GenXML("Indirizzo","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("NumeroCivico","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("CAP","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Comune","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Provincia","",mpdata,False,allowemptystr,XMLELEMPREF)
					XMLLib.GenXML("Nazione","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("IndirizzoResa","",mpdata,Null,Null,XMLCLOSE) 
				XMLLib.GenXML("DataOraConsegna","",mpdata,False,allowemptystr,XMLELEMPREF)
			XMLLib.GenXML("DatiTrasporto","",Null,Null,Null,XMLCLOSE)   
			
			XMLLib.GenXML("FatturaPrincipale","",Null,Null,Null,XMLOPEN) 
				XMLLib.GenXML("NumeroFatturaPrincipale","",mpdata,False,allowemptystr,XMLELEMPREF)
				XMLLib.GenXML("DataFatturaPrincipale","",mpdata,False,allowemptystr,XMLELEMPREF)			
			XMLLib.GenXML("FatturaPrincipale","",Null,Null,Null,XMLCLOSE)   
			                   
        XMLLib.GenXML("DatiGenerali","",Null,Null,Null,XMLCLOSE)    
		       
		XMLLib.GenXML("DatiBeniServizi","",Null,Null,Null,XMLOPEN)
			Dim lst As List=XMLLib.GenXML("DettaglioLinee","",mpdata,Null,Null,GETLIST).lst	
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)	
				XMLLib.GenXML("DettaglioLinee","",Null,Null,Null,XMLOPEN) 
					XMLLib.GenXML("NumeroLinea","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("TipoCessionePrestazione","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("CodiceArticolo","",mp2,False,allowemptystr,XMLELEM)  
					Dim lst2 As List=XMLLib.GenXML("CodiceArticolo","",mpdata,Null,Null,GETLIST).lst 				 					
					For n2=0 To  lst2.Size-1
 						Dim mp3 As Map=  lst2.Get(n2)	
						XMLLib.GenXML("CodiceArticolo","",Null,Null,Null,XMLOPEN) 
							XMLLib.GenXML("CodiceTipo","",mp3,False,allowemptystr,XMLELEM)   
							XMLLib.GenXML("CodiceValore","",mp3,False,allowemptystr,XMLELEM)					
						XMLLib.GenXML("CodiceArticolo","",Null,Null,Null,XMLCLOSE)   
					Next				  
					XMLLib.GenXML("Descrizione","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("Quantita","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("UnitaMisura","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("DataInizioPeriodo","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("DataFinePeriodo","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("PrezzoUnitario","",mp2,False,allowemptystr,XMLELEM)   
					Dim lst2 As List=XMLLib.GenXML("ScontoMaggiorazione","",mpdata,Null,Null,GETLIST).lst				 					
					For n2=0 To lst2.Size-1
 						Dim mp3 As Map=  lst2.Get(n2)	
						XMLLib.GenXML("ScontoMaggiorazione","",Null,Null,Null,XMLOPEN)
							XMLLib.GenXML("Tipo","",mp3,False,allowemptystr,XMLELEM) 
							XMLLib.GenXML("Percentuale","",mp3,False,allowemptystr,XMLELEM) 
							XMLLib.GenXML("Importo","",mp3,False,allowemptystr,XMLELEM) 				
						XMLLib.GenXML("ScontoMaggiorazione","",Null,Null,Null,XMLCLOSE)   
					Next	 
					XMLLib.GenXML("PrezzoTotale","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("AliquotaIVA","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("Ritenuta","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("Natura","",mp2,False,allowemptystr,XMLELEM)   
					XMLLib.GenXML("RiferimentoAmministrazione","",mp2,False,allowemptystr,XMLELEM)   
					Dim lst2 As List=XMLLib.GenXML("AltriDatiGestionali","",mpdata,Null,Null,GETLIST).lst				 					
					For n2=0 To lst2.Size-1
 						Dim mp3 As Map=  lst2.Get(n2)	
						XMLLib.GenXML("AltriDatiGestionali","",Null,Null,Null,XMLOPEN)
							XMLLib.GenXML("TipoDato","",mp3,False,allowemptystr,XMLELEM) 
							XMLLib.GenXML("RiferimentoTesto","",mp3,False,allowemptystr,XMLELEM) 
							XMLLib.GenXML("RiferimentoNumero","",mp3,False,allowemptystr,XMLELEM) 
							XMLLib.GenXML("RiferimentoData","",mp3,False,allowemptystr,XMLELEM) 
						XMLLib.GenXML("AltriDatiGestionali","",Null,Null,Null,XMLCLOSE)   
					Next	 
				XMLLib.GenXML("DettaglioLinee","",Null,Null,Null,XMLCLOSE)   
			Next	 
			 
			Dim lst As List=XMLLib.GenXML("DatiRiepilogo","",mpdata,Null,Null,GETLIST).lst 
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)	
				XMLLib.GenXML("DatiRiepilogo","",Null,Null,Null,XMLOPEN) 
					XMLLib.GenXML("AliquotaIVA","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Natura","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("SpeseAccessorie","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Arrotondamento","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("ImponibileImporto","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("Imposta","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("EsigibilitaIVA","",mp2,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("RiferimentoNormativo","",mp2,False,allowemptystr,XMLELEM) 
				XMLLib.GenXML("DatiRiepilogo","",Null,Null,Null,XMLCLOSE)               
			Next
		XMLLib.GenXML("DatiBeniServizi","",Null,Null,Null,XMLCLOSE) 	
		
		 	
		XMLLib.GenXML("DatiVeicoli","",Null,Null,Null,XMLOPEN) 
			XMLLib.GenXML("Data","",mpdata,False,allowemptystr,XMLELEMPREF)
			XMLLib.GenXML("TotalePercorso","",mpdata,False,allowemptystr,XMLELEMPREF)
		XMLLib.GenXML("DatiVeicoli","",Null,Null,Null,XMLCLOSE)   
	
		Dim lst As List=XMLLib.GenXML("DatiPagamento","",mpdata,Null,Null,GETLIST).lst	 		 				
		For n=0 To  lst.Size-1
			Dim mp2 As Map=  lst.Get(n)	
			XMLLib.GenXML("DatiPagamento","",Null,Null,Null,XMLOPEN) 
				XMLLib.GenXML("CondizioniPagamento","",mp2,False,allowemptystr,XMLELEM) 
 				Dim lst2 As List=XMLLib.GenXML("DettaglioPagamento","",mp2,Null,Null,GETLIST).lst	
				For n2=0 To lst2.Size-1
					Dim mp3 As Map=  lst2.Get(n2)	
					XMLLib.GenXML("DettaglioPagamento","",Null,Null,Null,XMLOPEN)				
						XMLLib.GenXML("Beneficiario","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("ModalitaPagamento","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("DataRiferimentoTerminiPagamento","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("GiorniTerminiPagamento","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("DataScadenzaPagamento","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("ImportoPagamento","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("CodUfficioPostale","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("CognomeQuietanzante","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("NomeQuietanzante","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("CFQuietanzante","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("TitoloQuietanzante","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("IstitutoFinanziario","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("IBAN","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("ABI","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("CAB","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("BIC","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("ScontoPagamentoAnticipato","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("DataLimitePagamentoAnticipato","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("PenalitaPagamentiRitardati","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("DataDecorrenzaPenale","",mp3,False,allowemptystr,XMLELEM)
						XMLLib.GenXML("CodicePagamento","",mp3,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("DettaglioPagamento","",Null,Null,Null,XMLCLOSE) 	
				Next 								 
			XMLLib.GenXML("DatiPagamento","",Null,Null,Null,XMLCLOSE)   			 
		Next
		Dim lst As List=XMLLib.GenXML("Allegati","",mpdata,Null,Null,GETLIST).lst
		For n=0 To  lst.Size-1
			Dim mp2 As Map=  lst.Get(n)	
			XMLLib.GenXML("Allegati","",Null,Null,Null,XMLOPEN) 
				XMLLib.GenXML("NomeAttachment","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("AlgoritmoCompressione","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("FormatoAttachment","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("DescrizioneAttachment","",mp2,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("Attachment","",mp2,False,allowemptystr,XMLELEM)			  
			XMLLib.GenXML("Allegati","",Null,Null,Null,XMLCLOSE)               
		Next
		  
   	XMLLib.GenXML("FatturaElettronicaBody","",Null,Null,Null,XMLCLOSE)   
	
	XMLLib.FinalProcessing(xsdfile,removeemptykeyval,allowemptystr)
	 
	Return XMLLib.XMLVars
	
End Sub

Public Sub GenRoss1000(mpdata As Map,removeemptykeyval As Int,allowemptystr As Boolean) As XMLConstruct 
	 	 
	Dim XMLOPEN, XMLCLOSE, XMLATTRIB, XMLELEM,XMLELEMPREF,GETMAP,GETLIST  As Int
	XMLOPEN = 1
	XMLCLOSE = 2
	XMLATTRIB = 3
	XMLELEMPREF = 4
	XMLELEM = 5
	GETMAP = 6
	GETLIST = 7
	
	Dim n As Int
	
	Dim XML As XMLBuilder
	
	XMLLib.XMLVars.xmlbld=XML.create("movimenti")
	XMLLib.XMLVars.keymem=""
	XMLLib.XMLVars.errors=""
	XMLLib.XMLVars.warn=""
 	
	XMLLib.GenXML("codice","",mpdata,False,allowemptystr,XMLELEMPREF)
	XMLLib.GenXML("prodotto","",mpdata,False,allowemptystr,XMLELEMPREF)
	XMLLib.GenXML("movimento","",Null,Null,Null,XMLOPEN)		
		XMLLib.GenXML("data","",mpdata,False,allowemptystr,XMLELEMPREF) 
		XMLLib.GenXML("struttura","",Null,Null,Null,XMLOPEN) 
			XMLLib.GenXML("apertura","",mpdata,False,allowemptystr,XMLELEMPREF) 
			XMLLib.GenXML("camereoccupate","",mpdata,False,allowemptystr,XMLELEMPREF) 
			XMLLib.GenXML("cameredisponibili","",mpdata,False,allowemptystr,XMLELEMPREF) 
			XMLLib.GenXML("lettidisponibili","",mpdata,False,allowemptystr,XMLELEMPREF) 
		XMLLib.GenXML("struttura","",Null,Null,Null,XMLCLOSE) 
		XMLLib.GenXML("arrivi","",Null,Null,Null,XMLOPEN)
			Dim lst As List=XMLLib.GenXML("arrivo","",mpdata,Null,Null,GETLIST).lst 
			For n=0 To  lst.Size-1
				Dim mp As Map=  lst.Get(n)	
				XMLLib.GenXML("arrivo","",Null,Null,Null,XMLOPEN) 
					XMLLib.GenXML("idswh","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("tipoalloggiato","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("idcapo","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("sesso","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("cittadinanza","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("statoresidenza","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("luogoresidenza","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("datanascita","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("statonascita","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("comunenascita","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("tipoturismo","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("mezzotrasporto","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("canaleprenotazione","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("titolostudio","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("professione","",mp,False,allowemptystr,XMLELEM) 
					XMLLib.GenXML("esenzioneimposta","",mp,False,allowemptystr,XMLELEM)  
				XMLLib.GenXML("arrivo","",Null,Null,Null,XMLCLOSE) 
			Next
		XMLLib.GenXML("arrivi","",Null,Null,Null,XMLCLOSE)
		XMLLib.GenXML("partenze","",Null,Null,Null,XMLOPEN) 
			Dim lst As List=XMLLib.GenXML("partenza","",mpdata,Null,Null,GETLIST).lst 
			For n=0 To  lst.Size-1
				Dim mp As Map=  lst.Get(n)	
				XMLLib.GenXML("partenza","",Null,Null,Null,XMLOPEN) 
					XMLLib.GenXML("idswh","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("tipoalloggiato","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("arrivo","",mp,False,allowemptystr,XMLELEM) 
				XMLLib.GenXML("partenza","",Null,Null,Null,XMLCLOSE) 
			Next
		XMLLib.GenXML("partenze","",Null,Null,Null,XMLCLOSE) 
		XMLLib.GenXML("prenotazioni","",Null,Null,Null,XMLOPEN) 
			Dim lst As List=XMLLib.GenXML("prenotazione","",mpdata,Null,Null,GETLIST).lst 
			For n=0 To  lst.Size-1
				Dim mp As Map=  lst.Get(n)	
				XMLLib.GenXML("prenotazione","",Null,Null,Null,XMLOPEN) 
					XMLLib.GenXML("idswh","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("arrivo","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("partenza","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("ospiti","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("camere","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("prezzo","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("canaleprenotazione","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("statoprovenienza","",mp,False,allowemptystr,XMLELEM)
					XMLLib.GenXML("comuneprovenienza","",mp,False,allowemptystr,XMLELEM)
				XMLLib.GenXML("prenotazione","",Null,Null,Null,XMLCLOSE) 
			Next	
		XMLLib.GenXML("prenotazioni","",Null,Null,Null,XMLCLOSE)
	XMLLib.GenXML("movimenti","",Null,Null,Null,XMLCLOSE)
	
	Dim xsdfile As String="" ' no checks
 
	XMLLib.FinalProcessing(xsdfile,removeemptykeyval,allowemptystr)
		
	Return XMLLib.XMLVars
	
End Sub


