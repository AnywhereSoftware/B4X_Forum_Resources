package io.github.tapcard.android;

import android.app.Activity;
import android.content.Intent;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.IsoDep;

import java.io.IOException;
import java.util.Collection;
import java.util.concurrent.Callable;

import io.github.tapcard.emvnfccard.log.Logger;
import io.github.tapcard.emvnfccard.log.LoggerFactory;
import io.github.tapcard.emvnfccard.model.EmvCard;
import io.github.tapcard.emvnfccard.parser.EmvParser;
import io.github.tapcard.emvnfccard.utils.AtrUtils;
import io.github.tapcard.emvnfccard.utils.BytesUtils;
import rx.Scheduler;
import rx.Single;
import rx.schedulers.Schedulers;

@SuppressWarnings({"WeakerAccess", "unused"})
public class NFCCardReader {
    private NFCUtils nfcUtils;
    private AndroidNfcProvider provider;
    private Logger logger;

    public NFCCardReader(Activity activity) {
        nfcUtils = new NFCUtils(activity);
        provider = new AndroidNfcProvider();
        logger = LoggerFactory.getLogger(NFCCardReader.class);
    }

    /**
     * Begin waiting for bank card been tapped to NFC module of phone
     */
    public void enableDispatch() {
        nfcUtils.enableDispatch();
    }

    /**
     * Stop waiting for bank card
     */
    public void disableDispatch() {
        nfcUtils.disableDispatch();
    }

    /**
     * Checks that intent is suitable for NFC card reading
     *
     * @param intent intent for check
     * @return true - intent is good. false - this is not the intent you're looking for
     */
    public boolean isSuitableIntent(Intent intent) {
        final Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
        if (tag == null) {
            logger.debug("No TAG in intent");
            return false;
        }

        IsoDep tagComm = IsoDep.get(tag);
        if (tagComm == null) {
            logger.debug("IsoDep was not enumerated in getTechList()");
            return false;
        }

        return true;
    }

    /**
     * Read card data from given intent.
     * <p>Note that this method is blocking. You should not use it as is.
     * Instead - wrap it into some async framework: RxJava, AsyncTask, etc</p>
     * <p>
     * <p>Intent by itself does not contain all data. It contains metadata of NFC card.
     * To read card data, library will open NFC connection and transfer some bytes.</p>
     * <p>
     * <p>You should check that this intent contain right data with {@link #isSuitableIntent(Intent)}
     * before calling this method</p>
     *
     * @param intent intent with initial card information.
     * @return Ready for use card data
     * @throws IOException          may be thrown during NFC data transfer
     * @throws WrongIntentException thrown if intent does not contain {@link NfcAdapter#EXTRA_TAG}
     * @throws WrongTagTech         thrown when this NFC tech is not supported:
     *                              not enumerated in {@link Tag#getTechList}.
     */
    public EmvCard readCardBlocking(Intent intent)
            throws IOException, WrongIntentException, WrongTagTech {
        final Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
        if (tag == null) {
            throw new WrongIntentException("No TAG in intent");
        }

        IsoDep tagComm = IsoDep.get(tag);
        if (tagComm == null) {
            throw new WrongTagTech();
        }

        try {
            tagComm.connect();
            provider.setmTagCom(tagComm);

            EmvParser parser = new EmvParser(provider, true);
            final EmvCard emvCard = parser.readEmvCard();

            emvCard.setAtrDescription(extractAtsDescription(tagComm));
            return emvCard;
        } finally {
            tagComm.close();
        }
    }

    /**
     * Get ATS from isoDep and find matching description
     */
    private Collection<String> extractAtsDescription(final IsoDep pIso) {
        byte[] pAts = null;
        if (pIso.isConnected()) {
            // Extract ATS from NFC-A
            pAts = pIso.getHistoricalBytes();
            if (pAts == null) {
                // Extract ATS from NFC-B
                pAts = pIso.getHiLayerResponse();
            }
        }
        return AtrUtils.getDescriptionFromAts(BytesUtils.bytesToString(pAts));
    }

    /**
     * Read card data from given intent.
     * <p>Intent by itself does not contain all data. It contains metadata of NFC card.
     * To read card data, library will open NFC connection and transfer some bytes.</p>
     * <p>You should check that this intent contain right data with {@link #isSuitableIntent(Intent)}
     * before calling this method</p>
     * <p>Operates on IO scheduler</p>
     *
     * @param intent intent with initial card information.
     */
    public Single<EmvCard> readCardRx1(final Intent intent) {
        return readCardRx1(intent, Schedulers.io());
    }

    /**
     * Read card data from given intent.
     * <p>Intent by itself does not contain all data. It contains metadata of NFC card.
     * To read card data, library will open NFC connection and transfer some bytes.</p>
     * <p>You should check that this intent contain right data with {@link #isSuitableIntent(Intent)}
     * before calling this method</p>
     * <p>Operates on given scheduler</p>
     *
     * @param intent    intent with initial card information.
     * @param scheduler scheduler for operating
     */
    public Single<EmvCard> readCardRx1(final Intent intent, Scheduler scheduler) {
        return Single
                .fromCallable(new Callable<EmvCard>() {
                    @Override
                    public EmvCard call() throws Exception {
                        return readCardBlocking(intent);
                    }
                })
                .subscribeOn(scheduler);
    }

    /**
     * Read card data from given intent.
     * <p>Intent by itself does not contain all data. It contains metadata of NFC card.
     * To read card data, library will open NFC connection and transfer some bytes.</p>
     * <p>You should check that this intent contain right data with {@link #isSuitableIntent(Intent)}
     * before calling this method</p>
     * <p>Operates on IO scheduler</p>
     *
     * @param intent intent with initial card information.
     */
    public io.reactivex.Single<EmvCard> readCardRx2(final Intent intent) {
        return readCardRx2(intent, io.reactivex.schedulers.Schedulers.io());
    }

    /**
     * Read card data from given intent.
     * <p>Intent by itself does not contain all data. It contains metadata of NFC card.
     * To read card data, library will open NFC connection and transfer some bytes.</p>
     * <p>You should check that this intent contain right data with {@link #isSuitableIntent(Intent)}
     * before calling this method</p>
     * <p>Operates on given scheduler</p>
     *
     * @param intent    intent with initial card information.
     * @param scheduler scheduler for operating
     */
    public io.reactivex.Single<EmvCard> readCardRx2(final Intent intent, io.reactivex.Scheduler scheduler) {
        return io.reactivex.Single.
                fromCallable(new Callable<EmvCard>() {
                    @Override
                    public EmvCard call() throws Exception {
                        return readCardBlocking(intent);
                    }
                })
                .subscribeOn(scheduler);
    }

    public static class WrongIntentException extends Exception {
        WrongIntentException(String detailMessage) {
            super(detailMessage);
        }
    }

    public static class WrongTagTech extends Exception {
        WrongTagTech() {
            super("IsoDep was not enumerated in getTechList()");
        }
    }
}
