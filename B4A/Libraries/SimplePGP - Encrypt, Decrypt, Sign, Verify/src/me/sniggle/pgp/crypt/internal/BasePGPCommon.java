package me.sniggle.pgp.crypt.internal;

import org.spongycastle.bcpg.ArmoredInputStream;
import org.spongycastle.openpgp.*;
import org.spongycastle.openpgp.operator.PBESecretKeyDecryptor;
import org.spongycastle.openpgp.operator.bc.BcKeyFingerprintCalculator;
import org.spongycastle.openpgp.operator.bc.BcPBESecretKeyDecryptorBuilder;
import org.spongycastle.openpgp.operator.bc.BcPGPDigestCalculatorProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.Iterator;

/**
 * Helper class centralizing access to commonly used PGP function by (all) PGP classes
 *
 * @author iulius
 */
public abstract class BasePGPCommon {

  private static final Logger LOGGER = LoggerFactory.getLogger(BasePGPCommon.class);

  /**
   * A functional interface to find the correct PGP key
   *
   * @param <T> should be PGPPublicKey or PGPSecretKey
   */
  protected interface KeyFilter<T> {

    /**
     *
     * @param pgpKey
     *    the PGP key to check
     * @return true if the PGP key matches the selection criteria
     */
    boolean accept(T pgpKey);

  }

  private boolean unlimitedEncryptionStrength = false;
  private int compressionAlgorithm = AlgorithmSelection.getDefaultCompressionAlgorithm();

  protected BasePGPCommon() {
  }

  /**
   * accessor to the compression algorithm
   *
   * @return the compression algorithm to use
   */
  protected int getCompressionAlgorithm() {
    return compressionAlgorithm;
  }

  /**
   * set the compression algorithm
   *
   * @param compressionAlgorithm
   *    the compression algorithm constant
   */
  public void setCompressionAlgorithm(int compressionAlgorithm) {
    this.compressionAlgorithm = compressionAlgorithm;
  }

  /**
   *  retrieve the appropriate secret key from the secret key ring collection
   *  based on the key filter
   *
   * @param secretKeyRingCollection
   *    the PGP secret key ring collection
   * @param keyFilter
   *    the key filter to apply
   * @return the secret key or null if none matches the filter
   * @throws PGPException
   */
  protected PGPSecretKey retrieveSecretKey(PGPSecretKeyRingCollection secretKeyRingCollection, KeyFilter<PGPSecretKey> keyFilter) throws PGPException {
    LOGGER.trace("retrieveSecretKey(PGPSecretKeyRingCollection, KeyFilter<PGPSecretKey>)");
    LOGGER.trace("Secret KeyRing Collection: {}, Key Filter: {}", secretKeyRingCollection == null ? "not set" : "set", keyFilter == null ? "not set" : "set");
    PGPSecretKey result = null;
    Iterator<PGPSecretKeyRing> secretKeyRingIterator = secretKeyRingCollection.getKeyRings();
    PGPSecretKeyRing secretKeyRing = null;
    LOGGER.debug("Iterating secret key ring");
    while( result == null && secretKeyRingIterator.hasNext() ) {
      secretKeyRing = secretKeyRingIterator.next();
      Iterator<PGPSecretKey> secretKeyIterator = secretKeyRing.getSecretKeys();
      LOGGER.debug("Iterating secret keys in key ring");
      while( secretKeyIterator.hasNext() ) {
        PGPSecretKey secretKey = secretKeyIterator.next();
        LOGGER.info("Found secret key: {}", secretKey.getKeyID());
        LOGGER.debug("Checking secret key with filter");
        if (keyFilter.accept(secretKey)) {
          LOGGER.info("Key {} selected from secret key ring");
          result = secretKey;
        }
      }
    }
    return result;
  }

  /**
   * helper method to read the secret key
   *
   * @param secretKey
   *    the secret key stream
   * @param userId
   *    the user id
   * @return the applicable secret key or null if none is part of the stream for the user id
   * @throws IOException
   * @throws PGPException
   */
  protected PGPSecretKey findSecretKey(InputStream secretKey, final String userId) throws IOException, PGPException {
    LOGGER.trace("findSecretKey(InputStream, String)");
    LOGGER.trace("Secret Key: {}, User ID: {}", secretKey == null ? "not set" : "set", userId);
    return findSecretKey(secretKey, new KeyFilter<PGPSecretKey>() {

      @Override
      public boolean accept(PGPSecretKey secretKey) {
        boolean result = false;
        Iterator<String> userIdIterator = secretKey.getUserIDs();
        while( userIdIterator.hasNext() && !result) {
          result |= userId.equals(userIdIterator.next());
        }
        return result;
      }

    });
  }

  /**
   * helper method to read a specific secret key
   *
   * @param secretKey
   *    the secret key stream
   * @param keyId
   *    the key id
   * @return the applicable secret key or null if none is part of the stream for the key id
   * @throws IOException
   * @throws PGPException
   */
  protected PGPSecretKey findSecretKey(InputStream secretKey, final long keyId) throws IOException, PGPException {
    LOGGER.trace("findSecretKey(InputStream, long)");
    LOGGER.trace("Secret Key: {}, Key ID: {}", secretKey == null ? "not set" : "set", keyId);
    return findSecretKey(secretKey, new KeyFilter<PGPSecretKey>() {
      @Override
      public boolean accept(PGPSecretKey secretKey) {
        return secretKey.getKeyID() == keyId;
      }
    });
  }

  /**
   * reads the given secret key and applies the provided key filter
   *
   * @param secretKey
   *    the secret key stream
   * @param keyFilter
   *    the filter to apply on the stream
   * @return the secret key or null if none matches the filter acceptance criteria
   * @throws IOException
   * @throws PGPException
   */
  protected PGPSecretKey findSecretKey(InputStream secretKey, KeyFilter<PGPSecretKey> keyFilter) throws IOException, PGPException {
    LOGGER.trace("findSecretKey(InputStream, KeyFilter<PGPSecretKey>)");
    PGPSecretKey result = null;
    LOGGER.debug("Wrapping secret key stream in ArmoredInputStream");
    try( InputStream armoredSecretKey = new ArmoredInputStream(secretKey) ) {
      LOGGER.debug("Creating PGPSecretKeyRingCollection");
      PGPSecretKeyRingCollection keyRingCollection = new PGPSecretKeyRingCollection(armoredSecretKey, new BcKeyFingerprintCalculator());
      result = retrieveSecretKey(keyRingCollection, keyFilter);
    }
    return result;
  }

  /**
   * read a private key and unlock it with the given password
   *
   * @param secretKey
   *    the secret key stream
   * @param userId
   *    the required user id
   * @param password
   *    the password to unlock the private key
   * @return the applicable private key or null if none is found
   * @throws PGPException
   * @throws IOException
   */
  protected PGPPrivateKey findPrivateKey(InputStream secretKey, final String userId, String password) throws PGPException, IOException {
    LOGGER.trace("findPrivateKey(InputStream, String, String)");
    LOGGER.trace("Secret Key: {}, User ID: {}, Password: {}", secretKey == null ? "not set" : "set", userId, password == null ? "not set" : "********");
    return findPrivateKey(secretKey, password, new KeyFilter<PGPSecretKey>() {

      @Override
      public boolean accept(PGPSecretKey secretKey) {
        boolean result = false;
        Iterator<String> userIdIterator = secretKey.getUserIDs();
        while (!result && userIdIterator.hasNext()) {
          result = userId.equals(userIdIterator.next());
        }
        return result;
      }

    });
  }

  /**
   * read a private key and unlock it with the given password
   *
   * @param secretKey
   *    the secret key stream
   * @param keyId
   *    the required key id
   * @param password
   *    the password to unlock the private key
   * @return the applicable private key or null if none is found
   * @throws PGPException
   * @throws IOException
   */
  protected PGPPrivateKey findPrivateKey(InputStream secretKey, final long keyId, String password) throws PGPException, IOException {
    LOGGER.trace("findPrivateKey(InputStream, long, String)");
    LOGGER.trace("Secret Key: {}, Key ID: {}, Password: {}", secretKey == null ? "not set" : "set", keyId, password == null ? "not set" : "********");
    return findPrivateKey(secretKey, password, new KeyFilter<PGPSecretKey>() {
      @Override
      public boolean accept(PGPSecretKey secretKey) {
        return secretKey.getKeyID() == keyId;
      }
    });
  }

  /**
   * read a private key and unlock it with the given password
   *
   * @param secretKey
   *    the secret key stream
   * @param password
   *    the password to use to unlock the private key
   * @param keyFilter
   *    the filter ot find the appropriate key
   * @return the appropriate private key  or null if none matches the filter
   * @throws IOException
   * @throws PGPException
   */
  protected PGPPrivateKey findPrivateKey(InputStream secretKey, String password, KeyFilter<PGPSecretKey> keyFilter) throws IOException, PGPException {
    LOGGER.trace("findPrivateKey(InputStream, String, KeyFilter<PGPSecretKey>)");
    LOGGER.trace("Secret Key: {}, Password: {}, KeyFilter: {}", secretKey == null ? "not set" : "set", password == null ? "not set" : "********", keyFilter == null ? "not set" : "set");
    return findPrivateKey(findSecretKey(secretKey, keyFilter), password);
  }

  /**
   * read the private key from the given secret key
   *
   * @param pgpSecretKey
   *    the secret key
   * @param password
   *    the password to unlock the private key
   * @return the unlocked private key
   * @throws PGPException
   */
  protected PGPPrivateKey findPrivateKey(PGPSecretKey pgpSecretKey, String password) throws PGPException {
    LOGGER.trace("findPrivateKey(PGPSecretKey, String)");
    LOGGER.trace("Secret Key: {}, Password: {}", pgpSecretKey == null ? "not set" : "set", password == null ? "not set" : "********");
    PGPPrivateKey result = null;
    PBESecretKeyDecryptor pbeSecretKeyDecryptor = new BcPBESecretKeyDecryptorBuilder(new BcPGPDigestCalculatorProvider()).build(password.toCharArray());
    LOGGER.info("Extracting private key");
    result = pgpSecretKey.extractPrivateKey(pbeSecretKeyDecryptor);
    if( result == null && LOGGER.isErrorEnabled() ) {
      LOGGER.error("No private key could be extracted");
    }
    return result;
  }

  /**
   * reads the public key from the given stream
   *
   * @param publicKey
   *    the input key stream
   * @param keyFilter
   *    the filter to apply
   * @return the matching PGP public key
   */
  protected PGPPublicKey findPublicKey(InputStream publicKey, KeyFilter<PGPPublicKey> keyFilter ) {
    LOGGER.trace("findPublicKey(InputStream, KeyFilter<PGPPublicKey>)");
    LOGGER.trace("Public Key: {}, Key Filter: {}", publicKey == null ? "not set" : "set", keyFilter == null ? "not set" : "set");
    return retrievePublicKey(readPublicKeyRing(publicKey), keyFilter);
  }

  /**
   * reads the PGP public key from a PublicKeyRing
   *
   * @param publicKeyRing
   *    the source public key ring
   * @param keyFilter
   *    the filter to apply
   * @return the matching PGP public or null if none matches
   */
  protected PGPPublicKey retrievePublicKey(PGPPublicKeyRing publicKeyRing, KeyFilter<PGPPublicKey> keyFilter) {
    LOGGER.trace("retrievePublicKey(PGPPublicKeyRing, KeyFilter<PGPPublicKey>)");
    PGPPublicKey result = null;
    Iterator<PGPPublicKey> publicKeyIterator = publicKeyRing.getPublicKeys();
    LOGGER.debug("Iterating through public keys in public key ring");
    while( result == null && publicKeyIterator.hasNext() ) {
      PGPPublicKey key = publicKeyIterator.next();
      LOGGER.info("Found secret key: {}", key.getKeyID());
      LOGGER.debug("Checking public key with filter");
      if( keyFilter.accept(key) ) {
        LOGGER.info("Public key {} selected from key ring", key.getKeyID());
        result = key;
      }
    }
    return result;
  }

  /**
   * reads the public key ring from the input stream
   *
   * @param publicKey
   *    the public key stream
   * @return the public key ring
   */
  protected PGPPublicKeyRing readPublicKeyRing(InputStream publicKey) {
    LOGGER.trace("readPublicKeyRing(InputStream)");
    PGPPublicKeyRing result = null;
    LOGGER.debug("Wrapping public key stream in decoder stream");
    try( InputStream decoderStream = PGPUtil.getDecoderStream(publicKey) ) {
      LOGGER.debug("Creating PGP Object Factory");
      PGPObjectFactory pgpObjectFactory = new PGPObjectFactory(decoderStream, new BcKeyFingerprintCalculator());
      Object o = null;
      LOGGER.debug("Looking up PGP Public KeyRing");
      while( (o = pgpObjectFactory.nextObject()) != null && result == null ) {
        if( o instanceof PGPPublicKeyRing ) {
          LOGGER.info("PGP Public KeyRing retrieved");
          result = (PGPPublicKeyRing)o;
        }
      }
    } catch (IOException e) {
      LOGGER.error("{}", e.getMessage());
    }
    return result;
  }

  /**
   * accessor to the secure random generator
   *
   * @return the secure random generator
   */
  protected SecureRandom getSecureRandom() {
    return new SecureRandom();
  }

  /**
   * setter for the unlimited strength encryption flag
   *
   * @param unlimitedEncryptionStrength
   */
  public void setUnlimitedEncryptionStrength(boolean unlimitedEncryptionStrength) {
    this.unlimitedEncryptionStrength = unlimitedEncryptionStrength;
  }

  /**
   * the accessor of the unlimited encryption strength
   *
   * @return the value of the flag
   */
  protected boolean isUnlimitedEncryptionStrength() {
    return unlimitedEncryptionStrength;
  }

}
