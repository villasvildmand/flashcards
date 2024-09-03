class OverviewState implements State {
  CardsOverview view;
  OverviewState() {
    view = new CardsOverview();
  }
  
  void handleMouseEvent(MouseEvent event) {
  }
  void handleKeyEvent(KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      if (event.getKeyCode() == 32) {
        state = new MenuState();
      }
    }
  }
  void update(double deltaTime) {
    view.update(deltaTime);
  }
  void render() {
    view.render();
  }
  void onEnter() {
  }
}
