//pyramid shape

class VisualThree {

  float acceleration = 0;

  void makeShape() {

    //add acceleration
    acceleration +=0.03;

    translate(width/2, height/2-75, 2);

    //movement
    rotateX(PI/2);
    rotateZ(-PI/6 - acceleration);

    //color and stroke details
    colorMode(RGB, 255);
    strokeWeight(3);
    stroke(200, c*4, c*3);
    noFill();

    //shape details
    beginShape();
    vertex(-shapeSize*0.75, -shapeSize*0.75, -shapeSize*0.75);
    vertex( shapeSize*0.75, -shapeSize*0.75, -shapeSize*0.75);
    vertex(   0, 0, shapeSize*0.75);

    vertex( shapeSize*0.75, -shapeSize*0.75, -shapeSize*0.75);
    vertex( shapeSize*0.75, shapeSize*0.75, -shapeSize*0.75);
    vertex(   0, 0, shapeSize*0.75);

    vertex( shapeSize*0.75, shapeSize*0.75, -shapeSize*0.75);
    vertex(-shapeSize*0.75, shapeSize*0.75, -shapeSize*0.75);
    vertex(   0, 0, shapeSize*0.75);

    vertex(-shapeSize*0.75, shapeSize*0.75, -shapeSize*0.75);
    vertex(-shapeSize*0.75, -shapeSize*0.75, -shapeSize*0.75);
    vertex(   0, 0, shapeSize*0.75);
    endShape();
  }
}

