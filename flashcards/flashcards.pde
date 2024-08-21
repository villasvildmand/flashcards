Flashcard[] flashcards;

int cardIndex = 0;
boolean showingAnswer = false;

// Brugerdata
String userName = "Christian";
int userLevel = 1;

void setup() {
  size(600, 450);

  loadCards();
  saveUserData();
}

void draw() {
  background(0);
  textAlign(CENTER);
  
  textSize(); //skrifstørrelse
  textLeading(); //Linjeafstand
  text(showingAnswer ? flashcards[cardIndex].back : flashcards[cardIndex].front, width / 2, height / 2);
}

void keyPressed(KeyEvent event) {
  // Tjekker om mellemrum trykkes
  if (event.getKeyCode() == 32) {
    if (showingAnswer == false) {
      showingAnswer = true;
    } else {
      showingAnswer = false;
      cardIndex = (cardIndex + 1) % flashcards.length;
    }
  }
}

void loadCards() {
  JSONObject json = loadJSONObject("data/cards.json");
  JSONArray cards = json.getJSONArray("cards");

  flashcards = new Flashcard[cards.size()];

  for (int i = 0; i < cards.size(); i++) {
    JSONObject card = cards.getJSONObject(i);

    String front = card.getString("front");
    String back = card.getString("back");

    flashcards[i] = new Flashcard(front, back);
  }

  for (Flashcard flashcard : flashcards) {
    println(flashcard.front);
  }
}

void saveUserData() {
  JSONObject json = new JSONObject();
  json.setString("name", userName);
  json.setInt("level", userLevel);

  saveJSONObject(json, "data/user/save_data.json");
}
