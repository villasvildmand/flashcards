class Particle {
  float lifetime;
  float fadeFrom;
  float x, y;
  float vx, vy;
  float size;
  color tint = color(255);
  PImage texture;
}

class ParticleSystem {

  int activeCount;
  static final int MAX_PARTICLES = 1000;
  Particle[] particles;


  ParticleSystem() {
    activeCount = 0;
    particles = new Particle[MAX_PARTICLES];
    for (int i = 0; i < MAX_PARTICLES; i++) {
      particles[i] = new Particle();
    }
  }


  void activateParticle(int index) {
    
    // bytter med den første inaktive partikel
    Particle temp = this.particles[this.activeCount];
    this.particles[this.activeCount] = this.particles[index];
    this.particles[index] = temp;

    this.activeCount++;
  }


  void deactivateParticle(int index) {

    this.activeCount--;

    // bytter med den sidste af de aktive partikler
    Particle temp = this.particles[this.activeCount];
    this.particles[this.activeCount] = this.particles[index];
    this.particles[index] = temp;
  }


  Particle[] spawnParticles(int count) {
    
    // Sørger for ikke at overskride MAX_PARTICLES
    int overflow = this.activeCount + count - (MAX_PARTICLES - 1);
    if (overflow > 0) count = max(count - overflow, 0);
    
    Particle[] spawnedParticles = new Particle[count];

    for (int i = 0; i < count; i++) {
      spawnedParticles[i] = this.particles[this.activeCount];
      this.activateParticle(this.activeCount);
    }

    return spawnedParticles;
  }

  
  void clearParticles() {
    this.activeCount = 0;
  }


  void update(double deltaTime) {

    // looper baglæns gennem de aktive partikler
    for (int i = this.activeCount - 1; i >= 0; i--) {
      Particle particle = this.particles[i];

      particle.lifetime -= deltaTime;
      if (particle.lifetime <= 0.0) {
        this.deactivateParticle(i);
      }

      particle.vx *= 0.99;
      particle.vy *= 0.99;

      particle.x += particle.vx;
      particle.y += particle.vy;
    }
  }


  void render() {
    //fill(255, 0, 0);
    imageMode(CENTER);

    for (int i = 0; i < this.activeCount; i++) {
      Particle particle = this.particles[i];

      float alpha = min(particle.lifetime / particle.fadeFrom, 1.0) * 255;

      tint(particle.tint, alpha);
      image(particle.texture, particle.x, particle.y, particle.size, particle.size);
      //circle(particle.x - 2.0, particle.y - 2.0, 4.0);
    }
  }
}
