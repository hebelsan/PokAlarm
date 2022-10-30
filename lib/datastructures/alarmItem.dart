class AlarmItem {
  final Function addTimerCallback;
  String text;
  bool isOn;
  int hours = 0;
  int minutes = 0;
  DateTime timeObject;

  AlarmItem(this.isOn, this.addTimerCallback);

  void setValue(bool value) {
    isOn = value;
  }

  void setHours(int h) {
    hours = h;
  }

  void setMinutes(int m) {
    minutes = m;
  }

  void createTimeObject(DateTime now) {
    int day = now.day;
    text = 'Today';
    if (this.hours < now.hour ||
        (this.hours == now.hour && this.minutes <= now.minute)) {
      day += 1;
      text = 'Tomorrow';
    }
    timeObject =
        new DateTime(now.year, now.month, day, this.hours, this.minutes);
  }
}
