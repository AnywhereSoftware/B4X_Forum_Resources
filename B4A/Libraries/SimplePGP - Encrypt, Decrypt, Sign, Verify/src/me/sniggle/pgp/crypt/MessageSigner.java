package me.sniggle.pgp.crypt;

import java.io.InputStream;
import java.io.OutputStream;

/**
 * The definition of a simple PGP message signer
 *
 * @author iulius
 */
public interface MessageSigner {

  /**
   * verifies the message with the (detached) signature
   *
   * @param publicKeyOfSender
   *    the public key of the sender of the message
   * @param message
   *    the message / data to verify
   * @param signatureStream
   *    the (detached) signature
   * @return true if verification successful
   */
  boolean verifyMessage(InputStream publicKeyOfSender, InputStream message, InputStream signatureStream);

  /**
   * signs the given message to enable the receiver to verify the data authenticity
   *
   * @param privateKeyOfSender
   *    the private key of the sender
   * @param userIdForPrivateKey
   *    the user id of the sender
   * @param passwordOfPrivateKey
   *    the password for the private key
   * @param message
   *    the message / data to verify
   * @param signature
   *    the (detached) signature
   * @return true if message/data was signed successfully
   */
  boolean signMessage(InputStream privateKeyOfSender, String userIdForPrivateKey, String passwordOfPrivateKey, InputStream message, OutputStream signature);

}
