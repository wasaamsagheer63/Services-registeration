class Timings{
  String startTime;
  String endTime;

  Timings(this.startTime, this.endTime);

  Map<String, dynamic> toMap() {
  return {
  "startTime":startTime,
  "endTime":endTime,
  };
  }

  static Timings fromMap(Map<String, dynamic> map) {
  return Timings(map["startTime"], map["endTime"]);
  }

  }
