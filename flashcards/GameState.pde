class GameState implements State {
  ArrayList<Integer> cardStack;
  int startSize;
  GameView view;
  boolean showingAnswer;

  int playerLevel;
  
  int[] unusedIndices;

  GameState() {
    cardStack = new ArrayList<>();
    view = new GameView();
  }

  void onEnter() {
    nextCard();
    particleSystem.clearParticles();
  }

  void appendCard(int index) {
    cardStack.add(index);
    this.startSize++;
  }

  void nextCard() {
    //if (cardStack.isEmpty()) return;
    
    view.setNumber(cardStack.size(), startSize);
    int backIndex = cardStack.size() - 1; // Index af sidste kort;
    int index = cardStack.remove(backIndex);
    view.setCard(cardsService.getCard(index));
  }

  void handleMouseEvent(MouseEvent event) {
  }

  void handlePlayerAnswer() {
    showingAnswer = false;
    if (!cardStack.isEmpty()) {
      nextCard();
    } else {
      // Hvis der ikke er flere kort, vender man tilbage til menuen
      state = new MenuState();
      playerData.points++;
      playerData.saveToFile();
    }
  }

  void handleKeyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      // Tjekker om mellemrum trykkes
      switch (event.getKeyCode()) {
      case 32:
        if (showingAnswer) {
          handlePlayerAnswer();
        } else {
          showingAnswer = true;
        }
        view.showingAnswer = showingAnswer;
        view.onCardFlipped();
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
