import themidibus.*;

MidiBus myBus;

/* Done by Marco Weibel
 Final for CODE 
 */


VisualOne visualOne;
VisualTwo visualTwo;


// Used for oveall rotation
float angle;

boolean midi1;
boolean midi2;
float c;
float backgroundC;

// Cube count-lower/raise to test performance
int limit = 500;

// Array for all cubes
ParticleOne[] particleOne = new ParticleOne[limit];

void setup () {
  size (1200, 800, P3D);
  lights ();

  //initialize my classes
  visualOne = new VisualOne();
  visualTwo = new VisualTwo();

  // Instantiate cubes, passing in random vals for size and postion
  for (int i = 0; i < particleOne.length; i++) {
    particleOne[i] = new ParticleOne(int(random(-10, 10)), int(random(-10, 10)), 
    int(random(-10, 10)), int(random(-140, 140)), 
    int(random(-140, 140)), int(random(-140, 140)));

    // List all available Midi devices on STDOUT. This will show each device's index and name.
    MidiBus.list();
    myBus = new MidiBus(this, 0, 1);
  }
}

void draw () {
  int channel = 0;
  int number = 0;
  int value = 0;

  myBus.sendControllerChange(channel, number, value); // Send a controllerChange\


  background (0, 0, backgroundC);

  if (midi1) {

    visualTwo.makeShape();
  }

  if (midi2) {

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

  if (pit == 60) {
    midi1 = true;
  }

  if (pit == 61) {
    midi2 = true;
  }
}

void noteOff(Note note) {

  midi1=false;

  midi2=false;
}

void controllerChange(int channel, int number, int value) {

  if (number == 13) {
    c = map (float(value), 0, 127, 120, 0);
  }

  if (number == 1) {
    backgroundC = map (float(value), 0, 127, 255, 0);
  }
}

