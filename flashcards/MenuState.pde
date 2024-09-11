class MenuState implements State {
  int gameMode;
  static final int MODE_COUNT = 2;

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

          for (int i = 0; i < cardsService.getCardsCount(); i++) {
            gameState.appendCard(i);
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
        if (this.gameMode < 0) this.gameMode = this.MODE_COUNT - 1;
        break;
      case 40: // pil ned
        gameMode++;
        if (this.gameMode > this.MODE_COUNT - 1) this.gameMode = 0;
        break;
      }
    }
  }

  void onEnter() {
  }

  void update(double deltaTime) {
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
      text(getModeName(i), width*0.2, listStartY + i * spacing);
    }
    
    textAlign(CENTER, CENTER);
    
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
    
    /*final float levelTextWidth = textWidth(str(playerData.getLevel()));
    textSize(36);
    fill(128);
    text(playerData.name, width*0.7, height/2 + 100);
    text("lvl", width * 0.7 - levelTextWidth, height/2);*/
    
    pop();
  }
}
