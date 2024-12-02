void statusPopup(){
        // First popup: Ask the user if they want to see a description of their current status or all statuses
        Object[] options = {"Current Status", "All Statuses"};
        int choice = JOptionPane.showOptionDialog(
            null,
            "Would you like to see the description of your current status or for all statuses?",
            "Status Options",
            JOptionPane.YES_NO_OPTION,
            JOptionPane.QUESTION_MESSAGE,
            null,
            options,
            options[0]
        );

        // Second popup: Show the corresponding information based on the user's choice
        if (choice == JOptionPane.YES_OPTION) { // Current Status
            JOptionPane.showMessageDialog(
                null,
                "Status: " + ClimbingString(currentStatus) + "\n" +
                "Description: " + AboutStatus(currentStatus),
                "Current Status Description",
                JOptionPane.INFORMATION_MESSAGE
            );
        }
        else if (choice == JOptionPane.NO_OPTION) { // All Statuses
            JOptionPane.showMessageDialog(
                null,
                "All Status Descriptions:\n" +
                "1. " + ClimbingString(ClimbingStatus.Climbing) + " : " + AboutStatus(ClimbingStatus.Climbing) + "\n" +
                "2. " + ClimbingString(ClimbingStatus.Stationary) + " : " + AboutStatus(ClimbingStatus.Stationary) + "\n" +
                "3. " + ClimbingString(ClimbingStatus.Falling) + " : " + AboutStatus(ClimbingStatus.Falling) + "\n", 
                "All Statuses Description",
                JOptionPane.INFORMATION_MESSAGE
            );
        }
}

void holdPopup(){
  // First popup: Ask the user if they want to see a description of their current status or all statuses
        Object[] options = {"Current Hold", "All Holds"};
        int choice = JOptionPane.showOptionDialog(
            null,
            "Would you like to see the description of your current hold or for all holds?",
            "Status Options",
            JOptionPane.YES_NO_OPTION,
            JOptionPane.QUESTION_MESSAGE,
            null,
            options,
            options[0]
        );

        // Second popup: Show the corresponding information based on the user's choice
        if (choice == JOptionPane.YES_OPTION) { // Current Status
            JOptionPane.showMessageDialog(
                null,
                "Status: " + HoldString(currentHold) + "\n" +
                "Description: " + AboutHold(currentHold),
                "Current Status Description",
                JOptionPane.INFORMATION_MESSAGE
            );
        }
        else if (choice == JOptionPane.NO_OPTION) { // All Statuses
            JOptionPane.showMessageDialog(
                null,
                "All Status Descriptions:\n" +
                "1. " + HoldString(Hold.Jug) + " : " + AboutHold(Hold.Jug) + "\n" +
                "2. " + HoldString(Hold.Sloper) + " : " + AboutHold(Hold.Sloper) + "\n" +
                "3. " + HoldString(Hold.Crimp) + " : " + AboutHold(Hold.Crimp) + "\n", 
                "All Statuses Description",
                JOptionPane.INFORMATION_MESSAGE
            );
        }
}

void performHandReadings() {
  JOptionPane.showMessageDialog(null, "Clench your hand and press spacebar to continue.");
  clenchedHandFlexReading = currValues != null ? currValues.GetFlex() : 0;
  
  JOptionPane.showMessageDialog(null, "Relax your hand and press spacebar to continue.");
  clenchedHandFlexReading = currValues != null ? currValues.GetFlex() : 0;
  
  currentState = State.Graph;
}
