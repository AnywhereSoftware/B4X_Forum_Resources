###  [B4XLIB] B4X Purchase Manager — In-App Purchases & Subscriptions Made Simple by Segga
### 06/27/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171392/)

Like many devs, I kept running into the same problem — monetizing my apps often felt like it took longer than building them.  
  
I had a PHP setup for iOS validation that worked, but every new app meant more servers, databases, hosting costs, ongoing maintenance, and rebuilding purchase flows and subscription screens. For Android, I didn't even have a server-side validation option — I just had to trust the billing library response client-side, with no way to detect refunds or verify anything independently.  
  
So I decided to tackle it properly and built my own monetization system.  
  
I figured others in the B4X community were probably hitting the same walls, so what started as a simple solution for my own apps turned into months of building both the B4X library and the backend infrastructure behind it — into a service any B4X developer can use.  
  
Register your app, grab your API key, add the b4xlib, and you're ready to go in just a few lines of code:  
  

```B4X
' Initialize with your App ID and API key from the dashboard  
PurchaseManager.Initialize(Root, BILLING_KEY, APP_ID, API_KEY)  
  
' Add your products  
PurchaseManager.AddProduct("premium", "Premium", "Unlock all features")  
  
' Show the purchase screen — that's it  
Wait For (PurchaseManager.ShowInAppPurchase) Complete (Success As Boolean)
```

  
  
Check status anytime — instant, from local cache:  
  

```B4X
If PurchaseManager.IsUnlocked Then …  
  
' Or trigger a live validation at any time  
Wait For (PurchaseManager.ValidateNow) Complete (Success As Boolean)
```

  
  
![](https://www.b4x.com/android/forum/attachments/172052)![](https://www.b4x.com/android/forum/attachments/172053)![](https://www.b4x.com/android/forum/attachments/172054)  
  
**Key Features**  
• Built-in purchase and subscription screens (dark mode, theming, feature cards)  
• Server-side validation — receipts verified directly with Apple and Google  
• Zero secrets in your app — credentials stored securely server-side  
• Smart caching — status checks are instant from local cache, background re-validation only when needed  
• Restore purchases flow for both platforms  
• Consumable product support  
• Auto-generated privacy policy and terms of service (or supply your own URL/HTML)  
• Subscription screens include Apple-required disclosures (auto-renewal terms, ToS/Privacy links) — App Store ready out of the box  
• Non-purchasing users generate zero API calls  
  
**How It Works**  
1. Create an account at b4xpurchasemanager.com and register your app  
2. Upload your store credentials (Apple Shared Secret / Google Play service account)  
3. Grab your API key from the dashboard  
4. Add the b4xlib to your project and initialize  
5. The library handles everything — purchase UI, store interaction, receipt validation, caching, and status management  
  
Your app talks to the BPM validation server over HTTPS. The server verifies receipts directly with Apple/Google and returns the result. No secrets in your app, no server to maintain.  
  
**Setup**  
1. Copy **B4XPurchaseManager.b4xlib** to your **B4X Additional Libraries folder**  
2. **iOS:** Your provisioning profile must be based on an **explicit App ID** (e.g., com.yourcompany.yourapp) — wildcard profiles (com.\*) will not compile  
3. **Android:** Add the following to your **manifest:**  

```B4X
CreateResourceFromFile(Macro, GooglePlayBilling.GooglePlayBilling)
```

  
  
Add your constants to Class\_Globals:  

```B4X
Private Const BILLING_KEY As String = "MIIBIjANBgkq…"  ' Your Google Play license key (ignored on iOS)  
Private Const APP_ID As String = "my-app"              ' Your BPM dashboard app identifier  
Private Const API_KEY As String = "bpm_your_key_here"  ' Your BPM API key
```

  
  
In-App Purchase Example (One-Time Unlock)  

```B4X
Private PurchaseManager As B4XPurchaseManager  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
     
    PurchaseManager.Initialize(Root, BILLING_KEY, APP_ID, API_KEY)  
    PurchaseManager.DisplayAppName = "My App"  
    PurchaseManager.AddFeature("🎨", "Premium Themes", "Access all premium themes")  
    PurchaseManager.AddFeature("🚀", "Advanced Features", "Unlock powerful tools")  
    PurchaseManager.AddProduct("premium_unlock", "Premium", "Unlock all features")  
End Sub  
  
Private Sub btnPurchase_Click  
    Wait For (PurchaseManager.ShowInAppPurchase) Complete (Success As Boolean)  
    If Success Then xui.MsgboxAsync("Purchase successful!", "Success")  
End Sub  
  
Private Sub btnRestore_Click  
    Wait For (PurchaseManager.RestorePurchases) Complete (Success As Boolean)  
End Sub  
  
Private Sub B4XPage_Appear  
    PurchaseManager.CheckStatus  
    If PurchaseManager.IsUnlocked Then  
        ' Show premium features  
    End If  
End Sub  
  
Sub B4XPage_CloseRequest As ResumableSub  
    If PurchaseManager.IsActive Then  
        PurchaseManager.HidePurchaseScreen  
        Return False  
    End If  
    Return True  
End Sub
```

  
  
Subscription Example (Monthly + Yearly)  

```B4X
Private PurchaseManager As B4XPurchaseManager  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
     
    PurchaseManager.Initialize(Root, BILLING_KEY, APP_ID, API_KEY)  
    PurchaseManager.DisplayAppName = "My App"  
    PurchaseManager.AddFeature("⭐", "Premium Access", "Full access to all features")  
    PurchaseManager.AddFeature("🔄", "Cross-Platform", "Works on Android and iOS")  
     
    ' Required for subscriptions  
    PurchaseManager.PolicyCompanyName = "Your Company"  
    PurchaseManager.PolicyEmailAddress = "support@yourcompany.com"  
    PurchaseManager.PolicyEffectiveDate = "January 1, 2025"  
     
    ' BasePlanId must match Google Play Console (ignored on iOS)  
    PurchaseManager.AddSubscription("premium_monthly", "monthly-plan", _  
        "Monthly Premium", "Full access, billed monthly", "Monthly")  
    PurchaseManager.AddSubscription("premium_yearly", "yearly-plan", _  
        "Yearly Premium", "Full access, billed yearly — save 40%", "Yearly")  
End Sub  
  
Private Sub btnSubscribe_Click  
    Wait For (PurchaseManager.ShowSubscriptionPurchase) Complete (Success As Boolean)  
    If Success Then xui.MsgboxAsync("Subscription activated!", "Success")  
End Sub  
  
Private Sub btnRestore_Click  
    Wait For (PurchaseManager.RestoreSubscriptions) Complete (Success As Boolean)  
End Sub  
  
Private Sub B4XPage_Appear  
    PurchaseManager.CheckStatus  
    If PurchaseManager.IsSubscriptionActive Then  
        ' Show premium features  
    End If  
End Sub  
  
Sub B4XPage_CloseRequest As ResumableSub  
    If PurchaseManager.IsActive Then  
        PurchaseManager.HidePurchaseScreen  
        Return False  
    End If  
    Return True  
End Sub
```

  
  
Additional Features  

```B4X
' ── Direct Purchase (use your own UI instead of built-in screens) ──  
Wait For (PurchaseManager.PurchaseProduct("premium_unlock")) Complete (Success As Boolean)  
Wait For (PurchaseManager.PurchaseSubscription("premium_monthly", "monthly-plan")) Complete (Success As Boolean)  
  
' ── Theming ──  
PurchaseManager.DarkMode = True  
PurchaseManager.SetThemeColors(0xFF6366F1, 0xFF8B5CF6, 0xFFEC4899, 0xFFFFFFFF, 0xFFF5F5F7)  
  
' ── Consumables ──  
PurchaseManager.AddConsumableProduct("power_boost", "Power Boost", "Boost your power", 10)  
If PurchaseManager.UseConsumables(1) Then Log("Consumed 1 item")  
Dim count As Int = PurchaseManager.GetConsumableCount  
  
' ── Debug & Testing ──  
PurchaseManager.DebugValidation = True  ' Faster cache intervals for development  
Wait For (PurchaseManager.ResetPurchaseForTesting("premium_unlock")) Complete (Success As Boolean)  
Wait For (PurchaseManager.ResetSubscriptionForTesting("premium_monthly")) Complete (Success As Boolean)  
  
' ── Privacy Policy & Terms Export (debug only) ──  
PurchaseManager.ExportPrivacyPolicyInapp       ' Logs full HTML to IDE log  
PurchaseManager.ExportPrivacyPolicySubscription  
PurchaseManager.ExportTermsOfService  
' Right-click HTML line in IDE log → Copy Line → paste into editor or LLM  
  
' ── Custom Privacy Policy & Terms ──  
PurchaseManager.CustomPrivacyPolicyInapp = "https://myapp.com/privacy.html"  ' URL or HTML  
PurchaseManager.CustomTermsOfService = "https://myapp.com/terms.html"
```

  
  
**Caching & Validation**  
The library uses smart caching so status checks are always instant. In-app purchases and subscriptions are cached independently — only the type whose cache has expired gets re-validated:  
  
• New in-app purchases (first 14 days / refund window): re-validated every 24 hours  
• Established in-app purchases (after 14 days): re-validated every 14 days (~2 credits/month)  
• Active subscriptions: re-validated every 24 hours (~30 credits/month)  
• Expired subscriptions: go dormant after 7-day grace period (zero cost)  
• Refunded purchases: go dormant immediately (zero cost)  
• Users who never purchased: zero API calls, zero credits consumed  
  
CheckStatus reads from local cache instantly. Background validation only triggers when cache expires. Blended average: ~15 validations per paying user per month.  
  
**Pricing**  
1 credit = 1 validation. Free tier: 500 credits/month (no credit card required). Paid tiers start at $5/month.  
You only pay for active paying users — non-purchasers, expired subs, and refunded users all cost zero.  
  
*Validation typically costs less than 1% of what your paying users generate in revenue.*  
  
  
**METHODS REFERENCE:**  
[TABLE]  
[TR]  
[TH]Method[/TH]  
[TH]Returns[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]Initialize(Parent, BillingKey, AppId, ApiKey)[/TD]  
[TD]—[/TD]  
[TD]Initialize the library.  
Pass Root for Parent.  
Pass "" for BillingKey on iOS.  
AppId is your BPM dashboard app identifier.  
ApiKey is required (starts with "bpm\_").[/TD]  
[/TR]  
[TR]  
[TD]IsInitialized[/TD]  
[TD]Boolean[/TD]  
[TD]True if Initialize has been called successfully[/TD]  
[/TR]  
[TR]  
[TD]AddProduct(ProductId, Title, Description)[/TD]  
[TD]—[/TD]  
[TD]Add a non-consumable product[/TD]  
[/TR]  
[TR]  
[TD]AddConsumableProduct(ProductId, Title, Description, Quantity)[/TD]  
[TD]—[/TD]  
[TD]Add a consumable product. Quantity defines how many consumables are automatically awarded per purchase.[/TD]  
[/TR]  
[TR]  
[TD]ClearProducts[/TD]  
[TD]—[/TD]  
[TD]Remove all configured products[/TD]  
[/TR]  
[TR]  
[TD]AddSubscription(ProductId, BasePlanId, Title, Description, Period)[/TD]  
[TD]—[/TD]  
[TD]Add a subscription[/TD]  
[/TR]  
[TR]  
[TD]ClearSubscriptions[/TD]  
[TD]—[/TD]  
[TD]Remove all configured subscriptions[/TD]  
[/TR]  
[TR]  
[TD]ShowInAppPurchase[/TD]  
[TD]Boolean[/TD]  
[TD]Show purchase screen. True = success[/TD]  
[/TR]  
[TR]  
[TD]ShowSubscriptionPurchase[/TD]  
[TD]Boolean[/TD]  
[TD]Show subscription screen. True = success[/TD]  
[/TR]  
[TR]  
[TD]PurchaseProduct(ProductId)[/TD]  
[TD]Boolean[/TD]  
[TD]Purchase directly without built-in screen[/TD]  
[/TR]  
[TR]  
[TD]PurchaseSubscription(ProductId, BasePlanId)[/TD]  
[TD]Boolean[/TD]  
[TD]Subscribe directly without built-in screen[/TD]  
[/TR]  
[TR]  
[TD]RestorePurchases[/TD]  
[TD]Boolean[/TD]  
[TD]Restore in-app purchases from store[/TD]  
[/TR]  
[TR]  
[TD]RestoreSubscriptions[/TD]  
[TD]Boolean[/TD]  
[TD]Restore subscriptions from store[/TD]  
[/TR]  
[TR]  
[TD]CheckStatus[/TD]  
[TD]—[/TD]  
[TD]Load cached status, trigger background validation if expired[/TD]  
[/TR]  
[TR]  
[TD]ValidateNow[/TD]  
[TD]Boolean[/TD]  
[TD]Force immediate live validation (costs 1 credit per configured type)[/TD]  
[/TR]  
[TR]  
[TD]IsUnlocked[/TD]  
[TD]Boolean[/TD]  
[TD]True if user owns a non-consumable product[/TD]  
[/TR]  
[TR]  
[TD]IsSubscriptionActive[/TD]  
[TD]Boolean[/TD]  
[TD]True if user has valid subscription[/TD]  
[/TR]  
[TR]  
[TD]GetActiveSubscriptionId[/TD]  
[TD]String[/TD]  
[TD]Active subscription product ID, or "" if none[/TD]  
[/TR]  
[TR]  
[TD]GetSubscriptionExpiryDate[/TD]  
[TD]Long[/TD]  
[TD]Subscription expiry date in ticks, or 0 if not available[/TD]  
[/TR]  
[TR]  
[TD]IsActive[/TD]  
[TD]Boolean[/TD]  
[TD]True if purchase/subscription screen is showing[/TD]  
[/TR]  
[TR]  
[TD]ValidationInProgress[/TD]  
[TD]Boolean[/TD]  
[TD]True if live backend validation is currently running[/TD]  
[/TR]  
[TR]  
[TD]HidePurchaseScreen[/TD]  
[TD]—[/TD]  
[TD]Close any active purchase/subscription screen[/TD]  
[/TR]  
[TR]  
[TD]AddConsumables(Count)[/TD]  
[TD]—[/TD]  
[TD]Manually add consumables (for custom UI purchases, ad rewards, referral bonuses, etc.)[/TD]  
[/TR]  
[TR]  
[TD]UseConsumables(Count)[/TD]  
[TD]Boolean[/TD]  
[TD]Deduct consumables. True if enough available[/TD]  
[/TR]  
[TR]  
[TD]GetConsumableCount[/TD]  
[TD]Int[/TD]  
[TD]Current consumable count[/TD]  
[/TR]  
[TR]  
[TD]SetConsumableCount(Count)[/TD]  
[TD]—[/TD]  
[TD]Set count directly (for server sync)[/TD]  
[/TR]  
[TR]  
[TD]SetThemeColors(Primary, Secondary, Accent, Bg1, Bg2)[/TD]  
[TD]—[/TD]  
[TD]Set theme colors. Pass 0 for defaults[/TD]  
[/TR]  
[TR]  
[TD]AddFeature(Emoji, Title, Description)[/TD]  
[TD]—[/TD]  
[TD]Add feature card to purchase screens[/TD]  
[/TR]  
[TR]  
[TD]ClearFeatures[/TD]  
[TD]—[/TD]  
[TD]Remove all feature cards[/TD]  
[/TR]  
[TR]  
[TD]ShowPrivacyPolicy[/TD]  
[TD]—[/TD]  
[TD]Show privacy policy overlay[/TD]  
[/TR]  
[TR]  
[TD]ShowTermsOfService[/TD]  
[TD]—[/TD]  
[TD]Show terms of service overlay[/TD]  
[/TR]  
[TR]  
[TD]ExportPrivacyPolicyInapp[/TD]  
[TD]Boolean[/TD]  
[TD]Export in-app privacy policy HTML to IDE log. Debug only.[/TD]  
[/TR]  
[TR]  
[TD]ExportPrivacyPolicySubscription[/TD]  
[TD]Boolean[/TD]  
[TD]Export subscription privacy policy HTML to IDE log. Debug only.[/TD]  
[/TR]  
[TR]  
[TD]ExportTermsOfService[/TD]  
[TD]Boolean[/TD]  
[TD]Export terms of service HTML to IDE log. Debug only.[/TD]  
[/TR]  
[TR]  
[TD]ResetPurchaseForTesting(ProductId)[/TD]  
[TD]Boolean[/TD]  
[TD]Reset a purchase for re-testing. Android: consumes token. iOS: clears cache.[/TD]  
[/TR]  
[TR]  
[TD]ResetSubscriptionForTesting(ProductId)[/TD]  
[TD]Boolean[/TD]  
[TD]Reset a subscription for re-testing.[/TD]  
[/TR]  
[/TABLE]  
  
**PROPERTIES REFERENCE:**  
[TABLE]  
[TR]  
[TH]Property[/TH]  
[TH]Type[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]DisplayAppName[/TD]  
[TD]String[/TD]  
[TD]App name on purchase screens (default: your app's name)[/TD]  
[/TR]  
[TR]  
[TD]DisplayTagline[/TD]  
[TD]String[/TD]  
[TD]Tagline below app name (default: "Unlock the Full Experience")[/TD]  
[/TR]  
[TR]  
[TD]DarkMode[/TD]  
[TD]Boolean[/TD]  
[TD]Dark theme (default: False)[/TD]  
[/TR]  
[TR]  
[TD]PolicyCompanyName[/TD]  
[TD]String[/TD]  
[TD]Company name for legal templates[/TD]  
[/TR]  
[TR]  
[TD]PolicyEmailAddress[/TD]  
[TD]String[/TD]  
[TD]Contact email for legal templates[/TD]  
[/TR]  
[TR]  
[TD]PolicyEffectiveDate[/TD]  
[TD]String[/TD]  
[TD]Effective date for legal documents[/TD]  
[/TR]  
[TR]  
[TD]CustomPrivacyPolicyInapp[/TD]  
[TD]String[/TD]  
[TD]Custom privacy policy — URL or HTML[/TD]  
[/TR]  
[TR]  
[TD]CustomPrivacyPolicySubscription[/TD]  
[TD]String[/TD]  
[TD]Custom subscription privacy policy — URL or HTML[/TD]  
[/TR]  
[TR]  
[TD]CustomTermsOfService[/TD]  
[TD]String[/TD]  
[TD]Custom terms — URL or HTML[/TD]  
[/TR]  
[TR]  
[TD]DebugValidation[/TD]  
[TD]Boolean[/TD]  
[TD]Faster revalidation intervals for testing (default: False)[/TD]  
[/TR]  
[/TABLE]  
  
Links  
• Website & Docs: <https://b4xpurchasemanager.com>  
• Dashboard: <https://app.b4xpurchasemanager.com>  
  
Step-by-step guides for Android setup, iOS setup, Google Play service account, Apple Shared Secret, and more are available on the website — along with a detailed FAQ.