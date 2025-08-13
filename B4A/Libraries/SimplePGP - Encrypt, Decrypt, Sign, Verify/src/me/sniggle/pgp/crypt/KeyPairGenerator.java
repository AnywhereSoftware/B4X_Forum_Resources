package me.sniggle.pgp.crypt;

import java.io.OutputStream;

/**
 * Definition of a simple key pair generator
 *
 * @author iulius
 */
public interface KeyPairGenerator {

  /**
   * the algorithm to be used for encryption
   */
  String KEY_ALGORITHM = "RSA";

  /**
   * the default key size in bits
   */
  int DEFAULT_KEY_SIZE = 4096;

  /**
   * generates a key pair for the given user id with the default key size ( KeyPairGenerator#DEFAULT_KEY_SIZE )
   *
   * @param userId
   *    the user id for the PGP key pair
   * @param password
   *    the password used to secure the secret (private) key
   * @param publicKey
   *    the target stream for the public key
   * @param secrectKey
   *    the target stream for the secret (private) key
   * @return true if the generation was successful
   */
  boolean generateKeyPair(String userId, String password, OutputStream publicKey, OutputStream secrectKey);

  /**
   * generates a key pair for the given user id with a custom key size
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
   * @return true if the generation was successful
   */
  boolean generateKeyPair(String userId, String password, int keySize, OutputStream publicKey, OutputStream secrectKey);

}
