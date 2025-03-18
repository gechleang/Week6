import 'package:flutter/material.dart';
import '../models/course.dart';

// Mock implementation of CoursesRepository
class CoursesRepository {
  List<Course> getCourses() {
    // Return a mock list of courses
    return [];
  }

  void addCourse(Course course, CourseScore score) {
    // Mock implementation for adding a course score
  }
}


class CoursesProvider extends  ChangeNotifier {
  final CoursesRepository _repository;

  CoursesProvider(this._repository);

  List<Course> get courses => _repository.getCourses();

  Course getCourseFor(String courseId) {
    return courses.firstWhere((course) => course.name == courseId);
  }

  void addScore(String courseId, CourseScore score) {
    final course = getCourseFor(courseId);
    _repository.addCourse(course, score);
    notifyListeners();
  }
}