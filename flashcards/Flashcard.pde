class Flashcard {
  String front;
  String back;
  int level;
  
  Flashcard(String front, String back, int level) {
    this.front = front;
    this.back = back;
    this.level = level;
  }
  
  String getBack() {
    return this.back;
  }
  
  String getFront() {
    return this.front;
  }
  
  int getLevel() {
    return this.level;
  }
}
