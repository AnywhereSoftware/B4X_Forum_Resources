B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'
'by Ivan Aldaz, jan'21
'
'Shows the consent form required for ads in EEC countries and UK in several languages (see Consts in Class_Globals). 
'It's almost a clone of the Google Consent form
'
'Depends on StringUtils library
'
'Forms height is adjusted according texts lenght, with fixed labels width. That's why it's not set in the Designer
' 
'Each developer has to download his own file "ad_technology_provider_privacy_urls.csv" from his AdMob console

'Feel free to change, improve and/or distribute free of charge
'

#Event: Selection

Sub Class_Globals
	Private xui As XUI

	Type Provider(Name As String, URL As String)

	Public Const LANG_ENGLISH 	 As String = "en"
	Public Const LANG_SPANISH 	 As String = "es"
	Public Const LANG_FRENCH  	 As String = "fr"
	Public Const LANG_PORTUGUESE As String = "pt"
	Public Const LANG_ITALIAN 	 As String = "it"
	Public Const LANG_GERMAN  	 As String = "de"
	Public Const LANG_RUSSIAN 	 As String = "ru"
	Public Const LANG_CHINESE 	 As String = "cn"
	Public Const LANG_KOREAN  	 As String = "ko"
	Public Const LANG_JAPANESE   As String = "jp"
	Public Const LANG_DUTCH      As String = "nl"

	Public Const PERSONALIZED 	  As String = "PERSONALIZED"
	Public Const NON_PERSONALIZED As String = "NON_PERSONALIZED"
	Public Const PAY_FOR_ADS_FREE As String = "PAY_FOR_ADS_FREE"

	Private appName As String
	Private headIntro, headQuestion, headDetail, howPartnersUse As String
	Private howPartnersUse2, howPartnersUse3 As String
	Private howAppUsesPrev, howAppUsesPost As String
	Private changeAnytimePrev, changeAnytimePost As String
	Private txtBtnYes, txtBtnNo, txtBtnAds As String
	Private linkPolicyText As String 'not used
	Private textExtraPrev, textExtraPost As String
	Private btnBackText, btnOKEXtraText As String
	Private btnsHeight As Int
	Private titleHeight As Int

	Private showBtnAds As Boolean
	Private icon As B4XBitmap
	Private appPrivacyPolicyURL As String
	Private AdProvidersFilename As String
	Private providersList As List
	
	Private btnAds As B4XView
	Private btnYes As B4XView
	Private btnNo As B4XView
	Private lblDetail As B4XView
	Private lblHead As B4XView
	Private lblPolicies As B4XView
	Private lblQuestion As B4XView
	Private lblTitle As B4XView
	Private pnlForm As B4XView
	
	Private eventName As String
	Private CallingModule As Object
	Private res As String
	Private pnlBase As B4XView

	Private btnBackExtra As B4XView
	Private btnOKEXtra As B4XView
	Private lblLinkExtra As B4XView
	Private lblTextExtra As B4XView
	Private lblTitleExtra As B4XView
	Private pnlExtra As B4XView
	
	Private pnlProviders As B4XView
	Private lblTitleProviders As B4XView
	Private lblTextProviders As B4XView
	Private svProviders As B4XView
	Private lblLinkProviders As B4XView
	Private btnBackProviders As B4XView

	Private pnlWeb As B4XView
	Private btnBackWeb As B4XView
	
End Sub


Public Sub Initialize(CallingModule1 As Object, basePanel As B4XView, eventName1 As String, appName1 As String, languageCode As String, appIcon As B4XBitmap, appPrivacyPolicyURL1 As String, AdProvidersFilenameCSV As String, showBtnAdsFree As Boolean)
	
	CallingModule = CallingModule1
	pnlBase = basePanel
	eventName = eventName1
	appName = appName1
	icon = appIcon
	showBtnAds = showBtnAdsFree
	appPrivacyPolicyURL = appPrivacyPolicyURL1
	AdProvidersFilename = AdProvidersFilenameCSV
	
	btnsHeight = pnlBase.Height * .06
	titleHeight = pnlBase.Height * .06	
	
	GetTexts(languageCode)	
	
	pnlBase.Color = xui.Color_ARGB(80, 0, 0, 0)
	pnlBase.LoadLayout("lo_consent_admob")

  	HidePanels
	SetMainForm	
	SetExtraForm		
	SetProvidersForm
	
End Sub


Private Sub SetMainForm

	Private mrg As Int = pnlBase.Width * .04
	Private btnHeight As Int = Min(60dip, pnlBase.Height * .12)
	Private itemWidth As Int = pnlBase.Width * .92 - 2 * mrg '(pnlBase.Width * .92 = pnlForm.Width)
	
	Private detailText As String = $"${changeAnytimePrev}${appName}${changeAnytimePost}${headDetail}"$
	Private policiesText As String = $"${howPartnersUse2}${appName}${howPartnersUse3}"$
	
 ' Calculate height for all labels - Fonts and font sizes are set in the Designer
 	lblTitle.Width 	  = itemWidth
	lblHead.Width 	  = itemWidth
	lblQuestion.Width = itemWidth
	lblDetail.Width   = itemWidth
	lblPolicies.Width   = itemWidth
	
	Private headHeight  As Int 		= GetlabelHeight(lblHead, headIntro)
	Private questionHeight As Int 	= GetlabelHeight(lblQuestion, headQuestion)
	Private detailHeight As Int		= GetlabelHeight(lblDetail, detailText)
	Private linkPolicyHeight As Int = GetlabelHeight(lblPolicies, policiesText) 
	
	Private numButtons As Int = 2  
	If showBtnAds Then numButtons = 3
	
 ' Up_to_down items
	Private pnlFormHeight As Int = 7 * mrg + titleHeight + headHeight + questionHeight + detailHeight + linkPolicyHeight + numButtons * (btnHeight + mrg)
	Private pnlFormTop As Int = (pnlBase.Height - pnlFormHeight)/2 		

	pnlForm.SetLayoutAnimated(0, 4%x, pnlFormTop, 92%x, pnlFormHeight)

	lblTitle.SetLayoutAnimated	 (0, mrg, mrg,										  itemWidth, titleHeight)
	lblHead.SetLayoutAnimated 	 (0, mrg, lblTitle.Top + lblTitle.Height + mrg, 	  itemWidth, headHeight)
	lblQuestion.SetLayoutAnimated(0, mrg, lblHead.Top + lblHead.Height + mrg, 		  itemWidth, questionHeight)
	lblDetail.SetLayoutAnimated	 (0, mrg, lblQuestion.Top + lblQuestion.Height + mrg, itemWidth, detailHeight)
	lblPolicies.SetLayoutAnimated  (0, mrg, lblDetail.Top + lblDetail.Height + mrg, 	  itemWidth, linkPolicyHeight)
			
	Private topButton As Int = pnlForm.Height - btnHeight - mrg
	
	If showBtnAds Then 
		btnAds.SetLayoutAnimated(0, mrg, topButton, itemWidth, btnHeight)
		topButton = topButton - btnHeight - mrg
	End If
		
	btnNo.SetLayoutAnimated(0 ,  mrg, topButton, itemWidth, btnHeight)
	topButton = topButton - btnHeight - mrg
	btnYes.SetLayoutAnimated(0, mrg, topButton, itemWidth, btnHeight)
		
 ' TEXTS
 	SetLabelTitle(lblTitle)
	lblHead.Text 	 = headIntro
	lblQuestion.Text = headQuestion
	lblDetail.Text   = detailText
	lblPolicies.Text = policiesText
	btnYes.Text 	 = txtBtnYes
	btnNo.Text  	 = txtBtnNo
	btnAds.Text 	 = txtBtnAds

End Sub



Private Sub SetExtraForm
	
	Private mrg As Int = pnlBase.Width * .04
	Private itemWidth As Int = pnlBase.Width * .92 - 2 * mrg
		
 ' Calculate height for all labels - Fonts and font sizes are set in the Designer
 	lblTitleExtra.Width = itemWidth
	lblTextExtra.Width  = itemWidth
	lblLinkExtra.Width  = itemWidth

	Private textExtra As String = $"${textExtraPrev}${appName}${textExtraPost}"$
	Private textHeight  As Int 		= GetlabelHeight(lblTextExtra, textExtra)
	
	Private textPolicy As String = $"${howAppUsesPrev}${appName}${howAppUsesPost}"$
	Private linkPolicyHeight As Int = GetlabelHeight(lblLinkExtra,textPolicy) 

	Private pnlExtraHeight As Int = 6 * mrg + titleHeight + textHeight + linkPolicyHeight + btnsHeight
	Private pnlExtraTop As Int = (pnlBase.Height - pnlExtraHeight)/2 		

	pnlExtra.SetLayoutAnimated(0, 4%x, pnlExtraTop, 92%x, pnlExtraHeight)

	lblTitleExtra.SetLayoutAnimated(0, mrg, mrg,										    itemWidth, titleHeight)
	lblTextExtra.SetLayoutAnimated (0, mrg, lblTitleExtra.Top + lblTitleExtra.Height + mrg, itemWidth, textHeight)
	lblLinkExtra.SetLayoutAnimated (0, mrg, lblTextExtra.Top + lblTextExtra.Height + mrg, 	itemWidth, linkPolicyHeight)
	
	Private btnsTop    As Int = lblLinkExtra.Top + lblLinkExtra.Height + 2 * mrg
	Private btnsWidth  As Int = 100dip
	Private sepButtons As Int = 20dip
	Private leftbtnBack As Int = (pnlExtra.Width - 2 * btnsWidth - sepButtons)/2
	Private leftBtnOKExtra As Int = leftbtnBack + btnsWidth + sepButtons
	
	btnBackExtra.SetLayoutAnimated(0, leftbtnBack, btnsTop, btnsWidth, btnsHeight)
	btnOKEXtra.SetLayoutAnimated  (0, leftBtnOKExtra,   btnsTop, btnsWidth, btnsHeight)
			
 ' TEXTS
 	SetLabelTitle(lblTitleExtra)
	lblTextExtra.Text 	 = textExtra
	lblLinkExtra.Text 	 = textPolicy
	btnBackExtra.Text 	 = $"<  ${btnBackText}"$
	btnOKEXtra.Text 	 = btnOKEXtraText

End Sub

Private Sub SetProvidersForm
	
	GetProvidersData
	
	Private mrg As Int = pnlBase.Width * .04
	Private itemWidth As Int = pnlBase.Width * .92 - 2 * mrg
		
 ' Calculate height for all labels - Fonts and font sizes are set in the Designer
 	lblTitleProviders.Width = itemWidth
	lblTextProviders.Width  = itemWidth
	lblLinkProviders.Width  = itemWidth

	Private textProviders As String = $"${changeAnytimePrev}${appName}${changeAnytimePost}${howPartnersUse}"$
	Private textHeight  As Int 		= GetlabelHeight(lblTextProviders, textProviders)
	
	Private textPolicy As String = $"${howAppUsesPrev}${appName}${howAppUsesPost}"$
	Private linkPolicyHeight As Int = GetlabelHeight(lblLinkProviders, textPolicy) 
		
	pnlProviders.SetLayoutAnimated(0, pnlBase.Width * .04, pnlBase.Height * .03, pnlBase.Width * .92, pnlBase.Height * .94)

	lblTitleProviders.SetLayoutAnimated(0, mrg, 5dip,								    			    itemWidth, titleHeight)
	lblTextProviders.SetLayoutAnimated (0, mrg, lblTitleProviders.Top + lblTitleProviders.Height + mrg, itemWidth, textHeight)
		
	Private btnWidth As Int = 100dip
	Private leftbtnBack As Int = (pnlProviders.Width - btnWidth)/2
	Private topBtnBack As Int = pnlProviders.Height - mrg - btnsHeight
	
	btnBackProviders.SetLayoutAnimated(0, leftbtnBack, topBtnBack, btnWidth, btnsHeight)
	lblLinkProviders.SetLayoutAnimated(0, mrg, btnBackProviders.Top - mrg - linkPolicyHeight, itemWidth, linkPolicyHeight)
		
	Private svProvidersHeight As Int = lblLinkProviders.Top - lblTextProviders.Top - lblTextProviders.Height - 2 * mrg		
	svProviders.SetLayoutAnimated (0, mrg, lblTextProviders.Top + lblTextProviders.Height + mrg, itemWidth, svProvidersHeight)
	
	Private btnPubLeft As Int = 0
	Private btnPubTop As Int = 0
	Private btnPubHeight As Int = btnBackProviders.Height
	Private btnPadding As Int = 7dip
	Private gapHorizBtns As Int = 4dip
	Private gapVertBtns As Int = 6dip
	
	svProviders.ScrollViewContentWidth = svProviders.Width
	svProviders.ScrollViewContentHeight = btnPubHeight + gapVertBtns
	
	For i = 0 To providersList.Size - 1
		
		Private lblPub As Label
				lblPub.Initialize("btnPub")
		
    	Private btnPub As B4XView = lblPub
    	svProviders.ScrollViewInnerPanel.AddView(btnPub, 0, 0, 10dip, 10dip)
		
				btnPub.Font = lblTextProviders.Font
				btnPub.SetTextAlignment("CENTER", "CENTER")
				btnPub.TextColor = lblTextProviders.TextColor
						
				Private provider As Provider = providersList.Get(i)
				btnPub.Text = provider.Name
				btnPub.Tag  = provider.URL
					
		Private cnv As B4XCanvas
				cnv.Initialize(btnPub)
					
		Private rectText As B4XRect = cnv.MeasureText(btnPub.Text, btnPub.font)
		Private btnPubWidth As Int = rectText.Width + 2 * btnPadding
		
		If btnPubLeft + btnPubWidth > svProviders.Width Then
			btnPubLeft = 0
			btnPubTop = btnPubTop + gapVertBtns + btnPubHeight
			svProviders.ScrollViewContentHeight = svProviders.ScrollViewContentHeight + gapVertBtns + btnPubHeight
		End If
		
		btnPub.SetLayoutanimated(0, btnPubLeft, btnPubTop, btnPubWidth, btnPubHeight)
		btnPub.SetColorAndBorder(xui.Color_Transparent, Min(1, 1dip), btnPub.TextColor, 8dip)
			
		btnPubLeft = btnPubLeft + btnPubWidth + gapHorizBtns
				
	Next	
			
 ' TEXTS
 	SetLabelTitle(lblTitleProviders)
	lblTextProviders.Text 	 = textProviders
	lblLinkProviders.Text 	 = textPolicy
	btnBackProviders.Text 	 = $"<  ${btnBackText}"$
		
	
End Sub

Private Sub GetProvidersData '(sorted)
	
	Private su As StringUtils
	Private rawList As List = su.LoadCSV(File.DirAssets, AdProvidersFilename, ",")
	
 ' The first item in the list obtained from AdMob web contains the fields names
	rawList.RemoveAt(0)

 ' Create providersList with known fields names...
 	providersList.Initialize
	For Each row() As String In rawList
		Private provider As Provider
				provider.Initialize
				provider.Name = row(0)
				provider.URL  = row(1)
		providersList.Add(provider)
	Next	
	
 ' ...and sort providersList by field 'Name'
	providersList.SortTypeCaseInsensitive("Name", True)
	
End Sub

Public Sub Show
	pnlForm.Visible = True
End Sub

Public Sub Close
	pnlForm.RemoveViewFromParent
	pnlExtra.RemoveViewFromParent	
	pnlProviders.RemoveViewFromParent
	providersList.Clear
End Sub

Private Sub HidePanels
	pnlForm.Visible = False
	pnlExtra.Visible = False
	pnlProviders.Visible = False
	pnlWeb.Visible = False
End Sub


Private Sub ExitForm
	
	Close
	
	If SubExists(CallingModule, $"${eventName}_Selection"$) Then
	   CallSub2(CallingModule, eventName & "_Selection", res)
	 Else
	   Log($"Missing Sub '${eventName}_Selection' in calling module"$)
	End If
	
End Sub

'Main
	Private Sub lblPolicies_Click
		HidePanels
		pnlProviders.Visible = True
	End Sub

	Private Sub btnYes_Click
		res = PERSONALIZED
		ExitForm
	End Sub

	Private Sub btnNo_Click
		HidePanels
		pnlExtra.Visible = True
	End Sub

	Private Sub btnAds_Click
		res = PAY_FOR_ADS_FREE
		ExitForm
	End Sub

' Extra
	Private Sub lblLinkExtra_Click
		OpenURL(appPrivacyPolicyURL)
	End Sub

	Private Sub btnOKExtra_Click
		res = NON_PERSONALIZED
		ExitForm
	End Sub

	Private Sub btnBackExtra_Click
		HidePanels
		pnlForm.Visible = True
	End Sub

'Providers
	Private Sub lblLinkProviders_Click
		OpenURL(appPrivacyPolicyURL)
	End Sub

	Private Sub btnBackProviders_Click
		HidePanels
		pnlForm.Visible = True
	End Sub

	Private Sub btnPub_Click
		Private btn As B4XView = Sender
		OpenURL(btn.Tag)	
	End Sub


Private Sub GetlabelHeight_OLD(view As B4XView, text As String) As Int
	Private su As StringUtils
	Return su.MeasureMultilineTextHeight(view, text)
End Sub


Private Sub GetlabelHeight(view As B4XView, text As String) As Int
	
	Private su As StringUtils
	Return su.MeasureMultilineTextHeight(view, text)
	
End Sub

Private Sub SetLabelTitle(lbl As B4XView)
	
	Private iconMargin As Int = lbl.Height * .05 'top and bottom margin from border to icon
	Private IcSize     As Int = lbl.Height - 2 * iconMargin
	Private iconTextSeparation As Int = 5dip	
	
	Private cnv As B4XCanvas 
			cnv.Initialize(lbl)

	Private txtRect As B4XRect = cnv.MeasureText(appName, lbl.Font)
	Private baseText  As Int = (lbl.height + txtRect.Height)/2
	Private lefticon  As Int
			lefticon = (lbl.Width - (IcSize + iconTextSeparation + txtRect.Width))/2
	Private leftText  As Int 
			leftText = lefticon + IcSize + iconTextSeparation
	
' Icon:
	Private destIconRect As B4XRect
	Private semiDiff, dist As Int

 ' Keep icon aspect ratio for non-square bitmaps. Otherwise it will fit IcSize x IcSize
	If icon.Width >= icon.Height Then 
		semiDiff = (icon.Width - icon.Height)/2
		dist = IcSize * semiDiff/icon.Width
		destIconRect.Initialize(lefticon, iconMargin + dist, lefticon + IcSize, iconMargin + IcSize - dist)
	Else	
		semiDiff = (icon.Height - icon.width)/2
		dist = IcSize * semiDiff/icon.Height
		destIconRect.Initialize(lefticon + dist, iconMargin, lefticon + IcSize - dist, iconMargin + IcSize)
	End If
					
	cnv.DrawBitmap(icon, destIconRect)
	cnv.DrawText(appName, leftText, baseText, lbl.font, lbl.TextColor, "LEFT")

End Sub

Private Sub pnlBase_Click
End Sub
Private Sub pnlForm_Click
End Sub
Private Sub pnlExtra_Click
End Sub
Private Sub pnlProviders_Click
End Sub
Private Sub pnlWeb_Click
End Sub

Sub GetTexts(langCode As String)
	
	Select langCode
	   	Case LANG_SPANISH	
			headIntro 		  = "Nos preocupamos por tu privacidad y la seguridad de tus datos. Los anuncios que mostramos en la aplicación nos permiten ofrecerla gratis."
			headQuestion 	  = "¿Permites que nuestros colaboradores sigan usando tus datos para personalizar los anuncios que te muestran?"
			changeAnytimePrev = "Puedes cambiar tu elección para "
			changeAnytimePost = " en cualquier momento desde los ajustes de la aplicación. "
			headDetail  	  = "Nuestros colaboradores recogerán los datos y usarán un identificador único en tu dispositivo para mostrarte anuncios."
			howPartnersUse	  = "Descubre cómo nuestros colaboradores recogen y usan los datos:"
			howPartnersUse2	  = "Descubre cómo "
			howPartnersUse3	  = " y nuestros colaboradores recogen y usan los datos"
			howAppUsesPrev	  = "Cómo utiliza "
			howAppUsesPost	  = " tus datos"
			txtBtnYes 	 	  = "Sí, quiero seguir viendo anuncios relevantes"
			txtBtnNo   	 	  = "No, quiero ver anuncios que sean menos relevantes"
			txtBtnAds 		  = "Pagar por la versión sin anuncios"
			linkPolicyText    = "Ver política de privacidad"
			textExtraPrev	  = "Colaboraremos con Google y usaremos un identificador único en tu dispositivo para respetar tu elección acerca del uso de los datos. Puedes cambiar tu elección para "
			textExtraPost	  = " en cualquier momento desde los ajustes de la aplicación."
			btnBackText  	  = "Atrás"
			btnOKEXtraText	  = "Acepto"
			
		Case LANG_FRENCH
			headIntro 		  = "Nous accordons énormément d'importance à la protection de votre confidentialité et à la sécurité de vos données. Les publicités que nous vous montrons dans cette application nous permettent de vous l'offrir gratuitement."
			headQuestion 	  = "Nos partenaires peuvent-ils continuer à utiliser vos données afin de personnaliser les publicités que vous voyez?"
			changeAnytimePrev = "Vous pouvez modifier votre choix à tout moment pour "
			changeAnytimePost = " dans les réglages de l'application. "
			headDetail 		  = "Nos partenaires recueilleront des données et utiliseront un identifiant unique sur votre appareil pour vous montrer des publicités."
			howPartnersUse	  = "Découvrez comment nos partenaires recueillent et utilisent les données :"
			howPartnersUse2	  = "Découvrez comment "
			howPartnersUse3	  = " et nos partenaires recueillent et utilisent les données"
			howAppUsesPrev	  = "Comment "
			howAppUsesPost	  = " utilise vos données"
			txtBtnYes 		  = "Oui, continuez à me montrer des publicités pertinentes"
			txtBtnNo 		  = "Non, montrez-moi des publicités qui sont moins pertinentes"
			txtBtnAds 		  = "Payer pour la version sans publicité"
			linkPolicyText	  = "Voir la politique de confidentialité"
			textExtraPrev	  = "Nous formerons un partenariat avec Google et utiliserons un identifiant unique sur votre appareil afin de respecter vos choix concernant l'utilisation des données. Vous pouvez modifier votre choix à tout moment pour "
			textExtraPost	  = " dans les réglage de l'application."
			btnBackText  	  = "Retour"
			btnOKEXtraText	  = "J'accepte"
		
		Case LANG_PORTUGUESE
			headIntro 		  = "Nós preocupamo-nos com a sua privacidade e segurança dos dados. Mantemos esta aplicação gratuita ao mostrar anúncios."
			headQuestion 	  = "Os nossos parceiros podem continuar a utilizar os seus dados para adequar os anúncios a si?"
			changeAnytimePrev = "Pode alterar a sua opção a qualquer momento para "
			changeAnytimePost = " nas definições da aplicação. "
			headDetail 		  = "Os nossos parceiros vão recolher dados e utilizar um identificador exclusivo no seu dispositivo para mostrar-lhe anúncios."
			howPartnersUse	  = "Saiba como os nossos parceiros recolhem e utilizam dados:"
			howPartnersUse2	  = "Saiba como "
			howPartnersUse3	  = " e os nossos parceiros recolhem e utilizam os dados"
			howAppUsesPrev	  = "Como "
			howAppUsesPost	  = "  utiliza os seus dados"
			txtBtnYes 		  = "Sim, continuar a ver anúncios relevantes"
			txtBtnNo 		  = "Não, ver anúncios que são menos relevantes"
			txtBtnAds 		  = "Pagar pela versão sem anúncios"
			linkPolicyText	  =	"Veja a política de privacidade"
			textExtraPrev	  = "Vamos fazer parceria com a Google e utilizar um identificar exclusivo no seu dispositivo para respeitar a sua escolha de utilização de dados. Pode alterar a sua escolha a qualquer momento para "
			textExtraPost	  = " nas definições da aplicação."
			btnBackText  	  = "Anterior"
			btnOKEXtraText	  = "Concordo"
			
		Case LANG_ITALIAN	
			headIntro 		  = "Abbiamo a cuore la tua privacy e la sicurezza dei tuoi dati. Gli annunci pubblicitari che mostriamo nell'app ci consentono di offrirla gratuitamente."
			headQuestion 	  = "Accetti che i nostri partner continuino a usare i tuoi dati per personalizzare gli annunci pubblicitari che ti vengono mostrati?"
			changeAnytimePrev = "Puoi modificare la tua scelta per "
			changeAnytimePost = " in qualsiasi momento dalle impostazioni dell'app. " 
			headDetail 		  = "I nostri partner raccoglieranno dati e utilizzeranno un identificatore univoco sul tuo dispositivo per mostrarti gli annunci pubblicitari."
			howPartnersUse	  = "Scopri in che modo i nostri partner raccolgono e usano i dati:"
			howPartnersUse2	  = "Scopri in che modo "
			howPartnersUse3	  = " e i suoi partner raccolgono e usano i dati"
			howAppUsesPrev	  = "In che modo "
			howAppUsesPost	  = "  usa i tuoi dati"
			txtBtnYes 		  = "Sì, desidero continuare a visualizzare annunci pubblicitari pertinenti"
			txtBtnNo 		  = "No, desidero visualizzare annunci pubblicitari meno pertinenti"
			txtBtnAds 		  =	"Acquista la versione senza annunci pubblicitari"
			linkPolicyText	  = "Vedi l'informativa sulla privacy"
			textExtraPrev	  = "Collaboreremo con Google e ci avvarremo di un identificatore univoco sul tuo dispositivo per rispettare la tua scelta in merito all'utilizzo dei dati. Puoi modificare la tua scelta per "
			textExtraPost	  = " in qualsiasi momento dalle impostazioni dell'app."
			btnBackText  	  = "Indietro"
			btnOKEXtraText	  = "Accetto"

		Case LANG_GERMAN	
			headIntro 		  = "Wir kümmern uns um Ihre Privatsphäre und Datensicherheit. Wir halten diese App kostenlos, indem wir Anzeigen schalten."
			headQuestion 	  = "Dürfen unsere Partner Ihre Daten weiterhin nutzen, um Anzeigen für Sie maßzuschneidern?"
			changeAnytimePrev = "Sie können Ihre Auswahl für "
			changeAnytimePost = " jederzeit in den App-Einstellungen ändern. "
			headDetail 		  = "Unsere Partner sammeln Daten und verwenden eine eindeutige Kennung auf Ihrem Gerät, um Ihnen Anzeigen zu zeigen."
			howPartnersUse	  = "Lernen Sie, wie unsere Partner Daten sammeln und nutzen:"
			howPartnersUse2	  = "Erfahren Sie, wie "
			howPartnersUse3	  = "  und unsere Partner Daten erheben und nutzen"
			howAppUsesPrev	  = "Wie "
			howAppUsesPost	  = " Ihre Daten verwendet"
			txtBtnYes 		  = "Ja, weiterhin relevante Anzeigen sehen"
			txtBtnNo 		  = "Nein, weniger relevante Anzeigen sehen"
			txtBtnAds 		  =	"Für die werbefreie Version bezahlen"
			linkPolicyText	  = "Siehe Datenschutzbestimmungen"
			textExtraPrev	  = "Wir arbeiten mit Google zusammen und verwenden eine eindeutige Kennung auf Ihrem Gerät, um Ihre Wahl der Datennutzung zu respektieren. Sie können Ihre Auswahl für "
			textExtraPost	  = " jederzeit in den App-Einstellungen ändern."
			btnBackText  	  = "Zurück"
			btnOKEXtraText	  = "Einverstanden"

		Case LANG_RUSSIAN	
			headIntro 		  = "Мы заботимся о вашей конфиденциальности и безопасности ваших данных. Чтобы это приложение оставалось бесплатным, мы должны размещать рекламу."
			headQuestion 	  = "Вы согласны, чтобы наши партнеры продолжали использовать ваши данные для показа рекламы по вашим интересам?"
			changeAnytimePrev = "Вы можете изменить свой выбор в любое время для "
			changeAnytimePost = " в настройках приложения. "
			headDetail 		  = "Наши партнеры будут собирать данные и использовать уникальный идентификатор на вашем устройстве, чтобы показывать вам рекламу."
			howPartnersUse	  = "Узнайте, как наши партнеры собирают и используют данные:"
			howPartnersUse2	  = "Узнайте как "
			howPartnersUse3	  = " и наши партнеры собирают и используют ваши данные"
			howAppUsesPrev	  = "Как "
			howAppUsesPost	  = " использует ваши данные"
			txtBtnYes 		  = "Да, я хочу по-прежнему видеть релевантную рекламу"
			txtBtnNo 		  = "Нет, я хочу видеть менее релевантную рекламу"
			txtBtnAds 		  =	"Заплатить за версию без рекламы" 
			linkPolicyText	  =	"См. Политику конфиденциальности"
			textExtraPrev	  = "В сотрудничестве с Google, мы будем использовать уникальный идентификатор на вашем устройстве, чтобы соответствовать вашему выбору по использованию данных. Вы можете изменить свой выбор в любое время для "
			textExtraPost	  = " в настройках приложения."
			btnBackText  	  = "Назад"
			btnOKEXtraText	  = "Согласен"

		Case LANG_DUTCH		
			headIntro 		  = "We hechten veel waarde aan uw privacy en de beveiliging van uw gegevens. Deze app is gratis dankzij de advertenties."
			headQuestion 	  = "Mogen onze partners uw gegevens blijven gebruiken om advertenties relevant voor u te maken?"
			changeAnytimePrev = "U kunt in de instellingen van "			
			changeAnytimePost = " uw keuze altijd aanpassen. "
			headDetail 		  = "Onze partners verzamelen gegevens en gebruiken een uniek identificatienummer op uw apparaat om u advertenties te tonen."
			howPartnersUse	  = "Meer informatie over hoe onze partners gegevens verzamelen en gebruiken:"
			howPartnersUse2	  = "Meer informatie over hoe "
			howPartnersUse3	  = " en onze partners gegevens verzamelen en gebruiken"
			howAppUsesPrev	  = "Hoe "
			howAppUsesPost	  = " uw gegevens gebruikt"
			txtBtnYes 		  = "Ja, ik wil graag relevante advertenties blijven zien"
			txtBtnNo 		  = "Nee, ik wil advertenties die minder relevant zijn"
			txtBtnAds 		  = "Betalen voor de versie zonder advertenties"
			linkPolicyText	  =	"Zie privacybeleid"
			textExtraPrev	  = "We werken samen met Google en gebruiken een uniek identificatienummer op uw apparaat om uw voorkeur voor gegevensgebruik te respecteren. U kunt in de instellingen van "
			textExtraPost	  = " altijd uw keuze aanpassen."
			btnBackText  	  = "Terug"
			btnOKEXtraText	  = "Akkoord"

		Case LANG_CHINESE	
			headIntro 		  = "我们十分重视您的隐私和数据安全。 我们凭借广告赞助，坚持向用户提供免费应用。"
			headQuestion 	  = "我们的合作伙伴可否继续使用您的数据，向您推送定制广告？"
			changeAnytimePrev = "您可随时前往应用设置，更改 "
			changeAnytimePost = " 中的相关选择。 "
			headDetail 		  = "我们的合作伙伴将收集数据，并为您的设备标注唯一标识符，以向您显示广告。"
			howPartnersUse	  = "了解我们的合作伙伴如何收集和使用数据："
			howPartnersUse2	  = "了解 "
			howPartnersUse3	  = " 及其合作伙伴的数据收集和使用方式"
			howAppUsesPrev	  = ""
			howAppUsesPost	  = " 如何使用您的数据"
			txtBtnYes 		  = "好，继续查看相关广告"
			txtBtnNo 		  = "否，查看其它无关广告"
			txtBtnAds 		  = "购买无广告版本"
			linkPolicyText	  =	"查看隐私权政策"
			textExtraPrev	  = "我们将与 Google 合作，为您的设备标注唯一标识符，以遵守您的数据使用选择。 您可随时前往应用设置，更改 "
			textExtraPost	  = " 中的相关选择。"
			btnBackText  	  = "返回"
			btnOKEXtraText	  = "同意"

		Case LANG_JAPANESE	
			headIntro 		  = "私どもはお客様のプライバシーとデータ セキュリティを重視しています。 広告を表示することによって、このアプリを無料にしています。"
			headQuestion 	  = "私どものパートナーがあなたのデータを使用して、あなた向きの広告を調整してよろしいですか?"
			changeAnytimePrev = "アプリの設定で "
			changeAnytimePost = " の選択をいつでも変更できます。 "
			headDetail 		  = "私どものパートナーがデータを収集し、お使いのデバイスで固有の識別子を使用して広告を表示します。"
			howPartnersUse	  = "私どものパートナーがデータを収集し使用する方法をご覧ください:"
			howPartnersUse2	  = ""
			howPartnersUse3	  = "と私どものパートナーがデータを収集し使用する方法をご覧ください"
			howAppUsesPrev	  = ""
			howAppUsesPost	  = " があなたのデータを使用する方法"
			txtBtnYes 		  = "はい、関連性の高い広告の表示を続行します"
			txtBtnNo 		  = "いいえ、関連性が低い広告を表示します"
			txtBtnAds 		  = "広告なしバージョンを購入"
			linkPolicyText	  =	"プライバシーポリシーを見る"
			textExtraPrev	  = "私どもは Google と提携して、データの使用法の選択を尊重するためにデバイス上で固有の識別子を使用します。 アプリの設定で "
			textExtraPost	  = " の選択をいつでも変更できます。"
			btnBackText  	  = "戻る"
			btnOKEXtraText	  = "同意する"

		Case LANG_KOREAN	
			headIntro 		  = "당사는 프라이버시와 데이터 보안을 소중히 생각합니다. 당사는 광고를 통해서 이 앱을 무료로 제공하고 있습니다."
			headQuestion 	  = "당사의 협력업체가 회원님의 정보를 계속 사용해서 맞춤형 광고를 제공해도 되겠습니까?"
			changeAnytimePrev = "언제든 앱 설정에서 "
			changeAnytimePost = " 에 대한 선택 사항을 변경하실 수 있습니다. "
			headDetail 		  = "당사의 협력업체는 데이터를 수집하고 장치에 있는 고유 식별자를 사용해서 광고를 표시합니다."
			howPartnersUse	  = "당사의 협력업체가 데이터를 수집 및 이용하는 방법 보기:"
			howPartnersUse2	  = ""
			howPartnersUse3	  = " 및 당사의 협력업체가 데이터를 수집 및 이용하는 방법 보기"
			howAppUsesPrev	  = ""
			howAppUsesPost	  = " 의 개인 정보 이용 방법"
			txtBtnYes 		  = "예, 계속해서 맞춤형 광고를 보겠습니다"
			txtBtnNo 		  = "아니요, 관련성이 적은 광고를 보겠습니다"
			txtBtnAds 		  = "광고가 없는 버전을 구입하겠습니다"
			linkPolicyText	  =	"개인 정보 보호 정책보기"
			textExtraPrev	  = "당사는 Google과 협력하고 장치에 있는 고유 식별자를 사용하며 회원님이 선택한 데이터 이용 방법을 존중합니다. 언제든 앱 설정에서 "
			textExtraPost	  = " 에 대한 선택 사항을 변경하실 수 있습니다."
			btnBackText  	  = "뒤로"
			btnOKEXtraText	  = "동의"

		Case Else	' "en"(english, default) and rest of codes
			headIntro 		  = "We care about your privacy and data security. We keep this app free by showing ads."
			headQuestion 	  = "Can our partners continue to use your data to tailor ads for you?"
			changeAnytimePrev = "You can change your choice anytime for "
			changeAnytimePost = " in the app settings. "
			headDetail 		  = "Our partners will collect data and use a unique identifier on your device to show you ads."
			howPartnersUse	  = "Learn how our partners collect and use data:"
			howPartnersUse2	  = "Learn how "
			howPartnersUse3	  = " and our partners collect and use data"
			howAppUsesPrev	  = "How "
			howAppUsesPost	  = " uses your data"
			txtBtnYes 		  = "Yes, continue to see relevant ads"
			txtBtnNo 		  = "No, see ads that are less relevant"
			txtBtnAds 		  = "Pay for the ad-free version"
			linkPolicyText    = "See privacy policy"
			textExtraPrev	  = "We’ll partner with Google and use a unique identifier on your device to respect your data usage choice. You can change your choice anytime for "
			textExtraPost	  = " in the app settings."
			btnBackText  	  = "Back"
			btnOKEXtraText	  = "Agree"
			
			
	End Select
	
			
End Sub

Private Sub OpenURL(URL As String)  'or use your favorite way to open URLs

	pnlWeb.Visible = True
	
	pnlWeb.SetLayoutAnimated(0, pnlBase.Width * .02, pnlBase.Height * .06, pnlBase.Width * .96, pnlBase.Height * .88)
	btnBackWeb.SetLayoutAnimated(0, 10dip, pnlWeb.Height - 50dip, 50dip, 40dip)
	btnBackWeb.Text = Chr(0xF060)
	
	Private wv As WebView
			wv.Initialize("wv")
				
	Private mrg As Int = 3dip 'blue border width
	pnlWeb.AddView(wv, mrg, mrg, pnlWeb.Width - 2 * mrg , pnlWeb.Height - 2 * mrg)
	wv.LoadUrl(URL)	
		
End Sub

Private Sub btnBackWeb_Click
	pnlWeb.Visible = False	
End Sub
