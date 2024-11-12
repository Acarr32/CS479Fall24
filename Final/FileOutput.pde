public void writeClimbingData(ArrayList<Data> forceData, ArrayList<Data> flexData) {
    String currentDateTime = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
    
    String directoryPath = "./logs";
    String fileName = "ClimbingData" + currentDateTime + ".txt";
    
    File directory = new File(directoryPath);
    if (!directory.exists()) {
        directory.mkdirs();
    }
    
    File file = new File(directoryPath + "/" + fileName);
    
    try (FileWriter writer = new FileWriter(file)) {
        writer.write("Data from Force Sensors:\n");
        for (Data item : forceData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }
        
        writer.write("\nData from List2:\n");
        for (Data item : flexData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }
        
        System.out.println("Log file created at: " + file.getAbsolutePath());
    } catch (IOException e) {
        e.printStackTrace();
        System.out.println("Failed to write to log file.");
    }
}
