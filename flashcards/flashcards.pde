Flashcard[] flashcards;
HashMap<String, ArrayList<Integer>> categories;

int cardIndex = 0;
boolean showingAnswer = false;

// Brugerdata
String userName = "Christian";
int userLevel = 1;

CardsOverview co;

long lastTime;

GameView view;
GameController controller;

void setup() {
  size(600, 450);
  smooth(8);

  categories = new HashMap<>();

  loadCards();
  saveUserData();
  
  view = new GameView();
  view.setCard(flashcards[cardIndex]);
  
  controller = new GameController();
  
  for (int i = 0; i < flashcards.length; i++) {
    controller.appendCard(i);
  }
  
  co = new CardsOverview();
  
  lastTime = System.nanoTime();
}

// deltaTime med hjælp fra:
// https://gamedev.stackexchange.com/questions/111741/calculating-delta-time

void draw() {
  long time = System.nanoTime();
  double deltaTime = (time - lastTime) / 1_000_000_000.0f; // StackOverflow spørgsmålet bruger int, men double er valgt da decimaler og præcision ønskes
  lastTime = time;
  
  view.render();

  //co.update(deltaTime);
  //co.render();
}

void keyPressed(KeyEvent event) {
  
}

void loadCards() {
  JSONObject json = loadJSONObject("data/cards.json");
  JSONArray cards = json.getJSONArray("cards");

  flashcards = new Flashcard[cards.size()];

  for (int i = 0; i < cards.size(); i++) {
    JSONObject card = cards.getJSONObject(i);

    String front = card.getString("front");
    String back = card.getString("back");

    String tag = card.getString("tag");
    if (tag == "") tag = "Ikke sorteret";
    
    if (categories.containsKey(tag)) {
      categories.get(tag).add(i);
    } else {
      categories.put(tag, new ArrayList<Integer>());
      categories.get(tag).add(i);
    }

    flashcards[i] = new Flashcard(front, back);
  }

  for (Flashcard flashcard : flashcards) {
    println(flashcard.front);
  }
  println(categories);
}

void saveUserData() {
  JSONObject json = new JSONObject();
  json.setString("name", userName);
  json.setInt("level", userLevel);

  saveJSONObject(json, "data/user/save_data.json");
}
