import processing.serial.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import grafica.*;
import javax.swing.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

State currentState;
PFont boldFont;
Serial myPort;

// Graphing Variables
int leftGraphIndex, rightGraphIndex;

// Color Pallettes
color mossGreen;
color rustyRed;
color coralOrange;
color charcoalGray;
color seafoamGreen;

GPlot fsrPlot, flexPlot, heightPlot, emgPlot;

ArrayList<ArrayList<Data>> fsrData = new ArrayList<ArrayList<Data>>();
ArrayList<Data> flexData = new ArrayList<Data>();
ArrayList<Data> heightData = new ArrayList<Data>();
ArrayList<Data> emgData = new ArrayList<Data>();

float minFlexReading, maxFlexReading;

float MAX_FORCE_READING = 1000;

float relaxedHandFlexReading, clenchedHandFlexReading;

PImage handImg;
PImage climbing1;
PImage climbing2;

Values currValues;
ArrayList<ReplayValues> replayValuesList = new ArrayList<ReplayValues>();
float replayClock = 0;
Replay replay;
float prevThm;
float prevPtr;
float prevMid;

Button startButton, stopButton, holdButton, statusButton, replayButton;

boolean GraphingLoaded = false;

// Original image dimensions
final float originalWidth = 211.0;
final float originalHeight = 288.0;

// Anchor coordinates (top-left corner of the rendered image)
float handAnchorX; // Set this to the actual anchor X position when rendering
float handAnchorY; // Set this to the actual anchor Y position when rendering

float handWidth;
float handHeight;

// Scaled coordinate ratios and adjusted positions
float middleX;
float middleY;

float pointerX;
float pointerY;

float thumbX;
float thumbY;

//currValues = new Values(thm, ind, mid, flx, vtg, acc, gyr);

int seed;

ClimbingStatus currentStatus;
Hold currentHold;
boolean Started;
boolean hasStartedBefore = false;

float clock;
