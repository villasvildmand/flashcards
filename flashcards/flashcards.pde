

Flashcard[] flashcards;
HashMap<String, ArrayList<Integer>> categories;

int cardIndex = 0;
boolean showingAnswer = false;

// Brugerdata
String userName = "Christian";
int userLevel = 1;

CardsOverview co;

long lastTime;

void setup() {
  size(600, 450);
  smooth(8);

  categories = new HashMap<>();

  loadCards();
  saveUserData();
  
  co = new CardsOverview();
  
  lastTime = System.nanoTime();
}

// deltaTime med hjælp fra:
// https://gamedev.stackexchange.com/questions/111741/calculating-delta-time

void draw() {
  long time = System.nanoTime();
  double deltaTime = (time - lastTime) / 1_000_000_000.0f; // StackOverflow spørgsmålet bruger int, men double er valgt da decimaler og præcision ønskes
  lastTime = time;
  
  background(100);
  //textAlign(CENTER);
  //rectMode(CENTER);
  final int textSize = 24;
  textSize(textSize); //skrifstørrelse
  textLeading(textSize*1.2); //Linjeafstand
  
  //text(showingAnswer ? flashcards[cardIndex].back : flashcards[cardIndex].front, width/4, height/4, width/2, height/2);

  co.update(deltaTime);
  co.render();
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
