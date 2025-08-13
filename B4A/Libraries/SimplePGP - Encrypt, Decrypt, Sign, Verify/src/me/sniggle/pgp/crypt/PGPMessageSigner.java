package me.sniggle.pgp.crypt;

import me.sniggle.pgp.crypt.internal.BasePGPCommon;
import me.sniggle.pgp.crypt.internal.io.IOUtils;
import org.spongycastle.bcpg.ArmoredInputStream;
import org.spongycastle.bcpg.ArmoredOutputStream;
import org.spongycastle.bcpg.BCPGOutputStream;
import org.spongycastle.bcpg.HashAlgorithmTags;
import org.spongycastle.openpgp.*;
import org.spongycastle.openpgp.operator.bc.BcKeyFingerprintCalculator;
import org.spongycastle.openpgp.operator.bc.BcPGPContentSignerBuilder;
import org.spongycastle.openpgp.operator.bc.BcPGPContentVerifierBuilderProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

/**
 * The the library dependent implementation of a MessageSigner
 *
 * @author iulius
 */
public class PGPMessageSigner extends BasePGPCommon implements MessageSigner {

  private static final Logger LOGGER = LoggerFactory.getLogger(PGPMessageSigner.class);

  /**
   * @see MessageSigner#verifyMessage(InputStream, InputStream, InputStream)
   *
   * @param publicKeyOfSender
   *    the public key of the sender of the message
   * @param message
   *    the message / data to verify
   * @param signatureStream
   *    the (detached) signature
   * @return
   */
  @Override
  public boolean verifyMessage(InputStream publicKeyOfSender, InputStream message, InputStream signatureStream) {
    LOGGER.trace("verifyMessage(InputStream, InputStream, InputStream)");
    LOGGER.trace("Public Key: {}, Data: {}, Signature: {}",
        publicKeyOfSender == null ? "not set" : "set", message == null ? "not set" : "set", signatureStream == null ? "not set" : "set");
    boolean result = false;
    LOGGER.debug("Wrapping signature stream in ArmoredInputStream");
    try( InputStream armordPublicKeyStream = new ArmoredInputStream(signatureStream) ) {
      Object pgpObject;
      PGPObjectFactory pgpObjectFactory = new PGPObjectFactory(armordPublicKeyStream, new BcKeyFingerprintCalculator());
      LOGGER.debug("Iterating over PGP objects in stream");
      while( (pgpObject = pgpObjectFactory.nextObject()) != null ) {
        if( pgpObject instanceof PGPSignatureList ) {
          LOGGER.debug("Signature List found");
          PGPSignatureList signatureList = (PGPSignatureList)pgpObject;
          LOGGER.debug("Iterating over signature list");
          Iterator<PGPSignature> signatureIterator = signatureList.iterator();
          while( signatureIterator.hasNext() ) {
            LOGGER.debug("Checking next signature");
            final PGPSignature signature = signatureIterator.next();
            PGPPublicKey pgpPublicKey = findPublicKey(publicKeyOfSender, new KeyFilter<PGPPublicKey>() {
              @Override
              public boolean accept(PGPPublicKey pgpKey) {
                return pgpKey.getKeyID() == signature.getKeyID();
              }
            });
            if( pgpPublicKey != null ) {
              signature.init(new BcPGPContentVerifierBuilderProvider(), pgpPublicKey);
              LOGGER.debug("Processing signature data");
              IOUtils.process(message, new IOUtils.StreamHandler() {
                @Override
                public void handleStreamBuffer(byte[] buffer, int offset, int length) throws IOException {
                  signature.update(buffer, offset, length);
                }
              });
              result = signature.verify();
              LOGGER.info("Verify Signature: {}", result);
            } else {
              LOGGER.warn("No public key found for signature. Key ID: {}", signature.getKeyID());
            }
          }
        }
      }
    } catch (IOException | PGPException e) {
      LOGGER.error("{}", e.getMessage());
      result &= false;
    }
    return result;
  }

  /**
   * @see MessageSigner#signMessage(InputStream, String, String, InputStream, OutputStream)
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
   * @return
   */
  @Override
  public boolean signMessage(InputStream privateKeyOfSender, final String userIdForPrivateKey, String passwordOfPrivateKey, InputStream message, OutputStream signature) {
    LOGGER.trace("signMessage(InputStream, String, String, InputStream, OutputStream)");
    LOGGER.trace("Private Key: {}, User ID: {}, Password: {}, Data: {}, Signature: {}",
        privateKeyOfSender == null ? "not set" : "set", userIdForPrivateKey, passwordOfPrivateKey == null ? "not set" : "********",
        message == null ? "not set" : "set", signature == null ? "not set" : "set");
    boolean result = false;
    try {
      LOGGER.debug("Retrieving Private Key");
      PGPPrivateKey privateKey = findPrivateKey(privateKeyOfSender, passwordOfPrivateKey,  new KeyFilter<PGPSecretKey>() {

        @Override
        public boolean accept(PGPSecretKey secretKey) {
          boolean result = secretKey.isSigningKey();
          if( result ) {
            Iterator<String> userIdIterator = secretKey.getUserIDs();
            boolean containsUserId = false;
            while( userIdIterator.hasNext() && !containsUserId ) {
              containsUserId |= userIdForPrivateKey.equals(userIdIterator.next());
            }
          }
          return result;
        }
      });
      LOGGER.debug("Initializing signature generator");
      final PGPSignatureGenerator signatureGenerator = new PGPSignatureGenerator(new BcPGPContentSignerBuilder(privateKey.getPublicKeyPacket().getAlgorithm(), HashAlgorithmTags.SHA256));
      signatureGenerator.init(PGPSignature.BINARY_DOCUMENT, privateKey);
      LOGGER.debug("Wrapping signature stream in ArmoredOutputStream and PGOutputStream");
      try( BCPGOutputStream outputStream = new BCPGOutputStream( new ArmoredOutputStream(signature)) ) {
        IOUtils.process(message, new IOUtils.StreamHandler() {

          @Override
          public void handleStreamBuffer(byte[] buffer, int offset, int length) throws IOException {
            signatureGenerator.update(buffer, offset, length);
          }

        });
        LOGGER.info("Writing signature out");
        signatureGenerator.generate().encode(outputStream);
      }
      result = true;
    } catch (IOException | PGPException e) {
      result &= false;
      LOGGER.error("{}", e.getMessage());
    }
    return result;
  }
}
