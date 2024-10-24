String GetString(String flag) {
  switch(flag) {
  case "title":
    return "TactiNotes";
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


class KeyPressEvent {
  String note;
  int time;  // Time in milliseconds when the key was pressed

  KeyPressEvent(String note, int time) {
    this.note = note;
    this.time = time;
  }
}

// Button class for easy management of buttons
class Button {
  float x, y, w, h;
  String label;
  PImage iconImage;
  color buttonColor;

  Button(float x, float y, float w, float h, String label, PImage iconImage, color buttonColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.iconImage = iconImage;
    this.buttonColor = buttonColor;
  }

  void display() {
    fill(150);
    rect(x, y, w, h);
    fill(0);
    
    if (label != "") {
      textAlign(CENTER, CENTER);
      text(label, x + w / 2, y + h / 2);
    } else {
      imageMode(CENTER);
      image(iconImage, x + w / 2, y + h / 2, w * 0.8, h * 0.8);
    }
  }
  
  void changeColor(color newColor) {
    this.buttonColor = newColor;
  }

  boolean isMouseOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
