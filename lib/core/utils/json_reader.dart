import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonReader {
  Future<dynamic> readJson(String fileName) async {
    try {
      final response =
          await rootBundle.loadString('assets/resources/$fileName.json');
      final data = json.decode(response);
      return data;
    } catch (e) {
      debugPrint("Error reading JSON file: $e");
      return null;
    }
  }
}
