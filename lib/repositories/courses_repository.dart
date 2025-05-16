import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/models/course.dart';

class CoursesRepository {
  final _firestore = FirebaseFirestore.instance;
  Future<void> createCourse(Course course) async {
    try {
      //convert course to json
      final courseData = course.toJson();
      //convert lessons to json
      final lessonsData =
          course.lessons.map((lesson) => lesson.toJson()).toList();
      //create course documents
      await _firestore.collection("courses").doc(course.id).set({
        ...courseData,
        "lesson": lessonsData,
      });
    } catch (e) {
      throw Exception("Failed to course:$e");
    }
  }

  Future<List<Course>> getinstructorCourses(String instructorId) async {
    try {
      final snapshot = await _firestore
          .collection("courses")
          .where("instructorId", isEqualTo: instructorId)
          .get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          throw Exception("Course data is null");
        }
        return Course.fromjson({
          ...data,
          "id": doc.id,
        });
      }).toList();
    } catch (e) {
      throw Exception("Failed to get instructor courses: $e");
    }
  }
}
