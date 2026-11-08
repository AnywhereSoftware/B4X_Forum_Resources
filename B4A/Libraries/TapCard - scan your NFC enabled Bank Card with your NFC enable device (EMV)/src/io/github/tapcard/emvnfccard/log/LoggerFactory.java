package io.github.tapcard.emvnfccard.log;


/**
 * Simple logging for emvnfccard library
 */

public class LoggerFactory {
    private static LogWriter currentLogWriter = new DummyWriter();

    /**
     * @param clazz the returned logger will be named after clazz
     * @return logger
     */
    public static Logger getLogger(Class clazz) {
        return new Logger(clazz);
    }

    static LogWriter getCurrentLogWriter() {
        return currentLogWriter;
    }

    public static void setLogWriter(LogWriter currentLogWriter) {
        LoggerFactory.currentLogWriter = currentLogWriter;
    }
}
