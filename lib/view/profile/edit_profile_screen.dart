import 'package:e_learning/bloc/profile/profile_bloc.dart';
import 'package:e_learning/bloc/profile/profile_event.dart';
import 'package:e_learning/bloc/profile/profile_state.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/profile/widgets/edit_profile_app_bar.dart';
import 'package:e_learning/view/profile/widgets/profile_picture_button_sheet.dart';
import 'package:e_learning/view/widgets/common/custom_button.dart';
import 'package:e_learning/view/widgets/common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _blocController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final profile = context.read<ProfileBloc>().state.profile;
    if (profile != null) {
      _fullNameController.text = profile.fullName;
      _phoneController.text = profile.phoneNumber ?? '';
      _blocController.text = profile.bio ?? "";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _phoneController.dispose();
    _blocController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_fromKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            UpdateProfileRequested(
              fullName: _fullNameController.text.trim(),
              phoneNumber: _phoneController.text.trim(),
              bio: _blocController.text.trim(),
            ),
          );
      //wait for the update to compleat before navigate back
      context
          .read<ProfileBloc>()
          .stream
          .firstWhere((state) => !state.isLoading)
          .then((_) => Get.back());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      final profile = state.profile;
      if (profile == null) return const Scaffold();
      return Scaffold(
        appBar: EditProfileAppBar(
          onSave: () {
            Get.back();
          },
        ),
        body: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              //profile picture section
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primaryLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.accent,
                                width: 3,
                              ),
                            ),
                            child: state.isPhotoUploading
                                ? Shimmer.fromColors(
                                    baseColor:
                                        AppColors.primary.withOpacity(0.5),
                                    highlightColor: AppColors.accent,
                                    child: const CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                    ))
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.accent,
                                    backgroundImage: profile.photoUrl != null
                                        ? NetworkImage(profile.photoUrl!)
                                        : null,
                                    child: profile.photoUrl == null
                                        ? Text(
                                            profile.fullName
                                                .split(' ')
                                                .map((e) => e[0])
                                                .take(2)
                                                .join()
                                                .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        : null,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: AppColors.accent,
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (context) =>
                                          const ProfilePictureButtonSheet(),
                                    );
                                  },
                                  color: AppColors.primary,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Edit You Profile",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
                //from field
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, left: 4),
                        child: Text(
                          "Personal Information",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                        ),
                      ),
                      //form field in cards
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CustomTextfield(
                              label: "Full Name",
                              prefixIcon: Icons.person_outline,
                              controller: _fullNameController,
                            ),
                            const SizedBox(height: 16),
                            const CustomTextfield(
                              label: "Email",
                              prefixIcon: Icons.email_outlined,
                              initialValue: "awais@gmail.com",
                              enabled: false, //email is not editable
                            ),
                            const SizedBox(height: 16),
                            CustomTextfield(
                              label: "Phone",
                              prefixIcon: Icons.phone_outlined,
                              // initialValue: "+923154809005",
                              controller: _phoneController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, left: 4),
                        child: Text(
                          "About You",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]),
                        padding: const EdgeInsets.all(20),
                        child: CustomTextfield(
                          label: "Bio",
                          prefixIcon: Icons.info_outline,
                          controller: _blocController,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        text: "Save Changes",
                        onPressed: _handleSave,
                        icon: Icons.check_circle_outline,
                        isLoading: state.isLoading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
