package io.github.tapcard.emvnfccard.log;

public class ConsoleWriter implements LogWriter {
    @Override
    public void debug(Class clazz, String msg) {
        System.out.println(String.format("emvnfccard D: [%s] %s",clazz.getSimpleName(), msg));
    }

    @Override
    public void error(Class clazz, String msg, Throwable t) {
        System.err.println(String.format("emvnfccard E: [%s] %s %s",clazz.getSimpleName(), msg, t.toString()));
    }

    @Override
    public void error(Class clazz, String msg) {
        System.err.println(String.format("emvnfccard E: [%s] %s",clazz.getSimpleName(), msg));
    }

    @Override
    public void info(Class clazz, String msg) {
        System.out.println(String.format("emvnfccard I: [%s] %s",clazz.getSimpleName(), msg));
    }

    @Override
    public boolean isDebugEnabled() {
        return true;
    }
}
