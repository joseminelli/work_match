import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import '../models/jobs.dart';
import '../widgets/job_card.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen>
    with TickerProviderStateMixin {
  List<Job> _jobs = [];
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/jobs.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      _jobs = data.map((jobData) => Job.fromJson(jobData)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _buildTitle(),
          ),
          Expanded(
            child: _buildJobList(),
          ),
        ],
      ),
    );
  }

  // Animação para o título "Vagas"
  Widget _buildTitle() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    return FadeTransition(
      opacity: _fadeIn,
      child: const Text(
        'Vagas',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Lista de vagas com animação de deslizamento
  Widget _buildJobList() {
    return ListView.builder(
      itemCount: _jobs.length,
      itemBuilder: (context, index) {
        return _buildJobCardWithAnimation(index);
      },
    );
  }

  // Animação de deslizamento para cada item da lista
  Widget _buildJobCardWithAnimation(int index) {
    // Controlador de animação
    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Definindo a animação de deslizamento
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Começa fora da tela, de baixo para cima
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    // Iniciando a animação
    animationController.forward();

    return SlideTransition(
      position: slideAnimation,
      child: JobCard(key: ValueKey(_jobs[index].id), job: _jobs[index]),
    );
  }
}
