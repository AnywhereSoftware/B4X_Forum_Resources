package io.github.tapcard.emvnfccard.log;

public class Logger {
    private Class clazz;

    public Logger(Class clazz) {
        this.clazz = clazz;
    }

    /**
     * Is the logger instance enabled for the DEBUG level?
     *
     * @return True if this Logger is enabled for the DEBUG level,
     *         false otherwise.
     */
    public boolean isDebugEnabled() {
        return LoggerFactory.getCurrentLogWriter().isDebugEnabled();
    }


    /**
     * Log a message at the DEBUG level.
     *
     * @param msg the message string to be logged
     */
    public void debug(String msg) {
        LoggerFactory.getCurrentLogWriter().debug(clazz, msg);
    }

    /**
     * Log an exception (throwable) at the ERROR level with an
     * accompanying message.
     *
     * @param msg the message accompanying the exception
     * @param t   the exception (throwable) to log
     */
    public void error(String msg, Throwable t) {
        LoggerFactory.getCurrentLogWriter().error(clazz, msg, t);
    }

    /**
     * Log a message at the ERROR level.
     *
     * @param msg the message string to be logged
     */
    public void error(String msg) {
        LoggerFactory.getCurrentLogWriter().error(clazz, msg);
    }

}
