import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6/EX-1-START-CODE/providers/course_provider.dart';
import '../models/course.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  void _editCourse(BuildContext context, Course course) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (ctx) => CourseScreen(courseId: course.name, course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<CoursesProvider>(
        builder: (ctx, coursesProvider, child) {
          final courses = coursesProvider.courses;
          
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (ctx, index) {
              final course = courses[index];
              return Dismissible(
                key: Key(course.name),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  coursesProvider.removeCourse(course);
                },
                child: CourseTile(
                  course: course,
                  onEdit: () => _editCourse(context, course),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final VoidCallback onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText => course.hasScore ? "$numberOfScores scores" : 'No score';
  
  String get averageText => course.hasScore ? "Average: ${course.average.toStringAsFixed(1)}" : '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: Colors.white,
        child: ListTile(
          onTap: onEdit,
          title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(numberText, style: const TextStyle(color: Colors.black54)),
              Text(averageText, style: const TextStyle(color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}
