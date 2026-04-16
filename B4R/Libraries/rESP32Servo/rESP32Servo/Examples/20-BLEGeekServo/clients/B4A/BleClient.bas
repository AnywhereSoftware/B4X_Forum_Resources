B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' ================================================================
' File:			BleClient
' Brief:		BLE GATT Central Client.
' Date:			2026-01-10
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	JavaObject
' Description:	- Connects to ONE BLE peripheral with timeout if can not connect
'   			- Writes data (with / without response)
'   			- Receives notifications / indications
'   			- Supports MTU negotiation
'
' Architecture:	1) Public B4X API (Connect, Write, SetMTU, Events)
'  			 	2) Bridge layer (B4X <=> Java, JavaObject, ba.raiseEvent, java_* subs)
'   			3) Native Android BLE (real BluetoothGatt, callbacks, queues, notifications)
'
' Threading:	- All BLE callbacks occur on Binder threads
'   			- Events are marshalled back into B4X main thread
' ================================================================

Sub Class_Globals

	' Write modes
	Public Const WRITE_WITH_RESPONSE As Int = 0
	Public Const WRITE_NO_RESPONSE   As Int = 1
	' Current write mode (default = safe)
	Private mWriteMode As Int = WRITE_WITH_RESPONSE

	' Last negotiated MTU (default BLE MTU)
	Private mMTU As Int = 23

	' Java bridge object (this class)
	Private jo As JavaObject

	' Event target and prefix
	Private mCallback  As Object
	Private mEventName As String
	
	' BLE Timeout Timer
	Private connectTimer As Timer
	Private connectInProgress As Boolean
	Private connectTimeoutMs As Long = 10000   ' 10 seconds (adjustable)
	
	' Device
	Private mMac As String = ""
End Sub

' ================================================================
' Public API
' ================================================================

Public Sub Initialize (Target As Object, EventName As String)
	jo = Me
	mCallback = Target
	mEventName = EventName
	connectTimer.Initialize("ConnectTimer", connectTimeoutMs)
	connectTimer.Enabled = False
	connectInProgress = False
End Sub

' IsBluetoothOn
' Returns True if Bluetooth adapter exists and is enabled
Public Sub IsBluetoothOn As Boolean
	Dim ctx As JavaObject
	ctx.InitializeContext
	Return jo.RunMethod("isBluetoothOn", Array(ctx))
End Sub

' Connect
' Connects to a BLE peripheral and prepares notifications
' Parameters:
' 	Mac - Device MAC address
' 	SvcUUID - Service UUID
' 	ChrUUIDTX - Characteristic UUID (Transmit)
' 	ChrUUIDRX - Characteristic UUID (Receive Flags read,notify,write)
Public Sub Connect(Mac As String, SvcUUID As String, ChrUUIDTX As String, ChrUUIDRX As String)
	Dim ctx As JavaObject

	' Check if alread trying to connect	
	If connectInProgress Then Return

	mMac = Mac
	connectInProgress = True
	connectTimer.Enabled = True
	
	ctx.InitializeContext
	jo.RunMethod("nativeConnect", Array(ctx, mMac, SvcUUID, ChrUUIDTX, ChrUUIDRX))

	Log($"[BleClient.Connect] mac=${Mac}, timeout=${connectTimeoutMs} ms"$)
End Sub

' ConnectTimer_Tick
' Triggered after NN seconds if connection failed.
' If the connection is successful then the event java_connected disables the connection timer.
Private Sub ConnectTimer_Tick
	connectTimer.Enabled = False

	If connectInProgress Then
		connectInProgress = False
	
		Log($"[BleClient.ConnectTimer][W] connection timeout"$)

		' Make sure BLE stack is reset
		Disconnect

		' 
		jo.RunMethod("nativeCancelConnect", Null)
		' Raise a timeout event
		java_connectionfailed("Timeout reached", mMac)
	End If
End Sub

' Get the connected state.
Public Sub IsConnected As Boolean
	Return connectInProgress = False And jo.IsInitialized
End Sub

' Write
' Queues data for writing (thread-safe)
' Parameters:
'	Data - Byte array to write to the device
Public Sub Write(Data() As Byte)
	jo.RunMethod("nativeWrite", Array(Data))
End Sub

' SetWriteMode
' Set or get the write mode.
' Parameters:
'	Mode - WRITE_WITH_RESPONSE - reliable, slower
' 		 - WRITE_NO_RESPONSE - fast, no ACK
Public Sub SetWriteMode(Mode As Int)
	mWriteMode = Mode
	jo.RunMethod("nativeSetWriteMode", Array(Mode))
End Sub
Public Sub GetWriteMode As Int
	Return mWriteMode
End Sub

' Disconnect
' Disconnects and releases native resources
Public Sub Disconnect
	jo.RunMethod("nativeDisconnect", Null)
End Sub

' Requests a new MTU size (Android only)
' Typical values: 23 (default), 128, 247, 512 (max depends on device)
' Requested MTU ≠ granted MTU > Always use GetMTUSize after _MTUChanged.
' Parameters:
'	Size - 
Public Sub SetMTUSize(Size As Int)
	mMTU = Size
	jo.RunMethod("nativeSetMTU", Array(Size))
End Sub

' Returns last negotiated MTU size
Public Sub GetMTUSize As Int
	Return mMTU
End Sub

' Check if the MAC address is valid
Public Sub IsValidMac(mac As String) As Boolean
	Return Regex.IsMatch("([0-9A-F]{2}:){5}[0-9A-F]{2}", mac.ToUpperCase)
End Sub

' ================================================================
' Events
' ================================================================

Private Sub java_connected
	connectInProgress = False
	connectTimer.Enabled = False
	CallSubDelayed(mCallback, mEventName & "_Connected")
End Sub

Private Sub java_connectionfailed (cause As String, msg As String)
	connectInProgress = False
	connectTimer.Enabled = False
	CallSubDelayed3(mCallback, mEventName & "_ConnectionFailed", cause, msg)
End Sub

Private Sub java_disconnected
	CallSubDelayed(mCallback, mEventName & "_Disconnected")
End Sub

Private Sub java_devicenotfound
	CallSubDelayed(mCallback, mEventName & "_DeviceNotFound")
End Sub

Private Sub java_datareceived (Data() As Byte)
	CallSubDelayed2(mCallback, mEventName & "_DataReceived", Data)
End Sub

Private Sub java_mtuchanged (Size As Int, Success As Boolean)
	mMTU = Size
	CallSubDelayed3(mCallback, mEventName & "_MTUChanged", Size, Success)
End Sub

Private Sub java_notificationsenabled
	CallSubDelayed(mCallback, mEventName & "_NotificationsEnabled")
End Sub

' ================================================================
' Inline Java
' ================================================================

#If JAVA

public boolean isBluetoothOn(Context ctx) {
    BluetoothManager bm =
        (BluetoothManager) ctx.getSystemService(Context.BLUETOOTH_SERVICE);
    BluetoothAdapter adapter = bm.getAdapter();
    return adapter != null && adapter.isEnabled();
}
#End If

#If JAVA
import android.bluetooth.*;
import android.content.Context;
import java.util.*;

public BluetoothGatt gatt;
public BluetoothGattCharacteristic controlChar;

// Write queue prevents GATT busy errors
public Queue<byte[]> writeQueue = new LinkedList<>();
public boolean writing = false;

// 0=with response, 1=no response
public int writeMode = 0;

// Negotiated MTU - default 23 bytes
public int currentMTU = 23;

// Flag ensuring to get the state connect cancelled
public boolean connectCancelled = false;

// ba object
public anywheresoftware.b4a.BA ba;

// Connect
// ctx - Context
// Mac - Device MAC address
// SvcUUID - Service UUID
// ChrUUIDTX - Characteristic UUID (Transmit)
// ChrUUIDRX - Characteristic UUID (Receive Flags read,notify,write)
public void nativeConnect(Context ctx, String mac, String svcUUID, String chrUUIDTX, String chrUUIDRX) {

	try {
        BluetoothManager bm =
            (BluetoothManager) ctx.getSystemService(Context.BLUETOOTH_SERVICE);
        BluetoothAdapter adapter = bm.getAdapter();

        if (adapter == null || !adapter.isEnabled()) {
            ba.raiseEvent(this, "java_connectionfailed", new Object[]{ "bluetooth_off" });
            return;
        }
		
	    BluetoothDevice device = adapter.getRemoteDevice(mac);

	    device.connectGatt(ctx, false, new BluetoothGattCallback() {

	        @Override
	        public void onConnectionStateChange(BluetoothGatt g, int status, int newState) {

				if (connectCancelled) return;

	            if (status != BluetoothGatt.GATT_SUCCESS) {
	                if (g != null) g.close();
	                gatt = null;
	                ba.raiseEvent(this, "java_connectionfailed", null);
	                return;
	            }

	            if (newState == BluetoothProfile.STATE_CONNECTED) {
	                gatt = g;
	                ba.raiseEvent(this, "java_connected", null);
	                g.discoverServices();
	            } else if (newState == BluetoothProfile.STATE_DISCONNECTED) {
					// Prevents write deadlock, Safe reconnect behavior
			        writing = false;
			        writeQueue.clear();
	                ba.raiseEvent(this, "java_disconnected", null);
	            }

	        }

			@Override
			public void onServicesDiscovered(BluetoothGatt g, int status) {
			    BluetoothGattService svc = g.getService(UUID.fromString(svcUUID));
			    if (svc != null) {
			        // RX = write
			        controlChar = svc.getCharacteristic(UUID.fromString(chrUUIDRX));
			        applyWriteType();

			        // TX = notify
			        BluetoothGattCharacteristic txChar = svc.getCharacteristic(UUID.fromString(chrUUIDTX));
			        if (txChar != null) {
			            gatt.setCharacteristicNotification(txChar, true);

			            BluetoothGattDescriptor desc = txChar.getDescriptor(
			                UUID.fromString("00002902-0000-1000-8000-00805f9b34fb")
			            );
			            if (desc != null) {
			                desc.setValue(BluetoothGattDescriptor.ENABLE_NOTIFICATION_VALUE);
			                gatt.writeDescriptor(desc);
			            }
			        }
			    }

			    if (svc == null || controlChar == null) {
			        ba.raiseEvent(this, "java_devicenotfound", null);
			    }
			}

	        @Override
	        public void onDescriptorWrite(BluetoothGatt g, BluetoothGattDescriptor d, int status) {
	            // Notifications are now active
	            if (status == BluetoothGatt.GATT_SUCCESS) {
	                ba.raiseEvent(this, "java_notificationsenabled", null);
	            }
	        }

	        @Override
	        public void onCharacteristicWrite(BluetoothGatt g, BluetoothGattCharacteristic c, int status) {
	            writing = false;
	            writeNext();
	        }

	        @Override
	        public void onCharacteristicChanged(BluetoothGatt g, BluetoothGattCharacteristic c) {
	            byte[] data = c.getValue();
	            ba.raiseEvent(this, "java_datareceived", new Object[]{ data });
	        }

	        @Override
	        public void onMtuChanged(BluetoothGatt g, int mtu, int status) {
	            boolean success = (status == BluetoothGatt.GATT_SUCCESS);
	            if (success) currentMTU = mtu;
	            ba.raiseEvent(this, "java_mtuchanged", new Object[]{ mtu, success });
	        }
	    });

	} catch (IllegalArgumentException e) {
        // INVALID MAC ADDRESS
        ba.raiseEvent(this, "java_connectionfailed",
            new Object[]{ "invalid_mac", mac });
    } catch (Exception e) {
        // ANY OTHER ERROR
        ba.raiseEvent(this, "java_connectionfailed",
            new Object[]{ "exception", e.getMessage() });
    }
}

public void nativeSetWriteMode(int mode) {
    writeMode = mode;
    if (controlChar != null) applyWriteType();
}

private void applyWriteType() {
    if (writeMode == 0) {
        controlChar.setWriteType(BluetoothGattCharacteristic.WRITE_TYPE_DEFAULT);
    } else {
        controlChar.setWriteType(BluetoothGattCharacteristic.WRITE_TYPE_NO_RESPONSE);
    }
}

public void nativeWrite(byte[] data) {
    if (controlChar == null || gatt == null) return;
    writeQueue.add(data);
    writeNext();
}

private void writeNext() {
    if (writing) return;
    byte[] data = writeQueue.poll();
    if (data == null) return;

    writing = true;
    controlChar.setValue(data);
    gatt.writeCharacteristic(controlChar);

    if (writeMode == 1) {
        // no-response → no callback
        writing = false;
        writeNext();
    }
}

public void nativeSetMTU(int mtu) {
    if (gatt != null) gatt.requestMtu(mtu);
}

public void nativeDisconnect() {
    if (gatt != null) {
        gatt.disconnect();
        gatt.close();
        gatt = null;
        ba.raiseEvent(this, "java_disconnected", null);
    }
}

public void nativeCancelConnect() {
    connectCancelled = true;
    if (gatt != null) {
        gatt.disconnect();
        gatt.close();
        gatt = null;
    }
}

#End If
