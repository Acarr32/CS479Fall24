import processing.serial.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import grafica.*;

State currentState;
PFont boldFont;
Serial myPort;


// Graphing Variables
int leftGraphIndex, rightGraphIndex;
color PLOT_POINT_COLOR;
color PLOT_LINE_COLOR;
color PLOT_POINT_SIZE;
color PLOT_GRID_LINE_COLOR;


float MAX_FORCE_READING;
