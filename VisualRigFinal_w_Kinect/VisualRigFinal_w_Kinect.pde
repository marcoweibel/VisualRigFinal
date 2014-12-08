/* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* /* 
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Final for CODE, 2014 Fall
 Live Visual Rig to be used with Kinect as well as a MIDI Controller.
 Done by Marco Weibel, with the help of various open source libraries 
 and examples. All credit mentioned right before the code is used!
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */

/* Import My Libraries*/
import themidibus.*;
import SimpleOpenNI.*; // kinect
import blobDetection.*; // blobs
import java.awt.Polygon; // this is a regular java import so we can use and extend the polygon class (see PolygonBlob)

          /*
          Code from Kinect Flow Example by Amnon Owed 
          */

          // declare SimpleOpenNI object
          SimpleOpenNI context;
      
          // declare BlobDetection object
          BlobDetection theBlobDetection;
      
          // declare custom PolygonBlob object (see class for more info)
          PolygonBlob poly = new PolygonBlob();
       
          // PImage to hold incoming imagery and smaller one for blob detection
          PImage cam, blobs;
      
          // the kinect's dimensions to be used later on for calculations
          int kinectWidth = 640;
          int kinectHeight = 480;
      
          // to center and rescale from 640x480 to higher custom resolutions
          float reScale;
          
          // background color
          color bgColor;
          
          // three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)
          String[] palettes = {
            "-13683658,-8410437,-13683658,-8410437,-13683658,-8410437,-13683658"
          };
          
          // an array called flow of 2250 Particle objects (see Particle class)
          Particle[] flow = new Particle[2250];
          
          // global variables to influence the movement of all particles
          float globalX, globalY;

      /*
      Code from Processing Examples : Space Junk
      */
      int limit = 500;
      // Array for all cubes
      ParticleOne[] particleOne = new ParticleOne[limit];
      float angle;

//declare midiBus
MidiBus myBus;

VisualOne visualOne;
VisualTwo visualTwo;
VisualThree visualThree;

ParticleTwo particleTwo;
ParticleThree[] particleThree = new ParticleThree[200]; //Creating an array with 200 objects

/*
Thanks Anthony for putting me onto using booleans to call my MIDI presses.
*/
boolean midi1Off;
boolean midi2Off;
boolean midi3Off;
boolean midi4Off;

boolean midi1Pressed;
boolean midi2Pressed;
boolean midi3Pressed;
boolean midi4Pressed;

boolean midi9Off;
boolean midi10Off;
boolean midi11Off;
boolean midi12Off;

boolean midi9Pressed;
boolean midi10Pressed;
boolean midi11Pressed;
boolean midi12Pressed;

boolean midi5;
boolean midi6;
boolean midi7;
boolean midi8;

boolean midi13;
boolean midi14;
boolean midi15;
boolean midi16;

float c;
float backgroundC;
float particleZoom;
float particleZoom2;
float particleZoom3;
float shapeSize;

void setup () {
  
  size (displayWidth, displayHeight, P3D);
  lights ();
  smooth();

  //initialize my classes (Shapes)
  visualOne = new VisualOne();
  visualTwo = new VisualTwo();
  visualThree = new VisualThree();

 //initialize my classes (Particle Systems)
            /*
                  Code is from Processing Examples - Space Junk 
             */
            // Instantiate cubes, passing in random vals for size and postion
            for (int i = 0; i < particleOne.length; i++) {
              particleOne[i] = new ParticleOne(int(random(-10, 10)), int(random(-10, 10)), 
              int(random(-10, 10)), int(random(-140, 140)), 
              int(random(-140, 140)), int(random(-140, 140)));

    particleTwo = new ParticleTwo();
    
    for (int k=0; k<particleThree.length; k++) {
      particleThree[k] = new ParticleThree();
    }

    //Choosing the inputs/output for connections to my MIDI controller
    myBus = new MidiBus(this, 0, 1);
  }

  //initiate my variables
  midi1Off=false;
  midi2Off=false;
  midi3Off=false;
  midi4Off=false;
  midi9Off=false;
  midi10Off=false;
  midi11Off=false;
  midi12Off=false;

  midi1Pressed=false;
  midi2Pressed=false;
  midi3Pressed=false;
  midi4Pressed=false;
  midi9Pressed=false;
  midi10Pressed=false;
  midi11Pressed=false;
  midi12Pressed=false;

  midi5=false;
  midi6=false;
  midi7=false;
  midi8=false;
  midi13=false;
  midi14=false;
  midi15=false;
  midi16=false;
  
  shapeSize = 100;

                          /*This code is from Kinect Library/Example : Kinect Flow
                           */
                          // initialize SimpleOpenNI object
                        
                          context = new SimpleOpenNI(this);
                        
                          if (!context.enableScene()) { 
                            println("Kinect not connected!"); 
                        
                            exit();
                          } else {
                        
                            // mirror the image to be more intuitive
                        
                              context.setMirror(true);
                        
                            // calculate the reScale value
                        
                              // currently it's rescaled to fill the complete width (cuts of top-bottom)
                        
                            // it's also possible to fill the complete height (leaves empty sides)
                        
                            reScale = (float) width / kinectWidth;
                        
                            // create a smaller blob image for speed and efficiency
                        
                            blobs = createImage(kinectWidth/3, kinectHeight/3, RGB);
                        
                            // initialize blob detection object to the blob image dimensions
                        
                            theBlobDetection = new BlobDetection(blobs.width, blobs.height);
                        
                            theBlobDetection.setThreshold(0.2);
                        
                            setupFlowfield();
                          }
}

void draw () {

  colorMode(HSB, 255, 255, 255);
  background (backgroundC*0.7, backgroundC*0.5, backgroundC);

  if (midi1Off) {
    visualOne.makeShape();
  }

  if (midi2Off) {
    visualTwo.makeShape();
  }

  if (midi3Off) {
    visualThree.makeShape();
  }

  if (midi4Off) {
    backgroundChange();
  }

  if (midi5) {
    visualOne.makeShape();
  }

  if (midi6) {
    visualTwo.makeShape();
  }

  if (midi7) {
    visualThree.makeShape();
  }

  if (midi8) {
    backgroundChange();
  }

  if (midi9Off) {

                                /*
                                    Code is from Processing Examples - Space Junk 
                                 */
                                // Set up some different colored lights
                                pointLight(51, 102, 255, 65, 60, 100); 
                                pointLight(200, 40, 60, -65, -60, -150);
                            
                                // Raise overall light in scene 
                                ambientLight(70, 70, 10); 
                            
                                // Center geometry in display windwow.
                                // you can changlee 3rd argument ('0')
                                // to move block group closer(+) / further(-)
                                translate(width/2, height/2, -200 + particleZoom * 0.65);
                            
                                // Rotate around y and x axes
                                rotateY(radians(angle));
                                rotateX(radians(angle));
                            
                                // Draw cubes
                                for (int i = 0; i < particleOne.length; i++) {
                                  particleOne[i].drawCube();
                                }
                            
                                // Used in rotate function calls above
                                angle += 0.6;
  }

  if (midi10Off) {
    particleTwo.drawParticles();
  }


  if (midi11Off) {

    for (int i=0; i<particleThree.length; i++) {

      particleThree[i].movement();
      particleThree[i].collision();
      particleThree[i].drawParticles();
      particleThree[i].updateShape();
    }
  }

  if (midi12Off) {
                                  /*
                                  Code from Kinect Flow Example by Amnon Owed 
                                   */
                              
                                  // update the SimpleOpenNI object
                              
                                  context.update();
                              
                                  // put the image into a PImage
                              
                                    cam = context.sceneImage().get();
                              
                                  // copy the image into the smaller blob image
                              
                                  blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);
                              
                                  // blur the blob image
                              
                                  blobs.filter(BLUR);
                              
                                  // detect the blobs
                              
                                  theBlobDetection.computeBlobs(blobs.pixels);
                              
                                  // clear the polygon (original functionality)
                              
                                  poly.reset();
                              
                                  // create the polygon from the blobs (custom functionality, see class)
                              
                                  poly.createPolygon();
                              
                                  drawFlowfield();
  }

  if (midi13) {
                                  /*
                                      This code is from Processing Examples - Space Junk 
                                   */
                                  // Set up some different colored lights
                                  pointLight(51, 102, 255, 65, 60, 100); 
                                  pointLight(200, 40, 60, -65, -60, -150);
                              
                                  // Raise overall light in scene 
                                  ambientLight(70, 70, 10); 
                              
                                  // Center geometry in display windwow.
                                  // you can changlee 3rd argument ('0')
                                  // to move block group closer(+) / further(-)
                                  translate(width/2, height/2, -200 + particleZoom * 0.65);
                              
                                  // Rotate around y and x axes
                                  rotateY(radians(angle));
                                  rotateX(radians(angle));
                              
                                  // Draw cubes
                                  for (int i = 0; i < particleOne.length; i++) {
                                    particleOne[i].drawCube();
                                  }
                              
                                  // Used in rotate function calls above
                                  angle += 0.6;
  }

  if (midi14) {
    particleTwo.drawParticles();
  }

  if (midi15) {

    for (int i=0; i<particleThree.length; i++) {

      particleThree[i].movement();
      particleThree[i].collision();
      particleThree[i].drawParticles();
      particleThree[i].updateShape();
    }
  }
  
   if (midi16) {
                                  /*
                                  Code from Kinect Flow Example by Amnon Owed 
                                   */
                              
                                  // update the SimpleOpenNI object
                              
                                  context.update();
                              
                                  // put the image into a PImage
                              
                                    cam = context.sceneImage().get();
                              
                                  // copy the image into the smaller blob image
                              
                                  blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);
                              
                                  // blur the blob image
                              
                                  blobs.filter(BLUR);
                              
                                  // detect the blobs
                              
                                  theBlobDetection.computeBlobs(blobs.pixels);
                              
                                  // clear the polygon (original functionality)
                              
                                  poly.reset();
                              
                                  // create the polygon from the blobs (custom functionality, see class)
                              
                                  poly.createPolygon();
                              
                                  drawFlowfield();
  }

}

void noteOn(int channel, int pit, int vel) {
  /*
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
   BIG SHOUT OUT TO KYLE LI FOR HELPING ME OUT WITH USING BOOLEANS TO CREATE AN ON/OFF STATE FOR MY BUTTONS
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   */
   
  //top row of MIDI controller buttons - Left to Right
  if (pit == 60) {
    if (midi1Pressed == false) {
      midi1Pressed = true;
      midi1Off=!midi1Off;
    }
  }

  if (pit == 61) {
    if (midi2Pressed == false) {
      midi2Pressed = true;
      midi2Off=!midi2Off;
    }
  }
  if (pit == 62) {
    if (midi3Pressed == false) {
      midi3Pressed = true;
      midi3Off=!midi3Off;
    }
  }

  if (pit == 63) {
    if (midi4Pressed == false) {
      midi4Pressed = true;
      midi4Off=!midi4Off;
    }
  }
  //Third row of MIDI controller buttons - Left to Right
  if (pit == 56) {
    midi5 = true;
  }

  if (pit == 57) {
    midi6 = true;
  }

  if (pit == 58) {
    midi7 = true;
  }
  if (pit == 59) {
    midi8 = true;
  }


  // Second row of MIDI controller buttons - Left to Right
  if (pit == 52) {
    if (midi9Pressed == false) {
      midi9Pressed = true;
      midi9Off=!midi9Off;
    }
  }

  if (pit == 53) {
    if (midi10Pressed == false) {
      midi10Pressed = true;
      midi10Off=!midi10Off;
    }
  }

  if (pit == 54) {
    if (midi11Pressed == false) {
      midi11Pressed = true;
      midi11Off=!midi11Off;
    }
  }

  if (pit == 55) {
    if (midi12Pressed == false) {
      midi12Pressed = true;
      midi12Off=!midi12Off;
    }
  }

  //First row of MIDI controller buttons - Left to Right
  if (pit == 48) {
    midi13 = true;
  }

  if (pit == 49) {
    midi14 = true;
  }

  if (pit == 50) {
    midi15 = true;
  }
  if (pit == 51) {
    midi16 = true;
  }
}


void noteOff(Note note) {

  midi1Pressed = false;
  midi2Pressed = false;
  midi3Pressed = false;
  midi4Pressed = false;


  midi5 = false;
  midi6 = false;
  midi7 = false;
  midi8 = false;

  midi9Pressed = false;
  midi10Pressed = false;
  midi11Pressed = false;
  midi12Pressed = false;

  midi13 = false;
  midi14 = false;
  midi15 = false;
  midi16 = false;
}

void controllerChange(int channel, int number, int value) {

  if (number == 13) {
    c = map (float(value), 1, 127, 150, 0);
  }

  if (number == 12) {
    shapeSize = map (float(value), 1, 127, 400, 200);
  }

  if (number == 11) {
    particleZoom = map (float(value), 1, 127, width-250, width/2);
    particleZoom2 = map (float(value), 2, 127, 15, 40);
    particleZoom3 = map (float(value), 127, 1, width+200, width/4);
  }

  if (number == 1) {
    backgroundC = map (float(value), 1, 127, 255, 0);
  }
}

void backgroundChange () {

  background (255);
}



                                  
                                  /*
                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   Code from Kinect Flow Example by Amnon Owed 
                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   */
                                  void setupFlowfield() {
                                  
                                    // set stroke weight (for particle display) to 2.5
                                  
                                    strokeWeight(2.5);
                                  
                                    // initialize all particles in the flow
                                  
                                    for (int i=0; i<flow.length; i++) {
                                  
                                      flow[i] = new Particle(i/10000.0);
                                    }
                                  
                                    // set all colors randomly now
                                  
                                    setRandomColors(1);
                                  }
                                  
                                  void drawFlowfield() {
                                  
                                    // center and reScale from Kinect to custom dimensions
                                  
                                    translate(0, (height-kinectHeight*reScale)/2);
                                  
                                    pushMatrix();
                                  
                                    scale(reScale);
                                  
                                    // set global variables that influence the particle flow's movement
                                  
                                    globalX = noise(frameCount * 0.01) * width/2 + width/4;
                                  
                                    globalY = noise(frameCount * 0.005 + 5) * height;
                                  
                                    // update and display all particles in the flow
                                  
                                    for (Particle p : flow) {
                                  
                                      p.updateAndDisplay();
                                    }
                                  
                                    popMatrix();
                                  }
                                  
                                  // sets the colors every nth frame
                                  void setRandomColors(int nthFrame) {
                                  
                                    String[] paletteStrings = split(palettes[int(random(palettes.length))], ",");
                                  
                                    // turn strings into colors
                                  
                                    color[] colorPalette = new color[paletteStrings.length];
                                  
                                    for (int i=0; i<paletteStrings.length; i++) {
                                  
                                      colorPalette[i] = int(paletteStrings[i]);
                                    }
                                  
                                    // set background color to first color from palette
                                  
                                    bgColor = colorPalette[0];
                                  
                                    // set all particle colors randomly to color from palette (excluding first aka background color)
                                  
                                    for (int i=0; i<flow.length; i++) {
                                  
                                      flow[i].col = colorPalette[int(random(1, colorPalette.length))];
                                    }
                                  }

