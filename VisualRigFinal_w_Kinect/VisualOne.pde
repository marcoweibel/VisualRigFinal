//sphere shape

class VisualOne {

  float acceleration = 0;

  void makeShape () {

    //add acceleration
    acceleration +=0.03;

    pushMatrix();
    translate(displayWidth/2, displayHeight/2,1);

    //movement
    rotateY(acceleration);
    rotateZ(0);

    //color and stroke details
    blendMode(ADD);
    strokeWeight(3);
    stroke(c*1.2+40, c*6+80, c*4+40);
    noFill();

    //shape details
    sphereDetail(12);
    sphere (shapeSize*0.95);

    popMatrix();
  }
}

