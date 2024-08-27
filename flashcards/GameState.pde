class GameState implements State {
  ArrayList<Integer> cardStack;
  GameView view;
  boolean showingAnswer;

  GameState() {
    cardStack = new ArrayList<>();
    view = new GameView();
  }

  void onEnter() {
    nextCard();
  }
  
  void appendCard(int index) {
    cardStack.add(index);
  }

  void nextCard() {
    int backIndex = cardStack.size() - 1; // Index af sidste kort;
    int index = cardStack.remove(backIndex);
    view.setCard(flashcards[index]);
  }

  void handleMouseEvent(MouseEvent event) {
  }
  
  void handleKeyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      // Tjekker om mellemrum trykkes
      if (event.getKeyCode() == 32) {
        if (showingAnswer == false) {
          showingAnswer = true;
        } else {
          showingAnswer = false;

          // Viser det nye kort
          if (!cardStack.isEmpty()) {
            nextCard();
          } else {
            state = new MenuState();
          }
        }
        view.showingAnswer = showingAnswer;
      }
    }
  }
  
  void update(double deltaTime) {
    view.update(deltaTime);
  }
  
  void render() {
    view.render();
  }
}
