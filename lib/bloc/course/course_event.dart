abstract class CourseEvent {}

class LoadCourse extends CourseEvent {
  final String? categoryId;
  LoadCourse({this.categoryId});
}

class LoadCourseDetail extends CourseEvent {
  final String courseId;
  LoadCourseDetail(this.courseId);
}

class EnrollCourse extends CourseEvent {
  final String courseId;
  EnrollCourse(this.courseId);
}

class LoadEnrolledCourses extends CourseEvent {}

class DownloadCourse extends CourseEvent {
  final String courseId;
  DownloadCourse(this.courseId);
}

class LoadOfflineCourses extends CourseEvent {}

class UpdateCourse extends CourseEvent {
  final String instructorId;
  UpdateCourse(this.instructorId);
}

class DeleteCourse extends CourseEvent {
  final String courseId;
  DeleteCourse(this.courseId);
}
