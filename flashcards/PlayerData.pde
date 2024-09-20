class PlayerData {
  //String name;
  int points;
  
  void loadFromFile() {
    JSONObject player = loadJSONObject("data/user/save_data.json");
    
    this.points = player.getInt("games_completed");
    //this.name = player.getString("name");
  }
  
  void saveToFile() {
    JSONObject json = new JSONObject();
    
    json.setInt("games_completed", points);
    //json.setString("name", name);
    
    saveJSONObject(json, "data/user/save_data.json");
    println("SAVED USER DATA");
  }
  
  int getLevel() {
    // 1 level = 5 point
    return points / 5;
  }
  
  float getLevelProgress() {
    return points / 5.0 - getLevel();
  }
}
