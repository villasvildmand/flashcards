class MenuState implements State {
  int gameMode;
  static final int MODE_COUNT = 2;
  float[] modeLabelOffsets;
  
  MenuState() {
    modeLabelOffsets = new float[MODE_COUNT];
  }

  String getModeName(int mode) {
    String name = "undefined";

    switch (mode) {
    case 0:
      name = "Spil";
      break;
    case 1:
      name = "Oversigt";
      break;
    }

    return name;
  }

  void handleMouseEvent(MouseEvent event) {
  }

  void handleKeyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      switch (event.getKeyCode()) {
      case 32: // mellemrum
        if (gameMode == 0) {
          GameState gameState = new GameState();

          int level = min(playerData.getLevel(), cardsService.getMaxLevel());

          // Udvælger 7 kort fra den nuværende level
          // Ved level 0 vælges dog 10 kort
          int[] levelCards = cardsService.getCardsAtLevel(level);
          int levelCardCount = min(levelCards.length, level > 0 ? 7 : 10);

          for (int index : Utilities.pickRandomFromIntArray(levelCards, levelCardCount)) {
            gameState.appendCard(index);
          }

          if (level > 0) {
            int[] otherCards = cardsService.getCardsBelowLevel(level);
            
            int[] fillerCards = Utilities.pickRandomFromIntArray(otherCards, 10 - levelCardCount);

            for (int index : fillerCards) {
              gameState.appendCard(index);
            }
          }

          state = gameState;
          gameState.onEnter();
        } else if (gameMode == 1) {
          OverviewState newState = new OverviewState();
          state = newState;
        }

        break;
      case 38: // pil op
        gameMode--;
        if (this.gameMode < 0) this.gameMode = MODE_COUNT - 1;
        break;
      case 40: // pil ned
        gameMode++;
        if (this.gameMode > MODE_COUNT - 1) this.gameMode = 0;
        break;
      }
    }
  }

  void onEnter() {
  }

  void update(double deltaTime) {
    float step = (float) deltaTime * 4.0;
    
    for (int i = 0; i < MODE_COUNT; i++) {
      if (i == gameMode) {
        modeLabelOffsets[i] = min(modeLabelOffsets[i] + step, 1.0);
      } else {
        modeLabelOffsets[i] = max(modeLabelOffsets[i] - step, 0.0);
      }
    }
  }

  void render() {
    push();
    textFont(fontRegular);
    background(COLOR_BACKGROUND);
    textSize(36);


    textAlign(LEFT, CENTER);

    final int spacing = 50;
    final float listStartY = (height - spacing * (MODE_COUNT - 1))/2.0;

    for (int i = 0; i < MODE_COUNT; i++) {
      fill(i == gameMode ? COLOR_PRIMARY : COLOR_SECONDARY);

      float offsetX = 0.0;
      if (i == gameMode) {
        offsetX = Easings.easeOutQuart(modeLabelOffsets[i]) * 10.0;
      } else {
        offsetX = Easings.easeInQuad(modeLabelOffsets[i]) * 10.0;
      }
      
      text(getModeName(i), width*0.2 + offsetX, listStartY + i * spacing);
    }

    textAlign(CENTER, CENTER);

    fill(COLOR_SECONDARY);
    text("Level", width * 0.7, height/2 - 160);
    

    textFont(fontBold);
    fill(COLOR_PRIMARY);
    textSize(192);
    text(playerData.getLevel(), width*0.7, height/2 - 24);

    noFill();
    strokeWeight(8);
    stroke(COLOR_TERTIARY);

    arc(width*0.7, height/2 + 8, 240, 180, PI * 0.25, PI*0.75);
    float levelProgress = playerData.getLevelProgress();
    stroke(COLOR_BACKGROUND);
    strokeWeight(16);
    arc(width*0.7, height/2 + 8, 240, 180, PI * 0.25, PI*(0.25 + levelProgress*0.5));
    strokeWeight(8);
    stroke(COLOR_SECONDARY);
    arc(width*0.7, height/2 + 8, 240, 180, PI * 0.25, PI*(0.25 + levelProgress*0.5));

    fill(COLOR_SECONDARY);
    textFont(fontRegular);
    text("Styr med mellemrum, pil op og pil ned", width/2, 75);

    /*final float levelTextWidth = textWidth(str(playerData.getLevel()));
     textSize(36);
     fill(128);
     text(playerData.name, width*0.7, height/2 + 100);
     text("lvl", width * 0.7 - levelTextWidth, height/2);*/

    pop();
  }
}
