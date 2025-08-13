package me.sniggle.pgp.crypt.internal;

import me.sniggle.pgp.crypt.KeyPairGenerator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.OutputStream;
import java.security.SecureRandom;

/**
 * The common functionality of a base key generator which is dependency (BouncyCastle vs. SpongyCastle) independent
 *
 * @author iulius
 */
public abstract class BaseKeyPairGenerator implements KeyPairGenerator {

  private static final Logger LOGGER = LoggerFactory.getLogger(BaseKeyPairGenerator.class);

  /**
   * flag to indicate whether the the Java Unlimited Strength library is installed, needs to be set manually!
   */
  private boolean unlimitedStrengthEncryption = false;

  protected BaseKeyPairGenerator() {
    super();
  }

  /**
   * provides access to a securely initialized SecureRandom generator
   *
   * @return a secure random instance
   */
  protected SecureRandom getSecureRandom() {
    return new SecureRandom();
  }

  /**
   * accessor to the defined signing key type
   *
   * @return the signing key constant
   */
  protected int getSigningKeyType() {
    return AlgorithmSelection.getSigningKeyType();
  }

  /**
   * accessor to the defined encryption key type
   *
   * @return the encryption key constant
   */
  protected int getEncryptionKeyType() {
    return AlgorithmSelection.getEncryptionKeyType();
  }

  /**
   * accessor to the preferred standard encryption algorithms
   *
   * @return the preferred encryption algorithms
   */
  protected int[] getPreferredEncryptionAlgorithms() {
    return AlgorithmSelection.getPreferredEncryptionAlgorithms();
  }

  /**
   * accessor to the preferred standard hashing algorithms
   *
   * @return the preferred hashing algorithms
   */
  protected int[] getPreferredHashingAlgorithms() {
    return AlgorithmSelection.getPreferredHashingAlgorithms();
  }

  /**
   * accessor to the preferred standard compression algorithms
   *
   * @return the preferred compression algorithms
   */
  protected int[] getPreferredCompressionAlgorithms() {
    return AlgorithmSelection.getPreferredCompressionAlgorithms();
  }

  /**
   * the provider identifier
   *
   * @return the provider identifier
   */
  protected abstract String getProvider();

  /**
   * the strongest allowed encryption algorithm
   *
   * @return AlgorithmSelection#getStrongEncryptionAlgorithm() if BaseKeyPairGenerator#unlimitedStrengthEncryption is true, otherwise AlgorithmSelection#getWeakEncryptionAlgorithm()
   */
  protected int getEncryptionAlgorithm() {
    return (unlimitedStrengthEncryption) ? AlgorithmSelection.getStrongEncryptionAlgorithm() : AlgorithmSelection.getWeakEncryptionAlgorithm();
  }

  /**
   * set the unlimited strength encryption flag
   *
   * @param unlimitedStrengthEncryption
   */
  public void setUnlimitedStrengthEncryption(boolean unlimitedStrengthEncryption) {
    this.unlimitedStrengthEncryption = unlimitedStrengthEncryption;
  }

  /**
   * @see KeyPairGenerator#generateKeyPair(String, String, OutputStream, OutputStream)
   *
   * @param userId
   *    the user id for the PGP key pair
   * @param password
   *    the password used to secure the secret (private) key
   * @param publicKey
   *    the target stream for the public key
   * @param secrectKey
   *    the target stream for the secret (private) key
   * @return
   */
  public boolean generateKeyPair(String userId, String password, OutputStream publicKey, OutputStream secrectKey) {
    LOGGER.trace("generateKeyPair(String, String, OutputStream, OutputStream)");
    LOGGER.trace("User ID: {}, Password: ********, Public Key: {}, Secret Key: {}", userId, publicKey == null ? "not set" : "set", secrectKey == null ? "not set" : "set");
    return generateKeyPair(userId, password, DEFAULT_KEY_SIZE, publicKey, secrectKey);
  }

}
