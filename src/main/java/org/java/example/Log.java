package org.java.example;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Utility class for logging messages with timestamps.
 * 
 * This class provides static methods for logging information and error messages
 * to the console (stdout and stderr respectively). Each log message is prefixed
 * with a timestamp in the format "yyyy-MM-dd HH:mm:ss.SSS" and a log level indicator.
 * 
 * This is a final class with a private constructor to prevent instantiation,
 * as it's designed to be used only as a utility class.
 */
public final class Log {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");

    /**
     * Private constructor to prevent instantiation of this utility class.
     */
    private Log() {
        // Utility class
    }

    /**
     * Logs an informational message to standard output.
     * 
     * The message is printed with a timestamp prefix and [INFO] level indicator.
     * 
     * @param msg the message to be logged
     */
    public static void info(final String msg) {
        final String timestamp = LocalDateTime.now().format(FORMATTER);
        System.out.println("[" + timestamp + "] [INFO] " + msg);
    }

    /**
     * Logs an error message to standard error output.
     * 
     * The message is printed to stderr with a timestamp prefix and [ERROR] level indicator.
     * 
     * @param msg the error message to be logged
     */
    public static void error(final String msg) {
        final String timestamp = LocalDateTime.now().format(FORMATTER);
        System.err.println("[" + timestamp + "] [ERROR] " + msg);
    }
}