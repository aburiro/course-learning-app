import 'package:flutter/material.dart';
import 'Course.dart';
import 'coursedetailscreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> _filteredCourses = [];

  final List<Course> allCourses = [
    Course(
      id: 1,
      title: 'UI/UX Design',
      instructor: 'Sarah Johnson',
      image: 'UX',
      rating: 4.8,
      students: 92000,
      price: 100,
      videoId: 'aqz-KE-bpKQ',
      description: 'Master UI/UX Design principles',
    ),
    Course(
      id: 2,
      title: 'Flutter Development',
      instructor: 'John Smith',
      image: 'FL',
      rating: 4.9,
      students: 85000,
      price: 120,
      videoId: '1xipg02wu8s',
      description: 'Build amazing mobile apps',
    ),
    Course(
      id: 3,
      title: 'Web Development',
      instructor: 'Emma Davis',
      image: 'WB',
      rating: 4.7,
      students: 120000,
      price: 110,
      videoId: 'qQBYp4bsSw8',
      description: 'Complete web development course',
    ),
    Course(
      id: 4,
      title: 'Python Programming',
      instructor: 'Mike Johnson',
      image: 'PY',
      rating: 4.9,
      students: 150000,
      price: 90,
      videoId: 'Z1Yd7aIsenw',
      description: 'Learn Python from scratch',
    ),
    Course(
      id: 5,
      title: 'Data Science',
      instructor: 'Lisa Chen',
      image: 'DS',
      rating: 4.8,
      students: 75000,
      price: 130,
      videoId: '1xipg02wu8s',
      description: 'Master data science concepts',
    ),
    Course(
      id: 6,
      title: 'Machine Learning',
      instructor: 'Tom Brown',
      image: 'ML',
      rating: 4.9,
      students: 95000,
      price: 150,
      videoId: 'Z1Yd7aIsenw',
      description: 'Learn machine learning algorithms',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredCourses = allCourses;
  }

  void _filterCourses(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCourses = allCourses;
      } else {
        _filteredCourses = allCourses
            .where(
              (course) =>
                  course.title.toLowerCase().contains(query.toLowerCase()) ||
                  course.instructor.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search Courses',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCourses,
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterCourses('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredCourses.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No courses found'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = _filteredCourses[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CourseDetailScreen(course: course),
                            ),
                          );
                        },
                        child: _buildSearchCourseCard(course),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCourseCard(Course course) {
    return Container(
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
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  course.instructor,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${course.rating}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${course.price}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
