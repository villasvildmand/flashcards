import java.util.Random;

// klasse med hjælpefunktioner
static class Utilities {
  static void shuffleIntArray(int[] array) {
    // https://stackoverflow.com/questions/1519736/random-shuffling-of-an-array
    
    // Bruger den moderne Fisher-Yates algoritme:
    // https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
    Random random = new Random();
    for (int i = array.length - 1; i > 0; i--) {
      int j = random.nextInt(i);
      
      // bytter værdierne af index i og j
      int ai = array[i];
      array[i] = array[j];
      array[j] = ai;
    }
  }
  
  static int[] pickRandomFromIntArray(final int[] array, int count) {
    count = min(count, array.length); // burde ikke være nødvendigt i dette program
    int[] values = new int[count];
    int valueIndex = 0;
    
    Random random = new Random();
    
    for (int i = array.length - 1; i >= array.length - count; i--) {
      int j = 0;
      if (i > 0) j = random.nextInt(i);
      
      // bytter værdierne af index j og i
      int ai = array[i];
      array[i] = array[j];
      array[j] = ai;
      
      values[valueIndex] = array[i];
      valueIndex++;
    }
    
    return values;
  }
}
