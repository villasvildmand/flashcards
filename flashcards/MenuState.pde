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

          for (int i = 0; i < flashcards.length; i++) {
            gameState.appendCard(i);
          }

          state = gameState;
          gameState.onEnter();
        } else if (gameMode == 1) {
          OverviewState newState = new OverviewState();
          state = newState;
        }

        break;
      case 37: // venstre pil
        gameMode--;
        if (this.gameMode < 0) this.gameMode = this.MODE_COUNT - 1;
        break;
      case 39: // højre pil
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
    background(0, 255, 0);
    textSize(36);
    textAlign(CENTER);
    text("Flashcards om programmering", width/2, height/2);
    text("Skift med piletaster", width / 2, height * 0.75 + 48);
    text(getModeName(this.gameMode), width/2, height*0.75);
  }
}
