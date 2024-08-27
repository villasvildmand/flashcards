public class GameController {
  ArrayList<Integer> cardStack;

  GameController() {
    cardStack = new ArrayList<>();

    registerMethod("keyEvent", this);
  }

  void nextCard() {
    int backIndex = cardStack.size() - 1; // Index af sidste kort;
    int index = cardStack.remove(backIndex);
    view.setCard(flashcards[index]);
  }
  
  void appendCard(int index) {
    cardStack.add(index);
  }

  public void keyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      // Tjekker om mellemrum trykkes
      if (event.getKeyCode() == 32) {
        if (showingAnswer == false) {
          showingAnswer = true;
        } else {
          showingAnswer = false;
          cardIndex = (cardIndex + 1) % flashcards.length;

          // Viser det nye kort
          if (!cardStack.isEmpty()) {
            nextCard();
          }
        }
        view.showingAnswer = showingAnswer;
      }
    }
  }
}
