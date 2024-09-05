// Model for the entire year's data
import 'month_data_model.dart';

class YearData {
  Map<String, MonthData> months;

  YearData({required this.months});

  factory YearData.fromJson(Map<String, dynamic> json) {
    Map<String, MonthData> months = {};
    json.forEach((key, value) {
      months[key] = MonthData.fromJson(value);
    });

    return YearData(months: months);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    months.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}
