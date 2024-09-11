class CardsOverview {
  ArrayList<CardObject> cards;
  float cardCounter;
  
  int[] spawnOrder;
  int spawnIndex;

  static final float SPAWN_RATE = 0.1f;

  CardsOverview() {
    cards = new ArrayList<>();

    int y = 0;
    for (ArrayList<Integer> category : cardsService.categories.values()) {
      for (int i = 0; i < category.size(); i++) {
        CardObject card = new CardObject(category.get(i), new PVector(width - 40, -15), new PVector(i * 47 + 100, y + 75));
        cards.add(card);
      }

      y += 50;
    }
    
    this.spawnOrder = new int[cards.size()];
    for(int i = 0; i < this.spawnOrder.length; i++) {
      this.spawnOrder[i] = i;
    }
    
    Utilities.shuffleIntArray(this.spawnOrder);
  }

  void render() {
    push();
    background(200);
    
    fill(255);
    text(playerData.name, width/2, 80);
    text(playerData.points, width/2, 100);

    for (int i = 0; i < this.cards.size(); i++) {
      this.cards.get(i).render();
    }

    pop();
  }

  void update(double deltaTime) {
    this.cardCounter += deltaTime;

    if (this.spawnIndex < cards.size()) {
      if (this.cardCounter > SPAWN_RATE) {
        this.cardCounter -= SPAWN_RATE;

        this.cards.get(this.spawnOrder[spawnIndex]).animating = true;
        this.spawnIndex++;
      }
    }

    for (int i = 0; i < this.cards.size(); i++) {
      this.cards.get(i).update(deltaTime);
    }
  }

  class CardObject {
    PVector animOffset;
    float animProgress = 0.0;
    PVector startPosition;
    boolean animating;
    float velocityX;
    float displacementX;
    PVector pos;
    PVector prevPos;

    static final float SPRING_CONSTANT = 80.0;
    static final float DAMPING_CONSTANT = 3.0;

    int flashcardIndex; //erstat med index hvis det ikke virker

    CardObject(int flashcardIndex, final PVector start, final PVector goal) {
      this.startPosition = start;
      this.animOffset = goal.sub(start);

      this.pos = start;
      this.flashcardIndex = flashcardIndex;
    }

    void render() {
      pushMatrix();
      stroke(60);
      fill(playerData.getLevel() >= cardsService.getCard(flashcardIndex).getLevel() ? 245 : 200);
      translate(this.pos.x, this.pos.y);
      rotate(this.displacementX * 0.0025);
      rect(-20.0, -15.0, 40.0, 30.0);
      
      popMatrix();
    }

    void update(double deltaTime) {
      if (this.animProgress < 1.0) {
        if (this.animating == true) {
          this.animProgress += deltaTime * 1.0;
          if (this.animProgress > 1.0) {
            this.animProgress = 1.0;
          }
        }
      } else {
        this.animating = false;
      }

      prevPos = pos;

      if (this.animating) {
        float progress = Easings.easeOutBack(animProgress);
        float mixX = progress;
        float mixY = Easings.easeOutVariableOvershoot(progress, 1.6);

        PVector offset = animOffset.copy();
        offset.x *= mixX;
        offset.y *= mixY;

        pos = PVector.add(startPosition, offset);
      }

      // Udregner hastighed i x-retningen med v = d/t
      float vX = (this.prevPos.x - this.pos.x) / (float) deltaTime;
      if (abs(this.velocityX) < abs(vX)) this.velocityX = vX;

      // Bruger en damped oscillator
      // https://medium.com/@lucasvanmol/elastic-deformations-and-damped-oscillations-5b16fa284187
      float force = -SPRING_CONSTANT * this.displacementX + DAMPING_CONSTANT * this.velocityX;
      this.velocityX -= force * deltaTime;
      this.displacementX -= this.velocityX * deltaTime;

      if (abs(this.velocityX) < 6.0 && abs(this.displacementX) < 12.0) {
        this.displacementX = 0.0;
        this.velocityX = 0.0;
      }
    }
  }
}
