B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	 
	Type XMLStruct (mp As Map,lst As List,xmlbld As XMLBuilder,errxsd As String,xmlstr As String,keymem As String,errors As String,warn As String)
	
	Private ErrChars() As Int=Array As Int(128,169,174,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254)
	 
End Sub

Public Sub GenInvXMLIT(mpdata As Map,xsdfile As String,removeemptykeyval As Boolean) As XMLStruct 'Our XML Template for IT Fatt XML
 
   'https://fex-app.com/FatturaElettronica/FatturaElettronicaBody/DatiGenerali/DatiOrdineAcquisto/IdDocumento
	
	Dim InvXML As XMLStruct
	
	 
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
	
	InvXML.xmlbld=xml.create("p:FatturaElettronica")
	InvXML.keymem=""
	InvXML.errors=""
	InvXML.warn=""
	   
	InvXML=GenXML(InvXML,"versione","FPR12",Null,False,XMLATTRIB) 
	
	InvXML=GenXML(InvXML,"xmlns:ds","http://www.w3.org/2000/09/xmldsig#",Null,False,XMLATTRIB)  
	InvXML=GenXML(InvXML,"xmlns:p","http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2",Null,False,XMLATTRIB)  
	InvXML=GenXML(InvXML,"xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance",Null,False,XMLATTRIB)  
	InvXML=GenXML(InvXML,"xsi:schemaLocation","http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2 http://www.fatturapa.gov.it/export/fatturazione/sdi/fatturapa/v1.2/Schema_del_file_xml_FatturaPA_versione_1.2.xsd",Null,False,XMLATTRIB)
	
	InvXML=GenXML(InvXML,"FatturaElettronicaHeader","",Null,False,XMLOPEN)         
		InvXML=GenXML(InvXML,"DatiTrasmissione","",Null,False,XMLOPEN) 
			InvXML=GenXML(InvXML,"IdTrasmittente","",Null,False,XMLOPEN)  
				InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
			InvXML=GenXML(InvXML,"IdTrasmittente","",Null,False,XMLCLOSE)     
			InvXML=GenXML(InvXML,"ProgressivoInvio","",mpdata,False,XMLELEMPREF)
			InvXML=GenXML(InvXML,"FormatoTrasmissione","",mpdata,False,XMLELEMPREF)
			InvXML=GenXML(InvXML,"CodiceDestinatario","",mpdata,False,XMLELEMPREF)
			InvXML=GenXML(InvXML,"ContattiTrasmittente","",Null,False,XMLOPEN)  
				InvXML=GenXML(InvXML,"Telefono","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"Email","",mpdata,False,XMLELEMPREF) 
			InvXML=GenXML(InvXML,"ContattiTrasmittente","",Null,False,XMLCLOSE) 			
			InvXML=GenXML(InvXML,"PECDestinatario","",mpdata,False,XMLELEMPREF)
        InvXML=GenXML(InvXML,"DatiTrasmissione","",Null,False,XMLCLOSE)    
        
		InvXML=GenXML(InvXML,"CedentePrestatore","",Null,False,XMLOPEN) 
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLOPEN)
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLOPEN) 
                    InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
                    InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLCLOSE)   
               	InvXML=GenXML(InvXML,"CodiceFiscale","",mpdata,False,XMLELEMPREF)                                            
                InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"Denominazione","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Nome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Cognome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Titolo","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"CodEORI","",mpdata,False,XMLELEMPREF)
               	InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLCLOSE) 
				InvXML=GenXML(InvXML,"AlboProfessionale","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"ProvinciaAlbo","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"NumeroIscrizioneAlbo","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"DataIscrizioneAlbo","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"RegimeFiscale","",mpdata,False,XMLELEMPREF)
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLCLOSE) 
           	InvXML=GenXML(InvXML,"Sede","",Null,False,XMLOPEN)
                InvXML=GenXML(InvXML,"Indirizzo","",mpdata,False,XMLELEMPREF)    
                InvXML=GenXML(InvXML,"NumeroCivico","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"CAP","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"Comune","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Provincia","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Nazione","",mpdata,False,XMLELEMPREF)
           	InvXML=GenXML(InvXML,"Sede","",Null,False,XMLCLOSE)    
			InvXML=GenXML(InvXML,"StabileOrganizzazione","",Null,False,XMLOPEN)
                InvXML=GenXML(InvXML,"Indirizzo","",mpdata,False,XMLELEMPREF)    
                InvXML=GenXML(InvXML,"NumeroCivico","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"CAP","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"Comune","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Provincia","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Nazione","",mpdata,False,XMLELEMPREF)
           	InvXML=GenXML(InvXML,"StabileOrganizzazione","",Null,False,XMLCLOSE)    
			InvXML=GenXML(InvXML,"IscrizioneREA","",Null,False,XMLOPEN)
				InvXML=GenXML(InvXML,"Ufficio","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"NumeroREA","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"CapitaleSociale","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"SocioUnico","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"StatoLiquidazione","",mpdata,False,XMLELEMPREF) 
            InvXML=GenXML(InvXML,"IscrizioneREA","",Null,False,XMLCLOSE)   
			InvXML=GenXML(InvXML,"Contatti","",Null,False,XMLOPEN)
				InvXML=GenXML(InvXML,"Telefono","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"Fax","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"Email","",mpdata,False,XMLELEMPREF) 
            InvXML=GenXML(InvXML,"Contatti","",Null,False,XMLCLOSE)    
			InvXML=GenXML(InvXML,"RiferimentoAmministrazione","",mpdata,False,XMLELEMPREF)			
        InvXML=GenXML(InvXML,"CedentePrestatore","",Null,False,XMLCLOSE)   
		
		InvXML=GenXML(InvXML,"RappresentanteFiscale","",Null,False,XMLOPEN) 
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLOPEN)  
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLOPEN) 
                    InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
                    InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLCLOSE) 
                InvXML=GenXML(InvXML,"CodiceFiscale","",mpdata,False,XMLELEMPREF)  
				 InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"Denominazione","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Nome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Cognome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Titolo","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"CodEORI","",mpdata,False,XMLELEMPREF)
               	InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLCLOSE) 				
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLCLOSE)   			 
        InvXML=GenXML(InvXML,"RappresentanteFiscale","",Null,False,XMLCLOSE)     
 	
       	InvXML=GenXML(InvXML,"CessionarioCommittente","",Null,False,XMLOPEN) 
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLOPEN)  
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLOPEN) 
                    InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
                    InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLCLOSE) 
                InvXML=GenXML(InvXML,"CodiceFiscale","",mpdata,False,XMLELEMPREF)  
				 InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"Denominazione","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Nome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Cognome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Titolo","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"CodEORI","",mpdata,False,XMLELEMPREF)
               	InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLCLOSE) 				
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLCLOSE)   
			InvXML=GenXML(InvXML,"Sede","",Null,False,XMLOPEN)
                InvXML=GenXML(InvXML,"Indirizzo","",mpdata,False,XMLELEMPREF)    
                InvXML=GenXML(InvXML,"NumeroCivico","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"CAP","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"Comune","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Provincia","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Nazione","",mpdata,False,XMLELEMPREF)
           	InvXML=GenXML(InvXML,"Sede","",Null,False,XMLCLOSE)     
			InvXML=GenXML(InvXML,"StabileOrganizzazione","",Null,False,XMLOPEN)
                InvXML=GenXML(InvXML,"Indirizzo","",mpdata,False,XMLELEMPREF)    
                InvXML=GenXML(InvXML,"NumeroCivico","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"CAP","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"Comune","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Provincia","",mpdata,False,XMLELEMPREF)
                InvXML=GenXML(InvXML,"Nazione","",mpdata,False,XMLELEMPREF)
           	InvXML=GenXML(InvXML,"StabileOrganizzazione","",Null,False,XMLCLOSE) 
			InvXML=GenXML(InvXML,"RappresentanteFiscale","",Null,False,XMLOPEN)  
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLOPEN) 
                    InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
                    InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLCLOSE) 
				InvXML=GenXML(InvXML,"Denominazione","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"Nome","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"Cognome","",mpdata,False,XMLELEMPREF)
			InvXML=GenXML(InvXML,"RappresentanteFiscale","",Null,False,XMLCLOSE)               
        InvXML=GenXML(InvXML,"CessionarioCommittente","",Null,False,XMLCLOSE)     

		InvXML=GenXML(InvXML,"TerzoIntermediarioOSoggettoEmittente","",Null,False,XMLOPEN)
		 	InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLOPEN)  
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLOPEN) 
                    InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
                    InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLCLOSE) 
                InvXML=GenXML(InvXML,"CodiceFiscale","",mpdata,False,XMLELEMPREF)  
				 InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"Denominazione","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Nome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Cognome","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Titolo","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"CodEORI","",mpdata,False,XMLELEMPREF)
               	InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLCLOSE) 				
            InvXML=GenXML(InvXML,"DatiAnagrafici","",Null,False,XMLCLOSE) 		 
		InvXML=GenXML(InvXML,"TerzoIntermediarioOSoggettoEmittente","",Null,False,XMLCLOSE)   
		
		InvXML=GenXML(InvXML,"SoggettoEmittente","",mpdata,False,XMLELEMPREF) 
	
	InvXML=GenXML(InvXML,"FatturaElettronicaHeader","",Null,False,XMLCLOSE)    

	InvXML=GenXML(InvXML,"FatturaElettronicaBody","",Null,False,XMLOPEN)  
        
		InvXML=GenXML(InvXML,"DatiGenerali","",Null,False,XMLOPEN)  
           	InvXML=GenXML(InvXML,"DatiGeneraliDocumento","",Null,False,XMLOPEN)
				InvXML=GenXML(InvXML,"TipoDocumento","",mpdata,False,XMLELEMPREF)  
				InvXML=GenXML(InvXML,"Divisa","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"Data","",mpdata,False,XMLELEMPREF) 
				InvXML=GenXML(InvXML,"Numero","",mpdata,False,XMLELEMPREF) 
				Dim lst As List=GenXML(InvXML,"DatiRitenuta","",mpdata,False,GETLIST).lst			
				For n=0 To lst.Size-1
					Dim mp2 As Map= lst.Get(n)	
					InvXML=GenXML(InvXML,"DatiRitenuta","",Null,False,XMLOPEN)
						InvXML=GenXML(InvXML,"TipoRitenuta","",mp2,False,XMLELEM)   
						InvXML=GenXML(InvXML,"ImportoRitenuta","",mp2,False,XMLELEM)   
						InvXML=GenXML(InvXML,"AliquotaRitenuta","",mp2,False,XMLELEM)   
						InvXML=GenXML(InvXML,"CausalePagamento","",mp2,False,XMLELEM)  
					InvXML=GenXML(InvXML,"DatiRitenuta","",Null,False,XMLCLOSE) 
				Next 
				InvXML=GenXML(InvXML,"DatiBollo","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"BolloVirtuale","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"ImportoBollo","",mpdata,False,XMLELEMPREF)				
				InvXML=GenXML(InvXML,"DatiBollo","",Null,False,XMLCLOSE) 
				
				Dim lst As List=GenXML(InvXML,"DatiCassaPrevidenziale","",mpdata,False,GETLIST).lst				
				For n=0 To lst.Size-1
					Dim mp2 As Map= lst.Get(n)	
					InvXML=GenXML(InvXML,"DatiCassaPrevidenziale","",Null,False,XMLOPEN)				
						InvXML=GenXML(InvXML,"TipoCassa","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"AlCassa","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"ImportoContributoCassa","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"ImponibileCassa","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"AliquotaIVA","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"Ritenuta","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"Natura","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"RiferimentoAmministrazione","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"DatiCassaPrevidenziale","",Null,False,XMLCLOSE) 
				Next				
				Dim lst As List=GenXML(InvXML,"ScontoMaggiorazione","",mpdata,False,GETLIST).lst 
				For n=0 To InvXML.lst.Size-1
					Dim mp2 As Map= InvXML.lst.Get(n)	
					InvXML=GenXML(InvXML,"ScontoMaggiorazione","",Null,False,XMLOPEN)
						InvXML=GenXML(InvXML,"Tipo","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"Percentuale","",mp2,False,XMLELEM)
						InvXML=GenXML(InvXML,"Importo","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"ScontoMaggiorazione","",Null,False,XMLCLOSE) 				
				Next
				 
				InvXML=GenXML(InvXML,"ImportoTotaleDocumento","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"Arrotondamento","",mpdata,False,XMLELEMPREF)  
				Dim lst As List=GenXML(InvXML,"Causale","",mpdata,False,GETLIST).lst
				If lst.Size=0 Then
					InvXML=GenXML(InvXML,"Causale","",mpdata,False,XMLELEMPREF) 
				Else	
					For n=0 To lst.size-1
 						Dim str As String= lst.Get(n)	
						InvXML=GenXML(InvXML,"Causale",str,Null,False,XMLELEM) 
					Next 	
				End If				      
				InvXML=GenXML(InvXML,"Art73","",mpdata,False,XMLELEMPREF)
           	InvXML=GenXML(InvXML,"DatiGeneraliDocumento","",Null,False,XMLCLOSE)    
			
			Dim lst As List=GenXML(InvXML,"DatiOrdineAcquisto","",mpdata,False,GETLIST).lst 						
			For n=0 To  lst.Size-1
				Dim mp2 As Map= lst.Get(n)
				InvXML=GenXML(InvXML,"DatiOrdineAcquisto","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"RiferimentoNumeroLinea","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"IdDocumento","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Data","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"NumItem","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCommessaConvenzione","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCUP","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCIG","",mp2,False,XMLELEM)				
				InvXML=GenXML(InvXML,"DatiOrdineAcquisto","",Null,False,XMLCLOSE)   
			Next  
			Dim lst As List=GenXML(InvXML,"DatiContratto","",mpdata,False,GETLIST).lst 	 					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				InvXML=GenXML(InvXML,"DatiContratto","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"RiferimentoNumeroLinea","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"IdDocumento","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Data","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"NumItem","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCommessaConvenzione","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCUP","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCIG","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DatiContratto","",Null,False,XMLCLOSE)   
			Next  
			Dim lst As List=GenXML(InvXML,"DatiConvenzione","",mpdata,False,GETLIST).lst 	 					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				InvXML=GenXML(InvXML,"DatiConvenzione","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"RiferimentoNumeroLinea","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"IdDocumento","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Data","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"NumItem","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCommessaConvenzione","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCUP","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCIG","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DatiConvenzione","",Null,False,XMLCLOSE)   
			Next  
			Dim lst As List=GenXML(InvXML,"DatiRicezione","",mpdata,False,GETLIST).lst				
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				InvXML=GenXML(InvXML,"DatiRicezione","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"RiferimentoNumeroLinea","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"IdDocumento","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Data","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"NumItem","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCommessaConvenzione","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCUP","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCIG","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DatiRicezione","",Null,False,XMLCLOSE)   
			Next  
			Dim lst As List=GenXML(InvXML,"DatiFattureCollegate","",mpdata,False,GETLIST).lst					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				InvXML=GenXML(InvXML,"DatiFattureCollegate","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"RiferimentoNumeroLinea","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"IdDocumento","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Data","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"NumItem","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCommessaConvenzione","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCUP","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"CodiceCIG","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DatiFattureCollegate","",Null,False,XMLCLOSE)   
			Next  
			Dim lst As List=GenXML(InvXML,"DatiSAL","",mpdata,False,GETLIST).lst					
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				InvXML=GenXML(InvXML,"DatiSAL","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"RiferimentoFase","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DatiSAL","",Null,False,XMLCLOSE)   
			Next  
			Dim lst As List=GenXML(InvXML,"DatiDDT","",mpdata,False,GETLIST) .lst			
			For n=0 To lst.Size-1
				Dim mp2 As Map=  lst.Get(n)
				InvXML=GenXML(InvXML,"DatiDDT","",Null,False,XMLOPEN) 				
					InvXML=GenXML(InvXML,"NumeroDDT","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"DataDDT","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"RiferimentoNumeroLinea","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DatiDDT","",Null,False,XMLCLOSE)   
			Next 
			 
			InvXML=GenXML(InvXML,"DatiTrasporto","",Null,False,XMLOPEN) 				
				InvXML=GenXML(InvXML,"DatiAnagraficiVettore","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLOPEN) 
	                    InvXML=GenXML(InvXML,"IdPaese","",mpdata,False,XMLELEMPREF) 
	                    InvXML=GenXML(InvXML,"IdCodice","",mpdata,False,XMLELEMPREF) 
	                InvXML=GenXML(InvXML,"IdFiscaleIVA","",Null,False,XMLCLOSE) 
	                InvXML=GenXML(InvXML,"CodiceFiscale","",mpdata,False,XMLELEMPREF)  
					 InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLOPEN)
						InvXML=GenXML(InvXML,"Denominazione","",mpdata,False,XMLELEMPREF)
						InvXML=GenXML(InvXML,"Nome","",mpdata,False,XMLELEMPREF)
						InvXML=GenXML(InvXML,"Cognome","",mpdata,False,XMLELEMPREF)
						InvXML=GenXML(InvXML,"Titolo","",mpdata,False,XMLELEMPREF)
						InvXML=GenXML(InvXML,"CodEORI","",mpdata,False,XMLELEMPREF)
	               	InvXML=GenXML(InvXML,"Anagrafica","",Null,False,XMLCLOSE) 	
					InvXML=GenXML(InvXML,"NumeroLicenzaGuida","",mpdata,False,XMLELEMPREF)	
				InvXML=GenXML(InvXML,"DatiAnagraficiVettore","",Null,False,XMLCLOSE)   				
				InvXML=GenXML(InvXML,"MezzoTrasporto","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"CausaleTrasporto","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"NumeroColli","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"Descrizione","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"UnitaMisuraPeso","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"PesoLordo","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"PesoNetto","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"DataOraRitiro","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"DataInizioTrasporto","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"TipoResa","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"IndirizzoResa","",Null,False,XMLOPEN)
					InvXML=GenXML(InvXML,"Indirizzo","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"NumeroCivico","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"CAP","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Comune","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Provincia","",mpdata,False,XMLELEMPREF)
					InvXML=GenXML(InvXML,"Nazione","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"IndirizzoResa","",mpdata,False,XMLCLOSE) 
				InvXML=GenXML(InvXML,"DataOraConsegna","",mpdata,False,XMLELEMPREF)
			InvXML=GenXML(InvXML,"DatiTrasporto","",Null,False,XMLCLOSE)   
			
			InvXML=GenXML(InvXML,"FatturaPrincipale","",Null,False,XMLOPEN) 
				InvXML=GenXML(InvXML,"NumeroFatturaPrincipale","",mpdata,False,XMLELEMPREF)
				InvXML=GenXML(InvXML,"DataFatturaPrincipale","",mpdata,False,XMLELEMPREF)			
			InvXML=GenXML(InvXML,"FatturaPrincipale","",Null,False,XMLCLOSE)   
			                   
        InvXML=GenXML(InvXML,"DatiGenerali","",Null,False,XMLCLOSE)    
		       
		InvXML=GenXML(InvXML,"DatiBeniServizi","",Null,False,XMLOPEN)
			Dim lst As List=GenXML(InvXML,"DettaglioLinee","",mpdata,False,GETLIST).lst	
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)	
				InvXML=GenXML(InvXML,"DettaglioLinee","",Null,False,XMLOPEN) 
					InvXML=GenXML(InvXML,"NumeroLinea","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"TipoCessionePrestazione","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"CodiceArticolo","",mp2,False,XMLELEM)  
					Dim lst2 As List=GenXML(InvXML,"CodiceArticolo","",mpdata,False,GETLIST).lst 				 					
					For n2=0 To  lst2.Size-1
 						Dim mp3 As Map=  lst2.Get(n2)	
						InvXML=GenXML(InvXML,"CodiceArticolo","",Null,False,XMLOPEN) 
							InvXML=GenXML(InvXML,"CodiceTipo","",mp3,False,XMLELEM)   
							InvXML=GenXML(InvXML,"CodiceValore","",mp3,False,XMLELEM)					
						InvXML=GenXML(InvXML,"CodiceArticolo","",Null,False,XMLCLOSE)   
					Next				  
					InvXML=GenXML(InvXML,"Descrizione","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"Quantita","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"UnitaMisura","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"DataInizioPeriodo","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"DataFinePeriodo","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"PrezzoUnitario","",mp2,False,XMLELEM)   
					Dim lst2 As List=GenXML(InvXML,"ScontoMaggiorazione","",mpdata,False,GETLIST).lst				 					
					For n2=0 To lst2.Size-1
 						Dim mp3 As Map=  lst2.Get(n2)	
						InvXML=GenXML(InvXML,"ScontoMaggiorazione","",Null,False,XMLOPEN)
							InvXML=GenXML(InvXML,"Tipo","",mp3,False,XMLELEM) 
							InvXML=GenXML(InvXML,"Percentuale","",mp3,False,XMLELEM) 
							InvXML=GenXML(InvXML,"Importo","",mp3,False,XMLELEM) 				
						InvXML=GenXML(InvXML,"ScontoMaggiorazione","",Null,False,XMLCLOSE)   
					Next	 
					InvXML=GenXML(InvXML,"PrezzoTotale","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"AliquotaIVA","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"Ritenuta","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"Natura","",mp2,False,XMLELEM)   
					InvXML=GenXML(InvXML,"RiferimentoAmministrazione","",mp2,False,XMLELEM)   
					Dim lst2 As List=GenXML(InvXML,"AltriDatiGestionali","",mpdata,False,GETLIST).lst				 					
					For n2=0 To lst2.Size-1
 						Dim mp3 As Map=  lst2.Get(n2)	
						InvXML=GenXML(InvXML,"AltriDatiGestionali","",Null,False,XMLOPEN)
							InvXML=GenXML(InvXML,"TipoDato","",mp3,False,XMLELEM) 
							InvXML=GenXML(InvXML,"RiferimentoTesto","",mp3,False,XMLELEM) 
							InvXML=GenXML(InvXML,"RiferimentoNumero","",mp3,False,XMLELEM) 
							InvXML=GenXML(InvXML,"RiferimentoData","",mp3,False,XMLELEM) 
						InvXML=GenXML(InvXML,"AltriDatiGestionali","",Null,False,XMLCLOSE)   
					Next	 
				InvXML=GenXML(InvXML,"DettaglioLinee","",Null,False,XMLCLOSE)   
			Next	 
			 
			Dim lst As List=GenXML(InvXML,"DatiRiepilogo","",mpdata,False,GETLIST).lst 
			For n=0 To  lst.Size-1
				Dim mp2 As Map=  lst.Get(n)	
				InvXML=GenXML(InvXML,"DatiRiepilogo","",Null,False,XMLOPEN) 
					InvXML=GenXML(InvXML,"AliquotaIVA","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Natura","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"SpeseAccessorie","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Arrotondamento","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"ImponibileImporto","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"Imposta","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"EsigibilitaIVA","",mp2,False,XMLELEM)
					InvXML=GenXML(InvXML,"RiferimentoNormativo","",mp2,False,XMLELEM) 
				InvXML=GenXML(InvXML,"DatiRiepilogo","",Null,False,XMLCLOSE)               
			Next
		InvXML=GenXML(InvXML,"DatiBeniServizi","",Null,False,XMLCLOSE) 	
		
		 	
		InvXML=GenXML(InvXML,"DatiVeicoli","",Null,False,XMLOPEN) 
			InvXML=GenXML(InvXML,"Data","",mpdata,False,XMLELEMPREF)
			InvXML=GenXML(InvXML,"TotalePercorso","",mpdata,False,XMLELEMPREF)
		InvXML=GenXML(InvXML,"DatiVeicoli","",Null,False,XMLCLOSE)   
	
		Dim lst As List=GenXML(InvXML,"DatiPagamento","",mpdata,False,GETLIST).lst	 		 				
		For n=0 To  lst.Size-1
			Dim mp2 As Map=  lst.Get(n)	
			InvXML=GenXML(InvXML,"DatiPagamento","",Null,False,XMLOPEN) 
				InvXML=GenXML(InvXML,"CondizioniPagamento","",mp2,False,XMLELEM) 
 				Dim lst2 As List=GenXML(InvXML,"DettaglioPagamento","",mp2,False,GETLIST).lst	
				For n2=0 To lst2.Size-1
					Dim mp3 As Map=  lst2.Get(n2)	
					InvXML=GenXML(InvXML,"DettaglioPagamento","",Null,False,XMLOPEN)				
						InvXML=GenXML(InvXML,"Beneficiario","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"ModalitaPagamento","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"DataRiferimentoTerminiPagamento","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"GiorniTerminiPagamento","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"DataScadenzaPagamento","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"ImportoPagamento","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"CodUfficioPostale","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"CognomeQuietanzante","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"NomeQuietanzante","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"CFQuietanzante","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"TitoloQuietanzante","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"IstitutoFinanziario","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"IBAN","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"ABI","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"CAB","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"BIC","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"ScontoPagamentoAnticipato","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"DataLimitePagamentoAnticipato","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"PenalitaPagamentiRitardati","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"DataDecorrenzaPenale","",mp3,False,XMLELEM)
						InvXML=GenXML(InvXML,"CodicePagamento","",mp3,False,XMLELEM)
					InvXML=GenXML(InvXML,"DettaglioPagamento","",Null,False,XMLCLOSE) 	
				Next 								 
			InvXML=GenXML(InvXML,"DatiPagamento","",Null,False,XMLCLOSE)   			 
		Next
		Dim lst As List=GenXML(InvXML,"Allegati","",mpdata,False,GETLIST).lst
		For n=0 To  lst.Size-1
			Dim mp2 As Map=  lst.Get(n)	
			InvXML=GenXML(InvXML,"Allegati","",Null,False,XMLOPEN) 
				InvXML=GenXML(InvXML,"NomeAttachment","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"AlgoritmoCompressione","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"FormatoAttachment","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"DescrizioneAttachment","",mp2,False,XMLELEM)
				InvXML=GenXML(InvXML,"Attachment","",mp2,False,XMLELEM)			  
			InvXML=GenXML(InvXML,"Allegati","",Null,False,XMLCLOSE)               
		Next
		  
   	InvXML=GenXML(InvXML,"FatturaElettronicaBody","",Null,False,XMLCLOSE)   
		 	
	Dim xmlstr As String= InvXML.xmlbld.asString
	
	If removeemptykeyval Then
		
		xmlstr=RemoveEmptyXMLValues(xmlstr) 
	
		InvXML.xmlstr=xmlstr
	
	End If
		
	InvXML.errxsd=""
	If xsdfile.Length>0 Then
		If File.Exists("",xsdfile) Then
			Dim xmltxt As String=xmlstr
			InvXML.errxsd=CheckDocXML(xmltxt,xsdfile)			 
		End If
		
	End If
	 
	Return InvXML
	
End Sub

Sub asJO(o As JavaObject) As JavaObject
	Return o
End Sub
			
Public Sub CheckDocXML(xmlstr As String,xsdfile As String) As String
	
	Dim r As String=""
	If File.Exists("",xsdfile) Then
		r=asJO(Me).RunMethod("validateAgainstXSD",Array As Object(xmlstr,xsdfile))
	End If
	Return r
	
End Sub

#if java

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXParseException;
import org.xml.sax.SAXException;

import org.w3c.dom.Document;

import java.io.*;
import java.io.Console;
import java.io.File;
import java.io.ByteArrayInputStream;

import java.nio.charset.StandardCharsets;


public static String validateAgainstXSD(String xml, String xsd) {
    try {
		
		Errors.Msg="";
		Errors.ErrCount=0;
		 
		SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
		Source schemaFile = new StreamSource(new File(xsd));
        Schema schema = factory.newSchema(schemaFile);
        Validator validator = schema.newValidator();		 
        validator.setErrorHandler(new XSDErrorHandler());		 
		validator.validate(new StreamSource(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8))));
		 	 
        return Errors.Msg;
		
    } catch (Exception ex) {
        // errorHandler.handle(ex);
		// ex.printStackTrace();
       return "Error";
    } 
}

private static class XSDErrorHandler implements ErrorHandler {
    public void warning(SAXParseException e) throws SAXException {
       //System.out.println("Warning: "); 
       printException(e);
    }
    public void error(SAXParseException e) throws SAXException {
       //System.out.println("Error: "); 
       printException(e);
    }
    public void fatalError(SAXParseException e) throws SAXException {
       //System.out.println("Fatal error: "); 
       printException(e);
    }
    private void printException(SAXParseException e) {
	  Errors.ErrCount++;
      //System.out.println("   Line number: "+e.getLineNumber());
      //System.out.println("   Column number: "+e.getColumnNumber());
      //System.out.println("   Message: "+e.getMessage());
      //System.out.println();
	  Errors.Msg=Errors.Msg+Errors.ErrCount+" : at " + e.getColumnNumber()+ " : " + e.getMessage()+"\r\n";
    }
}
  
public static class Errors {
    public static String Msg;
	public static Integer ErrCount;
}

#End If

Public Sub RemoveEmptyXMLValues(str As String) As String
	Dim ed As Int=str.IndexOf("/>")
	Do While  ed>0 
		If ed>0 Then
			Dim st As Int=str.LastIndexOf2("<",ed)
			If st>0 Then
				Dim wd As String=str.SubString2(st,ed+2)
				str=str.Replace(wd,"")
			End If
		End If
		Dim ed As Int=str.IndexOf("/>")
	Loop
	Dim lst As List
	lst.Initialize
	Dim ct As Int
	Dim found As Boolean=True
 
	Do Until found=False
		For ct=0 To str.Length-3
			Dim tmp As String=str.SubString2(ct,ct+3)
			If tmp="></" Then
				Dim st As Int=str.LastIndexOf2("<",ct)
				Dim ed As Int=str.IndexOf2(">",ct+1)
				If st>0 And ed>0 Then
					Dim wd1 As String=str.SubString2(st+1,ct)
					Dim wd2 As String=str.SubString2(ct+3,ed)	
					If wd1=wd2 Then
						lst.Add("<" & wd1 & "></" & wd2 & ">")					 			 
					End If					 
				End If			
			End If		 
		Next
		
		If lst.Size=0 Then
			found=False
		Else
			found=True
			For ct=0 To lst.Size-1
				str=str.Replace(lst.Get(ct),"")
			Next
			lst.Initialize
		End If
	Loop  
 
	Return str
	
End Sub

Sub CheckChars(Key As String,Value As String) As String
	Dim i As Int
	Dim errstr As String=""
	For i=0 To ErrChars.Length-1
		If Value.Contains(Chr(ErrChars(i)))  Then
			errstr=errstr & "Characters in '" & Key & "' not allowed '" & Chr(i) & "'"	& Chr(13) & Chr(10)	
		End If
	  
	Next
	Return errstr
End Sub

Sub GenXML(xmls As XMLStruct,key As String,value As String,obj As Object,cdata As Boolean,Action As Int) As XMLStruct
	
	Dim txt As String=""
	 
	Dim mp As Map
	mp.Initialize
	
	Dim lst As List
	lst.Initialize
	 
	If Action=1 Then ' open
		xmls.keymem=xmls.keymem & "/" & key
		xmls.xmlbld=xmls.xmlbld.element(key)
	else If Action=2 Then ' close
		xmls.xmlbld=xmls.xmlbld.up()
		Dim x As Int=xmls.keymem.LastIndexOf("/")
		If x=0 Then ' at the start
			xmls.keymem=""
		Else 
			xmls.keymem=xmls.keymem.SubString2(0,x)
		End If
	else If Action=3 Then ' attrib		
		value=value.Replace("<","&lt;").Replace(">","&gt;").Replace("&","&amp;")
		xmls.errors=xmls.errors & CheckChars(key,value)
		xmls.xmlbld=xmls.xmlbld.attribute(key,value)		
	Else If Action=4 Or Action=5  Then ' element	 
		If obj Is Map Then ' element is in a map
			Dim mp As Map=obj
			If mp.IsInitialized Then				 
				If Action=5 Then
					If mp.ContainsKey(key) Then
						txt=mp.Get (key)
					End If
				Else
					If mp.ContainsKey(xmls.keymem & "/" & key) Then
						txt=mp.Get (xmls.keymem & "/" & key) ' prefix + key = 4
					End If					
				End If			
				txt=txt.trim	
		 	End If
		Else
			txt=value.trim
		End If
		
		If txt<>"" Then	
			' escape xml & check
			txt=txt.Replace("<","&lt;").Replace(">","&gt;").Replace("&","&amp;")
			xmls.xmlbld=xmls.xmlbld.element(key)
			If cdata Then ' force
				xmls.xmlbld=xmls.xmlbld.cdata(txt).up()
			Else
				Dim chk As String=CheckChars(key,txt)
				If  chk="" Then
					xmls.xmlbld=xmls.xmlbld.text(txt).up()
				Else
					xmls.warn=xmls.warn & CheckChars(key,txt)  
					xmls.xmlbld=xmls.xmlbld.cdata(txt).up() ' switch to cdata
					
				End If
					
			End If
		End If	
	else If Action=6 Or Action=7 Then ' return the map or list		 
		
		If obj Is Map Then
			Dim mp As Map=obj
			If mp.IsInitialized Then
				If mp.ContainsKey(xmls.keymem & "/" & key) Then
					Dim obj2 As Object=mp.Get(xmls.keymem & "/" & key)
					 
					If obj2 Is Map And Action=6 Then  
						Dim mp As Map=obj2
					Else If obj2 Is List And Action=7 Then  
						Dim lst As List=obj2
					End If	
					 				
					xmls.lst=lst  ' return list that repeats		
				else If mp.ContainsKey(key) Then
					Dim obj2 As Object=mp.Get(key)
					 	 
					If obj2 Is Map And Action=6 Then  
						Dim mp As Map=obj2
					Else If obj2 Is List And Action=7 Then  
						Dim lst As List=obj2
					End If
					 
					xmls.mp=mp ' return map that repeats			
				End If
			End If
		End If
	End If
	
	xmls.lst=lst
	xmls.mp=mp
 	
	Return xmls
	
End Sub

 