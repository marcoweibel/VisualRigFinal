import themidibus.*;

import processing.opengl.*; // opengl

import SimpleOpenNI.*; // kinect

import blobDetection.*; // blobs

import java.awt.Polygon; // this is a regular java import so we can use and extend the polygon class (see PolygonBlob)

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
  //  
  //    "-0,-0,-0,-0,-0,-0,-0,-0,-0,-0", 

  //  "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634", 

  "-13683658,-8410437,-13683658,-8410437,-13683658,-8410437,-13683658" 
    //  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031", 

  //  "-255,-0,-255,-0,-255,-0,-255,-0,-255,-0"
  //  "-16711663,-13888933,-9029017,-5213092,-1787063,-11375744,-2167516,-15713402,-5389468,-2064585"
};


// an array called flow of 2250 Particle objects (see Particle class)
Particle[] flow = new Particle[2250];

// global variables to influence the movement of all particles
float globalX, globalY;

// Cube count-lower/raise to test performance
int limit = 500;

//declare midiBus
MidiBus myBus;

/* Done by Marco Weibel
 Final for CODE 
 */

VisualOne visualOne;
VisualTwo visualTwo;
VisualThree visualThree;

// Array for all cubes
ParticleOne[] particleOne = new ParticleOne[limit];

ParticleTwo particleTwo;
ParticleThree[] particleThree = new ParticleThree[200];


// Used for oveall rotation
float angle;

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

float c;
float backgroundC;
float particleZoom;
float particleZoom2;
float particleZoom3;
float shapeSize = 100;

void setup () {
  size (displayWidth, displayHeight, P3D);
  lights ();

  //initialize my classes
  visualOne = new VisualOne();
  visualTwo = new VisualTwo();
  visualThree = new VisualThree();

  // Instantiate cubes, passing in random vals for size and postion
  for (int i = 0; i < particleOne.length; i++) {
    particleOne[i] = new ParticleOne(int(random(-10, 10)), int(random(-10, 10)), 
    int(random(-10, 10)), int(random(-140, 140)), 
    int(random(-140, 140)), int(random(-140, 140)));

    particleTwo = new ParticleTwo();

    for (int k=0; k<particleThree.length; k++) {
      particleThree[k] = new ParticleThree();
    }

    //Choose appropriate inputs/output for MIDI controller
    myBus = new MidiBus(this, 0, 1);
  }

  //initiate
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

  //Kinect stuff

  // initialize SimpleOpenNI object

  context = new SimpleOpenNI(this);

  if (!context.enableScene()) { 

    // if context.enableScene() returns false

      // then the Kinect is not working correctly

    // make sure the green light is blinking

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
    //kinect stuff
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
}

void noteOn(int channel, int pit, int vel) {

  // BIG SHOUT OUT TO KYLE LI FOR HELPING ME OUT WITH USING BOOLEANS TO CREATE AN ON/OFF STATE FOR MY BUTTONS

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

  // set the colors randomly every 240th frame

  setRandomColors(120);

  popMatrix();
}



// sets the colors every nth frame

void setRandomColors(int nthFrame) {

  if (frameCount % nthFrame == 0) {

    // turn a palette into a series of strings

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
}

// a basic noise-based moving particle

class Particle {

  // unique id, (previous) position, speed

  float id, x, y, xp, yp, s, d;

  color col; // color



  Particle(float id) {

    this.id = id;

    s = random(2, 6); // speed
  }



  void updateAndDisplay() {

    // let it flow, end with a new x and y position

    id += 0.01;

    d = (noise(id, x/globalY, y/globalY)-0.5)*globalX;

    x += cos(radians(d))*s;

    y += sin(radians(d))*s;



    // constrain to boundaries

      if (x<-10) x=xp=kinectWidth+10;

    if (x>kinectWidth+10) x=xp=-10;

    if (y<-10) y=yp=kinectHeight+10;

    if (y>kinectHeight+10) y=yp=-10;



    // if there is a polygon (more than 0 points)

    if (poly.npoints > 0) {

      // if this particle is outside the polygon

      if (!poly.contains(x, y)) {

        // while it is outside the polygon

        while (!poly.contains (x, y)) {

          // randomize x and y

            x = random(kinectWidth);

          y = random(kinectHeight);
        }

        // set previous x and y, to this x and y

        xp=x;

        yp=y;
      }
    }



    // individual particle color

    stroke(col);

    // line from previous to current position

    line(xp, yp, x, y);



    // set previous to current position

    xp=x;

    yp=y;
  }
}

// an extended polygon class with my own customized createPolygon() method (feel free to improve!)

class PolygonBlob extends Polygon {



  // took me some time to make this method fully self-sufficient

  // now it works quite well in creating a correct polygon from a person's blob

  // of course many thanks to v3ga, because the library already does a lot of the work

  void createPolygon() {

    // an arrayList... of arrayLists... of PVectors

    // the arrayLists of PVectors are basically the person's contours (almost but not completely in a polygon-correct order)

    ArrayList<ArrayList<PVector>> contours = new ArrayList<ArrayList<PVector>>();

    // helpful variables to keep track of the selected contour and point (start/end point)

    int selectedContour = 0;

    int selectedPoint = 0;



    // create contours from blobs

    // go over all the detected blobs

    for (int n=0; n<theBlobDetection.getBlobNb (); n++) {

      Blob b = theBlobDetection.getBlob(n);

      // for each substantial blob...

      if (b != null && b.getEdgeNb() > 100) {

        // create a new contour arrayList of PVectors

        ArrayList<PVector> contour = new ArrayList<PVector>();

        // go over all the edges in the blob

        for (int m=0; m<b.getEdgeNb (); m++) {

          // get the edgeVertices of the edge

          EdgeVertex eA = b.getEdgeVertexA(m);

          EdgeVertex eB = b.getEdgeVertexB(m);

          // if both ain't null...

          if (eA != null && eB != null) {

            // get next and previous edgeVertexA

            EdgeVertex fn = b.getEdgeVertexA((m+1) % b.getEdgeNb());

            EdgeVertex fp = b.getEdgeVertexA((max(0, m-1)));

            // calculate distance between vertexA and next and previous edgeVertexA respectively

            // positions are multiplied by kinect dimensions because the blob library returns normalized values

            float dn = dist(eA.x*kinectWidth, eA.y*kinectHeight, fn.x*kinectWidth, fn.y*kinectHeight);

            float dp = dist(eA.x*kinectWidth, eA.y*kinectHeight, fp.x*kinectWidth, fp.y*kinectHeight);

            // if either distance is bigger than 15

            if (dn > 15 || dp > 15) {

              // if the current contour size is bigger than zero

              if (contour.size() > 0) {

                // add final point

                contour.add(new PVector(eB.x*kinectWidth, eB.y*kinectHeight));

                // add current contour to the arrayList

                  contours.add(contour);

                // start a new contour arrayList

                contour = new ArrayList<PVector>();

                // if the current contour size is 0 (aka it's a new list)
              } else {

                // add the point to the list

                contour.add(new PVector(eA.x*kinectWidth, eA.y*kinectHeight));
              }

              // if both distance are smaller than 15 (aka the points are close)
            } else {

              // add the point to the list

              contour.add(new PVector(eA.x*kinectWidth, eA.y*kinectHeight));
            }
          }
        }
      }
    }



    // at this point in the code we have a list of contours (aka an arrayList of arrayLists of PVectors)

    // now we need to sort those contours into a correct polygon. To do this we need two things:

    // 1. The correct order of contours

    // 2. The correct direction of each contour



    // as long as there are contours left...    

    while (contours.size () > 0) {



      // find next contour

      float distance = 999999999;

      // if there are already points in the polygon

      if (npoints > 0) {

        // use the polygon's last point as a starting point

        PVector lastPoint = new PVector(xpoints[npoints-1], ypoints[npoints-1]);

        // go over all contours

        for (int i=0; i<contours.size (); i++) {

          ArrayList<PVector> c = contours.get(i);

          // get the contour's first point

          PVector fp = c.get(0);

          // get the contour's last point

          PVector lp = c.get(c.size()-1);

          // if the distance between the current contour's first point and the polygon's last point is smaller than distance

          if (fp.dist(lastPoint) < distance) {

            // set distance to this distance

              distance = fp.dist(lastPoint);

            // set this as the selected contour

            selectedContour = i;

            // set selectedPoint to 0 (which signals first point)

            selectedPoint = 0;
          }

          // if the distance between the current contour's last point and the polygon's last point is smaller than distance

          if (lp.dist(lastPoint) < distance) {

            // set distance to this distance

              distance = lp.dist(lastPoint);

            // set this as the selected contour

            selectedContour = i;

            // set selectedPoint to 1 (which signals last point)

            selectedPoint = 1;
          }
        }

        // if the polygon is still empty
      } else {

        // use a starting point in the lower-right

        PVector closestPoint = new PVector(width, height);

        // go over all contours

        for (int i=0; i<contours.size (); i++) {

          ArrayList<PVector> c = contours.get(i);

          // get the contour's first point

          PVector fp = c.get(0);

          // get the contour's last point

          PVector lp = c.get(c.size()-1);

          // if the first point is in the lowest 5 pixels of the (kinect) screen and more to the left than the current closestPoint

          if (fp.y > kinectHeight-5 && fp.x < closestPoint.x) {

            // set closestPoint to first point

            closestPoint = fp;

            // set this as the selected contour

            selectedContour = i;

            // set selectedPoint to 0 (which signals first point)

            selectedPoint = 0;
          }

          // if the last point is in the lowest 5 pixels of the (kinect) screen and more to the left than the current closestPoint

          if (lp.y > kinectHeight-5 && lp.x < closestPoint.y) {

            // set closestPoint to last point

            closestPoint = lp;

            // set this as the selected contour

            selectedContour = i;

            // set selectedPoint to 1 (which signals last point)

            selectedPoint = 1;
          }
        }
      }



      // add contour to polygon

      ArrayList<PVector> contour = contours.get(selectedContour);

      // if selectedPoint is bigger than zero (aka last point) then reverse the arrayList of points

      //      if (selectedPoint > 0) { Collections.reverse(contour); }

      // add all the points in the contour to the polygon

      for (PVector p : contour) {

        addPoint(int(p.x), int(p.y));
      }

      // remove this contour from the list of contours

      contours.remove(selectedContour);

      // the while loop above makes all of this code loop until the number of contours is zero

      // at that time all the points in all the contours have been added to the polygon... in the correct order (hopefully)
    }
  }
}

