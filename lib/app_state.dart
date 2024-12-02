import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;
import 'dart:convert';
import '../models/jobs.dart';

class AppState extends ChangeNotifier {
  final List<Job> _appliedJobs = [];
  String username = 'Usuário';
  List<Job> get appliedJobs => List.unmodifiable(_appliedJobs);

  AppState() {
    _loadAppliedJobs();
  }

  void setusername(String newusername) {
    username = newusername;
  }

  String getusername() {
    return username;
  }

  void applyToJob(Job job) async {
    if (!_appliedJobs.contains(job)) {
      print('Aplicando para a vaga: ${job.title}');
      _appliedJobs.add(job);
      await _saveAppliedJobs();
      notifyListeners();
    }
  }

  void removeAppliedJob(Job job) async {
    _appliedJobs.remove(job);
    await _saveAppliedJobs();
    notifyListeners();
  }

  bool isJobApplied(Job job) {
    return _appliedJobs.contains(job);
  }

  Future<void> _saveAppliedJobs() async {
    final prefs = await sp.SharedPreferences.getInstance();

    final jobJsonList =
        _appliedJobs.map((job) => jsonEncode(job.toJson())).toList();

    await prefs.setStringList('appliedJobs', jobJsonList);

    for (final job in _appliedJobs) {
      print('Vaga aplicada: ${job.title}');
    }
  }

  Future<void> _loadAppliedJobs() async {
    final prefs = await sp.SharedPreferences.getInstance();

    final jobJsonList = prefs.getStringList('appliedJobs') ?? [];

    _appliedJobs.clear();
    _appliedJobs.addAll(
      jobJsonList.map((jobJson) => Job.fromJson(jsonDecode(jobJson))).toList(),
    );

    notifyListeners();
  }
}
