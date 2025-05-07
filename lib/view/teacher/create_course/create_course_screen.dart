import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/teacher/create_course/widgets/create_course_app_bar.dart';
import 'package:e_learning/view/widgets/common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _fromKey = GlobalKey<FormState>();
  String _selectedLevel = "Beginner";
  bool _isPremium = false;
  final List<String> _requirments = [''];
  final List<String> _learningPoints = [''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CreateCourseAppBar(
            onSubmit: _submitForm,
          ),
          SliverToBoxAdapter(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildImagePicker(),
                    const SizedBox(height: 32),
                    CustomTextfield(
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
                    _buildPremiumSwitch(),
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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
                      Icons.circle_outlined,
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

  void _submitForm() {
    if (_fromKey.currentState?.validate() ?? false) {
      //implement course creation logic
      Get.back();
    }
  }

  Widget _buildImagePicker() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add_photo_alternate,
            size: 40,
          ),
        ),
      ),
    );
  }
}
