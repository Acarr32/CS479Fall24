enum State {
  Menu,
  Piano,
  Guitar,
  Recording
}

State currentState = State.Menu;

float titleSize;
float maxTitleSize;
float minTitleSize;
float timeState;

PImage playIcon, playSampleIcon, startIcon, stopIcon;

// Save the pressed keys to record the music
ArrayList<String> keyPresses = new ArrayList<String>();

// Playback state
boolean isRecording = false;
boolean isPlayingBack = false;
boolean isPlayingSample = false;
int playbackStartTime = 0;
int playbackIndex = 0;
int recordingStartTime = 0;

// Create the buttons for the recording page
Button startRecordingButton, stopRecordingButton, playRecordingButton, playSampleButton;
float backButtonX, backButtonY, backButtonWidth, backButtonHeight;
Button backButton;

// Declare arrays for sound files
int numWhite = 10;
int numBlack = 6;

SoundFile[] whiteKeyNotes = new SoundFile[numWhite];
SoundFile[] blackKeyNotes = new SoundFile[numBlack];

// Octave handling
int currentOctave = 3; // Start at octave 3 (default)
String[] octaves = {"B", "C", "D", "E", "F", "G", "A", "B", "C", "D"};
String[] blackOctaves = {"Db", "Eb", "Gb", "Ab", "Bb", "Db"};

// Piano Keys declarations
float whiteKeyWidth, whiteKeyHeight, blackKeyWidth, blackKeyHeight;
color whiteKeyColor = color(255);
color blackKeyColor = color(0);
color pressedColor = color(200, 100, 100);

float[] whiteKeyX = new float[numWhite]; // Positions for white keys
float[] blackKeyX = new float[numBlack]; // Positions for black keys

boolean[] whiteKeyPressed = new boolean[numWhite];
boolean[] blackKeyPressed = new boolean[numBlack];

// Button positions and sizes
float buttonWidth, buttonHeight;
float octaveUpX, octaveDownX;
float buttonX, buttonY, recordButtonY;

float marginX, marginY;
float pianoX, learnX, guitarX;

Button learnModeButton, pianoModeButton, guitarModeButton;
