class GameState implements State {
  ArrayList<Integer> cardStack;
  int startSize;
  GameView view;
  boolean showingAnswer;
  
  int playerLevel;

  GameState() {
    cardStack = new ArrayList<>();
    view = new GameView();
  }

  void onEnter() {
    nextCard();
  }

  void appendCard(int index) {
    cardStack.add(index);
    this.startSize++;
  }

  void nextCard() {
    view.setNumber(cardStack.size(), startSize);
    int backIndex = cardStack.size() - 1; // Index af sidste kort;
    int index = cardStack.remove(backIndex);
    view.setCard(flashcards[index]);
  }

  void handleMouseEvent(MouseEvent event) {
  }

  void handlePlayerAnswer(boolean isCorrect) {
    showingAnswer = false;
    if (!cardStack.isEmpty()) {
      nextCard();
    } else {
      state = new MenuState();
    }
    view.showingAnswer = showingAnswer;
  }

  void handleKeyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      // Tjekker om mellemrum trykkes
      switch (event.getKeyCode()) {
      case 37: // venstre pil
        if (showingAnswer) {
          handlePlayerAnswer(false);
        }
        break;
      case 38: // op pil
        if (showingAnswer == false) {
          showingAnswer = true;
          view.showingAnswer = showingAnswer;
        }
        break;
      case 39: // højre pil
        if (showingAnswer) {
          handlePlayerAnswer(true);
        }
        break;
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
