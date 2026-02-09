import 'package:flutter/material.dart';
import 'Course.dart';
import '../services/api_service.dart';
import 'coursedetailscreen.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<ApiCoursesResult> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _coursesFuture = ApiService.instance.fetchCourses();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Course> availableCourses = [
    Course(
      id: 1,
      title: 'UX UI Design',
      instructor: 'Alex Holmes',
      lessons: 6,
      image: 'UX',
      isDownloaded: true,
      progress: 0,
      isEnrolled: true,
      rating: 4.8,
      students: 92000,
      price: 100,
      videoId: 'aqz-KE-bpKQ',
      description: 'Master UI/UX Design principles',
    ),
    Course(
      id: 2,
      title: 'HR Business',
      instructor: 'Jane Smith',
      lessons: 8,
      image: 'HR',
      isDownloaded: true,
      progress: 0,
      isEnrolled: true,
      rating: 4.6,
      students: 52000,
      price: 90,
      videoId: 'qQBYp4bsSw8',
      description: 'HR business fundamentals',
    ),
    Course(
      id: 3,
      title: 'Singular Design',
      instructor: 'Lisa Wagner',
      lessons: 19,
      image: 'SD',
      isDownloaded: true,
      progress: 0,
      isEnrolled: true,
      rating: 4.7,
      students: 68000,
      price: 110,
      videoId: 'Z1Yd7aIsenw',
      description: 'Design fundamentals and practice',
    ),
    Course(
      id: 4,
      title: 'Digital Marketing',
      instructor: 'David Nguyen',
      lessons: 8,
      image: 'DM',
      isDownloaded: true,
      progress: 0,
      isEnrolled: true,
      rating: 4.5,
      students: 43000,
      price: 95,
      videoId: '1xipg02wu8s',
      description: 'Digital marketing essentials',
    ),
    Course(
      id: 5,
      title: 'Programming',
      instructor: 'James Miller',
      lessons: 12,
      image: 'PR',
      isDownloaded: true,
      progress: 0,
      isEnrolled: true,
      rating: 4.9,
      students: 120000,
      price: 120,
      videoId: 'aqz-KE-bpKQ',
      description: 'Programming for beginners',
    ),
  ];

  final List<Course> downloadedCourses = [
    Course(
      id: 1,
      title: 'UX UI Design',
      instructor: 'Alex Holmes',
      lessons: 6,
      image: 'UX',
      isDownloaded: true,
      progress: 0.6,
      isEnrolled: true,
      rating: 4.8,
      students: 92000,
      price: 100,
      videoId: 'aqz-KE-bpKQ',
      description: 'Master UI/UX Design principles',
    ),
    Course(
      id: 2,
      title: 'UX UI Design',
      instructor: 'Alex Holmes',
      lessons: 6,
      image: 'UX',
      isDownloaded: true,
      progress: 0.6,
      isEnrolled: true,
      rating: 4.8,
      students: 92000,
      price: 100,
      videoId: 'aqz-KE-bpKQ',
      description: 'Master UI/UX Design principles',
    ),
    Course(
      id: 3,
      title: 'Singular Design',
      instructor: 'Lisa Wagner',
      lessons: 19,
      image: 'SD',
      isDownloaded: true,
      progress: 0.85,
      isEnrolled: true,
      rating: 4.7,
      students: 68000,
      price: 110,
      videoId: 'Z1Yd7aIsenw',
      description: 'Design fundamentals and practice',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        title: const Text(
          'Classes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'Downloaded'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Available Classes
          FutureBuilder<ApiCoursesResult>(
            future: _coursesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return _buildErrorState(
                  snapshot.error.toString(),
                  onRetry: () {
                    setState(() {
                      _coursesFuture = ApiService.instance.fetchCourses();
                    });
                  },
                );
              }
              final data = snapshot.data;
              final courses = data?.courses ?? [];
              if (courses.isEmpty) {
                return _buildEmptyState();
              }
              return Column(
                children: [
                  if (data != null && data.fromCache)
                    _buildCacheBanner(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return _buildClassCard(courses[index], true);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          // Downloaded Classes
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: downloadedCourses.length,
            itemBuilder: (context, index) {
              return _buildDownloadedClassCard(downloadedCourses[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(Course course, bool isAvailable) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailScreen(course: course),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(course.image, style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.instructor,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${course.lessons ?? 0} Lessons',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.check, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadedClassCard(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    course.image,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.instructor,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: course.progress ?? 0,
                    minHeight: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${((course.progress ?? 0) * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No courses available right now.',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildErrorState(String message, {required VoidCallback onRetry}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[700]),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCacheBanner() {
    return Container(
      width: double.infinity,
      color: Colors.amber[50],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Text(
        'Showing cached data (offline).',
        style: TextStyle(fontSize: 12, color: Colors.brown),
      ),
    );
  }
}
