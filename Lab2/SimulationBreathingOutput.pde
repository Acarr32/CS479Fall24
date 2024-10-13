import processing.serial.*;  // Import the Serial library

float targetAngle = PI / 2;  // Start pointing vertically upwards (PI/2 radians)
float easing = 0.05f;
Serial myPort;  // Declare object for serial port
PFont f;

void drawSpin() {
  fill(0, 12);  // Create the fading trail effect
  rect(0, 0, width, height);

  // Map the real-time respiration value (0 to 1000) to an angle between 0 and PI
  float mappedAngle = map(resprate, 0, 500, -PI / 2, PI / 2);  // Constrain to horizontal motion

  float dir = (mappedAngle - targetAngle) / TWO_PI;
  dir -= round(dir);
  dir *= TWO_PI;
  
  // Update target angle smoothly with easing
  targetAngle += dir * easing;

  drawSemiCircle();  // Draw semi-circle

  noFill();
  stroke(200);

  // Move the spinning object to the bottom-right corner of the window
  pushMatrix();
  float centerX = width - 150;  // Use the same center as the semi-circle
  float centerY = height - 100; 
  translate(centerX, centerY);  // Position in the bottom-right corner
  rotate(targetAngle);
  
  // Draw the spinning line (60 units long)
  line(0, 0, 0, -130);
  
  popMatrix();
}

void drawSemiCircle() {
  fill(0);
  rect(width-300, height-300, 500, 500);
  
  float radius = 130;  // Smaller radius for the semi-circle in the corner
  
  // Set up angles for the three segments (in radians)
  float startAngle = PI;           // Starting at 180 degrees (leftmost)
  float segmentAngle = PI / 3;     // Each segment is 60 degrees (PI/3 radians)
  
  // Calculate the center of the arc for the bottom-right corner
  float centerX = width - 150;
  float centerY = height - 100;
  
  noStroke();
  
  // Left third (green)
  fill(0, 100, 0);  // Green color
  arc(centerX, centerY, radius * 2, radius * 2, startAngle, startAngle + segmentAngle, PIE);
  
  // Middle third (yellow)
  fill(100, 100, 0);  // Yellow color
  arc(centerX, centerY, radius * 2, radius * 2, startAngle + segmentAngle, startAngle + 2 * segmentAngle, PIE);
  
  // Right third (red)
  fill(100, 0, 0);  // Red color
  arc(centerX, centerY, radius * 2, radius * 2, startAngle + 2 * segmentAngle, startAngle + PI, PIE);
  
  f = createFont("Arial", 16, true);
  textFont(f, 16);
  fill(255);
  text("Max\nPressure", centerX + 90, centerY+30);   // Adjusted for the corner
  text("Min\nPressure", centerX - 90, centerY+30);   // Adjusted for the corner
}
