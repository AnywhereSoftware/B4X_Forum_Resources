package io.github.tapcard.emvnfccard.log;

/**
 * Do not writes anything
 */

public class DummyWriter implements LogWriter {
    @Override
    public void debug(Class clazz, String msg) {
        //no-op
    }

    @Override
    public void error(Class clazz, String msg, Throwable t) {
        //no-op

    }

    @Override
    public void error(Class clazz, String msg) {
        //no-op
    }

    @Override
    public void info(Class clazz, String msg) {
        //no-op
    }

    @Override
    public boolean isDebugEnabled() {
        return false;
    }
}
