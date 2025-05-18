import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/models/course.dart';

class CoursesRepository {
  final _firestore = FirebaseFirestore.instance;
  Future<List<Course>> getCourses({String? categoryId}) async {
    try {
      Query query = _firestore.collection("courses");
      if (categoryId != null) {
        query = query.where("categoryId", isEqualTo: categoryId);
      }
      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          throw Exception("Course data is null");
        }
        return Course.fromjson({...data, "id": doc.id});
      }).toList();
    } catch (e) {
      throw Exception("Failed to get courses: $e");
    }
  }

  Future<Course> getCourseDetails(String courseId) async {
    try {
      final doc = await _firestore.collection("courses").doc(courseId).get();
      if (!doc.exists) {
        throw Exception("Course not found");
      }
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception("course data is null");
      }
      return Course.fromjson({...data, "id": doc.id});
    } catch (e) {
      throw Exception("Failed to get course details: $e");
    }
  }

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

  Future<void> updateCourse(Course course) async {
    try {
      //convert course to json
      final courseData = course.toJson();
      //convert lessson to json
      final lessonData =
          course.lessons.map((lesson) => lesson.toJson()).toList();
      //update course documents
      await _firestore.collection("courses").doc(course.id).update({
        ...courseData,
        "lessons": lessonData,
      });
    } catch (e) {
      throw Exception("Failed to update course: $e");
    }
  }

  //delete course
  Future<void> deleteCourse(String courseId) async {
    try {
      //delete the documenst
      await _firestore.collection("courses").doc(courseId).delete();
      //delete all enrollments for this course
      final enrollmentsSnapshot = await _firestore
          .collection("enrollments")
          .where("courseId", isEqualTo: courseId)
          .get();
      for (var doc in enrollmentsSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception("Failed to delete course: $e");
    }
  }
}
