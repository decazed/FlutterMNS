class BodyMassIndex {

  double calculateIMC(double height, double weight) {
    return weight / (height * height);
  }

  String getImcCategory(double imcValue) {
    if (imcValue < 18.5) {
      return 'underweight';
    } else if (imcValue >= 18.5 && imcValue < 25) {
      return 'normal';
    } else if (imcValue >= 25 && imcValue < 30) {
      return 'overweight';
    } else {
      return 'obesity';
    }
  }
}