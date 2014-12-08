class ParticleTwo {

 
void drawParticles() {
 
  noStroke();
  for (int x = 0; x <= width; x += particleZoom2) {
    for (int y = 0; y <= height; y += particleZoom2) {
 
      noFill();
      stroke(random(c,c*3), random(c,c*2), random(c,c*4));
      ellipse(x, y, particleZoom2, particleZoom2);
  }
    
}
}
}


