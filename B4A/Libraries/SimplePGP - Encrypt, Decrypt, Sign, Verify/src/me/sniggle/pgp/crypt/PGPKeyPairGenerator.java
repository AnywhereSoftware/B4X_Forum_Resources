package me.sniggle.pgp.crypt;

import me.sniggle.pgp.crypt.internal.BaseKeyPairGenerator;
import org.spongycastle.bcpg.ArmoredOutputStream;
import org.spongycastle.bcpg.HashAlgorithmTags;
import org.spongycastle.bcpg.sig.KeyFlags;
import org.spongycastle.crypto.generators.RSAKeyPairGenerator;
import org.spongycastle.crypto.params.RSAKeyGenerationParameters;
import org.spongycastle.openpgp.*;
import org.spongycastle.openpgp.operator.bc.BcPBESecretKeyEncryptorBuilder;
import org.spongycastle.openpgp.operator.bc.BcPGPContentSignerBuilder;
import org.spongycastle.openpgp.operator.bc.BcPGPDigestCalculatorProvider;
import org.spongycastle.openpgp.operator.bc.BcPGPKeyPair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Date;

/**
 * The the library dependent implementation of a KeyPairGenerator
 *
 * @author iulius
 */
public class PGPKeyPairGenerator extends BaseKeyPairGenerator {

  private static final Logger LOGGER = LoggerFactory.getLogger(PGPKeyPairGenerator.class);

  public PGPKeyPairGenerator() {
  }

  /**
   * creates and initializes a PGP Key Ring Generator
   *
   * @param userId
   *    the user id to use
   * @param password
   *    the password used for the private key
   * @param keySize
   *    the key size used for the keys
   * @return the initialized key ring generator or null if something goes wrong
   */
  private PGPKeyRingGenerator createKeyRingGenerator(String userId, String password, int keySize) {
    LOGGER.trace("createKeyRingGenerator(String, String, int)");
    LOGGER.trace("User ID: {}, Password: {}, Key Size: {}", userId, password == null ? "not set" : "********", keySize);
    PGPKeyRingGenerator generator = null;
    try {
      LOGGER.debug("Creating RSA key pair generator");
      RSAKeyPairGenerator generator1 = new RSAKeyPairGenerator();
      generator1.init(new RSAKeyGenerationParameters(BigInteger.valueOf(0x10001), getSecureRandom(), keySize, 12));
      LOGGER.debug("Generating Signing Key Pair");
      BcPGPKeyPair signingKeyPair = new BcPGPKeyPair(PGPPublicKey.RSA_SIGN, generator1.generateKeyPair(), new Date());
      LOGGER.debug("Generating Encyption Key Pair");
      BcPGPKeyPair encryptionKeyPair = new BcPGPKeyPair(PGPPublicKey.RSA_ENCRYPT, generator1.generateKeyPair(), new Date());
      LOGGER.debug("Generating Signature Key Properties");
      PGPSignatureSubpacketGenerator signatureSubpacketGenerator = new PGPSignatureSubpacketGenerator();
      signatureSubpacketGenerator.setKeyFlags(false, KeyFlags.SIGN_DATA | KeyFlags.CERTIFY_OTHER);
      signatureSubpacketGenerator.setPreferredSymmetricAlgorithms(false, getPreferredEncryptionAlgorithms());
      signatureSubpacketGenerator.setPreferredHashAlgorithms(false, getPreferredHashingAlgorithms());
      signatureSubpacketGenerator.setPreferredCompressionAlgorithms(false, getPreferredCompressionAlgorithms());

      LOGGER.debug("Generating Encyption Key Properties");
      PGPSignatureSubpacketGenerator encryptionSubpacketGenerator = new PGPSignatureSubpacketGenerator();
      encryptionSubpacketGenerator.setKeyFlags(false, KeyFlags.ENCRYPT_COMMS | KeyFlags.ENCRYPT_STORAGE);

      LOGGER.info("Creating PGP Key Ring Generator");
      generator = new PGPKeyRingGenerator(PGPPublicKey.RSA_SIGN, signingKeyPair, userId, new BcPGPDigestCalculatorProvider().get(HashAlgorithmTags.SHA1), signatureSubpacketGenerator.generate(), null, new BcPGPContentSignerBuilder(PGPPublicKey.RSA_SIGN, HashAlgorithmTags.SHA256), new BcPBESecretKeyEncryptorBuilder(getEncryptionAlgorithm()).build(password.toCharArray()));
      generator.addSubKey(encryptionKeyPair, encryptionSubpacketGenerator.generate(), null);
    } catch (PGPException e) {
      LOGGER.error("{}", e.getMessage());
      generator = null;
    }
    return generator;
  }

  /**
   * @see BaseKeyPairGenerator#getProvider()
   *
   * @return
   */
  protected  String getProvider() {
    return "BC";
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
  @Override
  public boolean generateKeyPair(String userId, String password, int keySize, OutputStream publicKey, OutputStream secrectKey) {
    LOGGER.trace("generateKeyPair(String, String, int, OutputStream, OutputStream)");
    LOGGER.trace("User ID: {}, Password: {}, Key Size: {}, Public Key: {}, Secret Key: {}", userId, password == null ? "not set" : "********", keySize, publicKey == null ? "not set" : "set", secrectKey == null ? "not set" : "set");
    boolean result = true;
    LOGGER.debug("Generating key ring generator");
    PGPKeyRingGenerator keyRingGenerator = createKeyRingGenerator(userId, password, keySize);
    LOGGER.debug("Generating public key ring");
    PGPPublicKeyRing publicKeyRing = keyRingGenerator.generatePublicKeyRing();
    
    LOGGER.debug("Generating secret key ring");
    PGPSecretKeyRing secretKeyRing = keyRingGenerator.generateSecretKeyRing();
    LOGGER.debug("Wrapping public key target stream in ArmoredOutputStream");
    try( OutputStream targetStream = new ArmoredOutputStream(publicKey) ) {
      LOGGER.info("Saving public key ring to public target");
      publicKeyRing.encode(targetStream);
    } catch (IOException e) {
      LOGGER.error("{}", e.getMessage());
      result &= false;
    }
    LOGGER.debug("Wrapping secret key target stream in ArmoredOutputStream");
    try( OutputStream targetStream = new ArmoredOutputStream(secrectKey) ) {
      LOGGER.debug("Create secret key ring collection");
      PGPSecretKeyRingCollection secretKeyRingCollection = new PGPSecretKeyRingCollection(Arrays.asList(secretKeyRing));
      LOGGER.info("Saving secret key ring to secret key target");
      secretKeyRingCollection.encode(targetStream);
    } catch (IOException | PGPException e) {
      LOGGER.error("{}", e.getMessage());
      result &= false;
    }
    return result;
  }

}
