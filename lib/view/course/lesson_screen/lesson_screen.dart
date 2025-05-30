import 'package:chewie/chewie.dart';
import 'package:e_learning/controller/vedio_controller.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/course.dart';
import 'package:e_learning/view/course/lesson_screen/widgets/certification_dialog.dart';
import 'package:e_learning/view/course/lesson_screen/widgets/resource_tile.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;
  const LessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late final LessonVedioController _videoController;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _videoController = LessonVedioController(
      lessonId: widget.lessonId,
      onLoadingChanged: (loading) {
        setState(() => _isLoading = loading);
      },
      onCertificateEarned: (Course) {
        if (mounted) {
          _showCertificateDialog(context, Course);
        }
      },
    );
    _videoController.initializeVedio();
  }

  @override
  void dispose() {
    _videoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _showCertificateDialog(BuildContext context, Course course) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CertificationDialog(
            course: course,
            onDownload: () => _downloadCertificate(course),
          );
        });
  }

  void _downloadCertificate(Course course) {
//here you will download actual certificate
//for know well show just succes message
    Get.snackbar(
      "Certifcate Ready",
      "Your certificate for ${course.title} has been generated",
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courseId = Get.parameters["courseId"];
    final course =
        courseId != null ? DummyDataService.getCourseById(courseId) : null;
    final isUnLocked =
        courseId != null ? DummyDataService.isCourseUlocked(courseId) : false;
    if (course == null) {
      return const Scaffold(
        body: Center(
          child: Text("Course not found"),
        ),
      );
    }
    if (course.ispremium && !isUnLocked) {
      return const Scaffold(
        body: Center(
          child: Text("Please purchase this course to access the content"),
        ),
      );
    }
    final lesson = course.lessons.firstWhere(
      (lesson) => lesson.id == widget.lessonId,
      orElse: () => course.lessons.first,
    );
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _isLoading
                ? Container(
                    color: theme.colorScheme.surface,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _videoController.chewieController != null
                    ? Chewie(controller: _videoController.chewieController!)
                    : Container(
                        color: theme.colorScheme.surface,
                        child: const Center(
                          child: Text("Error loading video"),
                        ),
                      ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${lesson.duration} minutes",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Description",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.description,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Resources",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...lesson.resources.map(
                    (resources) => ResourceTile(
                      title: resources.title,
                      icon: _getIconForResourceType(resources.type),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getIconForResourceType(String type) {
    switch (type.toLowerCase()) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "zip":
        return Icons.folder_zip;

      // case "video":
      //   return Icons.videocam;
      // case "audio":
      //   return Icons.audiotrack;
      // case "link":
      //   return Icons.link;
      default:
        return Icons.insert_drive_file;
    }
  }
}
