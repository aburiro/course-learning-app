class Course {
  final int id;
  final String title;
  final String instructor;
  final String image;
  final int? lessons;
  final bool? isDownloaded;
  final double? progress;
  final bool? isEnrolled;
  final double rating;
  final int students;
  final int price;
  final String videoId;
  final String description;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.image,
    this.lessons,
    this.isDownloaded,
    this.progress,
    this.isEnrolled,
    required this.rating,
    required this.students,
    required this.price,
    required this.videoId,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? 'Untitled',
      instructor: (json['instructor'] as String?) ?? 'Unknown',
      image: (json['image'] as String?) ?? '',
      lessons: (json['lessons'] as num?)?.toInt(),
      isDownloaded: json['isDownloaded'] as bool?,
      progress: (json['progress'] as num?)?.toDouble(),
      isEnrolled: json['isEnrolled'] as bool?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      students: (json['students'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toInt() ?? 0,
      videoId: (json['videoId'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instructor': instructor,
      'image': image,
      'lessons': lessons,
      'isDownloaded': isDownloaded,
      'progress': progress,
      'isEnrolled': isEnrolled,
      'rating': rating,
      'students': students,
      'price': price,
      'videoId': videoId,
      'description': description,
    };
  }
}
