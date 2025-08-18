/*
 * Copyright (C) The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package tapcardwrapper;

import anywheresoftware.b4a.AbsObjectWrapper;

import android.content.Context;
import android.view.ViewGroup;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.Hide;
import anywheresoftware.b4a.BA.Pixel;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.keywords.Common.DesignerCustomView;
import anywheresoftware.b4a.objects.LabelWrapper;
import anywheresoftware.b4a.objects.PanelWrapper;
import anywheresoftware.b4a.objects.ViewWrapper;
import anywheresoftware.b4a.BA.ActivityObject;
import anywheresoftware.b4a.BA.Permissions;
import anywheresoftware.b4a.IOnActivityResult;

import anywheresoftware.b4a.BA.Events;


//import android.support.v7.app.AppCompatActivity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.text.format.DateFormat;

import java.io.IOException;

import io.github.tapcard.android.NFCCardReader;
import io.github.tapcard.emvnfccard.model.EmvCard;

import java.io.InputStream;
import java.io.InputStreamReader;

@ActivityObject
@ShortName("TapCard")
@Events(values={"scan_result(cardNumber As String, cardType As String, expireDate As String, cardHolderLastname As String, cardHolderFirstname As String, isNfcLocked As Boolean)", "scan_completed(completed As Boolean)", "command_response(command As String, response As String)", "tag_data(tagname As String, tags As String, taglengths As String, tagvalues As String)"})
@Author("Wrapped by: Johan Schoeman")
@Version(1.00f)
@DependsOn(values={"rxjava-1.0.17", "rxjava-2.0.2"})
@Permissions(values={"android.permission.NFC"})


public class tapcardWrapper { 
//public class androidVisionMasterWrapper implements View.OnClickListener {
	
	@Hide
	public static BA ba;
	@Hide
	public static String eventName;
    private NFCCardReader nfcCardReader;
	
	public void Initialize(BA paramBA, String paramString) {
	    eventName = paramString.toLowerCase(BA.cul);
	    ba = paramBA;

	    String str = paramString.toLowerCase(BA.cul);
		
		nfcCardReader = new NFCCardReader(ba.activity);
		onNewIntent(ba.activity.getIntent());

	}	
	
    //@Override
    protected void onNewIntent(Intent intent) {
        if (nfcCardReader.isSuitableIntent(intent)) {
            BA.Log("Reading card....");
            readCardDataAsync(intent);
        }
    }

    //@Override
    protected void onResume() {
        nfcCardReader.enableDispatch();
        //super.onResume();
    }

    //@Override
    protected void onPause() {
        nfcCardReader.disableDispatch();
        //super.onPause();
    }

    private void showCardInfo(EmvCard card) {
        String text;

        if (card != null) {
            text = TextUtils.join("\n", new Object[]{
                    CardUtils.formatCardNumber(card.getCardNumber(), card.getType()),
                    DateFormat.format("M/y", card.getExpireDate()),
                    "---",
                    "Bank info (probably): ",
                    card.getAtrDescription(),
                    "---",
                    card.toString().replace(", ", ",\n")
            });
        } else {
            text = "Error reading card";
        }
		
		String mycardnumber = "";
		String mycardtype = "";
		String myexpiredate = "";
		String mylastname = "";
		String myfirstname = "";
		boolean nfcavailable = true;
		
		mycardnumber = CardUtils.formatCardNumber(card.getCardNumber(), card.getType());
		if (mycardnumber == null ) mycardnumber = "Not Available";
		mycardtype = "" + card.getType();
		if (mycardtype == null ) mycardtype = "Not Available";
		myexpiredate = "" + DateFormat.format("M/y", card.getExpireDate());
		if (myexpiredate == null ) myexpiredate = "Not Available";
		mylastname = card.getHolderLastname();
		if (mylastname == null ) mylastname = "Not Available";
		myfirstname = card.getHolderFirstname();
		if (myfirstname == null ) myfirstname = "Not Available";
		nfcavailable = card.isNfcLocked();
		
        ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_scan_result", true, new Object[]{mycardnumber, mycardtype, myexpiredate, mylastname, myfirstname, nfcavailable});
    }

    private void readCardDataAsync(Intent intent) {
        new AsyncTask<Intent, Object, EmvCard>() {

            @Override
            protected EmvCard doInBackground(Intent... intents) {
                try {
                    return nfcCardReader.readCardBlocking(intents[0]);
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (NFCCardReader.WrongIntentException e) {
                    e.printStackTrace();
                } catch (NFCCardReader.WrongTagTech e) {
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            protected void onPostExecute(EmvCard emvCard) {
                showCardInfo(emvCard);
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_scan_completed", true, new Object[]{});
				
            }
        }.execute(intent);
    }	
	
	@Hide
	public static InputStream ips = null;
	public void setIPS (InputStream ips) {
		this.ips = ips;
	}
}
