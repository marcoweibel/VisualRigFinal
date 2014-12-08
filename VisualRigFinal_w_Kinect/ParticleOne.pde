/* Code Taken from Processing Examples - Space Junk
 */

class ParticleOne {

  // Properties
  int w, h, d;
  int shiftX, shiftY, shiftZ;

  // Constructor
  ParticleOne(int w, int h, int d, int shiftX, int shiftY, int shiftZ) {
    this.w = w;
    this.h = h;
    this.d = d;
    this.shiftX = shiftX;
    this.shiftY = shiftY;
    this.shiftZ = shiftZ;
  }

  // Main cube drawing method, which looks 
  // more confusing than it really is. It's 
  // just a bunch of rectangles drawn for 
  // each cube face
  void drawCube() {

    stroke (c*2+40, c*4+80, c*2+40);
    strokeWeight (2);
    noFill();


    pushMatrix();
    beginShape(QUADS);
    // Front face
    vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 
    vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ); 

    // Back face
    vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 
    vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
    vertex(w + shiftX, h + shiftY, d + shiftZ); 
    vertex(-w/2 + shiftX, h + shiftY, d + shiftZ);

    // Left face
    vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
    vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 
    vertex(-w/2 + shiftX, h + shiftY, d + shiftZ); 
    vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ); 

    // Right face
    vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
    vertex(w + shiftX, h + shiftY, d + shiftZ); 
    vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 

    // Top face
    vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
    vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 

    // Bottom face
    vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 
    vertex(w + shiftX, h + shiftY, d + shiftZ); 
    vertex(-w/2 + shiftX, h + shiftY, d + shiftZ); 

    endShape(); 
    popMatrix();

    // Add some rotation to each box for pizazz.
    rotateY(radians(10));
    rotateX(radians(10));
    rotateZ(radians(5));
  }
}

