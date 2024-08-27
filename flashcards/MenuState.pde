class MenuState implements State {
  void handleMouseEvent(MouseEvent event) {
  }

  void handleKeyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      if (event.getKeyCode() == 32) {
        GameState gameState = new GameState();

        for (int i = 0; i < flashcards.length; i++) {
          gameState.appendCard(i);
        }

        state = gameState;
        gameState.onEnter();
      }
    }
  }

  void onEnter() {
  }

  void update(double deltaTime) {
  }

  void render() {
    background(0, 255, 0);
  }
}
