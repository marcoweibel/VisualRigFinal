//cube shape

class VisualTwo {

  float acceleration = 0;


  void makeShape () {

    //add acceleration
    acceleration +=0.03;
    
    pushMatrix();
    translate(width/2, height/2,2);
    
    //movement
    rotateX(acceleration);
    rotateY(acceleration);

    //color and stroke detail
    blendMode(ADD);
    strokeWeight (3);
    stroke(c*1.2+10, c*4+80, c*6+40);
    noFill();
    
    //shape detail
    box (shapeSize*1.2);
    
    popMatrix();
  }
}

