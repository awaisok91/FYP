import 'package:chewie/chewie.dart';
import 'package:e_learning/models/course.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LessonVedioController {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool isloading = true;
  final String lessonId;
  final Function(bool) onLoadingChanged;
  final Function(Course) onCertificateEarned;
  LessonVedioController({
    required this.lessonId,
    required this.onLoadingChanged,
    required this.onCertificateEarned,
  });
  Future<void> initializeVedio() async {
    try {
      final courseId = Get.parameters['courseId'];
      debugPrint('courseId: $courseId');
      if (courseId == null) {
        debugPrint("No courseId found in parameters");
        onLoadingChanged(false);
        return;
      }
      final course = DummyDataService.getCourseById(courseId);
      debugPrint("Course found: ${course.title}");
      if (course.ispremium && !DummyDataService.isCourseUlocked(courseId)) {
        onLoadingChanged(false);
        Get.back();
        //after the completion of payments screen ui then uncomment this lines
        // Get.toNamed(
        //   AppRoutes.payment,
        //   arguments: {
        //     'courseId': courseId,
        //     "courseName": course.title,
        //     "prise": course.price,
        //   },
        // );
        return;
      }
      final lesson = course.lessons.firstWhere(
        (lesson) => lesson.id == lessonId,
        orElse: () => course.lessons.first,
      );
      videoPlayerController =
          VideoPlayerController.network(lesson.videoStreamUrl);
      await videoPlayerController!.initialize();
      videoPlayerController
          ?.addListener(() => onVideoProgressChanged(courseId));
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        looping: false,
        autoPlay: true,
        aspectRatio: 16 / 9,
        errorBuilder: (context, erroMessage) {
          return Center(
            child: Text(
              "Error: Unable to load video content",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                  ),
            ),
          );
        },
      );
      onLoadingChanged(false);
    } catch (e) {
      debugPrint("Error initalizing vedio: $e");
      onLoadingChanged(false);
    }
  }

  void onVideoProgressChanged(String courseId) {
    if (videoPlayerController != null &&
        videoPlayerController!.value.position >=
            videoPlayerController!.value.duration) {
      markLessonAsCompleted(courseId);
      videoPlayerController
          ?.removeListener(() => onVideoProgressChanged(courseId));
    }
  }

  void markLessonAsCompleted(String courseId) async {
    final course = DummyDataService.getCourseById(courseId);
    final lessonindex =
        course.lessons.indexWhere((lesson) => lesson.id == lessonId);
    if (lessonindex != -1) {
      DummyDataService.updateLessonStatus(
        courseId,
        lessonId,
        isCompleated: true,
      );
      if (lessonindex < course.lessons.length - 1) {
        DummyDataService.updateLessonStatus(
          courseId,
          course.lessons[lessonindex + 1].id,
          isLocked: false,
        );
      }
      final isLastLesson = lessonindex == course.lessons.length - 1;
      final alllessonCompleated =
          DummyDataService.isCourseCompleted(courseId);
      Get.back(result: true);
      if (isLastLesson && alllessonCompleated) {
        onCertificateEarned(course);
      } else {
        Get.snackbar(
          "Lesson completed",
          "You can now proceed to the next lesson",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }
    }

  void dispose() {
    videoPlayerController?.removeListener(
        () => onVideoProgressChanged(Get.parameters['courseId'] ?? ''));
    videoPlayerController?.dispose();
    chewieController?.dispose();
  }
}
