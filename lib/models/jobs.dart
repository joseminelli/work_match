class Job {
  final String logo;
  final String title;
  final String company;
  final String type;
  final String description;

  Job({
    required this.logo,
    required this.title,
    required this.company,
    required this.type,
    required this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      logo: json['logo'],
      title: json['title'],
      company: json['company'],
      type: json['type'],
      description: json['description'],
    );
  }
}
