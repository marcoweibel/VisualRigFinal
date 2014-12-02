import themidibus.*;

MidiBus myBus;

/* Done by Marco Weibel
 Final for CODE 
 */


VisualOne visualOne;
VisualTwo visualTwo;
VisualThree visualThree;


// Used for oveall rotation
float angle;

boolean midi5;

boolean midi1Off;
boolean midi2Off;
boolean midi3Off;
boolean midi4Off;

boolean midi1Pressed;
boolean midi2Pressed;
boolean midi3Pressed;
boolean midi4Pressed;



float c;
float backgroundC;
float shapeSize = 100;


// Cube count-lower/raise to test performance
int limit = 500;

// Array for all cubes
ParticleOne[] particleOne = new ParticleOne[limit];

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

    // List all available Midi devices on STDOUT. This will show each device's index and name.
    MidiBus.list();
    myBus = new MidiBus(this, 0, 1);
  }

  //initiate
  midi5=false;

  midi1Off=false;
  midi2Off=false;
  midi3Off=false;
  midi4Off=false;

  midi1Pressed=false;
  midi2Pressed=false;
  midi3Pressed=false;
  midi4Pressed=false;
}

void draw () {
  int channel = 0;
  int number = 0;
  int value = 0;

  myBus.sendControllerChange(channel, number, value); // Send a controllerChange\

  colorMode(HSB, 180, 150, 100, 180);
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

  if (keyPressed) {

    if (key == 'c' || key == 'C') {
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
      translate(width/2, height/2, -200 + mouseX * 0.65);

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
  }
}

void noteOn(int channel, int pit, int vel) {

  // BIG SHOUT OUT TO KYLE FOR HELPING ME OUT WITH THIS ON/OFF STATE CODE

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
}  


void noteOff(Note note) {

  midi1Pressed = false;
  midi2Pressed = false;
  midi3Pressed = false;
  midi4Pressed = false;

  midi5 = false;
}

void controllerChange(int channel, int number, int value) {

  if (number == 13) {
    c = map (float(value), 0, 127, 120, 0);
  }

  if (number == 12) {
    shapeSize = map (float(value), 0, 127, 400, 200);
  }

  if (number == 1) {
    backgroundC = map (float(value), 0, 127, 255, 0);
  }
}

void backgroundChange () {

  background (0, 0, 255);
}

