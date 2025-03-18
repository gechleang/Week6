import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6/EX-1-START-CODE/providers/course_provider.dart';
import '../models/course.dart';

import 'course_score_form.dart';

const Color mainColor = Colors.blue;

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId, required Course course});

  final String courseId;

  void _addScore(BuildContext context) async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null) {
      Provider.of<CoursesProvider>(context, listen: false)
          .addScore(courseId, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesProvider>(
      builder: (ctx, coursesProvider, child) {
        final course = coursesProvider.getCourseFor(courseId);
        final scores = course.scores;
        
        Widget content = const Center(child: Text('No Scores added yet.'));

        if (scores.isNotEmpty) {
          content = ListView.builder(
            itemCount: scores.length,
            itemBuilder: (ctx, index) => ListTile(
              title: Text(scores[index].studentName),
              trailing: Text(
                scores[index].studenScore.toString(),
                style: TextStyle(
                  color: scoreColor(scores[index].studenScore),
                  fontSize: 15,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text(
              course.name,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () => _addScore(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: content,
        );
      },
    );
  }
}