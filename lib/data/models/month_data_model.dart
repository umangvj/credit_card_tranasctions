// Model for a single month's data
import 'day_data_model.dart';

class MonthData {
  Map<String, DayData> days;

  MonthData({required this.days});

  factory MonthData.fromJson(Map<String, dynamic> json) {
    Map<String, DayData> days = {};
    json.forEach((key, value) {
      days[key] = DayData.fromJson(value);
    });

    return MonthData(days: days);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    days.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}
