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

// Graphing Variables
int leftGraphIndex, rightGraphIndex;

// Color Pallettes
color mossGreen;
color rustyRed;
color coralOrange;
color charcoalGray;
color seafoamGreen;

GPlot altitudeGraph;

float minFlexReading, maxFlexReading;

float MAX_FORCE_READING = 1000;

float currentFlex;

float relaxedHandFlexReading, clenchedHandFlexReading;
