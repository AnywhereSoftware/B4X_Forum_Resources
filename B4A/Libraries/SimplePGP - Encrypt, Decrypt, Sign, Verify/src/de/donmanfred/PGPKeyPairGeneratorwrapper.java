package de.donmanfred;

import java.io.OutputStream;

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

@Version(1.00f)
@ShortName("PGPKeyPairGenerator")
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

public class PGPKeyPairGeneratorwrapper  {
	private BA ba;
	private String eventName;
	private PGPKeyPairGenerator gen; 
	/**
	 *  <link>...|http://www.b4x.com</link>
	 */
	public static void LIBRARY_DOC() {
	}

	 public void Initialize(BA ba, String EventName) {
		 this.eventName = EventName.toLowerCase(BA.cul);
		 this.ba = ba;
		 gen = new PGPKeyPairGenerator();
	}

	public boolean generateKeyPair(String userId, String password, OutputStream publicKey, OutputStream secrectKey) {
		return gen.generateKeyPair(userId, password, publicKey, secrectKey);
 	}

  /**
   * @see KeyPairGenerator#generateKeyPair(String, String, int, OutputStream, OutputStream)
   *
   * @param userId
   *    the user id for the PGP key pair
   * @param password
   *    the password used to secure the secret (private) key
   * @param keySize
   *    the custom key size
   * @param publicKey
   *    the target stream for the public key
   * @param secrectKey
   *    the target stream for the secret (private) key
   * @return
   */
 public boolean generateKeyPair2(String userId, String password, int keySize, OutputStream publicKey, OutputStream secrectKey) {
		return gen.generateKeyPair(userId, password, keySize, publicKey, secrectKey);
 	}

	
	
}
