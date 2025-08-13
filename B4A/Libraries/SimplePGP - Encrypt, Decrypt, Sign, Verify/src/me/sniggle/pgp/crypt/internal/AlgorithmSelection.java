package me.sniggle.pgp.crypt.internal;

/**
 * Helper class used to define sane and secure defaults
 *
 * Redefining the BouncyCastle constants in order to allow
 * usage of the constants in java and android module
 *
 * @author iulius
 */
public final class AlgorithmSelection {

  private AlgorithmSelection() {
    super();
  }

  /**
   * The signing key type, currently set to RSA
   *
   * @return
   */
  public static int getSigningKeyType() {
    //PGPPublicKey.RSA_SIGN
    return 3;
  }

  /**
   * The encryption key type, currently set to RSA
   *
   * @return
   */
  public static int getEncryptionKeyType() {
    //PGPPublicKey.RSA_ENCRYPT
    return 2;
  }

  /**
   * the preferred symmetric encryption algorithm order
   *
   * @return AES256, AES192, AES128
   */
  public static int[] getPreferredEncryptionAlgorithms() {
    return new int[] {
        //SymmetricKeyAlgorithmTags.AES_256,
        9,
        //SymmetricKeyAlgorithmTags.AES_192,
        8,
        //SymmetricKeyAlgorithmTags.AES_128
        7
    };
  }

  /**
   * the preferred hash algorithm order
   *
   * @return SHA-512, SHA-384, SHA-256
   */
  public static int[] getPreferredHashingAlgorithms() {
    return new int[] {
        //HashAlgorithmTags.SHA512,
        10,
        //HashAlgorithmTags.SHA384,
        9,
        //HashAlgorithmTags.SHA256
        8
    };
  }

  /**
   * provides access to the default compression algorthm
   *
   * @return currently ZIP
   */
  public static int getDefaultCompressionAlgorithm() {
    return getPreferredCompressionAlgorithms()[0];
  }

  /**
   * the preferred compression algorithms
   *
   * @return ZIP, BZIP2, ZLIB, UNCOMPRESSED
   */
  public static int[] getPreferredCompressionAlgorithms() {
    return new int[] {
        //CompressionAlgorithmTags.ZIP,
        1,
        //CompressionAlgorithmTags.BZIP2,
        3,
        //CompressionAlgorithmTags.ZLIB,
        2,
        //CompressionAlgorithmTags.UNCOMPRESSED
        0
    };
  }

  /**
   * the strongest suggested symmetric encryption algorithm
   *
   * @return AES256
   */
  public static int getStrongEncryptionAlgorithm() {
    return getPreferredEncryptionAlgorithms()[0];
  }

  /**
   * the weakest acceptable symmetric encryption algorithm
   *
   * @return AES128
   */
  public static int getWeakEncryptionAlgorithm() {
    return getPreferredEncryptionAlgorithms()[2];
  }

}
