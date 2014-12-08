//pyramid shape

class VisualThree {

  float acceleration = 0;

  void makeShape() {

    //add acceleration
    acceleration +=0.03;

    pushMatrix();
    translate(width/2, height/2-75,3);
    //movement
    rotateX(PI/2);
    rotateZ(-PI/6 - acceleration);

    //color and stroke details
    blendMode(ADD);
    strokeWeight(3);
    stroke(c*3+10, c*5+80, c*4+40);
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
    
    popMatrix();
  }
}

