public void writeClimbingData(ArrayList<ArrayList<Data>> forceData, ArrayList<Data> flexData, ArrayList<Data> heightData) {
    String currentDateTime = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
    String directoryPath = "logs"; // No leading slash for relative paths
    String fileName = "ClimbingData" + currentDateTime + ".txt";
    
    Path currentDirectory = Paths.get(".").toAbsolutePath(); // Absolute path for clarity
    File file;

    try {
        // Resolve the full directory path
        Path newDirectory = currentDirectory.resolve(directoryPath);
        Files.createDirectories(newDirectory); // Create all non-existing directories

        // Create the file inside the directory
        file = new File(newDirectory.toFile(), fileName);
    } catch (IOException e) {
        e.printStackTrace();
        System.out.println("Failed to create directory.");
        return;
    }

    try (FileWriter writer = new FileWriter(file)) {
        writer.write("Data from Accelerometer (Altitude):\n");
        for (Data item : heightData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }

        writer.write("\nData from Flex Sensors:\n");
        for (Data item : flexData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }

        for (int i = 0; i < forceData.size(); i++) {
            writer.write("\nData from Force Sensor " + i + ":\n");
            for (Data item : forceData.get(i)) {
                writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
            }
        }

        System.out.println("Log file created at: " + file.getAbsolutePath());
    } catch (IOException e) {
        e.printStackTrace();
        System.out.println("Failed to write to log file.");
    }
}
