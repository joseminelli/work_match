class Video {
  final String title;
  final String thumbnail;
  final String url;

  Video({
    required this.title,
    required this.thumbnail,
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'],
      thumbnail: json['thumbnail'],
      url: json['url'],
    );
  }
}
