package de.donmanfred;

import java.io.InputStream;
import java.io.OutputStream;

import org.spongycastle.crypto.CipherParameters;
import org.spongycastle.crypto.InvalidCipherTextException;

import android.content.Context;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Hide;
import anywheresoftware.b4a.BA.Pixel;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.keywords.Common.DesignerCustomView;
import anywheresoftware.b4a.objects.CustomViewWrapper;
import anywheresoftware.b4a.objects.LabelWrapper;
import anywheresoftware.b4a.objects.PanelWrapper;
import anywheresoftware.b4a.objects.ViewWrapper;
import anywheresoftware.b4a.objects.collections.Map;
import me.sniggle.pgp.crypt.KeyPairGenerator;
import me.sniggle.pgp.crypt.PGPKeyPairGenerator;
import me.sniggle.pgp.crypt.PGPMessageEncryptor;

//@Version(1.00f)
@ShortName("PGPMessageEncryptor")
//@ActivityObject

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class PGPMessageEncryptorwrapper  {
	private BA ba;
	private String eventName;
	private PGPMessageEncryptor encryptor;
	/**
	 *  <link>...|http://www.b4x.com</link>
	 */
	public static void LIBRARY_DOC() {
	}

	 public void Initialize(BA ba, String EventName) {
		 this.eventName = EventName.toLowerCase(BA.cul);
		 this.ba = ba;
		 encryptor = new PGPMessageEncryptor();
		 
	}

	public boolean decrypt(String passwordOfReceiversPrivateKey, InputStream privateKeyOfReceiver, InputStream encryptedData, OutputStream target) {
		return encryptor.decrypt(passwordOfReceiversPrivateKey, privateKeyOfReceiver, encryptedData, target);
 	}
	public boolean decrypt2(String passwordOfReceiversPrivateKey, InputStream privateKeyOfReceiver, InputStream publicKeyOfSender, InputStream encryptedData, OutputStream target) {
		return encryptor.decrypt(passwordOfReceiversPrivateKey, privateKeyOfReceiver, publicKeyOfSender, encryptedData, target);
 	}
	public boolean encrypt(InputStream publicKeyOfRecipient, String inputDataName, InputStream plainInputData, OutputStream target) {
		return encryptor.encrypt(publicKeyOfRecipient, inputDataName, plainInputData, target);
 	}
	public boolean encrypt2(InputStream publicKeyOfRecipient, InputStream privateKeyOfSender, String userIdOfSender, String passwordOfSendersPrivateKey, InputStream plainInputData, String inputDataName, OutputStream target) {
		return encryptor.encrypt(publicKeyOfRecipient, privateKeyOfSender, userIdOfSender, passwordOfSendersPrivateKey, inputDataName, plainInputData, target);
 	}
	public void init(boolean arg0, CipherParameters params) {
		encryptor.init(arg0, params);
 	}
	public byte[] messageDecrypt(byte[] arg0) throws InvalidCipherTextException {
		return encryptor.messageDecrypt(arg0);
 	}
	public byte[] messageEncrypt(byte[] arg0) throws InvalidCipherTextException {
		return encryptor.messageEncrypt(arg0);
	}	
	
}
