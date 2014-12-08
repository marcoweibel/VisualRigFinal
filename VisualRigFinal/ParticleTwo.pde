class ParticleTwo {

  ArrayList<PVector> stars = new ArrayList<PVector>();
  float h2;//=height/2
  float w2;//=width/2
  float d2;//=diagonal/2
  
  ParticleTwo() {

  noStroke();
  }

  void drawParticles() {
    
    
    noFill();

    for (int i = 0; i<20; i++) {   // star init
  
    }

    for (int i = 0; i<stars.size (); i++) {
      float x =stars.get(i).x;//local vars
      float y =stars.get(i).y;
      float d =stars.get(i).z;

      /* movement+"glitter"*/
      pushMatrix();
          translate (0,0);
      stars.set(i, new PVector(x-map(600, 0, width, -0.05, 0.05)*(w2-x), y-map(600, 0, height, -0.05, 0.05)*(h2-y), d));

//      if (d>3||d<-3) stars.set(i, new PVector(x, y, 3));
//      if (x<0||x>width||y<0||y>height) stars.remove(i);
//      if (stars.size()>9999) stars.remove(1);
      ellipse(x, y, random(d), random (d));//draw stars
      popMatrix();
     
    }
  }
}

