String GetString(String flag) {
  switch(flag) {
    case "title":
      return "Dynamic Menu Title";
    case "subtitle":
      return "Choose Your Mode";
    case "pianoMode":
      return "Piano Mode";
    case "guitarMode":
      return "Guitar Mode";
    case "testString":
      return "Test";
    default:
      return "";
  }
}

// Function to generate a color based on time
color GetColor() {
  float r = map(sin(timeState), -1, 1, 0, 255);
  float g = map(cos(timeState), -1, 1, 0, 255);
  float b = map(sin(timeState + PI / 2), -1, 1, 0, 255);
  return color(r, g, b);
}
