import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Course.dart';

class ApiServiceException implements Exception {
  final String message;

  ApiServiceException(this.message);

  @override
  String toString() => message;
}

class ApiCoursesResult {
  final List<Course> courses;
  final bool fromCache;

  const ApiCoursesResult({required this.courses, required this.fromCache});
}

class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  static const String coursesEndpoint = 'https://example.com/api/courses.json';
  static const String _cacheKey = 'api_courses_cache_v1';

  Future<ApiCoursesResult> fetchCourses() async {
    try {
      final response = await http
          .get(Uri.parse(coursesEndpoint))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiServiceException('Server error: ${response.statusCode}');
      }
      final decoded = jsonDecode(response.body);
      final list = _extractCourseList(decoded);
      final courses = list
          .map((item) => Course.fromJson(item as Map<String, dynamic>))
          .toList();
      await _saveCache(list);
      return ApiCoursesResult(courses: courses, fromCache: false);
    } catch (e) {
      debugPrint('API error: $e');
      final cached = await _loadCache();
      if (cached != null) {
        final courses = cached
            .map((item) => Course.fromJson(item as Map<String, dynamic>))
            .toList();
        return ApiCoursesResult(courses: courses, fromCache: true);
      }
      throw ApiServiceException(
        'Unable to load courses. Check your connection and try again.',
      );
    }
  }

  List<dynamic> _extractCourseList(dynamic decoded) {
    if (decoded is List) {
      return decoded;
    }
    if (decoded is Map && decoded['courses'] is List) {
      return decoded['courses'] as List;
    }
    throw ApiServiceException('Invalid API response format.');
  }

  Future<void> _saveCache(List<dynamic> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(list));
  }

  Future<List<dynamic>?> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded;
    }
    return null;
  }
}
