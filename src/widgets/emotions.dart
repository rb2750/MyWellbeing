enum Emotion { ANGRY, SAD, ANXIOUS }

extension EmotionExtension on Emotion {
  String name() {
    String str = this.toString().split(".")[1];
    return str[0] + str.substring(1).toLowerCase();
  }
}
