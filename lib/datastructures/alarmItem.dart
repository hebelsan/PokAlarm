class AlarmItem {
  final String text;
  final Function addTimerCallback;
  bool isOn;
  int hours = 0;
  int minutes = 0;
  var timeObject;

  AlarmItem(this.text, this.isOn, this.addTimerCallback);

  void setValue(bool value) {
      isOn = value;
  }

  void setHours(int h) {
    hours = h;
  }

  void setMinutes(int m) {
    minutes = m;
  }

  void createTimeObject() {
    timeObject = new DateTime(minutes=this.minutes, hours=this.hours);
  }
}