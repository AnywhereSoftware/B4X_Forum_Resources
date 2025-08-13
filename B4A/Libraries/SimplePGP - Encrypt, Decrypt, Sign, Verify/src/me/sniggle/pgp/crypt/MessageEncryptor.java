package me.sniggle.pgp.crypt;

import java.io.InputStream;
import java.io.OutputStream;

/**
 * The definition of a simple PGP message encryptor
 *
 * @author iulius
 */
public interface MessageEncryptor {

  /**
   * encrypts the plain input data with the public key (without signing the message)
   *
   * @param publicKeyOfRecipient
   *    the public key stream of the message recipient
   * @param inputDataName
   *    the (file)name of the input data
   * @param plainInputData
   *    the input data stream
   * @param target
   *    the encrypted (ascii-armored) target stream
   * @return true if encryption is successful
   */
  boolean encrypt(InputStream publicKeyOfRecipient, String inputDataName, InputStream plainInputData, OutputStream target);

  /**
   * encypts the plain input data with the public key <b>and</b> signs it with the private key
   *
   * @param publicKeyOfRecipient
   *    the public key stream of the message recipient
   * @param privateKeyOfSender
   *    the private key stream of the message sender
   * @param userIdOfSender
   *    the user id of the message sender
   * @param passwordOfSendersPrivateKey
   *    the password for the private key of the sender
   * @param inputDataName
   *    the (file)name of the input data
   * @param plainInputData
   *    the input data stream
   * @param target
   *    the encrypted (ascii-armored) target stream
   * @return true if encryption and signing successful
   */
  boolean encrypt(InputStream publicKeyOfRecipient, InputStream privateKeyOfSender, String userIdOfSender, String passwordOfSendersPrivateKey, String inputDataName, InputStream plainInputData, OutputStream target);

  /**
   * decrypts the encypted data stream with the recipients private key
   *
   * @param passwordOfReceiversPrivateKey
   *    the password for the receiver's private key
   * @param privateKeyOfReceiver
   *    the receiver's private key
   * @param encryptedData
   *    the encrypted data
   * @param target
   *    the plain data stream
   * @return true if decryption is successful
   */
  boolean decrypt(String passwordOfReceiversPrivateKey, InputStream privateKeyOfReceiver, InputStream encryptedData, OutputStream target);

  /**
   * decrypts and verifies the encrypted and signed datastream (if signature is present)
   * with the recipients private key (decryption) and the senders public key (verification)
   *
   * @param passwordOfReceiversPrivateKey
   *    the password of the receivers private key
   * @param privateKeyOfReceiver
   *    the receiver's private key
   * @param publicKeyOfSender
   *    the sender's public key
   * @param encryptedData
   *    the encrypted data
   * @param target
   *    the plain data stream
   * @return true if decryption and verification (if signed) was successful
   */
  boolean decrypt(String passwordOfReceiversPrivateKey, InputStream privateKeyOfReceiver, InputStream publicKeyOfSender, InputStream encryptedData, OutputStream target);

}
