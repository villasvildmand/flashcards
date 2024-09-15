class GameView {
  Flashcard flashcard;
  Flashcard oldFlashcard;
  
  boolean showingAnswer;
  String currentCardText;

  float jumpCounter;
  float scaleCounter = 1.0;
  
  int cardsTotal;
  int currentCard;

  GameView() {
  }

  void setNumber(int number, int total) {
    this.currentCardText = (total - number + 1) + "/" + total;
    cardsTotal = total;
    currentCard = number;
  }

  void setCard(Flashcard card) {
    this.oldFlashcard = this.flashcard;
    this.flashcard = card;
  }

  void render() {
    background(COLOR_BACKGROUND);

    float cardWidth = 540;
    float cardHeight = 320;

    pushMatrix();

    
    
    noStroke();
    rectMode(CENTER);
    
    for (int i = 0; i < currentCard - 1; i++) {
      int index = currentCard - i - 1;
      
      fill(220 - index * 10);
      rect(width / 2 + index * 10, height / 2 + index * 10, cardWidth, cardHeight);
    }

    //float scale = 1.0 - Easings.easeInQuad(Easings.easeLinear(scaleCounter));
    float offsetY = Easings.easeParabola(jumpCounter) * (showingAnswer ? 10.0 : 20.0);
    
    translate(width/2 - offsetY, height/2 - offsetY);
    //scale(1, scale);

    
    fill(255);
    
    rect(0, 0, cardWidth, cardHeight);

    final int textSize = 24;
    textSize(textSize); //skrifstørrelse
    textLeading(textSize*1.2); //Linjeafstand
    textAlign(LEFT, CENTER);

    String cardText = "";
    boolean isBack = false;;

    cardText = showingAnswer ? this.flashcard.getBack() : this.flashcard.getFront();
    isBack = showingAnswer;

    /*if (this.showingAnswer) {
      if (this.scaleCounter > 0.5) {
        cardText = this.flashcard.getBack();
        isBack = true;
      } else {
        cardText = this.flashcard.getFront();
        isBack = false;
      }
    } else {
      if (this.scaleCounter > 0.5) {
        cardText = this.flashcard.getFront();
        isBack = false;
      } else {
        cardText = this.oldFlashcard.getBack();
        isBack = true;
      }
    }*/

    fill(isBack ? #2185B8 : COLOR_TERTIARY);
    text(cardText, 0, 0, cardWidth - 100, cardHeight - 50);

    popMatrix();

    /*fill(COLOR_SECONDARY);
    textAlign(CENTER);
    text(this.currentCardText, 64, 48);*/


    /*if (showingAnswer) {
     textAlign(LEFT);
     fill(255, 0, 0);
     text("< Forkert", width/2 - 200, height*0.8);
     textAlign(RIGHT);
     fill(0, 255, 0);
     text("Rigtig >", width/2 + 200, height*0.8);
     }*/
  }

  void onCardFlipped() {
    jumpCounter = 0.0;
    scaleCounter = 0.0;
  }

  void update(double deltaTime) {
    if (jumpCounter < 1.0) {
      jumpCounter = min(jumpCounter + (float) deltaTime * 4.0, 1.0);
    }

    if (scaleCounter < 1.0) {
      scaleCounter = min(scaleCounter + (float) deltaTime * 2.0, 1.0);
    }
  }
}
