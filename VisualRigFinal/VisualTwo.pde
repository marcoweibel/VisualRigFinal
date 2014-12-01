class VisualTwo {

  float acceleration = 0;
  float sphereSize = 200;
  int c = 255;

  void makeShape () {
    
    print("NOW");

    acceleration +=0.03;
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(acceleration);
    rotateY(acceleration);
    fill(c, 220);
    box (sphereSize);
    popMatrix();
  }
}

