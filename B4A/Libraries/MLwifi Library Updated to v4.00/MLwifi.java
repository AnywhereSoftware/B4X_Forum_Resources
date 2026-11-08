package com.airlinemates.mlwifi;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Application;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.NetworkRequest;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.net.wifi.WifiNetworkSpecifier;
import android.net.wifi.WifiNetworkSuggestion;
import android.net.wifi.hotspot2.PasspointConfiguration;
import android.os.Build;


import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;

@ShortName("MLwifi")
@BA.Events(values={"Wifi_ConnectionResult(success As Boolean)", "scandone(wifis As List, wifiCount As Int)", "isonline_pingdone(exitValue As Int)"})
@Version(4.41F)
@Author("V-2.17 by Jem Miller - Missing Link Software; V-3.00 by bgsoft; v4.00+ by Computersmith")
@BA.DependsOn(values={"MLwifi400.aar"})
@BA.Permissions(values = {"android.permission.ACCESS_NETWORK_STATE","android.permission.ACCESS_WIFI_STATE","android.permission.CHANGE_WIFI_STATE","android.permission.ACCESS_FINE_LOCATION",
        "android.permission.INTERNET", "android.permission.CHANGE_NETWORK_STATE", "android.permission.WRITE_SETTINGS"})


public class MLwifi {
//    public static final int WIFI_2_4GHZ_BAND = 1;
//    public static final int WIFI_5GHZ_BAND = 2;
//    public static final int CHANNEL_WIDTH_20MHZ = 0;
//    public static final int CHANNEL_WIDTH_40MHZ = 1;
//    public static final int CHANNEL_WIDTH_80MHZ = 2;
//    public static final int CHANNEL_WIDTH_160MHZ = 3;
//    public static final int CHANNEL_WIDTH_80MHZ_PLUS_MHZ = 4;
//    private static final double DISTANCE_MHZ_M = 27.55D;
//    public static final int WIFI_MODE_FULL = 1;
//    public static final int WIFI_MODE_SCAN_ONLY = 2;
//    public static final int WIFI_MODE_FULL_HIGH_PERF = 3;
    public static final int SECURITY_OPEN = 0;
    public static final int SECURITY_WEP = 1;
    public static final int SECURITY_WPA2PSK = 2;

    private static ConnectivityManager cm;
   // private static boolean wifiConnected = false;
    private static ConnectivityManager.NetworkCallback cb;
    private static Timer tmr;
    private static BroadcastReceiver broadcastReceiver;
    public static boolean debug = false;
    private static boolean receiverRegistered = false;
    private static boolean connectionSuccess = false;


    @ShortName("MLScan")
    public static class MLWifiScanner {
        WifiManager WifiObj;

        WifiScanReceiver wifiReciever;

        private class WifiScanReceiver extends BroadcastReceiver {
            MLwifi.MLWifiScanner tScan;

            public WifiScanReceiver(MLwifi.MLWifiScanner tmpScan) {
                this.tScan = tmpScan;
            }

            public void onReceive(Context c, Intent intent) {
                if (this.tScan.NoEventOnSysScan && !this.tScan.OnScan)
                    return;
                String ssid, bssid, tmp, secur;
                int lev, freq, freq0, freq1, channelwidth;
                this.tScan.Results = this.tScan.WifiObj.getScanResults();
                Comparator<ScanResult> comparator = new Comparator<ScanResult>() {
                   public int compare(ScanResult lhs, ScanResult rhs) {
                        return (lhs.level < rhs.level) ? 1 : ((lhs.level == rhs.level) ? 0 : -1);
                   }
                };
                Collections.sort(this.tScan.Results, comparator);
                this.tScan.wifis = new String[this.tScan.Results.size()];
                for (int i = 0; i < this.tScan.Results.size(); i++) {
                    ScanResult Result = this.tScan.Results.get(i);
                    ssid = Result.SSID;
                    bssid = Result.BSSID;
                    tmp = Result.capabilities;
                    lev = Result.level;
                    freq = Result.frequency;
                    if (MLwifi.APIversion() >= 23) {
                        freq0 = Result.centerFreq0;
                        freq1 = Result.centerFreq1;
                        channelwidth = Result.channelWidth;
                    } else {
                        freq0 = 0;
                        freq1 = 0;
                        channelwidth = -1;
                    }
                    if (tmp.contains("WPA2")) {
                        secur = "WPA2";
                    } else if (tmp.contains("WPA")) {
                        secur = "WPA";
                    } else if (tmp.contains("WEP")) {
                        secur = "WEP";
                    } else {
                        secur = "NONE";
                    }
                    this.tScan.wifis[i] = ssid + "," + secur + "," + lev + "," + (MLwifi.isSavedWifiAP2(ssid) ? "Saved" : "") + "," +
                            bssid + "," + MLwifi.CalcWifiPct(lev) + "," + freq + "," + freq0 + "," + freq1 + "," + channelwidth + "," + MLwifi
                            .ieee80211_frequency_to_channel(freq) + "," + MLwifi.WifiBand_24G_5G(freq) + "," +
                            String.format(Locale.ROOT, "%.2f", MLwifi.calculateAPDistance(freq, lev)).replace(",", ".");
                }
                if (MLwifi.MLWifiScanner.this._ba.subExists(this.tScan.eventname + "_scandone"))
                    MLwifi.MLWifiScanner.this._ba.raiseEventFromDifferentThread(this.tScan, null, 0, this.tScan.eventname + "_scandone",
                            false, new Object[] { this.tScan.wifis, this.tScan.wifis.length});
                this.tScan.OnScan = false;
            }
        }

        private String eventname = "";

        protected List<ScanResult> Results = null;

        BA _ba = null;

        private boolean NoEventOnSysScan;

        private boolean OnScan = false;

        public String[] wifis;

        public void startScan(BA ba, String EventName, boolean NoEventOnSystemScan) {
            Application application = BA.applicationContext;
            if (this._ba == null) {
                this._ba = ba;
                this.WifiObj = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
                this.eventname = EventName.toLowerCase();
                this.NoEventOnSysScan = NoEventOnSystemScan;
                this.wifiReciever = new WifiScanReceiver(this);
            }
            updateWifiList(ba);
        }

        public void updateWifiList(BA ba) {
            Application application = BA.applicationContext;
            if (this.WifiObj != null && this.WifiObj.isWifiEnabled()) {
                if (this.wifiReciever == null)
                    this.wifiReciever = new WifiScanReceiver(this);
                application.registerReceiver(this.wifiReciever, new IntentFilter("android.net.wifi.SCAN_RESULTS"));
                this.OnScan = true;
                this.WifiObj.startScan();
            }
        }

        public void stopScan(BA ba) {
            Application application = BA.applicationContext;
            application.unregisterReceiver(this.wifiReciever);
        }

        public String getBSSID(int EntryNumber) {
            return ((ScanResult)this.Results.get(EntryNumber)).BSSID;
        }

        public String WifiCap(int EntryNumber) {
            String line;
            line = ((ScanResult) this.Results.get(EntryNumber)).SSID + "," + ((ScanResult)this.Results.get(EntryNumber)).BSSID + "," + ((ScanResult)this.Results.get(EntryNumber)).capabilities;
            return line;
        }

        public boolean isSavedWifiAP(int EntryNumber) {
            try {
                return MLwifi.isSavedWifiAP2(((ScanResult)this.Results.get(EntryNumber)).SSID);
            } catch (Exception e) {
                return false;
            }
        }

        public void connectWifiAP(BA ba, int EntryNumber, int timeout) {
            try {
                String ssid = ((ScanResult)this.Results.get(EntryNumber)).SSID;
                String bssid = ((ScanResult)this.Results.get(EntryNumber)).BSSID;
                tmr = new Timer();
                tmr.schedule(new TimeoutTask(ba), timeout);
                MLwifi.connectWifiAP2(ba, ssid, bssid, SECURITY_OPEN, "");
            } catch (Exception e) {
                BA.LogError(e.getLocalizedMessage());
            }
        }

        @SuppressLint("MissingPermission")
        public List<String> listSavedNetworks() {
            Application application = BA.applicationContext;
            List<String> netlst = new ArrayList<String>();
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            for (WifiConfiguration tmp : wifiManager.getConfiguredNetworks())
                netlst.add(tmp.SSID + "," + tmp.BSSID + "," + tmp.networkId);
            return netlst;
        }

        public void saveWifiAP(BA ba, int EntryNumber, String securityType, String Password, int timeout) {
            int security;
            String ssid = ((ScanResult)this.Results.get(EntryNumber)).SSID;
            String bssid = ((ScanResult)this.Results.get(EntryNumber)).BSSID;
            if (securityType.equals("NONE")) {
                security = SECURITY_OPEN;
            } else if (securityType.equals("WEP")) {
                security = SECURITY_WEP;
            } else if (securityType.contains("WPA")) {
                security = SECURITY_WPA2PSK;
            } else {
                return;
            }
            tmr = new Timer();
            tmr.schedule(new TimeoutTask(ba), timeout);
            MLwifi.saveWifiAP2(ba, ssid, bssid, security, Password, true);
        }

        public boolean removeWifiAP(int NetId) {
            Application application = BA.applicationContext;
            WifiManager wm = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            if (wm == null || !wm.isWifiEnabled())
                return false;
            boolean ok = wm.removeNetwork(NetId);
            wm.saveConfiguration();
            return ok;
        }
    }

    public void EnableWifi(boolean Enabled) {
        Application application = BA.applicationContext;
        try {
            WifiManager wifi = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            wifi.setWifiEnabled(Enabled);
        } catch (Exception exception) {}
    }

    public boolean isWifiEnabled() {
        Application application = BA.applicationContext;
        try {
            WifiManager wifi = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            return wifi.isWifiEnabled();
        } catch (Exception e) {
            return false;
        }
    }

    public static int APIversion() {
        return Build.VERSION.SDK_INT;
    }

    public static String WifiMACAddress() {
        if (APIversion() >= 23) {
            try {
                String interfaceName = "wlan0";
                List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
                for (NetworkInterface intf : interfaces) {
                    if (!intf.getName().equalsIgnoreCase(interfaceName))
                        continue;
                    byte[] mac = intf.getHardwareAddress();
                    if (mac == null)
                        return "";
                    StringBuilder buf = new StringBuilder();
                    byte b;
                    int i;
                    byte[] arrayOfByte1;
                    for (i = (arrayOfByte1 = mac).length, b = 0; b < i; ) {
                        byte aMac = arrayOfByte1[b];
                        buf.append(String.format("%02X:", aMac));
                        b++;
                    }
                    if (buf.length() > 0)
                        buf.deleteCharAt(buf.length() - 1);
                    return buf.toString();
                }
            } catch (Exception ex) {
                return "";
            }
            return "";
        }
        Application application = BA.applicationContext;
        try {
            WifiManager manager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            WifiInfo info = manager.getConnectionInfo();
            return info.getMacAddress();
        } catch (Exception ex) {
            return "";
        }
    }

    public static String WifiIpAddress() {
        Application application = BA.applicationContext;
        try {
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            int ipAddress = wifiInfo.getIpAddress();
            String ip = null;
            ip = String.format(Locale.ROOT, "%d.%d.%d.%d", ipAddress & 0xFF, ipAddress >> 8 & 0xFF, ipAddress >> 16 & 0xFF, ipAddress >> 24 & 0xFF);
            return ip;
        } catch (Exception ex) {
            return "";
        }
    }

    public static String WifiSSID() {
        Application application = BA.applicationContext;
        try {
            String st = "";
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            st = wifiInfo.getSSID().replace('"', ' ');
            return st.trim();
        } catch (Exception ex) {
            return "";
        }
    }

    public static String WifiBSSID() {
        Application application = BA.applicationContext;
        try {
            String st = "";
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            st = wifiInfo.getBSSID().replace('"', ' ');
            return st.trim();
        } catch (Exception ex) {
            return "";
        }
    }

    public int WifiSignal() {
        Application application = BA.applicationContext;
        try {
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            return wifiManager.getConnectionInfo().getRssi();
        } catch (Exception e) {
            return 0;
        }
    }

    public int WifiStrength() {
        Application application = BA.applicationContext;
        try {
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            int rssi = wifiManager.getConnectionInfo().getRssi();
            return WifiManager.calculateSignalLevel(rssi, 101);
        } catch (Exception e) {
            return 0;
        }
    }

    public static int CalcWifiPct(int WifiSignal) {
        double MIN_RSSI = -100.0D, MAX_RSSI = -50.0D;
        if ((double) WifiSignal <= MIN_RSSI)
            return 0;
        if ((double) WifiSignal >= MAX_RSSI)
            return 100;
        return (int)(100.0D * ((double) WifiSignal - MIN_RSSI) / (MAX_RSSI - MIN_RSSI));
    }

    public int WifiSignalPct() {
        return CalcWifiPct(WifiSignal());
    }

    public int WifiLinkSpeed() {
        Application application = BA.applicationContext;
        try {
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            WifiInfo wi = wifiManager.getConnectionInfo();
            return wi.getLinkSpeed();
        } catch (Exception e) {
            return 0;
        }
    }

    public int WifiFrequency() {
        if (APIversion() >= 21) {
            Application application = BA.applicationContext;
            try {
                WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
                WifiInfo wi = wifiManager.getConnectionInfo();
                return wi.getFrequency();
            } catch (Exception e) {
                return 0;
            }
        }
        return 0;
    }

    public int WifiChannel() {
        return ieee80211_frequency_to_channel(WifiFrequency());
    }

    private static int ieee80211_frequency_to_channel(int freq) {
        if (freq == 2484)
            return 14;
        if (freq >= 2412 && freq < 2484)
            return (freq - 2407) / 5;
        if (freq >= 5000 && freq <= 6000)
            return freq / 5 - 1000;
        return -1;
    }

    public int WifiBand() {
        int freq = WifiFrequency();
        return WifiBand_24G_5G(freq);
    }

    private static int WifiBand_24G_5G(int freq) {
        if (freq >= 5000)
            return 2;
        if (freq >= 2412 && freq <= 2484)
            return 1;
        return 0;
    }

    public boolean is5GHzBandSupported() {
        if (APIversion() >= 21)
            try {
                Application application = BA.applicationContext;
                WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
                return wifiManager.is5GHzBandSupported();
            } catch (Exception e) {
                return false;
            }
        return false;
    }

    public double WifiAPDistance() {
        if (APIversion() >= 21) {
            Application application = BA.applicationContext;
            try {
                WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
                WifiInfo wi = wifiManager.getConnectionInfo();
                return calculateAPDistance(wi.getFrequency(), wi.getRssi());
            } catch (Exception e) {
                return 0.0D;
            }
        }
        return 0.0D;
    }

    private static double calculateAPDistance(int frequency, int level) {
        return Math.pow(10.0D, (27.55D - 20.0D * Math.log10(frequency) + Math.abs(level)) / 20.0D);
    }

    private static WifiManager.WifiLock wifiLock = null;

    public static boolean holdWifiOn() {
        return WifiLockOnOff(true, 1);
    }

    public static boolean holdWifiOn2(int lockType) {
        return WifiLockOnOff(true, lockType);
    }

    public static boolean releaseWifiOn() {
        return WifiLockOnOff(false, 1);
    }

    private static boolean WifiLockOnOff(boolean OnOff, int lockType) {
        Application application = BA.applicationContext;
        try {
            if (wifiLock == null) {
                WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
                if (wifiManager != null) {
                    wifiLock = wifiManager.createWifiLock(lockType, "MLwifi");
                    wifiLock.setReferenceCounted(false);
                }
            }
            if (wifiLock != null) {
                if (OnOff) {
                    wifiLock.acquire();
                } else if (wifiLock.isHeld()) {
                    wifiLock.release();
                }
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isWifiHeldOn() {
        try {
            if (wifiLock != null)
                return wifiLock.isHeld();
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isWifiConnected() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            return isWifiConnected2();
        } else {
            return isWifiConnectedQ();
        }
    }

    private static boolean isWifiConnected2() {
        Application application = BA.applicationContext;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager)application.getSystemService(Context.CONNECTIVITY_SERVICE);
            @SuppressLint("MissingPermission") NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
            return (activeNetworkInfo != null && activeNetworkInfo.getType() == 1 && activeNetworkInfo.isConnected() && activeNetworkInfo.isAvailable());
        } catch (Exception e) {
            return false;
        }
    }

    @SuppressLint("MissingPermission")
    private static boolean isWifiConnectedQ() {
        Application application = BA.applicationContext;
        ConnectivityManager connectivityManager = (ConnectivityManager)application.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (connectivityManager.getActiveNetwork() == null) {
            return false;
        } else {
            NetworkCapabilities actNW = connectivityManager.getNetworkCapabilities(connectivityManager.getActiveNetwork());
            return actNW.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) || actNW.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET);
        }
    }

    public boolean isMobileConnected() {
        Application application = BA.applicationContext;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager)application.getSystemService(Context.CONNECTIVITY_SERVICE);
            @SuppressLint("MissingPermission") NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
            return (activeNetworkInfo != null && activeNetworkInfo.getType() == 0 && activeNetworkInfo.isConnected() && activeNetworkInfo.isAvailable());
        } catch (Exception e) {
            return false;
        }
    }

    public int ActiveNetworkType() {
        Application application = BA.applicationContext;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager)application.getSystemService(Context.CONNECTIVITY_SERVICE);
            @SuppressLint("MissingPermission") NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
            if (activeNetworkInfo != null && activeNetworkInfo.isConnected() && activeNetworkInfo.isAvailable())
                return activeNetworkInfo.getType();
            return -1;
        } catch (Exception e) {
            return -1;
        }
    }

    public String ActiveNetworkTypeName() {
        Application application = BA.applicationContext;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager)application.getSystemService(Context.CONNECTIVITY_SERVICE);
            @SuppressLint("MissingPermission") NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
            if (activeNetworkInfo != null && activeNetworkInfo.isConnected() && activeNetworkInfo.isAvailable())
                return activeNetworkInfo.getTypeName();
            return "";
        } catch (Exception e) {
            return "";
        }
    }

    public boolean isOnline() {
        Application application = BA.applicationContext;
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager)application.getSystemService(Context.CONNECTIVITY_SERVICE);
            @SuppressLint("MissingPermission") NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
            return (activeNetworkInfo != null && activeNetworkInfo.isConnected() && activeNetworkInfo.isAvailable());
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isOnlinePing() {
        return isOnlinePing2("8.8.8.8");
    }

    public boolean isOnlinePing2(String IpHost) {
        if (!isOnline())
            return false;
        Runtime runtime = Runtime.getRuntime();
        try {
            Process ipProcess = runtime.exec("/system/bin/ping -c 1 " + IpHost.trim());
            int exitValue = ipProcess.waitFor();
            return (exitValue == 0);
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isOnlinePing3(long timeout) {
        return isOnlinePing4("8.8.8.8", timeout);
    }

    public boolean isOnlinePing4(String IpHost, long timeout) {
        if (!isOnline())
            return false;
        Runtime runtime = Runtime.getRuntime();
        try {
            Process ipProcess = runtime.exec("/system/bin/ping -c 1 " + IpHost.trim());
            if (!waitFor2(timeout, TimeUnit.MILLISECONDS, ipProcess))
                return false;
            int exitValue = ipProcess.exitValue();
            return (exitValue == 0);
        } catch (Exception e) {
            return false;
        }
    }

    private boolean waitFor2(long timeout, TimeUnit unit, Process process) throws InterruptedException {
        long startTime = System.currentTimeMillis();
        while (true) {
            try {
                process.exitValue();
                return true;
            } catch (IllegalThreadStateException ex) {
                Thread.sleep(10L);
                if (System.currentTimeMillis() - startTime >= timeout)
                    break;
            }
        }
        return false;
    }

    public boolean isOnlinePing5(BA ba, long timeout) {
        return isOnlinePing6(ba, "8.8.8.8", timeout);
    }

    public boolean isOnlinePing6(BA ba, String IpHost, final long timeout) {
        if (!isOnline())
            return false;
        Runtime runtime = Runtime.getRuntime();
        try {
            final Process ipProcess = runtime.exec("/system/bin/ping -c 1 " + IpHost.trim());
            final BA _ba = ba;
            (new Thread(new Runnable() {
                public void run() {
                    int exitValue;
                    try {
                        if (timeout <= 0L) {
                            exitValue = ipProcess.waitFor();
                        } else if (MLwifi.this.waitFor2(timeout, TimeUnit.MILLISECONDS, ipProcess)) {
                            exitValue = ipProcess.exitValue();
                        } else {
                            exitValue = -1;
                        }
                    } catch (InterruptedException e) {
                        exitValue = -1;
                    }
                    String baEventName = "isonline_pingdone";
                    if (_ba.subExists(baEventName))
                        _ba.raiseEventFromDifferentThread(this, null, 0, baEventName, false, new Object[] {(exitValue == 0)});
                }
            })).start();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     *Adds a Wifi network, then optionally connects
     *Params:
     * ssid - the name of the Wifi Network
     * security = 0 = Open (SECURITY_OPEN), 1 = WEP (SECURITY_WEP), 2 = WPA-2/PSK (SECURITY_WPA2PSK)
     * password - the password or "" if the network is open
     * connect - ignored for Android Q+ (will always connect)
     * timeout - fail if not connected within timeout (ms)
     *
     *Raises Wifi_ConnectionResult event on success or failure
     *
     *Example:<code>
     * Private Sub connectToWifi
     *     Private wifi As MLwifi
     *     'To save & connect to an open network
     *     wifi.saveWifiAP("wifissid", wifi.SECURITY_OPEN, "", True, 30000)
     *     'To connect to a WPA-2 secured network
     *     wifi.saveWifiAP("wifissid", wifi.SECURITY_WPA2PSK, "password", True, 30000)
     * End Sub
     *
     * Public Sub Wifi_ConnectionResult(success As Boolean)
     *     If success then
     *         'Connected - set up sockets, etc...
     *     Else
     *         'Couldn't connect...
     *     End If
     * End Sub
     *</code>
     */
    public static void saveWifiAP(BA ba, String ssid, int security, String password, boolean connect, int timeout) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            tmr = new Timer();
            tmr.schedule(new TimeoutTask(ba), timeout);
            saveWifiAP2(ba, ssid, "", security, password, connect);
        } else {
            saveWifiAPQ(ba, ssid, security, password, connect, timeout);
        }
    }

    private static void saveWifiAP2(BA ba, String ssid, String bssid, int security, String password, boolean connect) {
        Application application = BA.applicationContext;
        try {

            WifiConfiguration wc;
            WifiManager wm = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            if (wm == null) {
                return;
            }
            int NetId = -1;
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
                wc = configureWifi(ssid, bssid, security, password);
                NetId = wm.addNetwork(wc);
                if (debug)
                    BA.Log("[MLwifi] " + ssid + " saved");
            } else {
                NetId = getSavedNetworkId(ssid);
                if (NetId == -1) {
                    wc = configureWifi(ssid, bssid, security, password);
                    NetId = wm.addNetwork(wc);
                    if (debug)
                        BA.Log("[MLwifi] " + ssid + " saved");
                } else {
                    if (debug)
                        BA.Log("[MLwifi] (P) " + ssid + "already exists. Not saving.");
                }
            }
            if (NetId == -1) {
                if (debug)
                    BA.Log("Invalid NetId");
                return;
            }
            if (connect) {
                if (!ssid.startsWith("\""))
                    ssid = "\"".concat(ssid).concat("\"");
                connectToWifi(ba, wm, NetId, ssid);
            }

        } catch (Exception e) {
            BA.LogError(e.getLocalizedMessage());
        }

    }

    private static int getSavedNetworkId(String ssid) {
        WifiManager wm = (WifiManager)BA.applicationContext.getSystemService(Context.WIFI_SERVICE);
        if (wm == null || !wm.isWifiEnabled())
            return -1;
        @SuppressLint("MissingPermission") List<WifiConfiguration> tmp = wm.getConfiguredNetworks();
        if (tmp == null)
            return -1;
        if (!ssid.startsWith("\""))
            ssid = "\"".concat(ssid).concat("\"");
        for (int i = 0; i < tmp.size(); i++) {
            if (ssid.trim().length() > 0 && (tmp.get(i)).SSID != null && (tmp.get(i)).SSID.equals(ssid)) {
                return tmp.get(i).networkId;
            }
        }
        return -1;
    }

    private static WifiConfiguration configureWifi(String ssid, String bssid, int security, String password) {
        try {
            WifiConfiguration wc = new WifiConfiguration();
            if (ssid.startsWith("\"")) {
                wc.SSID = ssid;
            } else {
                wc.SSID = "\"".concat(ssid).concat("\"");
            }
            if (bssid.trim().length() > 0)
                wc.BSSID = bssid;
            wc.hiddenSSID = false;
            wc.priority = 40;
            wc.status = 1;
            wc.allowedProtocols.set(1);
            wc.allowedProtocols.set(0);
            wc.allowedPairwiseCiphers.set(2);
            wc.allowedPairwiseCiphers.set(1);
            wc.allowedGroupCiphers.set(0);
            wc.allowedGroupCiphers.set(1);
            wc.allowedGroupCiphers.set(3);
            wc.allowedGroupCiphers.set(2);
            if (security == SECURITY_WPA2PSK) {
                wc.allowedKeyManagement.set(1);
                wc.preSharedKey = "\"".concat(password).concat("\"");
            } else if (security == SECURITY_WEP) {
                wc.allowedKeyManagement.set(0);
                wc.allowedAuthAlgorithms.set(0);
                wc.allowedAuthAlgorithms.set(1);
                if (isHex(password)) {
                    wc.wepKeys[0] = password;
                } else {
                    wc.wepKeys[0] = "\"".concat(password).concat("\"");
                }
                wc.wepTxKeyIndex = 0;
            } else {
                wc.allowedKeyManagement.set(0);
                wc.allowedAuthAlgorithms.clear();
            }
            return wc;
        } catch (Exception e) {
            return null;
        }
    }

    @SuppressLint("MissingPermission")
    @TargetApi(Build.VERSION_CODES.Q)
    private static void saveWifiAPQ(BA ba, String ssid, int security, String password, boolean connect, int timeout) {

         final WifiNetworkSuggestion.Builder builder = new WifiNetworkSuggestion.Builder().setSsid(ssid);
         if (security == SECURITY_WPA2PSK) {
             builder.setWpa2Passphrase(password);
         }
         final WifiNetworkSuggestion suggestion1 = builder.build();

        final ArrayList<WifiNetworkSuggestion> suggestionsList = new ArrayList<>();
        suggestionsList.add(suggestion1);


        final WifiManager wifiManager = (WifiManager) BA.applicationContext.getSystemService(Context.WIFI_SERVICE);
        final int status = wifiManager.addNetworkSuggestions(suggestionsList);

        if (status != WifiManager.STATUS_NETWORK_SUGGESTIONS_SUCCESS) {
            if (debug)
                BA.Log("[MLwifi Q+] Network Suggestion Status: " + status);
            if (connect) {
                connectWifiAPQ(ba, ssid, security, password, timeout);
            }
        }

//        final IntentFilter intentFilter = new IntentFilter(WifiManager.ACTION_WIFI_NETWORK_SUGGESTION_POST_CONNECTION);
//        broadcastReceiver = new BroadcastReceiver() {
//            @Override public void onReceive(Context context, Intent intent) {
//                if (!intent.getAction().equals(WifiManager.ACTION_WIFI_NETWORK_SUGGESTION_POST_CONNECTION)) {
//                    if (debug)
//                        BA.Log("[MLwifi Q+] BroadcastReceiver Intent Action: " + intent.getAction());
//                    return;
//
//                }
//                // Post connection
//                if (debug)
//                    BA.Log("[MLwifi Q+] Connected to " + ssid);
//                if (ba.subExists("wifi_connectionresult")) {
//                    ba.raiseEvent(this, "wifi_connectionresult", true);
//                }
//
//              //  wifiConnected = true;
//            }
//        };
//        BA.applicationContext.registerReceiver(broadcastReceiver, intentFilter);
    }

    private static boolean isHex(String in) {
        try {
            int t = Integer.parseInt(in, 16);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isSavedWifiAP(String ssid) {
        return isSavedWifiAP2(ssid);
    }

    private static boolean isSavedWifiAP2(String ssid) {
        Application application = BA.applicationContext;
        try {
            WifiManager wm = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            if (wm == null)
                return false;
            @SuppressLint("MissingPermission") List<WifiConfiguration> tmp = wm.getConfiguredNetworks();
            if (tmp == null)
                return false;
            if (!ssid.startsWith("\""))
                ssid = "\"".concat(ssid).concat("\"");
            for (int i = 0; i < tmp.size(); i++) {
                if (((WifiConfiguration)tmp.get(i)).SSID.equals(ssid))
                    return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    public static boolean removeWifiAP(String ssid) {
        Application application = BA.applicationContext;
        try {
            WifiManager wm = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            if (wm == null || !wm.isWifiEnabled())
                return false;
            @SuppressLint("MissingPermission") List<WifiConfiguration> tmp = wm.getConfiguredNetworks();
            if (tmp == null)
                return false;
            if (!ssid.startsWith("\""))
                ssid = "\"".concat(ssid).concat("\"");
            for (int i = 0; i < tmp.size(); i++) {
                if (((WifiConfiguration)tmp.get(i)).SSID.equals(ssid)) {
                    int NetId = ((WifiConfiguration)tmp.get(i)).networkId;
                    if (NetId <= 0)
                        return false;
                    if (!wm.removeNetwork(NetId))
                        return false;
                    wm.saveConfiguration();
                    return true;
                }
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    /**
     *Disconnect from a Wifi network
     *Params:
     *none
     *
     *Returns True (success) or False (failure)
     *
     *Usage:<code>
     * Private disconnected As Boolean = MLwifi.disconnectWifiAP
     *</code>
     */
    public boolean disconnectWifiAP() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            return disconnectWifiAP2();
        } else {
            return disconnectWifiAPQ();
        }
    }

    private boolean disconnectWifiAP2() {
        Application application = BA.applicationContext;
        try {
            if (receiverRegistered) {
                unregisterReceiver(broadcastReceiver);
            }
          //  wifiConnected = false;
            WifiManager wifiManager = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            return wifiManager.disconnect();
        } catch (Exception e) {
            return false;
        }
    }

    private boolean disconnectWifiAPQ() {
        if (cb != null) {
            cm.unregisterNetworkCallback(cb);
        //    wifiConnected = false;
            return true;
        }
        return false;
    }

    /**
     *Reconnects to a saved Wifi Network
     *Params:
     * ssid - the name of the Wifi Network
     * timeout - fail if not connected within timeout (Ms)
     *
     *Raises Wifi_ConnectionResult event on success or failure
     *
     * NOTE FOR SDK 29+: Will only work if the network being connected to is not secured.
     * You can connect to the previously connected network by calling disconnectWifiAP
     * or a specific network by calling connectWifiAP with the correct parameters.
     *
     *Example:<code>
     *     Private Sub connectToWifi
     *         Private wifi As MLwifi
     *         'reconnect to a Wifi network saved on this device
     *         wifi.reconnectWifiAP("wifissid", 30000)
     *     End Sub
     *
     *     Public Sub Wifi_ConnectionResult(success As Boolean)
     *         If success then
     *             'Connected - set up sockets, etc...
     *         Else
     *             'Couldn't connect...
     *         End If
     *     End Sub
     * </code>
     */
    public static void reconnectWifiAP(BA ba, String ssid, int timeout) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            tmr = new Timer();
            tmr.schedule(new TimeoutTask(ba), timeout);
            connectWifiAP2(ba, ssid, "", 0, "");
        } else {
            connectWifiAPQ(ba, ssid, SECURITY_OPEN, "", timeout);
        }
    }

    /**
     *Connects to an existing Wifi Network
     *Params:
     * ssid - the name of the Wifi Network
     * security = 0 = Open (SECURITY_OPEN), 1 = WEP (SECURITY_WEP), 2 = WPA-2/PSK (SECURITY_WPA2PSK)
     * password - the password or "" if the network is open
     * timeout - fail if not connected within timeout (Ms)
     *
     *Raises Wifi_ConnectionResult event on success or failure
     *
     *Example:<code>
     *     Private Sub connectToWifi
     *         Private wifi As MLwifi
     *         'To connect to an open network
     *         wifi.connectWifiAP("wifissid", wifi.SECURITY_OPEN, "", 30000)
     *         'To connect to a WPA-2 secured network
     *         wifi.connectWifiAP("wifissid", wifi.SECURITY_WPA2PSK, "password", 30000)
     *     End Sub
     *
     *     Public Sub Wifi_ConnectionResult(success As Boolean)
     *         If success then
     *             'Connected - set up sockets, etc...
     *         Else
     *             'Couldn't connect...
     *         End If
     *     End Sub
     * </code>
     */
    public void connectWifiAP(BA ba, String ssid, int security, String password, int timeout) {
        if (debug)
            BA.Log("SDK: " + Build.VERSION.SDK_INT);
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            tmr = new Timer();
            tmr.schedule(new TimeoutTask(ba), timeout);
            connectWifiAP2(ba, ssid, "", security, password);
        } else {
            connectWifiAPQ(ba, ssid, security, password, timeout);
        }
    }


    private static void connectWifiAP2(BA ba, String ssid, String bssid, int security, String password) {
        Application application = BA.applicationContext;

        try {

            WifiManager wm = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
            if (wm == null || !wm.isWifiEnabled())
                return;
            @SuppressLint("MissingPermission") List<WifiConfiguration> tmp = wm.getConfiguredNetworks();
            if (tmp == null)
                return;
            if (!ssid.startsWith("\""))
                ssid = "\"".concat(ssid).concat("\"");
            for (int i = 0; i < tmp.size(); i++) {
                if (ssid.trim().length() > 0 && (tmp.get(i)).SSID != null && (tmp.get(i)).SSID.equals(ssid)) { // || (bssid.trim().length() > 0 && (tmp.get(i)).BSSID != null && (tmp.get(i)).BSSID.equals(bssid))) {
                   // BA.Log("Found SSID: " + tmp.get(i).SSID);
                    int NetId;
                    if (security != SECURITY_OPEN && Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
                //        BA.Log("Configuring Wifi");
                        WifiConfiguration wc = configureWifi(ssid, bssid, security, password);
                        NetId = wm.addNetwork(wc);
                   //     BA.Log("NetId after config = " + NetId);
                    } else {
                      //  BA.Log("Going for NetId");
                        NetId = tmp.get(i).networkId;
                    //    BA.Log("NetId = " + NetId);
                    }
                    if (NetId == -1) {
                        return;
                    }
                //    BA.Log("Calling connectToWifi. NetId = " + NetId);
                    connectToWifi(ba, wm, NetId, ssid);
                    return;
                }
            }
            if (debug)
                BA.Log("[MLwifi] AP not found - is it in the device's saved list?");
        } catch (Exception e) {
            BA.LogError(e.getLocalizedMessage());
        }
    }


    static private void connectToWifi(BA ba, WifiManager wm, int NetId, String ssid) {
        try {
            connectionSuccess = false;
            if (debug)
                BA.Log("[MLwifi] Connecting to " + ssid);


            if (receiverRegistered) {
                unregisterReceiver(broadcastReceiver);
            }

            if (broadcastReceiver == null) {
                final IntentFilter intentFilter = new IntentFilter(WifiManager.NETWORK_STATE_CHANGED_ACTION);
                broadcastReceiver = new BroadcastReceiver() {
                    @Override
                    public void onReceive(Context context, Intent intent) {
                        if (!intent.getAction().equals(WifiManager.NETWORK_STATE_CHANGED_ACTION)) {
                            if (debug)
                                BA.Log("BroadcastReceiver Intent Action: " + intent.getAction());
                        }
                        // Post connection
                        @SuppressLint("MissingPermission") NetworkInfo networkInfo = intent.getParcelableExtra(WifiManager.EXTRA_NETWORK_INFO);
                        if (networkInfo != null) {
                            if (debug)
                                BA.Log(networkInfo.toString());
                            if (networkInfo.isConnected()) { //&& networkInfo.getExtraInfo().equals(ssid)) {
                                WifiManager wifiManager = (WifiManager) BA.applicationContext.getSystemService(Context.WIFI_SERVICE);
                                WifiInfo info = wifiManager.getConnectionInfo();
                               // BA.Log(info.getSSID() + " : " + ssid);
                                if (info.getSSID().equals(ssid)) {
                                    if (ba.subExists("wifi_connectionresult") && networkInfo.getState() == NetworkInfo.State.CONNECTED && !connectionSuccess) {
                                        connectionSuccess = true;
                                        if (debug)
                                            BA.Log("[MLwifi] Connected to " + info.getSSID());
                                        tmr.cancel();
                                        ScheduledThreadPoolExecutor exec = new ScheduledThreadPoolExecutor(1);
                                        exec.schedule(new Runnable() {
                                            public void run() {
                                                ba.raiseEvent(this, "wifi_connectionresult", true);
                                            }
                                        }, 1, TimeUnit.SECONDS);

                                    }
//                                } else {
//                                    if (ba.subExists("wifi_connectionresult")) {
//                                        ba.raiseEvent(this, "wifi_connectionresult", false);
//                                    }
                                }
                            } else if (!networkInfo.isAvailable() && networkInfo.getExtraInfo().equals(ssid)) {
                                tmr.cancel();
                                if (debug)
                                    BA.Log("[MLwifi] " + ssid + " not available");
                                if (ba.subExists("wifi_connectionresult")) {
                                    ba.raiseEvent(this, "wifi_connectionresult", false);
                                }
                            }
                        }
                    }
                };
                BA.applicationContext.registerReceiver(broadcastReceiver, intentFilter);
                receiverRegistered = true;
            }
            wm.enableNetwork(NetId, true);

        } catch (Exception e) {
            BA.LogError(e.getLocalizedMessage());
        }
    }

    static class TimeoutTask extends TimerTask {
        BA _ba;
        public TimeoutTask(BA ba) {
            _ba = ba;
        }
        public void run() {
            tmr.cancel(); //Terminate the timer thread
            if (_ba.subExists("wifi_connectionresult")) {
                _ba.raiseEvent(this, "wifi_connectionresult", false);
            }
            if (receiverRegistered) {
                unregisterReceiver(broadcastReceiver);
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.Q)
    static private void connectWifiAPQ(BA ba, String ssid, int security, String password, int timeout) {
        Application application = BA.applicationContext;
        WifiManager wm = (WifiManager)application.getSystemService(Context.WIFI_SERVICE);
        if (wm == null || !wm.isWifiEnabled()) {
            if (debug)
                BA.LogError("Wifi not enabled");
            return;
        }

        WifiNetworkSpecifier.Builder builder = new WifiNetworkSpecifier.Builder().setSsid(ssid);
        if (security == SECURITY_WPA2PSK) {
            builder.setWpa2Passphrase(password);
        }
        WifiNetworkSpecifier specifier = builder.build();
        if (debug)
            BA.Log("[MLwifi] (Q+) Connecting to " + ssid);
        NetworkRequest request = new NetworkRequest.Builder()
                .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
              //  .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
                .setNetworkSpecifier(specifier)
                .build();

        cb = new ConnectivityManager.NetworkCallback() {
            @Override
            public void onAvailable(Network network) {
                super.onAvailable(network);
                if (debug)
                    BA.Log("[MLwifi] Connected to " + ssid);
                //    wifiConnected = true;
                cm.bindProcessToNetwork(network);
                if (ba.subExists("wifi_connectionresult")) {
                    ba.raiseEvent(this, "wifi_connectionresult", true);
                }
            }

            @Override
            public void onUnavailable() {
                super.onUnavailable();
                if (debug)
                    BA.Log("[MLwifi] " + ssid + " not available");
                //     wifiConnected = false;
                if (ba.subExists("wifi_connectionresult")) {
                    ba.raiseEvent(this, "wifi_connectionresult", false);
                }
                cm.unregisterNetworkCallback(cb);
            }

            @Override
            public void onLost(Network network) {
                super.onLost(network);
                if (debug)
                    BA.Log("[MLwifi] Disconnected from " + ssid);
                //      wifiConnected = false;
                cm.unregisterNetworkCallback(cb);
            }

        };
    cm = (ConnectivityManager) application.getSystemService(Context.CONNECTIVITY_SERVICE);
    cm.requestNetwork(request, cb, timeout);
    }


    private static void unregisterReceiver(BroadcastReceiver receiver) {
        //BA.Log("Unregistering Receiver");
        BA.applicationContext.unregisterReceiver(receiver);
        receiverRegistered = false;
        broadcastReceiver = null;
    }


}
