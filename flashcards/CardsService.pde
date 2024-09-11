class CardsService {
  // Alle flashcards i en usorteret liste
  Flashcard[] flashcards;

  // Alle flashcards sorteret efter kategorier
  HashMap<String, ArrayList<Integer>> categories;
  
  HashMap<Integer, ArrayList<Integer>> levels;

  CardsService() {
    categories = new HashMap<>();
    levels = new HashMap<>();
  }

  ArrayList<Integer> getIndicesOfLevel(int level) {
    return levels.get(level);
  }

  Flashcard getCard(int id) {
    return flashcards[id];
  }
  
  int getCardsCount() {
    return flashcards.length;
  }

  void loadCards() {
    JSONObject json = loadJSONObject("data/cards.json");

    StringList tags = json.getStringList("tags");
    for (int i = 0; i < tags.size(); i++) {
      String tag = tags.get(i);
      categories.put(tag, new ArrayList<Integer>());
    }
    categories.put("Ikke sorteret", new ArrayList<Integer>());

    JSONArray cards = json.getJSONArray("cards");

    flashcards = new Flashcard[cards.size()];

    for (int i = 0; i < cards.size(); i++) {
      JSONObject card = cards.getJSONObject(i);

      String front = card.getString("front");
      String back = card.getString("back");

      String tag = card.getString("tag");

      if (categories.containsKey(tag)) {
        categories.get(tag).add(i);
      } else {
        if (!tag.equals("")) println("Unsorted tag: " + tag);
        categories.get("Ikke sorteret").add(i);
      }

      int level = card.getInt("level");
      
      if (!levels.containsKey(level)) {
        levels.put(level, new ArrayList<Integer>());
      }
      levels.get(level).add(i);

      flashcards[i] = new Flashcard(front, back, level);
    }

    for (Flashcard flashcard : flashcards) {
      println(flashcard.front);
    }
    
    println(categories);
    println(levels);
  }
}
