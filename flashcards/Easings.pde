static class Easings {

  // https://easings.net/#easeOutQuad
  static float easeOutQuad(float x) {
    //return 1.0 - (1.0 - x) * (1.0 - x);
    return (2.0 - x) * x; // Egen omskrivning.
  }

  // https://easings.net/#easeInBack
  static float easeInBack(float x) {
    final float c1 = 1.70158;
    final float c3 = c1 + 1.;

    return c3 * x * x * x - c1 * x * x;
  }

  // https://easings.net/#easeOutBack
  static float easeOutBack(float x) {
    final float c1 = 1.70158;
    final float c3 = c1 + 1.;

    return 1. + c3 * pow(x - 1., 3.) + c1 * pow(x - 1., 2.);
  }
  
  // https://easings.net/#easeOutQuart
  static float easeOutQuart(float x) {
    return 1.0 - pow(1.0 - x, 4);
  }
  
  static float easeOutOvershoot(float x) {
    return (1.5 - x) * x * 2.0;
  }
  
  // Virker som forventet når 1 < a <= 2
  static float easeOutVariableOvershoot(float x, float a) {
    return (a - x) * x / (a - 1.0);
  }
}
