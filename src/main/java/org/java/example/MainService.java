package org.java.example;

/**
 * Main service class for a Windows service application.
 * 
 * This class manages the lifecycle of a background service that runs in a separate thread.
 * It provides methods to start and stop the service, and includes a main method that
 * registers a shutdown hook to ensure graceful service termination.
 * 
 * The service continuously logs its status while running, with a 5-second interval
 * between log messages. It can be interrupted and properly cleaned up on shutdown.
 */
public class MainService {
    private static final long INTERVAL = 5000; // Interval in milliseconds for logging service status
    private static Thread serviceThread;
    private static boolean running = false;

    /**
     * Starts the service in a separate thread.
     * 
     * This method creates and starts a new thread that runs the service logic.
     * The service logs its start and continuously logs its running status every 5 seconds.
     * The service can be stopped by calling the stop() method.
     * 
     * @param args command-line arguments (currently unused)
     */
    public static void start(String[] args) {
        serviceThread = new Thread(() -> {
            Log.info("Service started.");
            running = true;
            while (running) {
                try {
                    Thread.sleep(INTERVAL); 
                    Log.info("Service is running...");
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }
        });
        serviceThread.start();
    }

    /**
     * Stops the service gracefully.
     * 
     * This method sets the running flag to false to signal the service thread to exit
     * and interrupts the service thread if it exists. It also logs the service stop event.
     * 
     * @param args command-line arguments (currently unused)
     */
    public static void stop(String[] args) {
        running = false;
        if (serviceThread != null) {
            serviceThread.interrupt();
        }
        Log.info("Service stopped.");
    }

    /**
     * Entry point of the application.
     * 
     * This method registers a shutdown hook to ensure the service is properly stopped
     * when the JVM shuts down, then starts the service.
     * 
     * @param args command-line arguments passed to the service
     */
    public static void main(String[] args) {
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            stop(args);
        }));
        start(args);
    }
}
