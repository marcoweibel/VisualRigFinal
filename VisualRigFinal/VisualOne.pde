//sphere shape

class VisualOne {

  float acceleration = 0;

  void makeShape () {

    //add acceleration
    acceleration +=0.03;

    pushMatrix();
    translate(width/2, height/2, 1);

    //movement
    rotateY(acceleration);
    rotateZ(0);

    //color and stroke details
    colorMode(RGB, 255);
    strokeWeight(3);
    stroke(200, c*4, c*3);
    noFill();

    //shape details
    sphereDetail(12);
    sphere (shapeSize*0.95);

    popMatrix();
  }
}

