package me.sniggle.pgp.crypt;

import org.spongycastle.jce.provider.BouncyCastleProvider;

import java.security.Security;

/**
 * The Factory providing a library independent simple access to the simple PGP API
 *
 * @author iulius
 */
public final class PGPWrapperFactory {

  private PGPWrapperFactory() {
    super();
  }

  /**
   * initializes the security provider
   */
  public static void init() {
    Security.addProvider(new BouncyCastleProvider());
  }

  /**
   *
   * @return a message encryptor instance
   */
  public static MessageEncryptor getEncyptor() {
    return (MessageEncryptor) new PGPMessageEncryptor();
  }

  /**
   *
   * @return a key pair generator instance
   */
  public static KeyPairGenerator getKeyPairGenerator() {
    return new PGPKeyPairGenerator();
  }

  /**
   *
   * @return a message signer instance
   */
  public static MessageSigner getSigner() {
    return new PGPMessageSigner();
  }

}
