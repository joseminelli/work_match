import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';
import '../models/videos.dart';
import '../widgets/video_card.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with TickerProviderStateMixin {
  List<Video> _videos = [];
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/data/videos.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      _videos = data.map((videoData) => Video.fromJson(videoData)).toList();
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
            child: _buildVideoList(),
          ),
        ],
      ),
    );
  }

  // Animação para o título "Conteúdos"
  Widget _buildTitle() {
    return FadeTransition(
      opacity: _fadeIn,
      child: const Text(
        'Conteúdos',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Lista de vídeos com animação de deslizamento
  Widget _buildVideoList() {
    return ListView.builder(
      itemCount: _videos.length,
      itemBuilder: (context, index) {
        return _buildVideoCardWithAnimation(index);
      },
    );
  }

  // Animação de deslizamento para cada item da lista
  Widget _buildVideoCardWithAnimation(int index) {
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
      child: VideoCard(video: _videos[index]),
    );
  }
}
