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
import me.sniggle.pgp.crypt.PGPMessageSigner;

//@Version(1.00f)
@ShortName("PGPMessageSigner")
//@ActivityObject

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})
/**
 * com.android.support:support-v4
 * com.android.support:appcompat-v7
 * com.android.support:cardview-v7
 * com.android.support:gridlayout-v7
 * com.android.support:mediarouter-v7
 * com.android.support:palette-v7
 * com.android.support:recyclerview-v
 * com.android.support:preference-v7
 * com.android.support:support-v13
 */

public class PGPMessageSignerwrapper  {
	private BA ba;
	private String eventName;
	private PGPMessageSigner signer;
	/**
	 *  <link>...|http://www.b4x.com</link>
	 */
	public static void LIBRARY_DOC() {
	}

	 public void Initialize(BA ba, String EventName) {
		 this.eventName = EventName.toLowerCase(BA.cul);
		 this.ba = ba;
		 signer = new PGPMessageSigner();
	}

	public void setCompressionAlgorithm(int compressionAlgorithm) {
		signer.setCompressionAlgorithm(compressionAlgorithm);		 
 	}
	public void setUnlimitedEncryptionStrength(boolean unlimitedEncryptionStrength) {
		signer.setUnlimitedEncryptionStrength(unlimitedEncryptionStrength);		 
 	}
	public boolean signMessage(InputStream privateKeyOfSender, String userIdForPrivateKey, String passwordOfPrivateKey, InputStream message, OutputStream signature) {
		return signer.signMessage(privateKeyOfSender, userIdForPrivateKey, passwordOfPrivateKey, message, signature);		 
 	}
	public boolean verifyMessage(InputStream publicKeyOfSender, InputStream message, InputStream signatureStream) {
		return signer.verifyMessage(publicKeyOfSender, message, signatureStream);		 
 	}
	
}
