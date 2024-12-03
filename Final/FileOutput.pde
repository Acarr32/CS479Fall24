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
        
        float totalFR = 0;
        float totalFT = 0;
        for (Data item : flexData) {
            totalFR += item.getReading();
            totalFT += item.getTime();
        }
        writer.write("\n Average Value from Flex Sensor: " + str((totalFR * 1000)/totalFT) + "\n");
        
        for (int i = 0; i < forceData.size(); i++) {
            float totalR = 0.0;
            float totalTime = 0.0;
            switch(i % 3){
                case 0:
                  writer.write("\n(Thumb)");
                case 1:
                  writer.write("\n(Pointer)");
                case 2:
                  writer.write("\n(Middle)");
                default:
                  break;
              }
            writer.write(" Average Value from Force Sensor " + i + ": ");
            for (Data item : forceData.get(i)) {
                totalR += item.getReading();
                totalTime += item.getTime();
            }
            writer.write(str(totalR/totalTime) + "\n");
        } 
        
        
        writer.write("Data Dumps For Further Analysis\n\n");
        writer.write("++++++++++++++++++++++++++++++++++++++++++++++++++");
        writer.write("Data Dump from Barometer (Altitude):\n");
        for (Data item : heightData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }

        writer.write("\nData Dump from Flex Sensors:\n");
        for (Data item : flexData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }
        
        writer.write("\nData Dump from Emg Sensors:\n");
        for (Data item : emgData) {
            writer.write("Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
        }

        for (int i = 0; i < forceData.size(); i++) {
            writer.write("\nData Dump from Force Sensor " + i + ":\n");
            for (Data item : forceData.get(i)) {
              switch(i % 3){
                case 0:
                  writer.write("Thumb");
                case 1:
                  writer.write("Pointer");
                case 2:
                  writer.write("Middle");
                default:
                  break;
              }
                writer.write(" Reading: " + item.reading + ", Time Elapsed: " + item.timeElapsed + "\n");
            }
        }

        System.out.println("Log file created at: " + file.getAbsolutePath());
    } 
    catch (IOException e) {
        System.out.println(throwError(e,4));
    }
}
