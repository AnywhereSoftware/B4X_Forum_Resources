### Selenium Library - Pnd_Selenium by Pendrush
### 06/12/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/145636/)

Selenium automates browsers. That's it!  
What you do with that power is entirely up to you.  
Primarily it is for automating web applications for testing purposes, but is certainly not limited to just that.  
Boring web-based administration tasks can (and should) also be automated as well.  
  
Library can be used in UI and Console (Non-UI) app.  
  
Wrapper is based on Selenium Java v4.33.0 (23. May 2025.) from [HERE](https://www.selenium.dev/downloads/).  
  
  
[SIZE=5]**Some things Selenium can do:**[/SIZE]  

- Most importantly, it "sees" the web page the same way a user does, with CSS, JavaScript, etc.
- Crawl or scrape websites, particularly those that don't provide an API and load content lazily using JavaScript.
- Measure web page elements and determine their locations.
- Simulate geolocation.
- Collect virtually anything imaginable from web pages.
- Inject JavaScript into a page, execute it, and retrieve the result.
- Manipulates cookies: read, add, edit, delete.
- Convert HTML to PDF.
- Take screenshots of the "visible" part or the entire web page.
- Can control web browser by automating user interactions, such as clicks, typing, scrolling, etc.
- It's primarily used for functional and regression testing of web applications, ensuring they behave as expected when users interact with them.
- You can use Selenium to extract information from web pages. It interacts with dynamic web content (JavaScript-heavy sites) better than traditional web scraping methods.
- Can simulate complex user interactions like dragging and dropping, mouse hover, multi-click, or keyboard input (e.g., filling out forms).
- You can fill out forms and submit them automatically, useful for testing forms or bulk form submissions.
- Can interact with browser alerts, pop-ups, and other modal dialogs, accepting, dismissing, or retrieving messages.
- It can interact with dynamic content that changes after page loads using techniques like waits, handling AJAX calls, or waiting for elements to load.
- Can interact with file upload controls, uploading files as part of automated tests, and downloading files to verify download functionality.
- Can run tests on headless browsers (browsers without a graphical user interface), such as Headless Chrome, enabling faster test execution, especially in CI/CD pipelines.
- Allows you to start and stop browser sessions, making it easy to manage the browser lifecycle during test execution.
- And much, much more.

  
> **Pnd\_Selenium  
>   
> Author:** Author: Selenium.dev - B4j Wrapper: Pendrush  
> **Version:** 1.07  
>
> - **Pnd\_Action**
>
> - **Functions:**
>
> - **Click** As org.openqa.selenium.interactions.Actions
> *Clicks at the current mouse location.*- **ClickAndHold** As org.openqa.selenium.interactions.Actions
> *Clicks (without releasing) at the current mouse location.*- **ClickAndHoldWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *Clicks (without releasing) in the middle of the given element.*- **ClickWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *Clicks in the middle of the given element.*- **ContextClick** As org.openqa.selenium.interactions.Actions
> *Performs a context-click at the current mouse location.*- **ContextClickWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *Performs a context-click at middle of the given element.  
>  First performs a mouseMove to the location of the element.*- **DoubleClick** As org.openqa.selenium.interactions.Actions
> *Performs a double-click at the current mouse location.*- **DoubleClickWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *Performs a double-click at middle of the given element.*- **DragAndDrop** (SourceWebElement As org.openqa.selenium.WebElement, TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *A convenience method that performs click-and-hold at the location of the source element, moves to the location of the target element, then releases the mouse.*- **DragAndDropBy** (SourceWebElement As org.openqa.selenium.WebElement, OffsetX As Int, OffsetY As Int) As org.openqa.selenium.interactions.Actions
> *A convenience method that performs click-and-hold at the location of the source element, moves by a given offset, then releases the mouse.*- **Initialize** (WebDriver As org.openqa.selenium.WebDriver)
> *Initialize Action class.  
>  WebDriver - Use Selenium.WebDriver.  
>  Dim Action As Pnd\_Action  
>  Action.Initialize(Selenium.WebDriver)*- **IsInitialized** As Boolean
> - **KeyDown** (Key As CharSequence) As org.openqa.selenium.interactions.Actions
> *Performs a modifier key press. Does not release the modifier key - subsequent interactions may assume it's kept pressed.  
>  Note that the modifier key is never released implicitly, keyUp(theKey) must be called to release the modifier.*- **KeyDownWebElement** (TargetWebElement As org.openqa.selenium.WebElement, Key As CharSequence) As org.openqa.selenium.interactions.Actions
> *Performs a modifier key press after focusing on an element. Does not release the modifier key - subsequent interactions may assume it's kept pressed.  
>  Note that the modifier key is never released implicitly, KeyUpWebElement(theKey) must be called to release the modifier.*- **KeyUp** (Key As CharSequence) As org.openqa.selenium.interactions.Actions
> *Performs a modifier key release.  
>  Releasing a non-depressed modifier key will yield undefined behaviour.*- **KeyUpWebElement** (TargetWebElement As org.openqa.selenium.WebElement, Key As CharSequence) As org.openqa.selenium.interactions.Actions
> *Performs a modifier key release after focusing on an element.*- **MoveByOffset** (OffsetX As Int, OffsetY As Int) As org.openqa.selenium.interactions.Actions
> *Moves the mouse from its current position (or 0,0) by the given offset.  
>  If the final coordinates of the move are outside the viewport (the mouse will end up outside the browser window), an exception is raised.  
>  OffsetX - Horizontal offset. A negative value means moving the mouse left.  
>  OffsetY - Vertical offset. A negative value means moving the mouse up.*- **MoveToLocation** (CoordinateX As Int, CoordinateY As Int) As org.openqa.selenium.interactions.Actions
> *Moves the mouse to provided coordinates on screen regardless of starting position of the mouse.  
>  If the coordinates provided are outside the viewport (the mouse will end up outside the browser window), an exception is raised.  
>  CoordinateX - Positive pixel value along horizontal axis in viewport. Numbers increase going right.  
>  CoordinateY - Positive pixel value along vertical axis in viewport. Numbers increase going down.*- **MoveToWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *Moves the mouse to the middle of the element.  
>  The element is scrolled into view and its location is calculated using getClientRects.*- **MoveToWebElementOffset** (TargetWebElement As org.openqa.selenium.WebElement, OffsetX As Int, OffsetY As Int) As org.openqa.selenium.interactions.Actions
> - **Pause** (PauseInMillis As Long) As org.openqa.selenium.interactions.Actions
> *Performs a pause in milliseconds.*- **Perform**
> *A convenience method for performing the actions.  
>  Need to be called at the end of the Action chain to execute Action.*- **Release** As org.openqa.selenium.interactions.Actions
> *Releases the depressed left mouse button at the current mouse location.*- **ReleaseWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *Releases the depressed left mouse button, in the middle of the given element.*- **ScrollByAmount** (DeltaX As Int, DeltaY As Int) As org.openqa.selenium.interactions.Actions
> *Scrolls by provided amounts with the origin in the top left corner of the viewport.  
>  DeltaX - The distance along X axis to scroll using the wheel. A negative value scrolls left.  
>  DeltaY - The distance along Y axis to scroll using the wheel. A negative value scrolls up.*- **ScrollFromWebElement** (TargetWebElement As org.openqa.selenium.WebElement, DeltaX As Int, DeltaY As Int) As org.openqa.selenium.interactions.Actions
> *Scrolls by provided amount based on a provided origin.  
>  The scroll origin is the center of an element.  
>  If the origin is an element, and the element is not in the viewport, the bottom of the element will first be scrolled to the bottom of the viewport.  
>  DeltaX - The distance along X axis to scroll using the wheel. A negative value scrolls left.  
>  DeltaY - The distance along Y axis to scroll using the wheel. A negative value scrolls up.*- **ScrollToWebElement** (TargetWebElement As org.openqa.selenium.WebElement) As org.openqa.selenium.interactions.Actions
> *If the element is outside the viewport, scrolls the bottom of the element to the bottom of the viewport.*- **SendKeys** (Keys As CharSequence) As org.openqa.selenium.interactions.Actions
> *Sends keys to the active element.  
>  This differs from calling WebElement.sendKeys() on the active element in two ways:  
>  1. The modifier keys included in this call are not released.  
>  2. There is no attempt to re-focus the element - so sendKeys(KeyCodes.TAB) for switching elements should work.*- **SendKeysWebElement** (TargetWebElement As org.openqa.selenium.WebElement, Keys As CharSequence) As org.openqa.selenium.interactions.Actions
> *Sends keys to the TargetWebElement element.  
>  This differs from calling WebElement.sendKeys() on the TargetWebElement element in two ways:  
>  1. The modifier keys included in this call are not released.  
>  2. There is no attempt to re-focus the element - so sendKeys(KeyCodes.TAB) for switching elements should work.*
> - **Pnd\_Cookies**
>
> - **Fields:**
>
> - **Domain** As String
> *The domain the cookie is visible to*- **Expires** As java.util.Date
> *The cookie's expiration date*- **IsHttpOnly** As Boolean
> *Whether this cookie is a httpOnly cookie*- **IsSecure** As Boolean
> *Whether this cookie requires a secure connection*- **Name** As String
> *The name of the cookie*- **Path** As String
> *The path the cookie is visible to.*- **SameSite** As String
> *The samesite attribute of this cookie; None, Lax, Strict*- **Value** As String
> *The cookie value*
> - **Pnd\_KeyCodes**
>
> - **Functions:**
>
> - **ADD** As org.openqa.selenium.Keys
> - **ALT** As org.openqa.selenium.Keys
> - **ARROW\_DOWN** As org.openqa.selenium.Keys
> - **ARROW\_LEFT** As org.openqa.selenium.Keys
> - **ARROW\_RIGHT** As org.openqa.selenium.Keys
> - **ARROW\_UP** As org.openqa.selenium.Keys
> - **BACK\_SPACE** As org.openqa.selenium.Keys
> - **CANCEL** As org.openqa.selenium.Keys
> - **CLEAR** As org.openqa.selenium.Keys
> - **COMMAND** As org.openqa.selenium.Keys
> - **CONTROL** As org.openqa.selenium.Keys
> - **DECIMAL** As org.openqa.selenium.Keys
> - **DELETE** As org.openqa.selenium.Keys
> - **DIVIDE** As org.openqa.selenium.Keys
> - **DOWN** As org.openqa.selenium.Keys
> - **END** As org.openqa.selenium.Keys
> - **ENTER** As org.openqa.selenium.Keys
> - **EQUALS** As org.openqa.selenium.Keys
> - **ESCAPE** As org.openqa.selenium.Keys
> - **F1** As org.openqa.selenium.Keys
> - **F10** As org.openqa.selenium.Keys
> - **F11** As org.openqa.selenium.Keys
> - **F12** As org.openqa.selenium.Keys
> - **F2** As org.openqa.selenium.Keys
> - **F3** As org.openqa.selenium.Keys
> - **F4** As org.openqa.selenium.Keys
> - **F5** As org.openqa.selenium.Keys
> - **F6** As org.openqa.selenium.Keys
> - **F7** As org.openqa.selenium.Keys
> - **F8** As org.openqa.selenium.Keys
> - **F9** As org.openqa.selenium.Keys
> - **HELP** As org.openqa.selenium.Keys
> - **HOME** As org.openqa.selenium.Keys
> - **INSERT** As org.openqa.selenium.Keys
> - **LEFT** As org.openqa.selenium.Keys
> - **LEFT\_ALT** As org.openqa.selenium.Keys
> - **LEFT\_CONTROL** As org.openqa.selenium.Keys
> - **LEFT\_SHIFT** As org.openqa.selenium.Keys
> - **META** As org.openqa.selenium.Keys
> - **MULTIPLY** As org.openqa.selenium.Keys
> - **NULL** As org.openqa.selenium.Keys
> - **NUMPAD0** As org.openqa.selenium.Keys
> - **NUMPAD1** As org.openqa.selenium.Keys
> - **NUMPAD2** As org.openqa.selenium.Keys
> - **NUMPAD3** As org.openqa.selenium.Keys
> - **NUMPAD4** As org.openqa.selenium.Keys
> - **NUMPAD5** As org.openqa.selenium.Keys
> - **NUMPAD6** As org.openqa.selenium.Keys
> - **NUMPAD7** As org.openqa.selenium.Keys
> - **NUMPAD8** As org.openqa.selenium.Keys
> - **NUMPAD9** As org.openqa.selenium.Keys
> - **PAGE\_DOWN** As org.openqa.selenium.Keys
> - **PAGE\_UP** As org.openqa.selenium.Keys
> - **PAUSE** As org.openqa.selenium.Keys
> - **RETURN** As org.openqa.selenium.Keys
> - **RIGHT** As org.openqa.selenium.Keys
> - **SEMICOLON** As org.openqa.selenium.Keys
> - **SEPARATOR** As org.openqa.selenium.Keys
> - **SHIFT** As org.openqa.selenium.Keys
> - **SPACE** As org.openqa.selenium.Keys
> - **SUBTRACT** As org.openqa.selenium.Keys
> - **TAB** As org.openqa.selenium.Keys
> - **UP** As org.openqa.selenium.Keys
> - **ZENKAKU\_HANKAKU** As org.openqa.selenium.Keys
>
> - **Pnd\_LogLevel**
>
> - **Functions:**
>
> - **ALL** As java.util.logging.Level
> *ALL indicates that all messages should be logged.*- **CONFIG** As java.util.logging.Level
> *CONFIG is a message level for static configuration messages.  
>  CONFIG messages are intended to provide a variety of static configuration information, to assist in debugging problems that may be associated with particular configurations.  
>  For example, CONFIG message might include the CPU type, the graphics depth, the GUI look-and-feel, etc.*- **FINE** As java.util.logging.Level
> *FINE is a message level providing tracing information.  
>  All of FINE, FINER, and FINEST are intended for relatively detailed tracing. The exact meaning of the three levels will vary between subsystems, but in general, FINEST should be used for the most voluminous detailed output, FINER for somewhat less detailed output, and FINE for the lowest volume (and most important) messages.  
>  In general the FINE level should be used for information that will be broadly interesting to developers who do not have a specialized interest in the specific subsystem.  
>  FINE messages might include things like minor (recoverable) failures. Issues indicating potential performance problems are also worth logging as FINE.*- **FINER** As java.util.logging.Level
> *FINER indicates a fairly detailed tracing message. By default logging calls for entering, returning, or throwing an exception are traced at this level.*- **FINEST** As java.util.logging.Level
> *FINEST indicates a highly detailed tracing message*- **INFO** As java.util.logging.Level
> *INFO is a message level for informational messages.  
>  Typically INFO messages will be written to the console or its equivalent.  
>  So the INFO level should only be used for reasonably significant messages that will make sense to end users and system administrators.*- **OFF** As java.util.logging.Level
> *OFF is a special level that can be used to turn off logging.*- **SEVERE** As java.util.logging.Level
> *SEVERE is a message level indicating a serious failure.  
>  In general SEVERE messages should describe events that are of considerable importance and which will prevent normal program execution.  
>  They should be reasonably intelligible to end users and to system administrators.*- **WARNING** As java.util.logging.Level
> *WARNING is a message level indicating a potential problem.  
>  In general WARNING messages should describe events that will be of interest to end users or system managers, or which indicate potential problems.*
> - **Pnd\_Select**
>
> - **Functions:**
>
> - **DeselectAll**
> *Clear all selected entries.  
>  This is only valid when the SELECT supports multiple selections.*- **DeselectByContainsVisibleText** (Text As String)
> *Deselect all options that display text matching the argument.  
>  That is, when given "Ba" this would deselect an option like:  
>  option value='foo' Bar option*- **DeselectByIndex** (Index As Int)
> *Deselect the option at the given index.  
>  This is done by examining the "index" attribute of an element, and not merely by counting.*- **DeselectByValue** (Value As String)
> *Deselect all options that have a value matching the argument.  
>  That is, when given "foo" this would deselect an option like:  
>  option value='foo' Bar option*- **DeselectByVisibleText** (Text As String)
> *Deselect all options that display text matching the argument.  
>  That is, when given "Bar" this would deselect an option like:  
>  option value='foo' Bar option*- **GetAllSelectedOptions** As List
> *All selected options belonging to this select tag.  
>  Return: List of WebElemnt*- **GetFirstSelectedOption** As org.openqa.selenium.WebElement
> *The first selected option in this select tag (or the currently selected option in a normal select  
>  Return: WebElement*- **GetOptions** As List
> *All options belonging to this select tag  
>  Return: List of WebElemnt*- **GetWrappedElement** As org.openqa.selenium.WebElement
> *Return: WebElement*- **Initialize** (WebElement As org.openqa.selenium.WebElement)
> - **IsInitialized** As Boolean
> - **IsMultiple** As Boolean
> *Whether this select element support selecting multiple options at the same time?  
>  This is done by checking the value of the "multiple" attribute.*- **SelectByContainsVisibleText** (Text As String)
> *Selects all options that display text matching or containing the provided argument.  
>  This method first attempts to find an exact match and, if not found, will then attempt to find options that contain the specified text as a substring.  
>  For example, when given "Bar", this would select an option like:  
>  option value='foo' Bar option  
>  And also select an option like:  
>  option value='baz' FooBar option or option value='baz' 1년납 option when '1년' is provided.*- **SelectByIndex** (Index As Int)
> *Select the option at the given index.  
>  This is done by examining the "index" attribute of an element, and not merely by counting.*- **SelectByValue** (Value As String)
> *Select all options that have a value matching the argument.  
>  That is, when given 'foo' this would select an option like:  
>  option value='foo' Bar option*- **SelectByVisibleText** (Text As String)
> *Select all options that display text matching the argument.  
>  That is, when given "Bar" this would select an option like:  
>  option value='foo' Bar option*
> - **Pnd\_Selenium**
>
> - **Events:**
>
> - **ConsoleMessage** (Text As String, Value As Object, Method As String, ObjType As String)
> - **JavaScriptError** (ErrorMessage As String, FunctionName As String, JsUrl As String, LineNumber As Int, ColumnNumber As Int, Time As Long)
> - **NavigationFinished**
>
> - **Functions:**
>
> - **AddArgument** (Arguments As String)
> *Arguments – The arguments to use when starting Chrome  
>  Use AddArgument BEFORE Selenium.Initialize method  
> List of possible [Arguments](https://peter.sh/experiments/chromium-command-line-switches/).  
> Another list of possible [Arguments](https://github.com/GoogleChrome/chrome-launcher/blob/main/docs/chrome-flags-for-tools.md).  
>  Selenium.AddArgument("–start-maximized")*- **AddConsoleMessageHandler** As Long
> *Console Message Handlers - Add Handler  
>  Record console.log events.  
>  Return: Handler ID*- **AddCookie** (Name As String, Value As String, Domain As String, Path As String, Expires As Long, IsSecure As Boolean, IsHttpOnly As Boolean, SameSite As String)
> *Add a specific cookie. If the cookie's domain name is left blank, it is assumed that the cookie is meant for the domain of the current document.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#add-cookie) for more details.  
>  Name – The name of the cookie; may not be an empty string.  
>  Value – The cookie value.  
>  Domain – The domain the cookie is visible to.  
>  Path – The path the cookie is visible to. If left blank, will be set to "/".  
>  Expires – The cookie's expiration date.  
>  IsSecure – Whether this cookie requires a secure connection.  
>  IsHttpOnly – Whether this cookie is a httpOnly cookie.  
>  SameSite – The samesite attribute of this cookie; None, Lax, Strict.*- **AddExperimentalOption** (Name As String, Value As Object)
> *Sets an experimental option. Useful for new ChromeDriver options not yet exposed through the ChromiumOptions API.  
>  Use AddExperimentalOption BEFORE Selenium.Initialize method  
>  Name – Name of the experimental option.  
>  Value – Value of the experimental option, which must be convertible to JSON.  
>  Selenium.AddExperimentalOption("useAutomationExtension", False)  
>  Selenium.AddExperimentalOption("excludeSwitches", Array As String("enable-automation"))*- **AddJavaScriptErrorHandler** As Long
> *JavaScript Exception Handlers - Add Handler  
>  Record JavaScript exception events.  
>  Return: Handler ID*- **AlertAccept**
> *Press the OK button in alert dialog.  
>  Alert is not initialized anymore after execution of AlertAccept, you need to execute AlertSwitchTo to initialize alert again.*- **AlertDismiss**
> *Press the Cancel button in alert dialog.  
>  Alert is not initialized anymore after execution of AlertDismiss, you need to execute AlertSwitchTo to initialize alert again.*- **AlertGetText** As String
> *Get alert text*- **AlertSendKeys** (KeysToSend As String)
> *Use this method to simulate typing into input filed in alert dialog.  
>  KeysToSend - string to send to the Alert.*- **AlertSwitchTo** As Boolean
> *AlertSwitchTo switches to the currently active modal dialog and initilize usage of other Alert properties.  
>  Return: True if switch is successful, False if the dialog cannot be found.  
>  Dim SwitchSuccess As Boolean  
>  SwitchSuccess = Selenium.AlertSwitchTo  
>  If SwitchSuccess Then  
>  Dim AlertText As String = Selenium.AlertGetText  
>  Log (AlertText)  
>  Selenium.AlertAccept  
>  End If*- **AllTabs** As List
> *Return: string List of all tabs*- **Close**
> *Close the current window, quitting the browser if it's the last window currently open.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#close-window) for more details.*- **CurrentUrl** As String
> *Get a string representing the current URL that the browser is looking at.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-current-url) for more details.  
>  Return: The URL of the page currently loaded in the browser*- **DeleteAllCookies**
> *Delete all the cookies for the current domain.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#delete-all-cookies) for more details.*- **DeleteCookieNamed** (Name As String)
> *Delete the named cookie from the current domain. This is equivalent to setting the named cookie's expiry date to some time in the past.  
>  Name – the name of the cookie  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#delete-cookie) for more details.*- **ExecuteAsyncScript** (JsScript As String, WebElement As Object) As String
> *Execute an asynchronous piece of JavaScript in the context of the currently selected frame or window.  
>  WebElement - Pass WebElement object or pass "" if you don't use it.  
>  Unlike executing synchronous JavaScript, scripts executed with this method must explicitly signal they are finished by invoking the provided callback.  
>  This callback is always injected into the executed function as the last argument.  
>  The first argument passed to the callback function will be used as the script's result. This value will be CONVERTED to String.  
>  The default timeout for a script to be executed is 0ms.  
>  In most cases you must set the script timeout, use ScriptTimeout(millis) beforehand to a value sufficiently large enough.  
> See [StackOverflow](https://stackoverflow.com/search?q=execute+async+script+in+Selenium) for questions and examples.*- **ExecuteCdpCommand** (CommandName As String, Parameters As Map) As Map
> *Execute a Chrome DevTools Protocol command and get returned result. The command and command args should follow chrome devtools protocol domains/ commands.  
>  It is strongly encouraged to use org. openqa. selenium. devtools. DevTools API instead of this  
>  Specified by: executeCdpCommand in interface HasCdp  
>  Params:  
>  CommandName – The command to execute with Chrome Dev Tools.  
>  Parameters – Any information needed to execute the Dev Tools command.  
>  Return: The name (Key) and value (Value) of the response As Map  
>  Dim Parameters As Map = CreateMap("userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")  
>  Dim CdpCommandMap As Map = Selenium.ExecuteCdpCommand("Network.setUserAgentOverride", Parameters)  
>  Log(CdpCommandMap)*- **ExecuteScript** (JsScript As String, WebElement As Object) As String
> *Executes JavaScript in the context of the currently selected frame or window. The script fragment provided will be executed as the body of an anonymous function.  
>  WebElement - Pass WebElement object or pass "" if you don't use it.  
>  Within the script, use document to refer to the current document. Note that local variables will not be available once the script has finished executing, though global variables will persist.  
>  If the script has a return value (i.e. if the script contains a return statement), then the return value will be CONVERTED to String.*- **FindByClassName** (ClassName As String) As org.openqa.selenium.WebElement
> *Find element within the current page using Class Name.  
>  Return: WebElement*- **FindByClassNameList** (ClassName As String) As List
> *Find all elements within the current page using Class Name.  
>  Return: List of WebElement*- **FindByCssSelector** (CssSelector As String) As org.openqa.selenium.WebElement
> *Find elements via the driver's underlying W3C Selector engine.  
>  If the browser does not implement the Selector API, a best effort is made to emulate the API.  
>  In this case, we strive for at least CSS2 support, but offer no guarantees.  
>  CssSelector – CSS expression.  
>  Return: WebElement*- **FindByCssSelectorList** (CssSelector As String) As List
> *Find elements via the driver's underlying W3C Selector engine.  
>  If the browser does not implement the Selector API, a best effort is made to emulate the API.  
>  In this case, we strive for at least CSS2 support, but offer no guarantees.  
>  Return: List of WebElement*- **FindById** (Id As String) As org.openqa.selenium.WebElement
> *Find element within the current page using ID.  
>  Return:WebElement*- **FindByIdList** (Id As String) As List
> *Find all elements within the current page using ID.  
>  Return: List of WebElement*- **FindByLinkText** (LinkText As String) As org.openqa.selenium.WebElement
> *FindByLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  LinkText – The exact text to match against.  
>  Return: WebElement*- **FindByLinkTextList** (LinkText As String) As List
> *FindByLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  LinkText – The exact text to match against.  
>  Return: List of WebElement*- **FindByName** (Name As String) As org.openqa.selenium.WebElement
> *The value of the "name" attribute to search for.*- **FindByNameList** (Name As String) As List
> *The value of the "name" attribute to search for.  
>  Return: List of WebElement*- **FindByPartialLinkText** (PartialLinkText As String) As org.openqa.selenium.WebElement
> *FindByPartialLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  PartialLinkText – The partial text to match against.  
>  Return: WebElement*- **FindByPartialLinkTextList** (PartialLinkText As String) As List
> *FindByPartialLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  Return: List of WebElement*- **FindByTagName** (TagName As String) As org.openqa.selenium.WebElement
> *TagName – The element's tag name.  
>  Return: WebElement*- **FindByTagNameList** (TagName As String) As List
> *TagName – The element's tag name.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-attribute) for more details.  
>  Return: List of WebElement*- **FindByXpath** (Path As String) As org.openqa.selenium.WebElement
> *Path – The path to use.  
>  Return: WebElement*- **FindByXPathList** (Path As String) As List
> *Path – The path to use.  
>  Return: List of WebElement*- **GetAllCookies** As List
> *Get all the cookies for the current domain.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-all-cookies) for more details.  
>  Return: A list of cookies for the current domain.*- **GetCookieNamed** (Name As String) As Pnd\_Cookies
> *Get a cookie with a given name.  
>  Name – The name of the cookie  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-named-cookie) for more details.  
>  Return: the cookie, or empty cookies if no cookie with the given name is present*- **Initialize** (EventName As String, ChromeDriverPath As String)
> *ChromeDriverPath - Path to Chrome driver  
>  Selenium.Initialize("Selenium", "c:\ChromeDriver\chromedriver.exe")*- **NavigateBack**
> *Move back a single "item" in the browser's history.*- **NavigateForward**
> *Move a single "item" forward in the browser's history.  
>  Does nothing if we are on the latest page viewed.*- **NavigateRefresh**
> *Refresh the current page*- **NavigateTo** (Url As String)
> *Load a new web page in the current browser window.  
>  This is done using an HTTP POST operation, and the method will block until the load is complete with the default 'page load strategy'.  
>  This will follow redirects issued either by the server or as a meta-redirect from within the returned HTML.  
>  Should a meta-redirect "rest" for any duration of time, it is best to wait until this timeout is over,  
>  since should the underlying page change whilst your test is executing the results of future calls against this interface will be against the freshly loaded page.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#navigate-to) for more details.*- **PageSource** As String
> *Get the source of the last loaded page.  
>  If the page has been modified after loading (for example, by Javascript)  
>  there is no guarantee that the returned text is that of the modified page.  
>  Please consult the documentation of the particular driver being used to determine whether the returned text  
>  reflects the current state of the page or the text last sent by the web server.  
>  The page source returned is a representation of the underlying DOM: do not expect it to be formatted or escaped  
>  in the same way as the response sent from the web server. Think of it as an artist's impression.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-page-source) for more details.  
>  Return: The source of the current page.*- **Quit**
> *Quits, closing every associated window.*- **RemoveConsoleMessageHandler** (HandlerId As Long)
> *Console Message Handlers - Remove Handler  
>  You need to store the ID returned when adding the handler to delete it.*- **RemoveJavaScriptErrorHandler** (HandlerId As Long)
> *JavaScript Exception Handlers - Remove Handler  
>  You need to store the ID returned when adding the handler to delete it.*- **SetCapability** (CapabilityName As String, Value As Object)
> *Setting the capability in the browser options will enable the required functionality.  
>  Use SetCapability BEFORE Selenium.Initialize method*- **SwitchToDefaultContent**
> *Selects either the first frame on the page, or the main document when a page contains iframes.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#switch-to-frame) for more details.  
>  This driver focused on the top window / first frame.*- **SwitchToFrame** (NameOrID As String)
> *Select a frame by its Name or ID. Frames located by matching name attributes are always given precedence over those matched by ID.  
>  Params: NameOrID – the name of the frame window, the id of the frame or iframe element, or the (zero-based) index.*- **SwitchToParentFrame**
> *Change focus to the parent context. If the current context is the top level browsing context, the context remains unchanged.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#switch-to-parent-frame) for more details.  
>  This driver focused on the parent frame.*- **SwitchToTab** (Name As String)
> *Switch the focus of future commands for this driver to the window/tab with the given name.*- **TakeScreenshotToFile** (Format As String, Path As String)
> *Capture the screenshot (only visible part of the page) and store it in the specified location.  
>  Format - "png" or "jpg"  
>  Path - "c:\test.jpg"  
>  Selenium.TakeScreenshotToFile("jpg", "c:\test.jpg")*- **Title** As String
> *Get the title of the current page.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-title) for more details.  
>  Return: The title of the current page, with leading and trailing whitespace stripped, or "" if one is not already set*- **WebDriver** As org.openqa.selenium.WebDriver
> *Return: WebDriver*
> - **Properties:**
>
> - **ImplicitlyWait** As Long [write only]
> *Specifies the amount of milliseconds the driver should wait when searching for an element if it is not immediately present.  
>  When searching for a single element, the driver should poll the page until the element has been found, or this timeout expires before throwing a NoSuchElementException.  
>  When searching for multiple elements, the driver should poll the page until at least one element has been found or this timeout has expired.  
>  Increasing the implicit wait timeout should be used judiciously as it will have an adverse effect on test run time, especially when used with slower location strategies like XPath.  
>  If the timeout is negative or greater than 2e16 - 1, an error code with invalid argument will be returned.*- **LogLevel** As java.util.logging.Level [write only]
> *Set the log level specifying which message levels will be logged by this logger.  
>  Message levels lower than this value will be discarded.  
>  OFF can be used to turn off logging.  
>  Use Pnd\_LogLevel class to set level  
>  Dim LogLevel As Pnd\_LogLevel  
>  Selenium.LogLevel = LogLevel.INFO*- **PageLoadTimeout** As Long [write only]
> *Sets the amount of milliseconds to wait for a page load to complete before throwing an error.  
>  If the timeout is negative or greater than 2e16 - 1, an error code with invalid argument will be returned.*- **ScriptTimeout** As Long [write only]
> *Sets the amount of milliseconds to wait for an asynchronous script to finish execution before throwing an error.  
>  If the timeout is negative or greater than 2e16 - 1, an error code with invalid argument will be returned.*
> - **Pnd\_WebElement**
>
> - **Functions:**
>
> - **Clear**
> *If this element is a form entry element, this will reset its value.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#element-clear) for more details.*- **Click**
> *Click this element. If this causes a new page to load, you should discard all references to this element  
>  and any further operations performed on this element will throw a StaleElementReferenceException.  
>  Note that if click() is done by sending a native event (which is the default on most browsers/platforms)  
>  then the method will \_not\_ wait for the next page to load and the caller should verify that themselves.  
>  There are some preconditions for an element to be clicked.  
>  The element must be visible, and it must have a height and width greater than 0.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#element-click) for more details.*- **FindByClassName** (ClassName As String) As org.openqa.selenium.WebElement
> *Find element within the current page using Class Name.  
>  Return: WebElement*- **FindByClassNameList** (ClassName As String) As List
> *Find all elements within the current page using Class Name.  
>  Return: List of WebElement*- **FindByCssSelector** (CssSelector As String) As org.openqa.selenium.WebElement
> *Find elements via the driver's underlying W3C Selector engine.  
>  If the browser does not implement the Selector API, a best effort is made to emulate the API.  
>  In this case, we strive for at least CSS2 support, but offer no guarantees.  
>  CssSelector – CSS expression.  
>  Return: WebElement*- **FindByCssSelectorList** (CssSelector As String) As List
> *Find elements via the driver's underlying W3C Selector engine.  
>  If the browser does not implement the Selector API, a best effort is made to emulate the API.  
>  In this case, we strive for at least CSS2 support, but offer no guarantees.  
>  Return: List of WebElement*- **FindById** (Id As String) As org.openqa.selenium.WebElement
> *Find element within the current page using ID.  
>  Return: WebElement*- **FindByIdList** (Id As String) As List
> *Find all elements within the current page using ID.  
>  Return: List of WebElement*- **FindByLinkText** (LinkText As String) As org.openqa.selenium.WebElement
> *FindByLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  LinkText – The exact text to match against.  
>  Return: WebElement*- **FindByLinkTextList** (LinkText As String) As List
> *FindByLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  LinkText – The exact text to match against.  
>  Return: List of WebElement*- **FindByName** (Name As String) As org.openqa.selenium.WebElement
> *The value of the "name" attribute to search for.  
>  Return: List of WebElement*- **FindByNameList** (Name As String) As List
> *The value of the "name" attribute to search for  
>  Return: List of WebElement*- **FindByPartialLinkText** (PartialLinkText As String) As org.openqa.selenium.WebElement
> *FindByPartialLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  PartialLinkText – The partial text to match against.  
>  Return: WebElement*- **FindByPartialLinkTextList** (PartialLinkText As String) As List
> *FindByPartialLinkText works on the link text as you see it with your eyes on the website (after all CSS is applied), not by the website source code.  
>  Return: List of WebElement*- **FindByTagName** (TagName As String) As org.openqa.selenium.WebElement
> *TagName – The element's tag name.  
>  Return: WebElement*- **FindByTagNameList** (TagName As String) As List
> *TagName – The element's tag name.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-attribute) for more details.  
>  Return: List of WebElement*- **FindByXpath** (Path As String) As org.openqa.selenium.WebElement
> *Path – The path to use.  
>  Return: WebElement*- **FindByXpathList** (Path As String) As List
> *Path – The path to use.  
>  Return: List of WebElement*- **GetAccessibleName** As String
> *Getsa result of a Accessible Name and Description Computation for the Accessible Name of the element.  
> See [W3C WebDriver specification](https://www.w3.org/TR/webdriver/#get-computed-label) for more details.  
>  Return: The accessible name of the element.*- **GetAriaRole** As String
> *Gets result of computing the WAI-ARIA role of element.  
> See [W3C WebDriver specification](https://www.w3.org/TR/webdriver/#get-computed-role) for more details.  
>  Return: The WAI-ARIA role of the element.*- **GetCssValue** (PropertyName As String) As String
> *Get the value of a given CSS property. Color values could be returned as rgba or rgb strings. This depends on whether the browser omits the implicit opacity value or not.  
>  For example if the "background-color" property is set as "green" in the HTML source, the returned value could be "rgba(0, 255, 0, 1)" if implicit opacity value is preserved or "rgb(0, 255, 0)" if it is omitted.  
>  Note that shorthand CSS properties (e. g. background, font, border, border-top, margin, margin-top, padding, padding-top, list-style, outline, pause, cue) are not returned, in accordance with the DOM CSS2 specification - you should directly access the longhand properties (e. g. background-color) to access the desired values.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-css-value) for more details.  
>  PropertyName – the css property name of the element*- **GetDomAttribute** (Name As String) As String
> *Get the value of the given attribute of the element.  
>  This method, unlike getAttribute(String), returns the value of the attribute with the given name but not the property with the same name.  
>  The following are deemed to be "boolean" attributes, and will return either "true" or null:  
>  async, autofocus, autoplay, checked, compact, complete, controls, declare, defaultchecked, defaultselected, defer, disabled, draggable, ended, formnovalidate, hidden, indeterminate, iscontenteditable, ismap, itemscope, loop, multiple, muted, nohref, noresize, noshade, novalidate, nowrap, open, paused, pubdate, readonly, required, reversed, scoped, seamless, seeking, selected, truespeed, willvalidate  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-attribute) for more details.  
>  Name – The name of the property  
>  Return: The attribute's value or empty string if the value is not set.*- **GetDomProperty** (Name As String) As String
> *Get the value of the given property of the element. Will return the current value, even if this has been modified after the page has been loaded.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-property) for more details.  
>  Name – The name of the property  
>  Return: The property's current value or empty string if the value is not set*- **GetLocationX** As Int
> *Where on the page is the left of the rendered element?  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-rect) for more details.  
>  Return: integer, containing the location of the left of the element*- **GetLocationY** As Int
> *Where on the page is the top of the rendered element?  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-rect) for more details.  
>  Return: integer, containing the location of the top of the element*- **GetRect** As String
> *Return: The location and size of the rendered element. (X, Y, Height, Width)  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-rect) for more details.  
>  X = X axis position of the top-left corner of the web element relative to the current browsing context’s document element in CSS pixels.  
>  Y = Y axis position of the top-left corner of the web element relative to the current browsing context’s document element in CSS pixels.  
>  Height = Height of the web element’s bounding rectangle in CSS pixels.  
>  Width = Width of the web element’s bounding rectangle in CSS pixels.  
>  Return: X=xx,Y=yy,Height=hh,Width=ww*- **GetSizeHeight** As Int
> *What is the height of the rendered element?  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-rect) for more details.  
>  Return: The height of the element on the page*- **GetSizeWidth** As Int
> *What is the width of the rendered element?  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-rect) for more details.  
>  Return: The width of the element on the page*- **GetTagName** As String
> *Get the tag name of this element. Not the value of the name attribute: will return "input" for the element .  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-tag-name) for more details.  
>  Return: The tag name of this element.*- **GetText** As String
> *Get the visible (i.e. not hidden by CSS) text of this element, including sub-elements.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#get-element-text) for more details.  
>  Return: The visible text of this element.*- **IsDisplayed** As Boolean
> *Is this element displayed or not? This method avoids the problem of having to parse an element's "style" attribute.*- **IsEnabled** As Boolean
> *Is the element currently enabled or not? This will generally return true for everything but disabled input elements.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#is-element-enabled) for more details.*- **IsInitialized** As Boolean
> - **IsSelected** As Boolean
> *Determine whether this element is selected or not.  
>  This operation only applies to input elements such as checkboxes, options in a select and radio buttons.  
>  For more information on which elements this method supports.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#is-element-selected) for more details.*- **SendKeys** (KeysToSend As CharSequence)
> *Use this method to simulate typing into an element, which may set its value.  
> See [W3C WebDriver specification](https://w3c.github.io/webdriver/#element-send-keys) for more details.  
>  Params: Keys – character sequence to send to the element*- **Submit**
> *If this current element is a form, or an element within a form, then this will be submitted to the remote server.  
>  If this causes the current page to change, then this method will block until the new page is loaded.*

  
**[SIZE=5]Versions:[/SIZE]  
  
v1.05**  

- Update for Selenium Java to v4.31.0

  
**v1.06**  

- Update for Selenium Java to v4.32.0

  
**v1.07**  

- Update for Selenium Java to v4.33.0

  
  
**[SIZE=5]Examples:[/SIZE]**  
  
> [SIZE=4]Sleep(XXXX) is added in example apps just to slow down interaction with browser so you can see whats happening[SIZE=4]. Sleep(XXXX) is not needed for production code.[/SIZE][/SIZE]  
>   
>   
> [SIZE=4]**Selenium01**[/SIZE]  
>
> - [SIZE=4]How to setup Chrome for Testing and Chrome Driver[/SIZE]
> - [SIZE=4]Where to find and how to setup Argument for Chrome[/SIZE]
> - [SIZE=4]Cookies: get, get all, add, edit, delete, delete all[/SIZE]
> - [SIZE=4]ExecuteScript, ExecuteAsyncScript[/SIZE]
> - [SIZE=4]Fill form and submit form[/SIZE]
> - [SIZE=4]General library usage examples[/SIZE]
>
>   
> [SIZE=4]**Selenium02**[/SIZE]  
>
> - [SIZE=4]How to get all links on the page with FindByTagNameList[/SIZE]
> - [SIZE=4]How to get all links on the page with FindByXPathList[/SIZE]
> - [SIZE=4]How to filter links[/SIZE]
> - [SIZE=4]How to get all TD text from all TABLES on all pages[/SIZE]
> - [SIZE=4]How to navigate from page to page without revisiting already visited links[/SIZE]
>
>   
> [SIZE=4]**Selenium03**[/SIZE]  
>
> - [SIZE=4]How to use AddExperimentalOption[/SIZE]
> - [SIZE=4]How to use ExecuteCdpCommand[/SIZE]
> - [SIZE=4]My best try to prevent bot detection on websites[/SIZE]
>
>   
> [SIZE=4]**Selenium04**[/SIZE]  
>
> - [SIZE=4]How to get all response headers with JS[/SIZE]
> - [SIZE=4]How to get all e-mails on the page with FindByXPathList[/SIZE]
>
>   
> [SIZE=4]**Selenium05**[/SIZE]  
>
> - [SIZE=4]How to switch to iframe[/SIZE]
> - [SIZE=4]How to find and click the form button[/SIZE]
> - [SIZE=4]How to get text from Alert dialog[/SIZE]
> - [SIZE=4]How to press OK button inside of the Alert dialog[/SIZE]
>
>   
> [SIZE=4]**Selenium06**[/SIZE]  
>
> - [SIZE=4]How to find all images on the page with FindByXPathList or FindByTagNameList[/SIZE]
> - [SIZE=4]How to find src, class and other attributes for every image on the page[/SIZE]
>
>   
> [SIZE=4]**Selenium07**[/SIZE]  
>
> - [SIZE=4]How to save (print) page to PDF file (Convert HTML to PDF including links)[/SIZE]
> - [SIZE=4]Possible parameters for Page.printToPDF[/SIZE]
>
>   
> [SIZE=4]**Selenium08**[/SIZE]  
>
> - [SIZE=4]How to use ChromeDevtools Protocol (ExecuteCdpCommand) and where to find all possible commands[/SIZE]
> - [SIZE=4]How to take screenshot of the entire page loaded by the browser with ExecuteCdpCommand[/SIZE]
> - [SIZE=4]How to set different geolocation with ExecuteCdpCommand[/SIZE]
>
>   
> [SIZE=4]**Selenium09**[/SIZE]  
>
> - [SIZE=4]How to wait for condition to be met[/SIZE]
> - [SIZE=4]How to create timeout in case condition never met[/SIZE]
>
>   
> [SIZE=4]**Selenium10**[/SIZE]  
>
> - [SIZE=4]How to use Action class[/SIZE]
> - [SIZE=4]Using mouse action: scroll down, click, drag and drop[/SIZE]
>
>   
> [SIZE=4]**Selenium11**[/SIZE]  
>
> - [SIZE=4]How to use Wait For Selenium\_NavigationFinished[/SIZE]
> - [SIZE=4]Same as Selenium10 example, but with Wait For[/SIZE]
>
>   
> [SIZE=4]**Selenium12**[/SIZE]  
>
> - [SIZE=4]How to use Wait For and ResumableSub[/SIZE]
> - [SIZE=4]Same as Selenium10 and Selenium 11 example, but with Wait For and ResumableSub[/SIZE]
>
>   
> [SIZE=4]**Selenium13**[/SIZE]  
>
> - [SIZE=4]Use Selenium library in Console (Non-UI) app[/SIZE]
> - [SIZE=4]How to convert local HTML to PDF[/SIZE]
> - [SIZE=4]How to convert online web page HTML to PDF[/SIZE]
>
>   
> [SIZE=4]**Selenium14**[/SIZE]  
>
> - [SIZE=4]How to handle error: org.openqa.selenium.NoSuchElementException: no such element: Unable to locate element…[/SIZE]
>
>   
> [SIZE=4]**Selenium15**[/SIZE]  
>
> - [SIZE=4]How to compile app in release mode with #MergeLibraries: True[/SIZE]
>
>   
> [SIZE=4]**Selenium16**[/SIZE]  
>
> - [SIZE=4]How to build standalone package[/SIZE]
>
>   
> [SIZE=4]**Selenium17**[/SIZE]  
>
> - [SIZE=4]How to enable BiDirectional functionality[/SIZE]
> - [SIZE=4]How to use .AddJavaScriptErrorHandler and .AddConsoleMessageHandler[/SIZE]
> - [SIZE=4]How to use events \_ConsoleMessage and \_JavaScriptError[/SIZE]
>
>   
> [SIZE=4]**Selenium18**[/SIZE]  
>
> - [SIZE=4]How to use Select class[/SIZE]
> - [SIZE=4]Working with select list elements[/SIZE]

  
  
Download library from: <https://mega.nz/file/UF5XkCQI#uvA_q_ekRwLJVqJI6vTt1PiNgaOfRubjwuUwCKYkmas>  
  
To compile app in release mode with #MergeLibraries: True, please check Selenium15 example.  
To build standalone package, please check Selenium16 example.  
  
When you download Chrome for Testing as well as the Chrome Driver, make sure to extract everything into one folder.  
**chrome.exe** and **chromedriver.exe** should be in same folder.  
For Windows use:  
Chrome For Testing: <https://storage.googleapis.com/chrome-for-testing-public/137.0.7151.70/win64/chrome-win64.zip>  
Chrome Driver: <https://storage.googleapis.com/chrome-for-testing-public/137.0.7151.70/win64/chromedriver-win64.zip>  
   
If you are using other OS download Chrome for Testing and Chrome Driver from: <https://googlechromelabs.github.io/chrome-for-testing/>  
Latest library version is tested with Chrome for Testing and Chrome Driver v137.0.7151.70