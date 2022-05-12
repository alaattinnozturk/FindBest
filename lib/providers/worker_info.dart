import 'package:barber_app/models/worker.dart';
import 'package:flutter/material.dart';

class WorkerInfo with ChangeNotifier {
  List<Worker> allService = [];

  void updateWorkerList(List<dynamic> newWorkersList) {
    print(newWorkersList);
    allService = newWorkersList.map((e) => e as Worker).toList();
    notifyListeners();
  }
}
