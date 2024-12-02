class Job {
  final int id;
  final String logo;
  final String title;
  final String company;
  final String type;
  final String description;

  Job({
    required this.id,
    required this.logo,
    required this.title,
    required this.company,
    required this.type,
    required this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      logo: json['logo'],
      title: json['title'],
      company: json['company'],
      type: json['type'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'title': title,
      'company': company,
      'type': type,
      'description': description,
    };
  }

  // Sobrescrevendo ==
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Job &&
        other.id == id &&
        other.logo == logo &&
        other.title == title &&
        other.company == company &&
        other.type == type &&
        other.description == description;
  }

  // Sobrescrevendo hashCode
  @override
  int get hashCode {
    return id.hashCode ^
        logo.hashCode ^
        title.hashCode ^
        company.hashCode ^
        type.hashCode ^
        description.hashCode;
  }
}
