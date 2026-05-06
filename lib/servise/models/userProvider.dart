import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Userprovider extends ChangeNotifier {
  dynamic user;
  List tasks = [];

  void use() {
    print("user => $user");
  }

  void addTask(String task) {
    tasks.add(task);
    print("task is add => $task");
    notifyListeners();
  }

  void removeTask(int taskinedx) {
    tasks.remove(taskinedx);
    print("task is add => ${tasks[taskinedx]}");
    notifyListeners();
  }
}
