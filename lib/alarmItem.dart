class AlarmItem {
  final String text;
  bool isOn;

  AlarmItem(this.text, this.isOn);

  void setValue(bool value) {
      isOn = value;
  }
}