interface State {
  void handleMouseEvent(MouseEvent event);
  void handleKeyEvent(KeyEvent event);
  void update(double deltaTime);
  void render();
  void onEnter();
  //void onExit();
}
