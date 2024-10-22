enum State {
  Menu,
  Piano,
  Guitar
}


State currentState = State.Menu;

float titleSize;
float maxTitleSize;
float minTitleSize;
float timeState;




int numWhite = 10;
int numBlack = 6;

// Declare arrays for sound files
SoundFile[] whiteKeyNotes = new SoundFile[numWhite];
SoundFile[] blackKeyNotes = new SoundFile[numBlack];

// Octave handling
int currentOctave = 3; // Start at octave 3 (default)
String[] octaves = {"B", "C", "D", "E", "F", "G", "A", "B", "C", "D"};
String[] blackOctaves = {"Db", "Eb", "Gb", "Ab", "Bb", "Db"};

// Piano Keys declarations
int whiteKeyWidth, whiteKeyHeight, blackKeyWidth, blackKeyHeight;
color whiteKeyColor, blackKeyColor, pressedColor;

int[] whiteKeyX = new int[numWhite]; // Positions for white keys
int[] blackKeyX = new int[numBlack]; // Positions for black keys

boolean[] whiteKeyPressed = new boolean[numWhite];
boolean[] blackKeyPressed = new boolean[numBlack];

// Button positions and sizes
int buttonWidth;
int buttonHeight;
int octaveUpX, octaveDownX, buttonY;

int marginX, marginY;
