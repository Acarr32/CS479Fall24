import processing.serial.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import grafica.*;
import javax.swing.*;

State currentState;
PFont boldFont;
Serial myPort;

Values currValues;

// Graphing Variables
int leftGraphIndex, rightGraphIndex;

// Color Pallettes
color mossGreen;
color rustyRed;
color coralOrange;
color charcoalGray;
color seafoamGreen;

GPlot fsrPlot, flexPlot, heightPlot;

ArrayList<ArrayList<Data>> fsrData = new ArrayList<ArrayList<Data>>();
ArrayList<Data> flexData = new ArrayList<Data>();
ArrayList<Data> heightData = new ArrayList<Data>();

float minFlexReading, maxFlexReading;

float MAX_FORCE_READING = 1000;

float currentFlex;

float relaxedHandFlexReading, clenchedHandFlexReading;

PImage handImg;
PImage climbing1;
PImage climbing2;

Button startButton, stopButton, holdButton, statusButton;

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
float pinkyX;
float pinkyY;
float currPinkyForce;

float ringX;
float ringY;
float currRingForce;

float middleX;
float middleY;
float currMiddleForce;

float pointerX;
float pointerY;
float currPointerForce;

float thumbX;
float thumbY;
float currThumbForce;

ClimbingStatus currentStatus;
Hold currentHold;
boolean Started;
