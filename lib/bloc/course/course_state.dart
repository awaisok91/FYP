import 'package:e_learning/models/course.dart';

abstract class CourseState {}

class courseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}

class CourseLoaded extends CourseState {
  final List<Course> courses;
  CourseLoaded(this.courses);
}

class CourseDetailLoaded extends CourseState {
  final Course course;
  CourseDetailLoaded(this.course);
}

class offlineCoursesLoaded extends CourseState {
  final List<Course> courses;
  offlineCoursesLoaded(this.courses);
}

class CourseDeleted extends CourseState {
  final String message;
  CourseDeleted(this.message);
}
