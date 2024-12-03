public void writeClimbingData(ArrayList<ArrayList<Data>> forceData, ArrayList<Data> flexData, ArrayList<Data> heightData, ArrayList<Data> emgData) {
    String currentDateTime = new SimpleDateFormat("mmDDyyyy_HHmmss").format(new Date());
    String directoryPath = "logs"; // No leading slash for relative paths
    String fileName = "ClimbingData" + currentDateTime + ".txt";
    
    Path currentDirectory = Paths.get(dataPath("")); // Absolute path for clarity
    File file;

    try {
        // Resolve the full directory path
        Path newDirectory = currentDirectory.resolve(directoryPath);
        Files.createDirectories(newDirectory); // Create all non-existing directories

        // Create the file inside the directory
        file = new File(newDirectory.toFile(), fileName);
    }
    catch (IOException e) {
      throwError(e, 6);
      return;
    }
    
    
    try (FileWriter writer = new FileWriter(file)) {
        writer.write("Data Summary\n\n");
        writer.write("++++++++++++++++++++++++++++++++++++++++++++++++++");
        float totalHR = 0;
        float totalHT = 0;
        
        for (Data item : heightData) {
            totalHR += item.getReading();
            totalHT += item.getTime();
        }
        writer.write("\n Average Value from Barometer (Altitude) : " + str((totalHR * 1000) /totalHT) + "\n");
        
        
        float totalER = 0;
        float totalET = 0;
        
        for (Data item : emgData) {
            totalER += item.getReading();
            totalET += item.getTime();
        }
        writer.write("\n Average Value from EMG : " + str((totalER * 1000) /totalET) + "\n");
        writer.write("+++++++++++++++++++");
        float totalFR = 0;
        float totalFT = 0;
        for (Data item : flexData) {
            totalFR += item.getReading();
            totalFT += item.getTime();
        }
        
        if(((totalFR * 1000)/totalFT) != 0.0){
            writer.write("\n Average Value from Flex Sensor: " + str((totalFR * 1000)/totalFT) + "\n");
        }
        writer.write("+++++++++++++++++++");
  
        float totalThm = 0.0;
        float totalPtr = 0.0;
        float totalMid = 0.0;
        float totalTime = 0.0;
        for (int i = 0; i < forceData.size(); i++) {
            totalThm += forceData.get(i).get(0).getReading();
            totalPtr += forceData.get(i).get(1).getReading();
            totalMid += forceData.get(i).get(2).getReading();
            totalTime += forceData.get(i).get(0).getTime();
        } 
        
        writer.write("\n Average Value from Thumb Finger Force Sensor: " + str((totalThm * 1000)/ totalTime) + "\n");
        writer.write("\n Average Value from Pointer Finger Force Sensor: " + str((totalPtr * 1000)/ totalTime) + "\n");
        writer.write("\n Average Value from Middle Finger Force Sensor: " + str((totalMid * 1000)/ totalTime) + "\n");
        writer.write("+++++++++++++++++++");
        
        writer.write("Data Dumps For Further Analysis\n\n");
        writer.write("++++++++++++++++++++++++++++++++++++++++++++++++++");
        writer.write("Data Dump from Barometer (Altitude):\n");
        for (Data item : heightData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }
        
        writer.write("+++++++++++++++++++");
        writer.write("\nData Dump from Flex Sensors:\n");
        for (Data item : flexData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }
        writer.write("+++++++++++++++++++");
        writer.write("\nData Dump from Emg Sensors:\n");
        for (Data item : emgData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }
        writer.write("+++++++++++++++++++");
        writer.write("\nData Dump from Force Sensors: \n");
        for (int i = 0; i < forceData.size(); i++) {
            float thm = forceData.get(i).get(0).getReading();
            float ptr = forceData.get(i).get(1).getReading();
            float mid = forceData.get(i).get(2).getReading();
            int tme = forceData.get(i).get(0).getTime();
            
            writer.write("At Time :" + str(tme) + " \n");
            writer.write("Thumb Value: " + str(thm) + "\n");
            writer.write("Pointer Value: " + str(ptr) + "\n");
            writer.write("Mid Value: " + str(mid) + "\n");
            writer.write("+++++++++++++++++++");
        }

        System.out.println("Log file created at: " + file.getAbsolutePath());
    } 
    catch (IOException e) {
        System.out.println(throwError(e,4));
    }
}
