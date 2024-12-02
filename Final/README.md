# tRocker - Smart Rock-Climbing Glove

[![Link to LaTeX report](https://img.shields.io/badge/Research_Paper-Link-green)](https://drive.google.com/drive/folders/1l-PDidxaaZN4nYoOUncHmqJZ8NY1nHeO?usp=sharing)

## Overview
This project involves the design and development of a wearable glove system specifically tailored for optimizing rock climbing training. The glove integrates multiple sensors to capture data on grip force, finger flexion, hand motion, muscle activity, and altitude changes. The system is built on BLE-enabled FireBeetle 328P boards using a central-peripheral communication model to facilitate real-time data processing and transmission. Data is pre-processed on-board to ensure accuracy before being sent to a custom user interface for visualization.

## Features
- **Sensor Integration**: Includes Force-Sensitive Resistors (FSRs), Flex Sensors, an MPU-6050 accelerometer, MYOWARE 2.0 EMG sensors, and a BMP380 barometer.
- **Real-Time Monitoring**: Provides climbers with detailed metrics and feedback for technique optimization.
- **User Interface**: Features dynamic graphs, real-time status updates, and a replay functionality to review performance.

## Authors
This project is developed by a student team from the University of Illinois at Chicago, and submitted as a final project for CS/BME 479 Wearable and Nearable Technologies:
<div align="center">
  
   **Shehrirar Burney**  
   Department of Computer Science  
   Chicago, Illinois, USA  
   [sburne4@uic.edu](mailto:sburne4@uic.edu)

   **Eleonora Cabai**  
   Department of Computer Science  
   Chicago, Illinois, USA  
   [ecaba5@uic.edu](mailto:ecaba5@uic.edu)

   **Anna Carroll**  
   Department of Biomedical Engineering  
   Chicago, Illinois, USA  
   [acarr32@uic.edu](mailto:acarr32@uic.edu)

   **Alexander Williams, Jr.**  
   Department of Computer Science  
   Chicago, Illinois, USA  
   [awill276@uic.edu](mailto:awill276@uic.edu)
</div>

## Possible Errors and Proposed Fixes

### Error 001: Image File Not Loaded
- **Cause**: Missing image file `replaybackground.jpg`.
- **Solution**: Download the image `replaybackground.jpg` from the [GitHub repository](https://github.com/Acarr32/CS479Fall24/tree/main/Final/data) and add it to the `./data/` directory.

### Error 002: Altitude Sensor Not Properly Connected
- **Cause**: The altitude sensor connection is not secure.
- **Solution**: Refer to the wiring diagram in the [Report](https://drive.google.com/drive/folders/1l-PDidxaaZN4nYoOUncHmqJZ8NY1nHeO?usp=sharing) to in the ensure that the wires are where they should be (see: `Figure 1: Circuit Diagram`). If this is the case, your sensor could be shorted, which you can check with a multimeter. Refer to the `Additional Resources` to find more information about the sensors.

### Error 003: Force Sensor(s) Not Properly Connected
- **Cause**: Force sensors may not be connected correctly.
- **Solution**: Refer to the wiring diagram in the [Report](https://drive.google.com/drive/folders/1l-PDidxaaZN4nYoOUncHmqJZ8NY1nHeO?usp=sharing) to in the ensure that the wires are where they should be (see: `Figure 1: Circuit Diagram`). If this is the case, your sensor could be shorted, which you can check with a multimeter. Refer to the `Additional Resources` to find more information about the sensors.

### Error 004: Failed to Write to Output Log File
- **Cause**: Issues with file permissions or incorrect file paths.
- **Solution**: Verify that the output directory is writable and that the paths are correct. You may need to add permission to processing in order to allow this feature to work.
 
### Error 005: Serial Event Read Failure
- **Cause**: The connection between the 328P board and the program itself is poor.
- **Solution**: Reload the [Arduino File](https://github.com/Acarr32/CS479Fall24/blob/main/Final/FinalArduino/FinalArduino.ino) to the central board and try again. If the problem persists, email one of the developers, as there is no other non-code related fix.

## Additional Resources
- [Report](https://drive.google.com/drive/folders/1l-PDidxaaZN4nYoOUncHmqJZ8NY1nHeO?usp=sharing)
- [GitHub Repository](https://github.com/Acarr32/CS479Fall24/tree/main/Final)
- [BMP390 Barometer](https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp390/)
- [FireBeetle 328P Boards](https://www.dfrobot.com/product-1646.html)
- [MPU 6050 Accelerometer](https://invensense.tdk.com/products/motion-tracking/6-axis/mpu-6050/)

## Acknowledgments
We would like to thank our academic peers and mentors who provided valuable feedback and guidance throughout the development of this project. Special thanks to the University of Illinois at Chicago Biomedical Engineering deparement and professor Esmailbeigi for their resources and support.
