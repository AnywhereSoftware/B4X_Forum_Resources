package me.sniggle.pgp.crypt;

import me.sniggle.pgp.crypt.internal.BasePGPCommon;
import me.sniggle.pgp.crypt.internal.io.IOUtils;
import org.spongycastle.bcpg.ArmoredInputStream;
import org.spongycastle.bcpg.ArmoredOutputStream;
import org.spongycastle.bcpg.BCPGOutputStream;
import org.spongycastle.bcpg.HashAlgorithmTags;
import org.spongycastle.crypto.CipherParameters;
import org.spongycastle.crypto.InvalidCipherTextException;
import org.spongycastle.openpgp.*;
import org.spongycastle.openpgp.operator.PublicKeyDataDecryptorFactory;
import org.spongycastle.openpgp.operator.bc.*;
import org.spongycastle.pqc.crypto.MessageEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.Iterator;

/**
 * The the library dependent implementation of a MessageEncryptor
 *
 * @author iulius
 */
public class PGPMessageEncryptor extends BasePGPCommon implements MessageEncryptor {

  private static final Logger LOGGER = LoggerFactory.getLogger(PGPMessageEncryptor.class);

  public PGPMessageEncryptor() {
  }

  /**
   * encrypts and if possible (secret key and password provided) signs the target stream
   *
   * @param pgpSecretKey
   *    the secret key
   * @param password
   *    the password for the private key
   * @param inputDataName
   *    the name of the data
   * @param inputData
   *    the plain input data
   * @param encryptedDataStream
   *    the encrypted data stream
   * @throws PGPException
   * @throws IOException
   */
  private void encryptAndSign(PGPSecretKey pgpSecretKey, String password, String inputDataName, InputStream inputData, OutputStream encryptedDataStream) throws PGPException, IOException {
    LOGGER.trace("encryptAndSign(PGPSecretKey, String, String, InputStream, OutputStream)");
    LOGGER.trace("Secret Key: {}, Password: {}, Input Name: {}, Input Data: {}, Output Data: {}", pgpSecretKey == null ? "not set" : "set", password == null ? "not set" : "********", inputDataName, inputData == null ? "not set" : "set", encryptedDataStream == null ? "not set" : "set");
    PGPSignatureGenerator pgpSignatureGenerator = null;

    PGPPrivateKey signingKey = null;
    if (pgpSecretKey != null) {
      LOGGER.info("Retrieving signing key from secret key");
      signingKey = findPrivateKey(pgpSecretKey, password);
    }

    LOGGER.debug("Wrapping target stream in compressed data stream");
    PGPCompressedDataGenerator compressedDataGenerator = new PGPCompressedDataGenerator(getCompressionAlgorithm());
    try ( OutputStream compressedDataStream = new BCPGOutputStream(compressedDataGenerator.open(encryptedDataStream)) ) {

      if (signingKey != null) {
        LOGGER.info("Preparing message signing");
        pgpSignatureGenerator = new PGPSignatureGenerator(new BcPGPContentSignerBuilder(signingKey.getPublicKeyPacket().getAlgorithm(), HashAlgorithmTags.SHA256));
        pgpSignatureGenerator.init(PGPSignature.BINARY_DOCUMENT, signingKey);
        pgpSignatureGenerator.generateOnePassVersion(false).encode(compressedDataStream);
      } else {
        LOGGER.info("No signing key provided. Encrypted data will be unsigned!");
      }

      PGPLiteralDataGenerator literalDataGenerator = new PGPLiteralDataGenerator(false);
      LOGGER.debug("Wrapping compressed data stream in literal data stream");
      try (OutputStream literalDataOutputStream = literalDataGenerator.open(compressedDataStream, PGPLiteralDataGenerator.BINARY, inputDataName, new Date(), new byte[4096])) {

        IOUtils.StreamHandler streamHandler = null;
        if( signingKey != null ) {
          final PGPSignatureGenerator callbackGenerator = pgpSignatureGenerator;
          streamHandler = new IOUtils.StreamHandler() {
            @Override
            public void handleStreamBuffer(byte[] buffer, int offset, int length) throws IOException {
              callbackGenerator.update(buffer, offset, length);
            }
          };
        }

        LOGGER.info("Encrypting data and saving to target stream");
        IOUtils.copy(inputData, literalDataOutputStream, new byte[4096], streamHandler);

        literalDataGenerator.close();
      }
      if (signingKey != null) {
        LOGGER.info("Generating data signature");
        pgpSignatureGenerator.generate().encode(compressedDataStream);
      }
      compressedDataGenerator.close();
    }
  }

  /**
   * accessor to the encryption algorithm constant to use, based of #isUnlimitedEncryptionStrength()
   *
   * @return the appropriate algorithm constant
   */
  protected  int getEncryptionAlgorithm() {
    return (isUnlimitedEncryptionStrength()) ? PGPEncryptedData.AES_256 : PGPEncryptedData.AES_128;
  }

  /**
   * @see MessageEncryptor#encrypt(InputStream, String, InputStream, OutputStream)
   *
   * @param publicKeyOfRecipient
   *    the public key stream of the message recipient
   * @param inputDataName
   *    the (file)name of the input data
   * @param plainInputData
   *    the input data stream
   * @param target
   *    the encrypted (ascii-armored) target stream
   * @return
   */
  public boolean encrypt(InputStream publicKeyOfRecipient, String inputDataName, InputStream plainInputData, OutputStream target) {
    LOGGER.trace("encrypt(InputStream, String, InputStream, OutputStream)");
    LOGGER.trace("Public Key: {}, Input Name: {}, Input Data: {}, Output: {}",publicKeyOfRecipient == null ? "not set" : "set", inputDataName, plainInputData == null ? "not set" : "set", target == null ? "not set" : "set");
    return encrypt(publicKeyOfRecipient, null, null, null, inputDataName, plainInputData, target);
  }

  /**
   * @see MessageEncryptor#encrypt(InputStream, InputStream, String, String, String, InputStream, OutputStream)
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
   * @return
   */
  public boolean encrypt(InputStream publicKeyOfRecipient, InputStream privateKeyOfSender, String userIdOfSender, String passwordOfSendersPrivateKey, String inputDataName, InputStream plainInputData, OutputStream target) {
    LOGGER.trace("encrypt(InputStream, InputStream, String, String, String, InputStream, OutputStream)");
    LOGGER.trace("Public Key: {}, Private Key: {}, User ID: {}, Password: {}, Input Name: {}, Input Data: {}, Output: {}",
        publicKeyOfRecipient == null ? "not set" : "set", privateKeyOfSender == null ? "not set" : "set", userIdOfSender, passwordOfSendersPrivateKey == null ? "not set" : "********", inputDataName, plainInputData == null ? "not set" : "set", target == null ? "not set" : "set");
    boolean result = true;
    LOGGER.debug("Reading public key");
    PGPPublicKey pgpPublicKey = findPublicKey(publicKeyOfRecipient, new KeyFilter<PGPPublicKey>() {
      @Override
      public boolean accept(PGPPublicKey pgpKey) {
        return pgpKey.isEncryptionKey() && !pgpKey.isMasterKey();
      }
    });
    if( pgpPublicKey != null ) {
      LOGGER.debug("Wrapping target stream in ArmoredOutputStream");
      try( OutputStream wrappedTargetStream = new ArmoredOutputStream(target) ) {
        BcPGPDataEncryptorBuilder encryptorBuilder = new BcPGPDataEncryptorBuilder(getEncryptionAlgorithm());
        LOGGER.debug("Enabling integrity packet");
        encryptorBuilder.setWithIntegrityPacket(true);
        LOGGER.debug("Creating encrypted data generator");
        PGPEncryptedDataGenerator encryptedDataGenerator = new PGPEncryptedDataGenerator(encryptorBuilder);
        encryptedDataGenerator.addMethod(new BcPublicKeyKeyEncryptionMethodGenerator(pgpPublicKey));
        PGPSecretKey pgpSecretKey = null;
        if( privateKeyOfSender != null ) {
          LOGGER.debug("Looking up secret key");
          pgpSecretKey = findSecretKey(privateKeyOfSender, userIdOfSender);
        } else {
          LOGGER.info("No private key provided -> No signing of encrypted data");
        }
        LOGGER.debug("Wrapping target stream in encrypted output stream");
        try( OutputStream encryptedDataStream = encryptedDataGenerator.open(wrappedTargetStream, new byte[4096]) ) {
          LOGGER.info("Encrypting and optionally signing of input data");
          encryptAndSign(pgpSecretKey, passwordOfSendersPrivateKey, inputDataName, plainInputData, encryptedDataStream);
        }
      } catch (IOException | PGPException e) {
        LOGGER.error("{}", e.getMessage());
        result &= false;
      }
    } else {
      LOGGER.error("No public key found for encryption!");
      result &= false;
    }
    return result;
  }

  /**
   * @see MessageEncryptor#decrypt(String, InputStream, InputStream, OutputStream)
   *
   * @param passwordOfReceiversPrivateKey
   *    the password for the receiver's private key
   * @param privateKeyOfReceiver
   *    the receiver's private key
   * @param encryptedData
   *    the encrypted data
   * @param target
   *    the plain data stream
   * @return
   */
  public boolean decrypt(String passwordOfReceiversPrivateKey, InputStream privateKeyOfReceiver, InputStream encryptedData, OutputStream target) {
    LOGGER.trace("decrypt(String, InputStream, InputStream, OutputStream)");
    LOGGER.trace("Password: {}, Private Key: {}, Encrypted Data: {}, Output: {}",
        passwordOfReceiversPrivateKey == null ? "not set" : "********", privateKeyOfReceiver == null ? "not set" : "set", encryptedData == null ? "not set" : "set", target == null ? "not set" : "set");
    return decrypt(passwordOfReceiversPrivateKey, privateKeyOfReceiver, null, encryptedData, target);
  }

  /**
   * @see MessageEncryptor#decrypt(String, InputStream, InputStream, InputStream, OutputStream)
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
   * @return
   */
  public boolean decrypt(String passwordOfReceiversPrivateKey, InputStream privateKeyOfReceiver, InputStream publicKeyOfSender, InputStream encryptedData, OutputStream target) {
    LOGGER.trace("decrypt(String, InputStream, InputStream, InputStream, OutputStream)");
    LOGGER.trace("Password: {}, Private Key: {}, Public Key: {}, Encrypted Data: {}, Output: {}",
        passwordOfReceiversPrivateKey == null ? "not set" : "set", privateKeyOfReceiver == null ? "not set" : "set", publicKeyOfSender == null ? "not set" : "set",
        encryptedData == null ? "not set" : "set", target == null ? "not set" : "set");
    boolean result = true;
    try {
      PGPPublicKeyRingCollection publicKeyRingCollection = null;
      if( publicKeyOfSender != null ) {
        LOGGER.debug("Wrapping public key in ArmoredInputStream");
        try( InputStream armoredInputStream = new ArmoredInputStream(publicKeyOfSender) ) {
          publicKeyRingCollection = new PGPPublicKeyRingCollection(armoredInputStream, new BcKeyFingerprintCalculator());
        }
      }
      LOGGER.debug("Retrieving DecoderStream from encrypted input");
      try( InputStream in = PGPUtil.getDecoderStream(encryptedData) ) {
        LOGGER.debug("Create PGP Object factory");

        PGPObjectFactory objectFactory = new PGPObjectFactory(in, new BcKeyFingerprintCalculator());
        PGPEncryptedDataList dataList;

        LOGGER.debug("Retrieve EncryptedDataList");
        Object firstObject = objectFactory.nextObject();
        if( firstObject instanceof PGPEncryptedDataList ) {
          dataList = (PGPEncryptedDataList)firstObject;
        } else {
          dataList = (PGPEncryptedDataList)objectFactory.nextObject();
        }

        PGPPrivateKey pgpPrivateKey = null;
        PGPEncryptedData pgpEncryptedData = null;
        LOGGER.debug("Iterating over encrypted data objects");
        Iterator<PGPEncryptedData> iterator = dataList.getEncryptedDataObjects();
        while( pgpPrivateKey == null && iterator.hasNext() ) {
          pgpEncryptedData = iterator.next();
          LOGGER.debug("Looking up private key");
          pgpPrivateKey = findPrivateKey(privateKeyOfReceiver, ((PGPPublicKeyEncryptedData) pgpEncryptedData).getKeyID(), passwordOfReceiversPrivateKey);
        }
        PublicKeyDataDecryptorFactory publicKeyDataDecryptorFactory = new BcPublicKeyDataDecryptorFactory(pgpPrivateKey);
        LOGGER.debug("Retrieving data stream from encrypted data");
        try( InputStream clearText = ((PGPPublicKeyEncryptedData)pgpEncryptedData).getDataStream(publicKeyDataDecryptorFactory)) {
          PGPObjectFactory pgpObjectFactory = new PGPObjectFactory(clearText, new BcKeyFingerprintCalculator());
          Object message;
          PGPCompressedData compressedData;
          PGPOnePassSignatureList onePassSignatureList = null;
          PGPOnePassSignature onePassSignature = null;
          PGPLiteralData literalData;
          PGPSignatureList signatures = null;
          PGPPublicKey pgpPublicKey = null;

          while( (message = pgpObjectFactory.nextObject()) != null ) {
            if( message instanceof PGPCompressedData ) {
              compressedData = (PGPCompressedData) message;
              LOGGER.debug("Compressed data block found, creating new object factory with compressed data stream");
              pgpObjectFactory = new PGPObjectFactory(compressedData.getDataStream(), new BcKeyFingerprintCalculator());
            }
            if( message instanceof PGPLiteralData ) {
              literalData = (PGPLiteralData) message;
              LOGGER.debug("Reading literal data stream");
              try( InputStream literalDataStream = literalData.getInputStream() ) {
                IOUtils.StreamHandler streamHandler = null;
                if( onePassSignature != null ) {
                  final PGPOnePassSignature callbackSignature = onePassSignature;
                  streamHandler = new IOUtils.StreamHandler() {
                    @Override
                    public void handleStreamBuffer(byte[] buffer, int offset, int length) throws IOException {
                      callbackSignature.update(buffer, offset, length);
                    }
                  };
                }
                IOUtils.copy(literalDataStream, target, new byte[4096], streamHandler);
              }
            } else if( message instanceof PGPOnePassSignatureList ) {
              onePassSignatureList = (PGPOnePassSignatureList)message;
              if( publicKeyOfSender != null ) {
                LOGGER.info("Public key provided -> verifying message signature");
                onePassSignature = onePassSignatureList.get(0);
                pgpPublicKey = publicKeyRingCollection.getPublicKey(onePassSignature.getKeyID());
                onePassSignature.init(new BcPGPContentVerifierBuilderProvider(), pgpPublicKey);
              }
            } else if( message instanceof  PGPSignatureList){
              LOGGER.info("Signature List found for verification");
              signatures = (PGPSignatureList)message;
            }
          }

          LOGGER.debug("Iterating over signature list");
          for( int i = 0; onePassSignatureList != null && i < onePassSignatureList.size(); i++ ) {
            if( pgpPublicKey != null && signatures != null ) {
              LOGGER.info("Verifying signatures");
              PGPSignature signature = signatures.get(i);
              if( onePassSignature.verify(signature) ) {
                LOGGER.info("Signature verified");
                String userId = null;
                Iterator<String> it = pgpPublicKey.getUserIDs();
                while (it.hasNext()) {
                  userId = it.next();
                  LOGGER.info("Signed by {}", userId);
                }
              } else {
                LOGGER.warn("Signature verification failed");
                result &= false;
              }
            }
          }


          if( pgpEncryptedData.isIntegrityProtected() ) {
            LOGGER.info("Performing integrity check on encrypted data");
            if( pgpEncryptedData.verify() ) {
              LOGGER.info("Data integrity verified");
            } else {
              LOGGER.warn("Data integrity verification failed");
              result &= false;
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

	@Override
	public void init(boolean arg0, CipherParameters arg1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public byte[] messageDecrypt(byte[] arg0) throws InvalidCipherTextException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public byte[] messageEncrypt(byte[] arg0) {
		// TODO Auto-generated method stub
		return null;
	}


}
