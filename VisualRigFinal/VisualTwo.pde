//cube shape

class VisualTwo {

  float acceleration = 0;


  void makeShape () {

    //add acceleration
    acceleration +=0.03;
    
    pushMatrix();
    translate(width/2, height/2, 3);
    
    //movement
    rotateX(acceleration);
    rotateY(acceleration);

    //color and stroke detail
    colorMode(RGB, 255);
    strokeWeight (3);
    stroke(200, c*4, c*3);
    noFill();
    
    //shape detail
    box (shapeSize*1.2);
    
    popMatrix();
  }
}

