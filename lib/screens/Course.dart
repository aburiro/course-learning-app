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
}
