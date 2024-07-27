class ScheduleModel {
  String? id;
  String? userId;
  String? sessionId;
  String? token;
  String? type;
  String? startTimeLabel;
  String? startTimeValue;
  String? endTimeLabel;
  String? endTimeValue;
  String? dayId;
  String? dayName;
  String? timeZone;
  String? slot;

  ScheduleModel({
    this.id,
    this.userId,
    this.sessionId,
    this.token,
    this.type,
    this.startTimeLabel,
    this.startTimeValue,
    this.endTimeLabel,
    this.endTimeValue,
    this.dayId,
    this.dayName,
    this.timeZone,
    this.slot,
  });

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sessionId = json['session_id'];
    token = json['token'];
    type = json['type'];
    endTimeLabel = json['end_time_label'];
    endTimeValue = json['end_time_value'];
    startTimeValue = json['start_time_value'];
    startTimeLabel = json['start_time_label'];
    dayId = json['day_id'];
    dayName = json['day_name'];
    timeZone = json['time_zone'];
    slot = json['slot'];
  }
}
