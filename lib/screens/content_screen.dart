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

class _ContentScreenState extends State<ContentScreen> {
  List<Video> _videos = [];

  @override
  void initState() {
    super.initState();
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
            child: Text(
              'Conteúdos',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                return VideoCard(video: _videos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
