import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6/EX-1-START-CODE/repositories/courses_mock_repository.dart';
import 'models/course.dart';

import 'screens/course_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CoursesProvider(CoursesMockRepository() as CoursesRepository),
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const CourseListScreen(),
      ),
    );
  }
}

class CoursesMockRepository {
}
