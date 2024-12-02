String throwError(Exception e, int id){
  printLine();
  if(e != null){
  }
  switch(id){
    case 1:
      System.out.println("ERROR 001: IMAGE FILE NOT LOADED.");
      System.out.println("PLESE DOWNLOAD THE IMAGE FROM THE FOLLOWING LINK AND ADD TO ./DATA/REPLAYBACKGROUND.JPG");
      System.out.println("https://github.com/Acarr32/CS479Fall24/blob/main/Final/README.md");
      if(e != null){
        printLine();
        System.out.println("STACK TRACE (FOR DEBUGGING)");
        e.printStackTrace();
        printLine();
      }
      return "ERROR 001: PLEASE CONSULT THE TERMINAL FOR MORE INFORMATION";
    case 2:
      System.out.println("ERROR 002: ALTITUDE SENSOR NOT PROPERLY CONNECTED");
      System.out.println("See the repository README for more information");
      System.out.println("https://github.com/Acarr32/CS479Fall24/blob/main/Final/README.md");
      if(e != null){
        printLine();
        System.out.println("STACK TRACE (FOR DEBUGGING)");
        e.printStackTrace();
        printLine();
      }
      return "ERROR 002: ALTITUDE SENSOR NOT PROPERLY CONNECTED";
    case 3:
      System.out.println("ERROR 003: FORCE SENSOR(S) NOT PROPERLY CONNECTED");
      System.out.println("See the repository README for more information");
      System.out.println("https://github.com/Acarr32/CS479Fall24/blob/main/Final/README.md");
      if(e != null){
        printLine();
        System.out.println("STACK TRACE (FOR DEBUGGING)");
        e.printStackTrace();
        printLine();
      }
      return "ERROR 003: FORCE SENSOR(S) NOT PROPERLY CONNECTED";
    case 4:
      System.out.println("ERROR 004: FAILED TO WRITE TO OUTPUT LOG FILE");
      System.out.println("See the repository README for more information");
      System.out.println("https://github.com/Acarr32/CS479Fall24/blob/main/Final/README.md");
      if(e != null){
        printLine();
        System.out.println("STACK TRACE (FOR DEBUGGING)");
        e.printStackTrace();
        printLine();
      }
      return "ERROR 004: FAILED TO WRITE TO OUTPUT LOG FILE";
    case 5:
      System.out.println("ERROR OO5: SERIAL OUTPUT FAILURE");
      System.out.println("See the repository README for more information");
      System.out.println("https://github.com/Acarr32/CS479Fall24/blob/main/Final/README.md");
      if(e != null){
        printLine();
        System.out.println("STACK TRACE (FOR DEBUGGING)");
        e.printStackTrace();
        printLine();
      }
      return "ERROR OO5: SERIAL OUTPUT FAILURE";
    case 6:
        System.out.println("ERROR OO6: FILE DIRECTORY ERROR");
        System.out.println("See the repository README for more information");
        System.out.println("https://github.com/Acarr32/blob/main/Final/README.md");
        if(e != null){
          printLine();
          System.out.println("STACK TRACE (FOR DEBUGGING)");
          e.printStackTrace();
          printLine();
        }
        return "ERROR OO6: FILE DIRECTORY ERROR";
    default:
      return null;
  }
}
