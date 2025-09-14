B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'GPPurchases 
'Author Jerryk
'version 1.0
#DesignerProperty: Key: dHidePurchInapp, DisplayName: Hide purchased inapp, FieldType: Boolean, DefaultValue: False, Description: Hide purchased inapp.
#DesignerProperty: Key: dShowTimePurchase, DisplayName: Show time of purchase, FieldType: Boolean, DefaultValue: True, Description: Show time of purchase.
#DesignerProperty: Key: dHideInappDesc, DisplayName: Hide Inapp description, FieldType: Boolean, DefaultValue: False, Description: Hide Inapp description.
#DesignerProperty: Key: dExpInappDesc, DisplayName: Expanded Inapp description, FieldType: Boolean, DefaultValue: True, Description: Show expanded Inapp description.
#DesignerProperty: Key: dInappBackgroudColor, DisplayName: Inapp Backgroud Color, FieldType: Color, DefaultValue: #FFD3D3D3, Description: Backgroud Color for Inapp panel
#DesignerProperty: Key: dInappNameTextColor, DisplayName: Inapp Name Text Color, FieldType: Color, DefaultValue: #FF000000, Description: Name Text color
#DesignerProperty: Key: dInappDescTextColor, DisplayName: Inapp Description Text Color, FieldType: Color, DefaultValue: #FF000000, Description: Description Text color
#DesignerProperty: Key: dInappDescTextSize, DisplayName: Inapp Description Text Size, FieldType: Int, DefaultValue: 12, MinRange: 10, MaxRange: 20

#DesignerProperty: Key: dHidePurchSubs, DisplayName: Hide purchased subs, FieldType: Boolean, DefaultValue: False, Description: Hide purchased subs.
#DesignerProperty: Key: dShowUnsubscribe, DisplayName: Show Unsubscribe button, FieldType: Boolean, DefaultValue: False, Description: Show Unsubscribe button.
#DesignerProperty: Key: dHideSubsDesc, DisplayName: Hide Subs description, FieldType: Boolean, DefaultValue: False, Description: Hide Subs description.
#DesignerProperty: Key: dExpSubsDesc, DisplayName: Expanded Subs description, FieldType: Boolean, DefaultValue: True, Description: Show expanded Subs description.
#DesignerProperty: Key: dSubsBackgroudColor, DisplayName: Subs Backgroud Color, FieldType: Color, DefaultValue: #FFD3D3D3, Description: Backgroud Color for Subs panel
#DesignerProperty: Key: dSubsNameTextColor, DisplayName: Subs Name Text Color, FieldType: Color, DefaultValue: #FF000000, Description:
#DesignerProperty: Key: dSubsDescTextColor, DisplayName: Subs Description Text Color, FieldType: Color, DefaultValue: #FF000000, Description: Description Text color
#DesignerProperty: Key: dSubsDescTextSize, DisplayName: Subs Description Text Size, FieldType: Int, DefaultValue: 12, MinRange: 10, MaxRange: 20
#DesignerProperty: Key: dSubsOfferTextColor, DisplayName: Subs Offer Text Color, FieldType: Color, DefaultValue: #FF404040, Description: Offer Text color

#Event: PurchaseCompleted(p As Purchase)
#Event: BillingError(error As Int)
#Event: PurchaseError(Result As BillingResult)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private gpb As GPBilling

	Private su As StringUtils
	Private br As BillingResult
	Private dd As DDD
	Private pnlBackground As B4XView
	Private clv As CustomListView
	Private rx As ReadXml
	Type ItemData (Sku As String, CollapsedHeight As Int, ExpandedHeight As Int, Value As Object, Expanded As Boolean)
	Private xItemData As ItemData
	 
	Private skutype As String
	Private lSKU_INAPP As List
	Private lSKU_SUBS As List
	
	Public CODE_NO_INAPP As Int
	Public CODE_NO_SUBSCRIPTION As Int
	
'	Property
	Private HidePurchInapp As Boolean
	Private ShowTimePurchase As Boolean
	Private HideInappDesc As Boolean
	Private ExpInappDesc As Boolean
	Private InappBackgroudColor As Int
	Private InappNameTextColor As Int
	Private InappDescTextColor As Int
	Private InappDescTextSize As Int

	Private HidePurchSubs As Boolean
	Private ShowUnsubscribe As Boolean
	Private HideSubsDesc As Boolean
	Private ExpSubsDesc As Boolean
	Private SubsBackgroudColor As Int
	Private SubsNameTextColor As Int
	Private SubsDescTextColor As Int
	Private SubsDescTextSize As Int
	Private SubsOfferTextColor As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub Init (LICENSE_KEY As String)
	gpb.Initialize(Me, "gpb", LICENSE_KEY)
	lSKU_INAPP.Initialize
	lSKU_SUBS.Initialize
	CODE_NO_INAPP = gpb.CODE_NO_INAPP
	CODE_NO_SUBSCRIPTION = gpb.CODE_NO_SUBSCRIPTION
End Sub

'stype: INAPP - show Inapp, SUBS - show Subs, ALL - show all SKUs	
'linapp - list of INAPP id's, lsubs - list of SUBS id's
Public Sub SetSku (stype As String, linapp As List, lsubs As List)
	skutype = stype
	lSKU_INAPP = linapp
	lSKU_SUBS = lsubs
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
	mBase.Tag = Me
	Dim wlbl As Label
	wlbl.Initialize("")
	DateTime.DateFormat = DateTime.DeviceDefaultDateFormat
 
	rx.Initialize("rx")
	dd.Initialize
	xui.RegisterDesignerClass(dd)
	
	pnlBackground = xui.CreatePanel("")
	mBase.AddView(pnlBackground, 0, 0, mBase.Width, mBase.Height)
	
	Dim wmap As Map
	wmap.Initialize
	wmap.Put("DividerColor", 0xFFD9D7DE)
	wmap.Put("DividerHeight", 2)
	wmap.Put("PressedColor", 0xFF7EB4FA)
	wmap.Put("InsertAnimationDuration", 300)
	wmap.Put("ListOrientation","Vertical")
	wmap.Put("ShowScrollBar", True)
	clv.Initialize(Me,"xclv_main")
	clv.DesignerCreateView(pnlBackground, wlbl, wmap)
	clv.AsView.Tag = clv
	
	xItemData.Initialize
	
	HidePurchInapp = Props.Get("dHidePurchInapp")
	ShowTimePurchase = Props.Get("dShowTimePurchase")
	HideInappDesc = Props.Get("dHideInappDesc")
	ExpInappDesc = Props.Get("dExpInappDesc")
	InappBackgroudColor = Props.Get("dInappBackgroudColor")
	InappNameTextColor = Props.Get("dInappNameTextColor")
	InappDescTextColor = Props.Get("dInappDescTextColor")
	InappDescTextSize = Props.Get("dInappDescTextSize")

	HidePurchSubs = Props.Get("dHidePurchSubs")
	ShowUnsubscribe = Props.Get("dShowUnsubscribe")
	HideSubsDesc = Props.Get("dHideSubsDesc")
	ExpSubsDesc = Props.Get("dExpSubsDesc")
	SubsBackgroudColor = Props.Get("dSubsBackgroudColor")
	SubsNameTextColor = Props.Get("dSubsNameTextColor")
	SubsDescTextColor = Props.Get("dSubsDescTextColor")
	SubsDescTextSize = Props.Get("dSubsDescTextSize")
	SubsOfferTextColor = Props.Get("dSubsOfferTextColor")
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
End Sub

'show SKUs in CustomListView
Public Sub ShowSku 
	clv.Clear
	Select skutype
		Case "INAPP"
			FillClvInapp
		Case "SUBS"
			FillClvSubs
		Case "ALL"
			FillClvInapp
			Wait For FillClvInapp_Complete
			FillClvSubs
	End Select
End Sub

'**************************************** INAPP ****************************************

#Region INAPP
Private Sub FillClvInapp
	Wait For (gpb.GetInAppProducts(lSKU_INAPP)) Complete (iar As ProductResult)
	If iar.ResponseCode = br.CODE_OK Then
		Dim lProducts As List
		lProducts.Initialize
		lProducts.AddAll(iar.ProductsList)
		For i = 0 To lProducts.Size - 1
			Dim iap As InAppProduct
			iap.Initialize
			iap = lProducts.Get(i)
			
			Wait For(gpb.IsPurchased("inapp",iap.ProductId)) Complete (pResult As PurchasedResult)
			
			Dim idata As ItemData
			idata.Initialize
			idata.Sku = iap.ProductId
			idata.CollapsedHeight = 70
			xItemData = idata
			If Not(pResult.ItemPurchased And HidePurchInapp) Then
				Dim p As B4XView = CreateListItemInap(iap, pResult, clv.AsView.Width, 70dip)
				clv.Add(p, idata)
				clv.GetRawListItem(clv.Size-1).Value = xItemData
			End If
		Next
		CallSubDelayed(Me, "FillClvInapp_Complete")
	Else
		HandleError(iar.ResponseCode)
	End If
End Sub

Private Sub CreateListItemInap(iapp As InAppProduct, pResult As PurchasedResult, Width As Int, Height As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, Height)
	p.LoadLayout("pCellItemI")
	p.Color = InappBackgroudColor
	
	'Note that we call DDD.CollectViewsData in CellItem designer script. This is required if we want to get views with dd.GetViewByName.
	Dim ddName As B4XView = dd.GetViewByName(p, "lName")
	ddName.Text = iapp.Name
	ddName.TextColor = InappNameTextColor
	ddName.Height = Max(su.MeasureMultilineTextHeight(ddName, iapp.Name), 60dip)
	xItemData.CollapsedHeight = ddName.Height + 10dip
	
	Dim ddDesc As B4XView = dd.GetViewByName(p, "lDesc")
	ddDesc.Text = iapp.Description
	ddDesc.Color =  MakeColorLighter(InappBackgroudColor, 7)
	ddDesc.TextColor = InappDescTextColor
	ddDesc.TextSize = InappDescTextSize
	ddDesc.Top = Max(ddName.Height + 5dip, 70dip)
	ddDesc.Height = su.MeasureMultilineTextHeight(ddDesc, ddDesc.Text)
	xItemData.ExpandedHeight = 10dip + ddName.Height + ddDesc.Height

	If HideInappDesc Then
		ExpInappDesc = False
		dd.GetViewByName(p, "IArrow").Visible = False
	End If
	If ExpInappDesc Then 
		xItemData.Expanded = True
		p.Height = xItemData.ExpandedHeight
		AnimatedArrow(0, 180, p)
	Else
		xItemData.Expanded = False
		p.Height = xItemData.CollapsedHeight
		AnimatedArrow(180, 0, p) 
	End If

	dd.GetViewByName(p, "btnBuyI").Text = rx.Locale("Buy")
	dd.GetViewByName(p, "lPrice").Text = iapp.FormattedPrice
	If pResult.ItemPurchased Then
		dd.GetViewByName(p, "btnBuyI").Visible = False
		dd.GetViewByName(p, "lCheck").Left = p.Width - 10dip - dd.GetViewByName(p, "lCheck").Width
		dd.GetViewByName(p, "lCheck").Visible = True
		If ShowTimePurchase Then
			dd.GetViewByName(p, "lPrice").Text = DateTime.Date(pResult.ProductPurchased.PurchaseTime)
		Else
			dd.GetViewByName(p, "lPrice").Text = ""
		End If
	End If
	Return p
End Sub

Private Sub btnBuyI_Click
'	Dim button As B4XView = Sender
	Dim index As Int = clv.GetItemFromView(Sender)
	Dim idata As ItemData = clv.GetValue(index)
	Dim lSKUs As List
	lSKUs.Initialize
	lSKUs.Add(idata.sku)
	Wait For(gpb.PurchaseInAppProducts(lSKUs)) Complete (Result2 As BillingResult)
'	event will be raised
	
	If Not(Result2.IsSuccess) Then
		HandleError(Result2.ResponseCode)
	End If
End Sub

Private Sub	gpb_PurchaseCompleted(p As Purchase)
	If SubExists(mCallBack, mEventName & "_PurchaseCompleted") Then
		CallSubDelayed2(mCallBack,  mEventName & "_PurchaseCompleted", p)
	End If
End Sub

Private Sub gpb_PurchaseError(Result As BillingResult)
	If SubExists(mCallBack, mEventName & "_PurchaseError") Then
		CallSubDelayed2(mCallBack,  mEventName & "_PurchaseError", Result)
	End If
End Sub
#End Region

'**************************************** SUBS ****************************************

#Region SUBS
Private Sub FillClvSubs
	Wait For (gpb.GetSubscriptions(lSKU_SUBS)) Complete (sur As ProductResult)
	If sur.ResponseCode = br.CODE_OK Then
		Dim lProducts As List
		lProducts.Initialize
		lProducts.AddAll(sur.ProductsList)
		For i = 0 To lProducts.Size - 1
			Dim sup As SubsProduct
			sup.Initialize
			sup = lProducts.Get(i)
			
			Wait For(gpb.IsPurchased("subs",sup.ProductId)) Complete (pResult As PurchasedResult)

			Dim idata As ItemData
			idata.Initialize
			idata.Sku = sup.ProductId
			idata.CollapsedHeight = 70
			xItemData = idata
			If Not(pResult.ItemPurchased And HidePurchSubs) Then
				Dim p As B4XView = CreateListItemSub(sup, pResult, clv.AsView.Width, 100dip)
				clv.Add(p, idata)
				Dim ldet As List
				ldet.Initialize
				ldet.AddAll(sup.SubscriptionOfferDetails)
				If Not(pResult.ItemPurchased And ldet.Size = 1) Then
					For j = 0 To ldet.Size - 1
						Dim so As SubsOffer = ldet.Get(j)
						Dim param(2) As String
						param(0) = sup.ProductId
						param(1) = so.OfferToken
						clv.Add(CreateListItemOff(so, clv.AsView.Width, 50dip), param)
					Next
				End If
			End If	
		Next
	Else
		HandleError(sur.ResponseCode)
	End If
End Sub

Private Sub CreateListItemSub(supp As SubsProduct, pResult As PurchasedResult,  Width As Int, Height As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, Height)
	p.LoadLayout("pCellItemS")
	p.Color = SubsBackgroudColor
	
	'Note that we call DDD.CollectViewsData in CellItem designer script. This is required if we want to get views with dd.GetViewByName.
	Dim ddName As B4XView = dd.GetViewByName(p, "lName")
	ddName.Text = supp.Name
	ddName.TextColor = SubsNameTextColor
	ddName.Height = Max(su.MeasureMultilineTextHeight(ddName, supp.Name), 60dip)
	xItemData.CollapsedHeight = ddName.Height + 10dip

	Dim ddDesc As B4XView = dd.GetViewByName(p, "lDescSub")
	ddDesc.Text = supp.Description
	ddDesc.Color =  MakeColorLighter(SubsBackgroudColor, 7)
	ddDesc.TextColor = SubsDescTextColor
	ddDesc.TextSize = SubsDescTextSize
	ddDesc.Top = Max(ddName.Height + 5dip, 70dip)
	ddDesc.Height = su.MeasureMultilineTextHeight(ddDesc, ddDesc.Text)
	xItemData.ExpandedHeight = 10dip + ddName.Height + ddDesc.Height

	If HideSubsDesc Then
		ExpSubsDesc = False
		dd.GetViewByName(p, "IArrow").Visible = False
	End If
	If ExpSubsDesc Then
		xItemData.Expanded = True
		p.Height = xItemData.ExpandedHeight
		AnimatedArrow(0, 180, p)
	Else
		xItemData.Expanded = False
		p.Height = xItemData.CollapsedHeight
		AnimatedArrow(180, 0, p)
	End If
	
	dd.GetViewByName(p, "btnUnsub").Text = rx.Locale("Unsubscribe")
	If pResult.ItemPurchased Then
		If ShowUnsubscribe Then
			dd.GetViewByName(p, "btnUnsub").Visible = True
		Else
			dd.GetViewByName(p, "btnUnsub").Visible = False
			dd.GetViewByName(p, "lCheck").Left = p.Width - 10dip - dd.GetViewByName(p, "lCheck").Width
		End If
		If ShowTimePurchase Then
			dd.GetViewByName(p, "lBought").Text = DateTime.Date(pResult.ProductPurchased.PurchaseTime)
		End If
		dd.GetViewByName(p, "lCheck").Visible = True
	End If
	Return p
End Sub

Private Sub CreateListItemOff(sof As SubsOffer, Width As Int, Height As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, Height)
	p.LoadLayout("pCellItemO")
	'Note that we call DDD.CollectViewsData in CellItem designer script. This is required if we want to get views with dd.GetViewByName.
	Dim ddpnl As B4XView = dd.GetViewByName(p, "PanelLeft")
	ddpnl.Color = SubsBackgroudColor
	Dim act As B4XView = ddpnl.Parent
	act.Color = MakeColorLighter(SubsBackgroudColor, 15)
	Dim ddlPeT As B4XView = dd.GetViewByName(p, "lPeriodTitle")
	ddlPeT.Text = rx.Locale("PeriodTitle")
	ddlPeT.TextColor = SubsOfferTextColor
	Dim ddlPrT As B4XView = dd.GetViewByName(p, "lPriceTitle")
	ddlPrT.Text = rx.Locale("PriceTitle")
	ddlPrT.TextColor = SubsOfferTextColor
	Dim ddlPeriod As B4XView = dd.GetViewByName(p, "lPeriod")
	ddlPeriod.TextColor = SubsOfferTextColor
	Dim ddlPrice As B4XView = dd.GetViewByName(p, "lPrice")
	ddlPrice.TextColor = SubsOfferTextColor
	dd.GetViewByName(p, "btnBuyS").Text = rx.Locale("Subscribe")

	Dim phases As List
	phases.Initialize
	phases = sof.PricingPhaseList
	Dim sprice = "", speriod  = "" As String
	Dim s, lf As String
	For i = 0 To phases.Size - 1
		Dim prph As PricingPhase
		prph = phases.Get(i)
		s = IIf(i = 0,"","└► ")
		lf = IIf(i = phases.Size - 1, "", CRLF)
		Dim mul As String
		mul = IIf(prph.BillingCycleCount > 1, prph.BillingCycleCount & "x", "")
		speriod = speriod & s & ParseISO8601Duration(prph.BillingPeriod) & " " & mul & lf
		sprice = sprice & prph.FormattedPrice & lf
	Next
	
	Dim ddPeriod As B4XView = dd.GetViewByName(p, "lPeriod")
	Dim ddPrice As B4XView = dd.GetViewByName(p, "lPrice")
	ddPrice.Text = sprice
	ddPeriod.Text = speriod
	
	ddPeriod.Height = su.MeasureMultilineTextHeight(ddPeriod, speriod)
	ddPrice.Height = ddPeriod.Height
	p.Height = 30dip + ddPeriod.Height
	dd.GetViewByName(p, "PanelLeft").Height = p.Height

	Return p
End Sub

Private Sub btnBuyS_Click
'	Dim button As B4XView = Sender
	Dim index As Int = clv.GetItemFromView(Sender)
	Dim param(2) As String
	Dim lSKUs As List
	lSKUs.Initialize
	Sleep(100)
	param = clv.GetValue(index)
'	Log(param(0))   'sku
'	Log(param(1))	'OfferToken
	lSKUs.Add(param(0))
	Wait For(gpb.PurchaseSubsProducts(lSKUs, param(1))) Complete (Result As BillingResult)
'	event will be raised 

	If Not(Result.IsSuccess) Then
		HandleError(Result.ResponseCode)
	End If
End Sub	

Private Sub btnUnsub_Click
	Dim index As Int = clv.GetItemFromView(Sender)
	Dim idata As ItemData = clv.GetValue(index)
'	Dim sku As String = clv.GetValue(index)
	Dim ph As PhoneIntents
	Dim sPack As String = Application.PackageName
	StartActivity(ph.OpenBrowser($"https://play.google.com/store/account/subscriptions?sku=${idata.Sku}&package=${sPack}"$))
'	StartActivity(ph.OpenBrowser("https://play.google.com/store/account/subscriptions"))
End Sub
#End Region

Private Sub HandleError(Error As Int)
	If SubExists(mCallBack, mEventName & "_BillingError") Then
		CallSubDelayed2(mCallBack,  mEventName & "_BillingError", Error)
	End If
End Sub

'Consume ConsumeProduct, stype: INAPP, SUBS, sku - SKU id
Public Sub ConsumeProduct(stype As String, sku As String) As ResumableSub
	Wait For(gpb.ConsumeProducts(stype, sku)) Complete (Result As BillingResult)
	Return Result
End Sub

'convert error to string
Public Sub ErrorText(error As Int) As String
	Dim br As BillingResult
	Select Case error
		Case br.CODE_BILLING_UNAVAILABLE
			Return rx.Locale("BILLING_UNAVAILABLE")
		Case br.CODE_DEVELOPER_ERROR
			Return rx.Locale("DEVELOPER_ERROR")
		Case br.CODE_ERROR
			Return rx.Locale("ERROR")
		Case br.CODE_OK
			Return rx.Locale("OK")
		Case br.CODE_FEATURE_NOT_SUPPORTED
			Return rx.Locale("FEATURE_NOT_SUPPORTED")
		Case br.CODE_ITEM_ALREADY_OWNED
			Return rx.Locale("ITEM_ALREADY_OWNED")
		Case br.CODE_ITEM_NOT_OWNED
			Return rx.Locale("ITEM_NOT_OWNED")
		Case br.CODE_ITEM_UNAVAILABLE
			Return rx.Locale("ITEM_UNAVAILABLE")
		Case br.CODE_SERVICE_DISCONNECTED
			Return rx.Locale("SERVICE_DISCONNECTED")
		Case br.CODE_SERVICE_UNAVAILABLE
			Return rx.Locale("SERVICE_UNAVAILABLE")
		Case br.CODE_SERVICE_TIMEOUT
			Return rx.Locale("SERVICE_TIMEOUT")
		Case br.CODE_USER_CANCELED
			Return rx.Locale("USER_CANCELED")
		Case gpb.CODE_NO_INAPP
			Return rx.Locale("NO_INAP")
		Case gpb.CODE_NO_SUBSCRIPTION
			Return rx.Locale("NO_SUBSCRIPTION")
	End Select
End Sub

Public Sub setHidePurchasedInapp(NewValue As Boolean)
	HidePurchInapp = NewValue
End Sub
Public Sub getHidePurchasedInapp As Boolean
	Return HidePurchInapp
End Sub
Public Sub setShowTimeOfPurchase(NewValue As Boolean)
	ShowTimePurchase = NewValue
End Sub
Public Sub getShowTimeOfPurchase As Boolean
	Return ShowTimePurchase
End Sub
Public Sub setHideInappDescription(NewValue As Boolean)
	HideInappDesc = NewValue
End Sub
Public Sub getHideInappDescription As Boolean
	Return HideInappDesc
End Sub
Public Sub setExpandedInappDescription(NewValue As Boolean)
	ExpInappDesc = NewValue
End Sub
Public Sub getExpandedInappDescription As Boolean
	Return ExpInappDesc
End Sub

Public Sub setHidePurchasedSubs(NewValue As Boolean)
	HidePurchSubs = NewValue
End Sub
Public Sub getHidePurchasedSubs As Boolean
	Return HidePurchSubs
End Sub
Public Sub setShowUnsubscribeButton(NewValue As Boolean)
	ShowUnsubscribe = NewValue
End Sub
Public Sub getShowUnsubscribeButton As Boolean
	Return ShowUnsubscribe
End Sub
Public Sub setHideSubsDescription(NewValue As Boolean)
	HideSubsDesc = NewValue
End Sub
Public Sub getHideSubsDescription As Boolean
	Return HideSubsDesc
End Sub
Public Sub setExpandedSubsDescription(NewValue As Boolean)
	ExpSubsDesc = NewValue
End Sub
Public Sub getExpandedSubsDescription As Boolean
	Return ExpSubsDesc
End Sub

'tools
Private Sub ParseISO8601Duration(DurationString As String) As String
	Dim result As String = ""
	Dim pattern As String
	pattern = "P(\d+Y)?(\d+M)?(\d+W)?(\d+D)?T?(\d+H)?(\d+M)?(\d+S)?"
	Dim matcher As Matcher
	matcher = Regex.Matcher(pattern, DurationString)

	If matcher.Find Then
		Dim years As Int = ParseDurationComponent(matcher.Group(1))
		Dim months As Int = ParseDurationComponent(matcher.Group(2))
		Dim weeks As Int = ParseDurationComponent(matcher.Group(3))
		Dim days As Int = ParseDurationComponent(matcher.Group(4))
		Dim hours As Int = ParseDurationComponent(matcher.Group(5))
		Dim minutes As Int = ParseDurationComponent(matcher.Group(6))
		Dim seconds As Int = ParseDurationComponent(matcher.Group(7))

		If years > 0 Then
			result = result & years & " " & rx.Plural("p_year", years) & " "
		End If
		If months > 0 Then
			result = result & months & " " & rx.Plural("p_month", months) & " "
		End If
		If weeks > 0 Then
			result = result & weeks & " " & rx.Plural("p_week", weeks) & " "
		End If
		If days > 0 Then
			result = result & days & " " & rx.Plural("p_day", days) & " "
		End If
		If hours > 0 Then
			result = result & hours & IIf(hours = 1, " hour ", " hours ")
		End If
		If minutes > 0 Then
			result = result & minutes & IIf(minutes = 1, " minute ", " minutes ")
		End If
		If seconds > 0 Then
			result = result & seconds & IIf(seconds = 1, " second ", " seconds ")
		End If
	End If
	Return result
End Sub

Private Sub ParseDurationComponent(Component As String) As Int
	If Component = Null Or Component = "" Then
		Return 0
	Else
		Return NumberFormat(Component.SubString2(0, Component.Length - 1),0,0)
	End If
End Sub

Private Sub MakeColorLighter(color As Int, percent As Float) As Int
	Dim r, g, b, a As Int
	a = Bit.UnsignedShiftRight(Bit.And(color, 0xFF000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(color, 0x00FF0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(color, 0x0000FF00), 8)
	b = Bit.And(color, 0x000000FF)
    
	b = Min(255, b + b * percent / 100)
	r = Min(255, r + (255 - r) * percent / 100)
	g = Min(255, g + (255 - g) * percent / 100)
	b = Min(255, b + (255 - b) * percent / 100)
    
	Return Bit.Or(Bit.ShiftLeft(a, 24), Bit.Or(Bit.ShiftLeft(r, 16), Bit.Or(Bit.ShiftLeft(g, 8), b)))
End Sub

Private Sub AnimatedArrow(From As Int, ToDegree As Int, Pnl As B4XView)
	Dim ddArrow As B4XView = dd.GetViewByName(Pnl, "IArrow")
	ddArrow.SetRotationAnimated(0, From)
	ddArrow.SetRotationAnimated(clv.AnimationDuration, ToDegree)
End Sub

Private Sub IArrow_Click
	Dim index As Int = clv.GetItemFromView(Sender)
	Dim p As B4XView = clv.GetPanel(index)
	Dim idata As ItemData = clv.GetRawListItem(index).Value
	If idata.Expanded Then
		p.Visible = False
		clv.ResizeItem(index, idata.CollapsedHeight)
		Sleep(100)
		p.Visible = True
		AnimatedArrow(180, 0, p)
		idata.Expanded = False
	Else
		p.Visible = False
		clv.ResizeItem(index, idata.ExpandedHeight)
		Sleep(100)
		p.Visible = True
		AnimatedArrow(0, 180, p)
		idata.Expanded = True
	End If
	clv.GetRawListItem(index).Value = idata
End Sub




