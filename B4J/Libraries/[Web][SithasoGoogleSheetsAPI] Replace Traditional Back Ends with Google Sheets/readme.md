### [Web][SithasoGoogleSheetsAPI] Replace Traditional Back Ends with Google Sheets by Mashiane
### 11/13/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/169283/)

Hi Fam  
  
[Documentation](https://sithaso-google-sheets-api-documenta.vercel.app/)  
  
I have always been curious about this and wanted a version I could use with BANano. Finally its here, well, kinda loading…  
  
The ability to use Google Sheets as your back-end. Let's watch..  
  
  
[MEDIA=youtube]wqEW1G7i4U0[/MEDIA]  
  
  
  
**STEP BY STEP SETUP**  
  
Follow these steps to set up your Google Sheet and get the credentials needed to use BANanoGoogleSheetAPI.js:  
  
1. Create a Google Sheet\*\*  
 - Go to [Google Sheets](https://sheets.google.com) and create a new spreadsheet.  
 - Name your sheet (e.g., `Users`).  
  
2. Get Your Spreadsheet ID\*\*  
 - Open your sheet in the browser. The URL will look like:  

```B4X
https://docs.google.com/spreadsheets/d/your-spreadsheet-id/edit#gid=0
```

  
  
 - **Copy the long string after `/d/` and before `/edit` — this is your \*\*spreadsheetId\*\*.**  
  
3. Create a Google Cloud Project\*\*  
 - Go to the [Google Cloud Console](https://console.cloud.google.com/)  
 - Click the project dropdown (top left) and select "New Project". Give it a name and create it.  
  
4. Enable the Google Sheets API\*\*  
 - In your project, go to "APIs & Services > Library".  
 - Search for "Google Sheets API" and click "Enable".  
  
5. Create OAuth2 Credentials\*\*  
 - Go to "APIs & Services > Credentials".  
 - Click "Create Credentials" > "OAuth client ID".  
 - If prompted, configure the consent screen (just fill required fields).  
 - **Authorized Redirect URL should be** [**<https://developers.google.com/oauthplayground>**](https://developers.google.com/oauthplayground)  
 - Choose "Web Application" as the application type.  
 - Download the credentials JSON file. It contains your \*\*client\_id\*\* and \*\*client\_secret\*\*.  
  
6. Get a Refresh Token and Access Token\*\*  
 - Go to [OAuth 2.0 Playground](https://developers.google.com/oauthplayground/) to:  
 - Authorize with your client ID/secret.  
 - Click the gear for OAuth Configuration and enter your client id & client secret and close.  
  
![](https://www.b4x.com/android/forum/attachments/168234)  
  
  
 - Select the scope on the left for 'Select & Authorize API': `<https://www.googleapis.com/auth/spreadsheets>`, click Authorize API. This should ask you to confirm with your account.  
  
![](https://www.b4x.com/android/forum/attachments/168232)  
  
 - Exchange the code for a refresh token and access token.  
  
![](https://www.b4x.com/android/forum/attachments/168233)  
 - Save your \*\*accessToken\*\* and \*\*refreshToken\*\*.  
 - Use a tool like PostMan to check if you can get a token using the refresh token. If so you are good to go, these are the details you will use on the app also.  
  
![](https://www.b4x.com/android/forum/attachments/168265)  
  
  
7. \*\*Share Your Sheet for API Access\*\*  
 - In your Google Sheet, click "Share" and add the email address shown in your OAuth credentials (often ends with `@developer.gserviceaccount.com` or your Google account email).  
 - Give it "Editor" access.  
8. \*\*Use These in BANanoGoogleSheetAPI.js\*\*  
 - Use the `spreadsheetId`, `accessToken` (optional), `refreshToken`, `clientId`, `clientSecret` in your BANanoGoogleSheetAPI config as shown in the usage examples below.  
  
Example Sheet:  
  
![](https://www.b4x.com/android/forum/attachments/168238)  
  
***NB: This b4xlib will not be free due to the great amount of work and time taken to create it, you can send your $25 certificate of appreciation to, <https://paypal.me/anelembanga>  
  
  
Related Content: Share My Creations  
  
<https://www.b4x.com/android/forum/threads/web-sithasogooglesheetsapi-replace-traditional-back-ends-with-google-sheets.169301/>***