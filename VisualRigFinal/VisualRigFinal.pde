import themidibus.*;

MidiBus myBus;

/* Done by Marco Weibel
 Final for CODE 
 */


VisualOne visualOne;
VisualTwo visualTwo;
VisualThree visualThree;

ParticleTwo particleTwo;


// Used for oveall rotation
float angle;

boolean midi1Off;
boolean midi2Off;
boolean midi3Off;
boolean midi4Off;
boolean midi9Off;

boolean midi1Pressed;
boolean midi2Pressed;
boolean midi3Pressed;
boolean midi4Pressed;
boolean midi9Pressed;

boolean midi5;
boolean midi6;
boolean midi7;
boolean midi8;
boolean midi13;
boolean midi14;


float c;
float backgroundC;
float particleZoom;
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
  
  particleTwo = new ParticleTwo();
  

  // Instantiate cubes, passing in random vals for size and postion
  for (int i = 0; i < particleOne.length; i++) {
    particleOne[i] = new ParticleOne(int(random(-10, 10)), int(random(-10, 10)), 
    int(random(-10, 10)), int(random(-140, 140)), 
    int(random(-140, 140)), int(random(-140, 140)));

    // List all available Midi devices on STDOUT. This will show each device's index and name.
//    MidiBus.list();
    myBus = new MidiBus(this, 0, 1);
  }

  //initiate
  midi1Off=false;
  midi2Off=false;
  midi3Off=false;
  midi4Off=false;
  midi9Off=false;

  midi1Pressed=false;
  midi2Pressed=false;
  midi3Pressed=false;
  midi4Pressed=false;
  midi9Pressed=false;

  midi5=false;
  midi6=false;
  midi7=false;
  midi8=false;
  midi13=false;
  midi14=false;
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

  //First row of MIDI controller buttons - Left to Right
  if (pit == 48) {
    midi13 = true;
  }
  
  if(pit == 49) {
    midi14 = true;
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
  
  midi13 = false;
  midi14 = false;
}

void controllerChange(int channel, int number, int value) {

  if (number == 13) {
    c = map (float(value), 0, 127, 100, 0);
  }

  if (number == 12) {
    shapeSize = map (float(value), 0, 127, 400, 200);
  }
  
  if (number == 11) {
    particleZoom = map (float(value), 0, 127, width-200, width/3+100);
  }

  if (number == 1) {
    backgroundC = map (float(value), 0, 127, 255, 0);
  }
}

void backgroundChange () {

  background (255);
}

