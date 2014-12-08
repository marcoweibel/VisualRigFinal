class ParticleThree {
  float x;
  float y;
  float xSpeed;
  float ySpeed;

  float partSize;

  ParticleThree() {
    x = random (width) ;
    y = random (height);
    partSize = 10;

    xSpeed = random(-7, 7);
    ySpeed = random(-7, 7);
  }

  void movement() {
    x += xSpeed;
    y += ySpeed;
  }

  void updateShape() {
    partSize = particleZoom3/30;
  }

  void collision() {

    float r = partSize/2;

    if ( (x<r) || (x>width-r)) {
      xSpeed *= -1;
    }

    if ( (y<r) || (y>height-r)) {
      ySpeed *= -1;
    }
  }

  void drawParticles() {

    blendMode(ADD);
    colorMode (RGB);
    stroke(random (c+100), random(c*2+40), random(c*5));
    noFill();

    rectMode(CENTER);
    rect (x, y, partSize, partSize);
  }
}

