package com.micr.b4jping;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.objects.collections.List;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@BA.Version(0.31F)
@BA.Author("MICR")
@BA.ShortName("B4JPing")

@BA.Events(values = {"ResponseSuccessFul (values As List)", "ResponseError (values As List)"})

public class jPing {

    private BA ba;
    private String eventName;
    private Object callBack;
    List myListResponseOK = new List();
    List myListResponseError = new List();
    ArrayList<String> commandList = new ArrayList<String>();
    private int Attempt = 4; //dafault 4 
    private int QuantityBytes = 32; //dafault 32   
    private int Timeout = 4000; //dafault 4 s
    private String Host = "www.google.com";
    private String Encoding = "CP850";

    public void Initialize(BA paramBA, Object mCallBack, String EventName) {
        this.ba = paramBA;
        this.eventName = EventName.toLowerCase(BA.cul);
        this.callBack = mCallBack;

        // Inicializar la lista
        myListResponseOK.Initialize();
        myListResponseError.Initialize();
    }

    //Default es 4
    public void setAttempt(int value) {
        Attempt = value;
    }

    //Default es 32
    public void setQuantityBytes(int value) {
        QuantityBytes = value;
    }

    //Default es 32
    public void setTimeout(int value) {
        Timeout = value;
    }

    public void setHost(String host) {
        this.Host = host;
    }
     public void setEncoding(String encoding) {
        this.Encoding = encoding;
    }

    // method for finding the ping statistics of website
    public void Start() {
        try {

            commandList.clear();
            commandList.add("ping");
            commandList.add("-n");
            commandList.add(Attempt + "");

            commandList.add("-l");
            commandList.add(QuantityBytes + "");

            commandList.add("-w");
            commandList.add(Timeout + "");
            commandList.add(Host);

            // creating the sub process, execute system command
            ProcessBuilder build = new ProcessBuilder(commandList);
            Process process = build.start();

            // to read the output
            BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream(), Encoding));
            BufferedReader Error = new BufferedReader(new InputStreamReader(process.getErrorStream(), Encoding));
            String s = null;

            myListResponseOK.Clear();
            myListResponseError.Clear();

            while ((s = input.readLine()) != null) {
                myListResponseOK.Add(s);
            }

            while ((s = Error.readLine()) != null) {
                myListResponseError.Add(s);
            }
            if (myListResponseOK.getSize() > 0) {
              //  System.out.println("Standard output");
                RaiseEventResponseOK(myListResponseOK);
            }
            if (myListResponseError.getSize() > 0) {
                System.out.println("Error output");
                RaiseEventResponseError(myListResponseError);
            }
        } catch (IOException ex) {
            Logger.getLogger(jPing.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void RaiseEventResponseOK(List input) {
        if (ba.subExists(eventName + "_ResponseSuccessFul".toLowerCase())) {
            ba.raiseEventFromUI(callBack, eventName + "_ResponseSuccessFul".toLowerCase(), input);
        }
    }

    private void RaiseEventResponseError(List miListaResponseError) {
        if (ba.subExists(eventName + "_ResponseError".toLowerCase())) {
            ba.raiseEventFromUI(callBack, eventName + "_ResponseError".toLowerCase(), miListaResponseError);
        }
    }

    public boolean sendPingRequest(int timeOut) {
        boolean result = false;
        try {
            InetAddress geek = InetAddress.getByName(this.Host);
            result = geek.isReachable(timeOut);

        } catch (UnknownHostException ex) {
            anywheresoftware.b4a.BA.Log("Unknown host");
            anywheresoftware.b4a.BA.Log(ex.getMessage());

        } catch (IOException ex) {
            anywheresoftware.b4a.BA.Log(ex.getMessage());
        }
        return result;
    }

    //Utilidad para obtener la IP
    public String getIPFromHost(String hostName) {
        String IP = "";
        try {
            InetAddress geek = InetAddress.getByName(hostName);
            IP = geek.getHostAddress();
        } catch (UnknownHostException ex) {
            anywheresoftware.b4a.BA.Log("Unknown host");
            anywheresoftware.b4a.BA.Log(ex.getMessage());
        }
        return IP;
    }
}
