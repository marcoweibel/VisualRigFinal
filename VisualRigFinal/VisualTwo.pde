class VisualTwo {

  float acceleration = 0;
  float boxSize = 200;


  void makeShape () {

    acceleration +=0.03;
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(acceleration);
    rotateY(acceleration);

    colorMode(RGB, 200);
    for (int i = 0; i < 100; i++) {
      for (int j = 0; j < 100; j++) {
        stroke(i, j, 100);
        point(i, j);
      }
    }
    fill(c*2, c*0.5, c/0.4);
    box (boxSize);
    popMatrix();
  }
}

