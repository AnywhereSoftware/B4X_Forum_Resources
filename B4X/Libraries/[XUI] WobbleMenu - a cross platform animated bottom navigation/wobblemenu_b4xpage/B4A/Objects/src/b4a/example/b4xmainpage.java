package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class b4xmainpage extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new anywheresoftware.b4a.ShellBA(_ba, this, htSubs, "b4a.example.b4xmainpage");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.b4xmainpage.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _root = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public de.amberhome.viewpager.AHViewPager _ahviewpager1 = null;
public b4a.example.wobblemenu _wobblemenu1 = null;
public de.amberhome.viewpager.AHPageContainer _pagecont = null;
public b4a.example.main _main = null;
public b4a.example.starter _starter = null;
public b4a.example.b4xpages _b4xpages = null;
public b4a.example.b4xcollections _b4xcollections = null;
public String  _b4xpage_created(b4a.example.b4xmainpage __ref,anywheresoftware.b4a.objects.B4XViewWrapper _root1) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "b4xpage_created", false))
	 {return ((String) Debug.delegate(ba, "b4xpage_created", new Object[] {_root1}));}
int _i = 0;
anywheresoftware.b4a.objects.PanelWrapper _p = null;
anywheresoftware.b4a.objects.LabelWrapper _l = null;
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Root = Root1";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = _root1;
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="Root.LoadLayout(\"MainPage\")";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("MainPage",ba);
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="WobbleMenu1.SetTabTextIcon(1,\"Page 1\", Chr(0xE3D0";
__ref._wobblemenu1 /*b4a.example.wobblemenu*/ ._settabtexticon /*String*/ (null,(int) (1),"Page 1",BA.ObjectToString(__c.Chr((int) (0xe3d0))),(anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.getMATERIALICONS())));
RDebugUtils.currentLine=720901;
 //BA.debugLineNum = 720901;BA.debugLine="WobbleMenu1.SetTabTextIcon(2,\"Page 2\", Chr(0xE3D1";
__ref._wobblemenu1 /*b4a.example.wobblemenu*/ ._settabtexticon /*String*/ (null,(int) (2),"Page 2",BA.ObjectToString(__c.Chr((int) (0xe3d1))),(anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.getMATERIALICONS())));
RDebugUtils.currentLine=720902;
 //BA.debugLineNum = 720902;BA.debugLine="WobbleMenu1.SetTabTextIcon(3,\"Page 3\", Chr(0xE3D2";
__ref._wobblemenu1 /*b4a.example.wobblemenu*/ ._settabtexticon /*String*/ (null,(int) (3),"Page 3",BA.ObjectToString(__c.Chr((int) (0xe3d2))),(anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.getMATERIALICONS())));
RDebugUtils.currentLine=720903;
 //BA.debugLineNum = 720903;BA.debugLine="WobbleMenu1.SetTabTextIcon(4,\"Page 4\", Chr(0xE3D4";
__ref._wobblemenu1 /*b4a.example.wobblemenu*/ ._settabtexticon /*String*/ (null,(int) (4),"Page 4",BA.ObjectToString(__c.Chr((int) (0xe3d4))),(anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.getMATERIALICONS())));
RDebugUtils.currentLine=720904;
 //BA.debugLineNum = 720904;BA.debugLine="WobbleMenu1.SetTabTextIcon(5,\"Page 5\", Chr(0xE3D5";
__ref._wobblemenu1 /*b4a.example.wobblemenu*/ ._settabtexticon /*String*/ (null,(int) (5),"Page 5",BA.ObjectToString(__c.Chr((int) (0xe3d5))),(anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.getMATERIALICONS())));
RDebugUtils.currentLine=720906;
 //BA.debugLineNum = 720906;BA.debugLine="For i=0 To 4";
{
final int step8 = 1;
final int limit8 = (int) (4);
_i = (int) (0) ;
for (;_i <= limit8 ;_i = _i + step8 ) {
RDebugUtils.currentLine=720907;
 //BA.debugLineNum = 720907;BA.debugLine="Dim p As Panel = xui.CreatePanel(\"\")";
_p = new anywheresoftware.b4a.objects.PanelWrapper();
_p = (anywheresoftware.b4a.objects.PanelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.PanelWrapper(), (android.view.ViewGroup)(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"").getObject()));
RDebugUtils.currentLine=720908;
 //BA.debugLineNum = 720908;BA.debugLine="p.SetLayout(0,0,AHViewPager1.Width,AHViewPager1.";
_p.SetLayout((int) (0),(int) (0),__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .getWidth(),__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .getHeight());
RDebugUtils.currentLine=720914;
 //BA.debugLineNum = 720914;BA.debugLine="p.Color = Colors.LightGray";
_p.setColor(__c.Colors.LightGray);
RDebugUtils.currentLine=720915;
 //BA.debugLineNum = 720915;BA.debugLine="Dim l As Label";
_l = new anywheresoftware.b4a.objects.LabelWrapper();
RDebugUtils.currentLine=720916;
 //BA.debugLineNum = 720916;BA.debugLine="l.Initialize(\"\")";
_l.Initialize(ba,"");
RDebugUtils.currentLine=720917;
 //BA.debugLineNum = 720917;BA.debugLine="l.Text = \"Page \"&(i+1)";
_l.setText(BA.ObjectToCharSequence("Page "+BA.NumberToString((_i+1))));
RDebugUtils.currentLine=720918;
 //BA.debugLineNum = 720918;BA.debugLine="l.Gravity = Gravity.CENTER";
_l.setGravity(__c.Gravity.CENTER);
RDebugUtils.currentLine=720919;
 //BA.debugLineNum = 720919;BA.debugLine="l.TextColor = Colors.Black";
_l.setTextColor(__c.Colors.Black);
RDebugUtils.currentLine=720920;
 //BA.debugLineNum = 720920;BA.debugLine="l.TextSize = 40";
_l.setTextSize((float) (40));
RDebugUtils.currentLine=720921;
 //BA.debugLineNum = 720921;BA.debugLine="p.AddView(l,0,0,AHViewPager1.Width,AHViewPager1.";
_p.AddView((android.view.View)(_l.getObject()),(int) (0),(int) (0),__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .getWidth(),__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .getHeight());
RDebugUtils.currentLine=720923;
 //BA.debugLineNum = 720923;BA.debugLine="pagecont.AddPage(p,\"\")";
__ref._pagecont /*de.amberhome.viewpager.AHPageContainer*/ .AddPage((android.view.View)(_p.getObject()),"");
 }
};
RDebugUtils.currentLine=720926;
 //BA.debugLineNum = 720926;BA.debugLine="AHViewPager1.PageContainer = pagecont";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .setPageContainer(__ref._pagecont /*de.amberhome.viewpager.AHPageContainer*/ );
RDebugUtils.currentLine=720927;
 //BA.debugLineNum = 720927;BA.debugLine="AHViewPager1.CurrentPage = 2";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .setCurrentPage((int) (2));
RDebugUtils.currentLine=720928;
 //BA.debugLineNum = 720928;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4a.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Private Root As B4XView";
_root = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=589827;
 //BA.debugLineNum = 589827;BA.debugLine="Private AHViewPager1 As AHViewPager";
_ahviewpager1 = new de.amberhome.viewpager.AHViewPager();
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="Private WobbleMenu1 As WobbleMenu";
_wobblemenu1 = new b4a.example.wobblemenu();
RDebugUtils.currentLine=589830;
 //BA.debugLineNum = 589830;BA.debugLine="Private pagecont As AHPageContainer";
_pagecont = new de.amberhome.viewpager.AHPageContainer();
RDebugUtils.currentLine=589831;
 //BA.debugLineNum = 589831;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4a.example.b4xmainpage __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="pagecont.Initialize";
__ref._pagecont /*de.amberhome.viewpager.AHPageContainer*/ .Initialize(ba);
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="End Sub";
return "";
}
public String  _wobblemenu1_tab1click(b4a.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "wobblemenu1_tab1click", false))
	 {return ((String) Debug.delegate(ba, "wobblemenu1_tab1click", null));}
RDebugUtils.currentLine=10223616;
 //BA.debugLineNum = 10223616;BA.debugLine="Sub WobbleMenu1_Tab1Click";
RDebugUtils.currentLine=10223617;
 //BA.debugLineNum = 10223617;BA.debugLine="AHViewPager1.GotoPage(0,True)";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .GotoPage((int) (0),__c.True);
RDebugUtils.currentLine=10223618;
 //BA.debugLineNum = 10223618;BA.debugLine="End Sub";
return "";
}
public String  _wobblemenu1_tab2click(b4a.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "wobblemenu1_tab2click", false))
	 {return ((String) Debug.delegate(ba, "wobblemenu1_tab2click", null));}
RDebugUtils.currentLine=10289152;
 //BA.debugLineNum = 10289152;BA.debugLine="Sub WobbleMenu1_Tab2Click";
RDebugUtils.currentLine=10289153;
 //BA.debugLineNum = 10289153;BA.debugLine="AHViewPager1.GotoPage(1,True)";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .GotoPage((int) (1),__c.True);
RDebugUtils.currentLine=10289154;
 //BA.debugLineNum = 10289154;BA.debugLine="End Sub";
return "";
}
public String  _wobblemenu1_tab3click(b4a.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "wobblemenu1_tab3click", false))
	 {return ((String) Debug.delegate(ba, "wobblemenu1_tab3click", null));}
RDebugUtils.currentLine=10354688;
 //BA.debugLineNum = 10354688;BA.debugLine="Sub WobbleMenu1_Tab3Click";
RDebugUtils.currentLine=10354689;
 //BA.debugLineNum = 10354689;BA.debugLine="AHViewPager1.GotoPage(2,True)";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .GotoPage((int) (2),__c.True);
RDebugUtils.currentLine=10354690;
 //BA.debugLineNum = 10354690;BA.debugLine="End Sub";
return "";
}
public String  _wobblemenu1_tab4click(b4a.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "wobblemenu1_tab4click", false))
	 {return ((String) Debug.delegate(ba, "wobblemenu1_tab4click", null));}
RDebugUtils.currentLine=10420224;
 //BA.debugLineNum = 10420224;BA.debugLine="Sub WobbleMenu1_Tab4Click";
RDebugUtils.currentLine=10420225;
 //BA.debugLineNum = 10420225;BA.debugLine="AHViewPager1.GotoPage(3,True)";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .GotoPage((int) (3),__c.True);
RDebugUtils.currentLine=10420226;
 //BA.debugLineNum = 10420226;BA.debugLine="End Sub";
return "";
}
public String  _wobblemenu1_tab5click(b4a.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "wobblemenu1_tab5click", false))
	 {return ((String) Debug.delegate(ba, "wobblemenu1_tab5click", null));}
RDebugUtils.currentLine=10485760;
 //BA.debugLineNum = 10485760;BA.debugLine="Sub WobbleMenu1_Tab5Click";
RDebugUtils.currentLine=10485761;
 //BA.debugLineNum = 10485761;BA.debugLine="AHViewPager1.GotoPage(4,True)";
__ref._ahviewpager1 /*de.amberhome.viewpager.AHViewPager*/ .GotoPage((int) (4),__c.True);
RDebugUtils.currentLine=10485762;
 //BA.debugLineNum = 10485762;BA.debugLine="End Sub";
return "";
}
}