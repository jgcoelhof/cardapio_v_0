

import 'package:flutter/material.dart';
import '../models/tableStatus.dart';

class AppState extends ChangeNotifier {
  bool wasReinitialized = false;
  int numberTables = 0;
  List<TableStatus> tables = [];

  void setWasReinitialized (bool value) {
    wasReinitialized = value;
    notifyListeners();
  }

  void setNumberTables (int value) {
    numberTables = value;
    notifyListeners();
  }

  void setTables (List<TableStatus> value) {
    tables = value;
    notifyListeners();
  }

}
