import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  List<String> jobList = ['Vaga 1', 'Vaga 2', 'Vaga 3'];

  List<String> contentList = ['Vídeo 1', 'Vídeo 2', 'Vídeo 3'];

  void addJob(String job) {
    jobList.add(job);
    notifyListeners();
  }

  void addContent(String content) {
    contentList.add(content);
    notifyListeners();
  }
}
