import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/bloc/course/course_bloc.dart';
import 'package:e_learning/bloc/course/course_event.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/course.dart';
import 'package:e_learning/models/lesson.dart';
import 'package:e_learning/models/prerequisite_course.dart';
import 'package:e_learning/repositories/courses_repository.dart';
import 'package:e_learning/services/cloudinary_service.dart';
import 'package:e_learning/view/teacher/create_course/widgets/create_course_app_bar.dart';
import 'package:e_learning/view/widgets/common/custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class CreateCourseScreen extends StatefulWidget {
  final Course? course;
  const CreateCourseScreen({super.key, this.course});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _fromKey = GlobalKey<FormState>();
  String _selectedLevel = "Beginner";
  bool _isPremium = false;
  final List<String> _requirments = [''];
  final List<String> _learningPoints = [''];
  final _courseRepository = CoursesRepository();
  final _cloudinaryServices = CloudinaryService();
  final _imagePicker = ImagePicker();
  final _firestore = FirebaseFirestore.instance;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategoryId;
  String? _selectedCategoryName;
  final List<Lesson> _lessons = [];
  String? _courseImagePath;
  String? _courseImageUrl;
  bool _isloading = false;
  List<Map<String, dynamic>> _categories = [
    // {
    //   "id": "1",
    //   "name": "Programmer",
    //   "icon": "0xeB6f",
    // },
    // {
    //   "id": "2",
    //   "name": "Business",
    //   "icon": "0xeb3c",
    // }
  ];
  bool _isUploadingImage = false;
  final Map<int, bool> _isUploadingVideo = {};
  final Map<int, bool> _isUplodaingResourses = {};
  List<PrerequisiteCourse> _availableCourses = [
    // PrerequisiteCourse(id: "1", title: "Flutter Fundementals"),
    // PrerequisiteCourse(id: "2", title: "Dart Pro Language"),
    // PrerequisiteCourse(id: "3", title: "State managments"),
    // PrerequisiteCourse(id: "4", title: "Apps Developments"),
  ];
  final List<String> _selectedPrerequisites = [];
  final Map<int, VideoPlayerController?> _videocontroller = {};
  final Map<int, ChewieController?> _chewieController = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategories();
    _loadAvailableCourse();
    if (widget.course != null) {
      _initializeCourseData();
    }
  }

  void _initializeCourseData() {
    final course = widget.course!;
    _titleController.text = course.title;
    _descriptionController.text = course.description;
    _priceController.text = course.price.toString();
    _selectedLevel = course.level;
    _selectedCategoryId = course.categoryId;
    _isPremium = course.ispremium;
    _requirments.clear();
    _requirments.addAll(course.requirments);
    _learningPoints.clear();
    _learningPoints.addAll(course.whatYouWillLearn);
    _lessons.clear();
    _lessons.addAll(course.lessons);
    _courseImageUrl = course.imageUrl;
    _selectedPrerequisites.clear();
    _selectedPrerequisites.addAll(course.prerequisites);
  }

  Future<void> _loadCategories() async {
    try {
      final snapShot = await _firestore.collection("categories").get();
      setState(() {
        _categories = snapShot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'name': data['name'] as String,
            'icon': data['icon'] as String, //store the raw code string
          };
        }).toList();
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load categories: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _loadAvailableCourse() async {
    try {
      final snapshot = await _firestore.collection("courses").get();
      setState(() {
        _availableCourses = snapshot.docs.map((doc) {
          final data = doc.data();
          return PrerequisiteCourse(
            id: doc.id,
            title: data["title"] as String,
          );
        }).toList();
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load courses: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    //dispose video controller
    for (var controller in _videocontroller.values) {
      controller?.dispose();
    }
    for (var controller in _chewieController.values) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CreateCourseAppBar(
                onSubmit: _submitForm,
                course: widget.course,
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: _fromKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildImagePicker(),
                        const SizedBox(height: 32),
                        CustomTextfield(
                          controller: _titleController,
                          label: "Course Title",
                          hint: "Enter course title",
                          maxLines: 1,
                          validate: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return "Please enter a title";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextfield(
                          controller: _descriptionController,
                          label: "Description",
                          hint: "Enter course description",
                          maxLines: 3,
                          validate: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return "Please enter a description";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextfield(
                                controller: _priceController,
                                label: "Price",
                                hint: "Enter price",
                                keyboardType: TextInputType.number,
                                validate: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDropdown(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildCategoryDropdown(),
                        const SizedBox(height: 24),
                        _buildPremiumSwitch(),
                        const SizedBox(height: 24),
                        _buildPrerequisitesDropdown(),
                        const SizedBox(height: 32),
                        _buildDynamicList(
                          "Course Requirements",
                          _requirments,
                          (index) => _requirments.removeAt(index),
                          () => _requirments.add(""),
                        ),
                        const SizedBox(height: 32),
                        _buildDynamicList(
                          "What you will Learn",
                          _learningPoints,
                          (index) => _requirments.removeAt(index),
                          () => _requirments.add(""),
                        ),
                        const SizedBox(height: 32),
                        _buildLessonsSection(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          if (_isloading)
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLessonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Course Lessons",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            TextButton.icon(
              onPressed: _addLesson,
              icon: const Icon(Icons.add),
              label: const Text("Add Lesson"),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _lessons.length,
          itemBuilder: (context, index) {
            return _buildLessonCard(_lessons[index], index);
          },
        ),
      ],
    );
  }

  Widget _buildLessonCard(Lesson lesson, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lesson ${index + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Text("Preview"),
                        Switch(
                          value: lesson.isPreview,
                          onChanged: (value) => _updateLesson(
                            index,
                            ispreview: value,
                          ),
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => _removeLesson(index),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            CustomTextfield(
              label: "Lesson Title",
              hint: "Enter lesson title",
              initialValue: lesson.title,
              onChanged: (value) => _updateLesson(index, title: value),
            ),
            const SizedBox(height: 8),
            CustomTextfield(
              label: "Lesson Description",
              hint: "Enter lesson Description",
              initialValue: lesson.description,
              maxLines: 2,
              onChanged: (value) => _updateLesson(index, description: value),
            ),
            const SizedBox(height: 8),
            CustomTextfield(
              label: "Duration(minutes)",
              hint: "Enter Duration",
              initialValue: lesson.duration.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => _updateLesson(
                index,
                duration: int.tryParse(value ?? '0') ?? 0,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isUploadingVideo[index] == true
                        ? null
                        : () => _pickVideo(index),
                    icon: _isUploadingVideo[index] == true
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.video_library),
                    label: Text(
                      _isUploadingVideo[index] == true
                          ? "Uploading..."
                          : lesson.vedioUrl.isEmpty
                              ? "Add Video"
                              : "Change video",
                    ),
                  ),
                ),
              ],
            ),
            //add vedio preview if avaliable
            if (lesson.vedioUrl.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  final maxwidth = constraints.maxWidth;
                  final AspectRation =
                      _videocontroller[index]?.value.aspectRatio ?? 16 / 9;
                  final height = maxwidth / AspectRation;
                  return Container(
                    width: maxwidth,
                    height: height.clamp(
                      200,
                      MediaQuery.of(context).size.height * 0.4,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _chewieController[index] != null
                          ? Chewie(controller: _chewieController[index]!)
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 16),
            const Text(
              "Resources",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lesson.resources.length,
              itemBuilder: (context, resourceIndex) {
                final resource = lesson.resources[resourceIndex];
                return ListTile(
                  title: Text(resource.title),
                  subtitle: Text(resource.type),
                  trailing: IconButton(
                    onPressed: () => _removeResource(index, resourceIndex),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
            TextButton.icon(
              onPressed: _isUplodaingResourses[index] == true
                  ? null
                  : () => _addResource(index),
              icon: _isUplodaingResourses[index] == true
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                    )
                  : const Icon(Icons.add),
              label: Text(_isUplodaingResourses[index] == true
                  ? "Uploading..."
                  : "Add Resource"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addResource(int lessonIndex) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUplodaingResourses[lessonIndex] = true;
        });
        final file = result.files.first;
        final resourceUrl = await _cloudinaryServices.uploadFile(file.path!);
        final resource = Resource(
          id: const Uuid().v4(),
          title: file.name,
          type: file.extension ?? "unKnown",
          url: resourceUrl,
        );
        setState(() {
          final updateResources =
              List<Resource>.from(_lessons[lessonIndex].resources)
                ..add(resource);
          _updateLesson(lessonIndex, resources: updateResources);
          _isUplodaingResourses[lessonIndex] = false;
        });
      }
    } catch (e) {
      setState(() {
        _isUplodaingResourses[lessonIndex] = false;
      });
      Get.snackbar(
        "Error",
        "Failed to add resources: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _removeResource(int lessonIndex, int resourceIndex) {
    setState(() {
      final updatedResource =
          List<Resource>.from(_lessons[lessonIndex].resources);
      _updateLesson(lessonIndex, resources: updatedResource);
    });
  }

  Future<void> _pickVideo(int lessonIndex) async {
    try {
      final PickedFile = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      if (PickedFile != null) {
        setState(() {
          _isUploadingVideo[lessonIndex] = true;
        });
        // upload vedio to cloudinary
        final videoUrl = await _cloudinaryServices.uploadVideo(PickedFile.path);
        //update lesson with new vedio url
        setState(() async {
          _lessons[lessonIndex] = _lessons[lessonIndex].copyWith(
            videoUrl: videoUrl,
          );
        });
        //initialized vedio player afther successful upload
        await _initializeVideoPlayer(lessonIndex, videoUrl);
        setState(() {
          _isUploadingVideo[lessonIndex] = false;
        });
      }
    } catch (e) {
      setState(() {
        _isUploadingVideo[lessonIndex] = false;
      });
      Get.snackbar(
        "Error",
        "Failed to pick video: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _initializeVideoPlayer(int lessonIndex, String videoUrl) async {
    try {
      //dispose existing controller if any
      _videocontroller[lessonIndex]?.dispose();
      _chewieController[lessonIndex]?.dispose();
      //create and initialize video player controller
      final videoController = VideoPlayerController.network(videoUrl);
      await videoController.initialize();
      //calculate aspect ration based on video dimensions
      final aspectRation = videoController.value.aspectRatio;
      //create chewis controller
      final chewieController = ChewieController(
          videoPlayerController: videoController,
          autoPlay: false,
          looping: false,
          aspectRatio: aspectRation,
          allowFullScreen: true,
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          allowMuting: true,
          showControls: true,
          placeholder: Container(
            color: Colors.black,
          ),
          errorBuilder: (context, errorMessage) {
            return const Center(
              child: Text(
                "Error: Unable to load video content",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          });
      if (mounted) {
        setState(() {
          _videocontroller[lessonIndex] = videoController;
          _chewieController[lessonIndex] = chewieController;
        });
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
          "Error",
          "Failed to initialize player: $e",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void _removeLesson(int index) {
    setState(
      () {
        _videocontroller[index]?.dispose();
        _chewieController[index]?.dispose();
        _videocontroller.remove(index);
        _chewieController.remove(index);
        _lessons.remove(index);
      },
    );
  }

  void _updateLesson(
    int index, {
    String? title,
    String? description,
    String? videoUrl,
    int? duration,
    List<Resource>? resources,
    bool? ispreview,
  }) {
    setState(() {
      _lessons[index] = _lessons[index].copyWith(
        title: title,
        description: _descriptionController.text,
        videoUrl: videoUrl,
        duration: duration,
        resources: resources,
        isPreview: ispreview,
      );
    });
  }

  void _addLesson() {
    setState(() {
      _lessons.add(
        Lesson(
          id: const Uuid().v4(),
          title: '',
          description: '',
          vedioUrl: '',
          duration: 0,
          resources: [],
          isPreview: false,
        ),
      );
    });
  }

  Widget _buildPrerequisitesDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Prerequisites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select Prerequisites"),
              value: null,
              items: _availableCourses.map<DropdownMenuItem<String>>(
                (course) {
                  return DropdownMenuItem(
                    value: course.id,
                    child: Text(course.title),
                  );
                },
              ).toList(),
              onChanged: (String? newvalue) {
                if (newvalue != null &&
                    !_selectedPrerequisites.contains(newvalue)) {
                  setState(() {
                    _selectedPrerequisites.add(newvalue);
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _selectedPrerequisites.map((courseId) {
            final course = _availableCourses.firstWhere(
              (c) => c.id == courseId,
              orElse: () =>
                  PrerequisiteCourse(id: courseId, title: "Unknown Course"),
            );
            return Chip(
              label: Text(course.title),
              onDeleted: () {
                setState(() {
                  _selectedPrerequisites.remove(courseId);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDynamicList(
    String title,
    List<String> items,
    Function(int) onRemove,
    Function() onAdd,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: InputDecorationTheme(
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      child: CustomTextfield(
                        label: "label",
                        hint: "Enter $title",
                        initialValue: items[index],
                        onChanged: (value) => items[index] = value,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (items.length > 1) {
                          onRemove(index);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: Text(
            "Add $title",
          ),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategoryId,
              isExpanded: true,
              hint: const Text("Selected Category"),
              items: _categories.map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem<String>(
                  value: category['id'] as String,
                  child: Row(
                    children: [
                      Icon(
                        _getIconData(category["icon"] as String),
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category["name"] as String,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(
                  () {
                    _selectedCategoryId = value;
                    _selectedCategoryName = _categories.firstWhere(
                        (cat) => cat["id"] == value)["name"] as String;
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  IconData _getIconData(String iconCode) {
    //convert the string code to int
    return IconData(
      int.parse(iconCode),
      fontFamily: "MaterialIcon",
    );
  }

  Widget _buildPremiumSwitch() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Premium Course",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Switch(
            value: _isPremium,
            onChanged: (value) {
              setState(() {
                _isPremium = value;
              });
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      children: [
        const Text(
          "Level",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedLevel,
              items: ["Beginner", "Intermediate", "Advanced"]
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLevel = value!;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  void _submitForm() async {
    if (!_fromKey.currentState!.validate()) return;
    //validate course thumbnail
    if (_courseImageUrl == null) {
      Get.snackbar(
        "Error",
        "Please Select a course thumbnail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }
    //validate category
    if (_selectedCategoryId == null) {
      Get.snackbar(
        "Error",
        "Please select a category",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }
    //validate lesson
    if (_lessons.isEmpty) {
      Get.snackbar(
        "Error",
        "Please add atleast one lesson",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }
    //validate lesson fields
    String? lessonError = _validateLesson();
    if (lessonError != null) {
      Get.snackbar(
        "Error",
        lessonError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }
    setState(() => _isloading = true);
    try {
      final course = Course(
        id: widget.course?.id ?? const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageUrl: _courseImageUrl!,
        instructorId: FirebaseAuth.instance.currentUser!.uid,
        categoryId: _selectedCategoryId!,
        lessons: _lessons,
        level: _selectedLevel,
        requirments: _requirments.where((r) => r.isNotEmpty).toList(),
        whatYouWillLearn: _learningPoints.where((p) => p.isNotEmpty).toList(),
        createdAt: widget.course?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        ispremium: _isPremium,
        prerequisites: _selectedPrerequisites,
        rating: widget.course?.rating ?? 0.0,
        reviewCount: widget.course?.reviewCount ?? 0,
        enrollmentCount: widget.course?.enrollmentCount ?? 0,
      );
      if (widget.course != null) {
        await _courseRepository.updateCourse(course);
        //dispatch updated course event to refresh the course list
        context.read<CourseBloc>().add(UpdateCourse(
              FirebaseAuth.instance.currentUser!.uid,
            ));
        Get.back();
        Get.snackbar(
          "Success",
          "Course updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[900],
        );
      } else {
        await _courseRepository.createCourse(course);
        Get.back();
        Get.snackbar(
          "Success",
          "Course created successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[900],
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to create course: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      setState(() => _isloading = false);
    }
  }

  String? _validateLesson() {
    for (int i = 0; i < _lessons.length; i++) {
      final lesson = _lessons[i];
      //validate lesson title
      if (lesson.title.isEmpty) {
        return "Please enter a title for lesson ${i + 1}";
      }
      //validate description
      if (lesson.description.isEmpty) {
        return "Please enter a description for lesson ${i + 1}";
      }
      //validate lesson video
      if (lesson.title.isEmpty) {
        return "Please upload a video for lesson ${i + 1}";
      }
      //validate lesson duration
      if (lesson.duration <= 0) {
        return "Please enter a validate duration for lesson ${i + 1}";
      }
    }
    return null;
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: _courseImageUrl != null && !_isUploadingImage
                    ? DecorationImage(
                        image: NetworkImage(_courseImageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null),
            child: _isUploadingImage
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    ),
                  )
                : _courseImageUrl == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 24,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Add course Thumbnail",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : null,
          ),
          if (_courseImageUrl != null && !_isUploadingImage)
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Change Thumbnail",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ))
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final PickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (PickedFile != null) {
        setState(() {
          _courseImagePath = PickedFile.path;
          _isUploadingImage = true;
        });
        //upload image to cloudinary
        final imageUrl = await _cloudinaryServices.uploadImage(
          PickedFile.path,
          "course_images",
        );
        setState(() {
          _courseImageUrl = imageUrl;
          _isUploadingImage = false;
        });
      }
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
      });
      Get.snackbar(
        "Error",
        "Failed to pick iamge: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
