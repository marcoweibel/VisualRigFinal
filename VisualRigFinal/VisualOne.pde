class VisualOne {

  float acceleration = 0;
  float sphereSize = 200;
  

  void makeShape () {

    acceleration +=0.03;
    pushMatrix();
    translate(width/2, height/2, 0);

colorMode(RGB, 200);
for (int i = 0; i < 100; i++) {
  for (int j = 0; j < 100; j++) {
    stroke(i, j, 0);
    point(i, j);
  }
}

    rotateY(acceleration);
    fill(c*3, c*2, c/3);
    sphereDetail(30);
    sphere (sphereSize);
    popMatrix();
  }
}

