class VisualOne {

  float acceleration = 0;
  float sphereSize = 200;


  void makeShape () {

    acceleration +=0.03;
    pushMatrix();
    translate(width/2, height/2, 0);

    noStroke();
    colorMode(HSB, 200);
    for (int i = 0; i < 100; i++) {
      for (int j = 0; j < 100; j++) {
        stroke(i*10, j, 100);
        point(i, j);
      }
    }

    rotateY(acceleration);
    fill(0, backgroundC, 0);
    sphereDetail(30);
    sphere (sphereSize);
    popMatrix();
  }
}

