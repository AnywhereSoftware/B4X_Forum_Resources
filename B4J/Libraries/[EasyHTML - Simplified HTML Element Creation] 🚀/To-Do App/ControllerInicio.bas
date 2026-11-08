B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private Page As PageBuilderHTML
	
	Private Container As EasyHTML
	Private Btn1 As EasyHTML
	Private Input1 As EasyHTML
	Private Div1 As EasyHTML
	Private H1 As EasyHTML
	Private DivTasks As EasyHTML
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	
	Container.Initialize("main").AddClass("container")
	
	Div1.Initialize("div")
	
	H1.Initialize("h1").AddElement("To-Do App")
	
	Input1.Initialize("input").AddId("task").AddAttribute("name", "task").AddAttribute("placeholder", "Type here...")
	
	Btn1.Initialize("button").AddId("btn1").AddElement("Add task").HX_Target("#divTasks") _
	.HX_Include("[name='task'], [name='task2']").HX_POST("/add").AddAttribute("hx-encoding", "application/json") _
	
	DivTasks.Initialize("div").AddId("divTasks").HX_Target("this").HX_GET("/get").HX_Trigger("load").HX_Swap("innerHTML")
	
	Div1.AddElement(H1.Mount)
	Div1.AddElement(Input1.Mount)
	Div1.AddElement(Btn1.Mount)
	Div1.AddElement(DivTasks.Mount)
	
	Container.AddElement(Div1.Mount)
	
	Page.Initialize
	Page.SetPathHTMLX("/js/htmlx.min.js")
	Page.AddStyle("https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css")
	Page.AddElement(Container.Mount)
	
	resp.Write(Page.Mount)
	
End Sub