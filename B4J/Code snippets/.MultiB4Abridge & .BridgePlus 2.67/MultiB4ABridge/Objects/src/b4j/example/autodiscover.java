package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class autodiscover extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.autodiscover", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.autodiscover.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public int _vv1 = 0;
public anywheresoftware.b4a.objects.SocketWrapper.UDPSocket _vv2 = null;
public anywheresoftware.b4a.objects.collections.Map _vv3 = null;
public anywheresoftware.b4a.objects.Timer _vv4 = null;
public String _vv5 = "";
public com.stevel05.draganddrop.transfermode _vv6 = null;
public b4j.example.main _main = null;
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private const port As Int = 58912";
_vv1 = (int) (58912);
 //BA.debugLineNum = 4;BA.debugLine="Private udpsocket As UDPSocket";
_vv2 = new anywheresoftware.b4a.objects.SocketWrapper.UDPSocket();
 //BA.debugLineNum = 5;BA.debugLine="Private FoundDevices As Map";
_vv3 = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 6;BA.debugLine="Private Timer1 As Timer";
_vv4 = new anywheresoftware.b4a.objects.Timer();
 //BA.debugLineNum = 7;BA.debugLine="Private mHost As String";
_vv5 = "";
 //BA.debugLineNum = 8;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba,String _host) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 10;BA.debugLine="Public Sub Initialize(Host As String)";
 //BA.debugLineNum = 11;BA.debugLine="mHost = Host";
_vv5 = _host;
 //BA.debugLineNum = 12;BA.debugLine="udpsocket.Initialize(\"udpsocket\", 0, 8192)";
_vv2.Initialize(ba,"udpsocket",(int) (0),(int) (8192));
 //BA.debugLineNum = 13;BA.debugLine="FoundDevices.Initialize";
_vv3.Initialize();
 //BA.debugLineNum = 14;BA.debugLine="Timer1.Initialize(\"Timer1\", 1000)";
_vv4.Initialize(ba,"Timer1",(long) (1000));
 //BA.debugLineNum = 15;BA.debugLine="End Sub";
return "";
}
public String  _v7() throws Exception{
 //BA.debugLineNum = 23;BA.debugLine="Public Sub Start";
 //BA.debugLineNum = 24;BA.debugLine="FoundDevices.Clear";
_vv3.Clear();
 //BA.debugLineNum = 25;BA.debugLine="Timer1.Enabled = True";
_vv4.setEnabled(__c.True);
 //BA.debugLineNum = 26;BA.debugLine="End Sub";
return "";
}
public String  _v0() throws Exception{
 //BA.debugLineNum = 28;BA.debugLine="Public Sub Stop";
 //BA.debugLineNum = 29;BA.debugLine="udpsocket.Close";
_vv2.Close();
 //BA.debugLineNum = 30;BA.debugLine="Timer1.Enabled = False";
_vv4.setEnabled(__c.False);
 //BA.debugLineNum = 31;BA.debugLine="End Sub";
return "";
}
public String  _timer1_tick() throws Exception{
anywheresoftware.b4a.objects.SocketWrapper.UDPSocket.UDPPacket _p = null;
 //BA.debugLineNum = 17;BA.debugLine="Private Sub Timer1_Tick";
 //BA.debugLineNum = 18;BA.debugLine="Dim p As UDPPacket";
_p = new anywheresoftware.b4a.objects.SocketWrapper.UDPSocket.UDPPacket();
 //BA.debugLineNum = 19;BA.debugLine="p.Initialize(Array As Byte(0), mHost, port)";
_p.Initialize(new byte[]{(byte) (0)},_vv5,_vv1);
 //BA.debugLineNum = 20;BA.debugLine="udpsocket.Send(p)";
_vv2.Send(_p);
 //BA.debugLineNum = 21;BA.debugLine="End Sub";
return "";
}
public String  _udpsocket_packetarrived(anywheresoftware.b4a.objects.SocketWrapper.UDPSocket.UDPPacket _packet) throws Exception{
String _name = "";
 //BA.debugLineNum = 33;BA.debugLine="Private Sub UdpSocket_PacketArrived (Packet As UDP";
 //BA.debugLineNum = 34;BA.debugLine="Dim name As String = BytesToString(Packet.Data, 1";
_name = __c.BytesToString(_packet.getData(),(int) (1),(int) (_packet.getLength()-1),"utf8");
 //BA.debugLineNum = 35;BA.debugLine="If FoundDevices.GetDefault(Packet.HostAddress, \"\"";
if ((_vv3.GetDefault((Object)(_packet.getHostAddress()),(Object)(""))).equals((Object)(_name)) == false) { 
 //BA.debugLineNum = 36;BA.debugLine="FoundDevices.Put(Packet.HostAddress, name)";
_vv3.Put((Object)(_packet.getHostAddress()),(Object)(_name));
 //BA.debugLineNum = 37;BA.debugLine="Main.AutoDiscover_Found(name, Packet.HostAddress";
_main._autodiscover_found /*String*/ (_name,_packet.getHostAddress());
 };
 //BA.debugLineNum = 39;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
