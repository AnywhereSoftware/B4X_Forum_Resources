package me.sniggle.pgp.crypt;

import java.io.InputStream;
import java.io.OutputStream;

/**
 * Definition of a simple PGP key signer
 *
 * @author iulius
 */
public interface KeySigner {

  /**
   * TODO no implementation present yet
   *
   * @param publicKey
   * @param privateKey
   * @param targetStream
   * @return
   */
  boolean signKey(InputStream publicKey, InputStream privateKey, OutputStream targetStream);

}
