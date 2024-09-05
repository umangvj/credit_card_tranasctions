// Utility function to parse the full JSON
import 'package:credit_card_transactions/data/models/year_data_model.dart';

class CreditCardData {
  Map<String, YearData> years;

  CreditCardData({required this.years});

  factory CreditCardData.fromJson(Map<String, dynamic> json) {
    Map<String, YearData> years = {};
    json.forEach((key, value) {
      years[key] = YearData.fromJson(value);
    });

    return CreditCardData(years: years);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    years.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}
