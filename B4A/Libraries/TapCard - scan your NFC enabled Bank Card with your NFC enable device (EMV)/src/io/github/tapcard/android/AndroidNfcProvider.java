package io.github.tapcard.android;

import android.nfc.tech.IsoDep;
import android.util.Log;

import java.io.IOException;

import io.github.tapcard.emvnfccard.enums.SwEnum;
import io.github.tapcard.emvnfccard.exception.CommunicationException;
import io.github.tapcard.emvnfccard.parser.IProvider;
import io.github.tapcard.emvnfccard.utils.BytesUtils;
import io.github.tapcard.emvnfccard.utils.TlvUtil;

import anywheresoftware.b4a.BA;

import tapcardwrapper.tapcardWrapper;

/**
 * Provider used to communicate with EMV card
 */
class AndroidNfcProvider implements IProvider {

    /**
     * TAG for logger
     */
    private static final String TAG = AndroidNfcProvider.class.getName();

    /**
     * Tag comm
     */
    private IsoDep mTagCom;

    private boolean debugMode = false;

    @Override
    public byte[] transceive(final byte[] pCommand) throws CommunicationException {
        if (debugMode) {
            //BA.Log("command: " + BytesUtils.bytesToString(pCommand));
        }
		//BA.Log("command: " + BytesUtils.bytesToString(pCommand));
		this.command = BytesUtils.bytesToString(pCommand);
        byte[] response;
        try {
            // send command to emv card
            response = mTagCom.transceive(pCommand);
        } catch (IOException e) {
            throw new CommunicationException(e.getMessage());
        }

        //BA.Log("resp 1: " + BytesUtils.bytesToString(response));
        try {
            //BA.Log("resp 2: " + TlvUtil.prettyPrintAPDUResponse(response));
			this.prettyResponse = TlvUtil.prettyPrintAPDUResponse(response);
            SwEnum val = SwEnum.getSW(response);
            if (val != null) {
                //BA.Log("resp 3: " + val.getDetail());
            }
        } catch (Exception e) {
            Log.w(TAG, e.toString());
        }
		
		tapcardWrapper.ba.raiseEventFromDifferentThread(this, null, 0, tapcardWrapper.eventName + "_command_response", true, new Object[]{command, prettyResponse});

        return response;
    }
	
	private String command = "";
	private String prettyResponse = "";
	

    /**
     * Enable ro disable debug info logging
     */
    public AndroidNfcProvider setDebugMode(boolean debugMode) {
        this.debugMode = debugMode;
        return this;
    }

    /**
     * Setter for the field mTagCom
     *
     * @param mTagCom the mTagCom to set
     */
    void setmTagCom(final IsoDep mTagCom) {
        this.mTagCom = mTagCom;
    }

    private void log(String logLine) {
        if (debugMode) {
            Log.d(TAG, logLine);
        }
    }
}
