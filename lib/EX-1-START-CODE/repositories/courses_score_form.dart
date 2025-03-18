
import 'package:week6/EX-1-START-CODE/models/course.dart';

abstract class CoursesRepository {
 List<Course> getCourses();
 void addCourse(Course course , CourseScore score);
}