B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public MyTheme As ABMTheme	
	Private ABM As ABMaterial 'ignore	
	Public NeedsAuthorization As Boolean = False
	Public AppVersion As String = DateTime.now ' NEW 2.01 this helps to get the latest js/css files when the app is started/restarted
	Public AppPublishedStartURL As String = ""
	Public AppName As String = ""
	
	Public CachedPages As Map
	Public CacheScavengePeriodSeconds As Int = 15*60 ' 15 minutes 
	Public SessionMaxInactiveIntervalSeconds As Int = 30*60 ' 30 minutes '1*60*24 ' one hour ' -1 = immortal but beware! This also means your cache is NEVER emptied!	
End Sub

'----------------------START MODIFICATION 4.00-------------------------------
Public Sub NavigateToPage(ws As WebSocket, PageId As String, TargetUrl As String) 'ignore	
	Dim testTargetUrl As String = TargetUrl
	If Not(testTargetUrl.EndsWith(".htm") Or testTargetUrl.EndsWith(".html") Or testTargetUrl.EndsWith("/")) Then
		TargetUrl = TargetUrl & "/"
	End If
	If PageId.Length > 0 Then ABM.RemoveMeFromCache(CachedPages, PageId)
	If ws.Open Then
		' it doesn't keep navigation history in the browser (the back button exists the application)
		'ws.Eval("window.location.replace(arguments[0])", Array As Object(TargetUrl))
		' if you need browser history just comment the lines above and uncomment the lines below
		' it keeps the navigation history in the browser
		ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))
		ws.Flush
		ws.Close ' ALSO NEW 4.00	
		' note that this error can be ignored anyway
		' if you are bothered by the warning error you get with this close, you can try to replace it with this:
				
		'Sleep(50)
		'If ws.Open Then
		'	Log("closing the websocket, in case the eval does not do it...")
		'	ws.Close ' ALSO NEW 4.00
		'End If
	End If	
End Sub
'----------------------END MODIFICATION 4.00-------------------------------

'----------------------START MODIFICATION 4.00-------------------------------
Public Sub NavigateToPageNewTab(ws As WebSocket, PageId As String, TargetUrl As String, OpenInNewTab As Boolean) 'ignore	
	Dim testTargetUrl As String = TargetUrl
	If Not(testTargetUrl.EndsWith(".htm") Or testTargetUrl.EndsWith(".html") Or testTargetUrl.EndsWith("/")) Then
		TargetUrl = TargetUrl & "/"
	End If
	If PageId.Length > 0 Then ABM.RemoveMeFromCache(CachedPages, PageId)
	If ws.Open Then
		If OpenInNewTab Then
			Dim s As String
			' check if a mobile phone only
'			s = $"var check = false;
'  			(function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
'  			if (check) {
'  				window.location = arguments[0];
'  			} else {
'  				window.open(arguments[0],'_blank');  				
'  			}"$
			
			' check if a mobile phone or a tablet
			s = $"var check = false;
  			(function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
   			if (check) {
  				window.location = arguments[0];
  			} else {
				window.open(arguments[0],'_blank');  				
  			}"$			
			ws.Eval(s, Array As Object(TargetUrl))							
		Else
			ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))			
		End If
		ws.Flush
		ws.Close ' ALSO NEW 4.00
	End If
End Sub


Public Sub NavigateToPageNewTab2(ws As WebSocket, PageId As String, TargetUrl As String, OpenInNewTab As Boolean) 'ignore	
	Dim testTargetUrl As String = TargetUrl
	If Not(testTargetUrl.EndsWith(".htm") Or testTargetUrl.EndsWith(".html") Or testTargetUrl.EndsWith("/")) Then
		TargetUrl = TargetUrl & "/"
	End If
	If PageId.Length > 0 Then ABM.RemoveMeFromCache(CachedPages, PageId)
	If ws.Open Then
		If OpenInNewTab Then
			Dim s As String
			' check if a mobile phone only
'			s = $"var check = false;
'  			(function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
'  			if (check) {
'  				window.location = arguments[0];
'  			} else {
'  				window.open(arguments[0],'_blank');  				
'  			}"$
			
			' check if a mobile phone or a tablet
			s = $"var check = false;
  			(function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
   			if (check) {
  				window.location = arguments[0];
  			} else {
				window.open(arguments[0],'_blank');  				
  			}"$			
			ws.Eval(s, Array As Object(TargetUrl))							
		Else
			ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))			
		End If
'		ws.Flush
'		ws.Close ' ALSO NEW 4.00
	End If
End Sub


'----------------------END MODIFICATION 4.00-------------------------------

Sub RedirectOutput (Dir As String, FileName As String) 'ignore
   #if RELEASE
   Dim out As OutputStream = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs
   Dim ps As JavaObject
   ps.InitializeNewInstance("java.io.PrintStream", Array(out, True, "utf8"))
   Dim jo As JavaObject
   jo.InitializeStatic("java.lang.System")
   jo.RunMethod("setOut", Array(ps))
   jo.RunMethod("setErr", Array(ps))
   #end if
End Sub

Sub LogOff(page As ABMPage) 'ignore
	' do whatever you have to do to log off your user
			
	page.ws.Session.SetAttribute("IsAuthorized", "")				
	NavigateToPage(page.ws, page.GetPageID, "../")	
End Sub

' build methods for ABM objects
Sub BuildTheme(themeName As String)
	MyTheme.Initialize(themeName)
	
	' the page theme
	MyTheme.AddNavigationBarTheme("nav1theme")
	MyTheme.NavigationBar("nav1theme").SideBarBackColor = ABM.COLOR_BLUEGREY
	MyTheme.NavigationBar("nav1theme").SideBarBackgroundColor = ABM.COLOR_BLUEGREY
	MyTheme.NavigationBar("nav1theme").SideBarFontSize = "22px"
	MyTheme.NavigationBar("nav1theme").SideBarBold  = True
	MyTheme.NavigationBar("nav1theme").TopBarBackColor = ABM.COLOR_BLUEGREY
	
End Sub

Sub BuildNavigationBar(page As ABMPage, Title As String, logo As String, ActiveTopReturnName As String, ActiveSideReturnName As String, ActiveSideSubReturnName As String) 	'ignore	
	' we have to make an ABMImage from our logo url
	Dim sbtopimg As ABMImage
	sbtopimg.Initialize(page, "sbtopimg", logo, 1)
	sbtopimg.SetFixedSize(330, 55)	

	page.NavigationBar.Initialize(page, "nav1", ABM.SIDEBAR_MANUAL_HIDEMEDIUMSMALL, Title, True, True, 330, 50, sbtopimg, ABM.COLLAPSE_ACCORDION, "nav1theme")
'	page.NavigationBar.Initialize(page, "nav1", ABM.SIDEBAR_MANUAL_ALWAYSHIDE, Title, True, True, 330, 50, sbtopimg, ABM.COLLAPSE_ACCORDION, "nav1theme")		
		
	page.NavigationBar.TopBarDropDownConstrainWidth = False
	page.NavigationBar.TopBarDropdownHideArrow = True
	page.NavigationBar.ActiveTopReturnName = ActiveTopReturnName
	page.NavigationBar.ActiveSideReturnName = ActiveSideReturnName
	page.NavigationBar.ActiveSideSubReturnName = ActiveSideSubReturnName
	
	' you must add at least ONE dummy item if you want to add items to the topbar	in ConnectNaviagationBar
	page.NavigationBar.AddTopItem("DUMMY", "{NBSP}", "", "", False)
	
	' you must add at least ONE dummy item if you want to add items to the sidebar	
	page.NavigationBar.AddSideBarItem("DUMMY", "{NBSP}", "", "")
		
End Sub

Sub ConnectNavigationBar(page As ABMPage) 'ignore	
	' Clear the dummies we created in BuildNavigationBar
	page.NavigationBar.Clear
	

	
	page.NavigationBar.AddSideBarItem("menu_page1", "Page 1", "", "../home/")
	page.NavigationBar.AddSideBarItem("menu_page2", "Page 2", "", "../Page2/")
	page.NavigationBar.AddSideBarItem("menu_page3", "Page List", "", "../Page3/")
	page.NavigationBar.AddSideBarItem("menu_page4", "Page Table", "", "../Page4/")
	page.NavigationBar.AddSideBarItem("menu_page5", "Page Datetime", "", "../Page5/")
	page.NavigationBar.AddSideBarItem("menu_page6", "Page Tabs", "", "../Page6/")
	page.NavigationBar.AddSideBarItem("menu_page7", "Page Upload", "", "../Page7/")
	page.NavigationBar.AddSideBarItem("menu_page8", "Images", "", "../Page8/")

	'page.NavigationBar.AddSideBarItem("ret3", "Page 3", "", "../Page3")
	
	'page.NavigationBar.AddTopItemWithSideBar("sidebar", "sidebar", "", "", ABM.VISIBILITY_ALL, sb)
	' add your navigationbar items
	
	page.NavigationBar.AddTopItem("menu","Page list", "", "",True)
	page.NavigationBar.AddTopSubItem("menu", "menu_page1", "Home", "","../home")
	page.NavigationBar.AddTopSubItem("menu", "menu_page2", "Page 2", "","../Page2")
	
	page.NavigationBar.AddTopItem("exit", "","mdi-action-exit-to-app","",True)
		
	page.NavigationBar.Refresh ' IMPORTANT	
	
	'myMenu.Open
End Sub

public Sub BuildParagraph(page As ABMPage, id As String, Text As String) As ABMLabel 'ignore
	Dim lbl As ABMLabel	
	lbl.Initialize(page, id, Text , ABM.SIZE_PARAGRAPH, False, "")
	Return lbl
End Sub

Sub Mid(Text As String, Start As Int, Length As Int) As String 'ignore
	Return Text.SubString2(Start-1,Start+Length-1)
End Sub

Sub Mid2(Text As String, Start As Int) As String 'ignore
	Return Text.SubString(Start-1)
End Sub

Sub ReplaceAll(Text As String, Pattern As String, Replacement As String) As String 'ignore
	Dim jo As JavaObject = Regex.Matcher(Pattern, Text)
	Return jo.RunMethod("replaceAll", Array(Replacement))
End Sub




