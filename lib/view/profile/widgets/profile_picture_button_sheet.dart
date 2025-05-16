import 'package:e_learning/bloc/profile/profile_bloc.dart';
import 'package:e_learning/bloc/profile/profile_event.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureButtonSheet extends StatelessWidget {
  const ProfilePictureButtonSheet({super.key});
  Future<void> _picImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (!context.mounted) return;
    //close the button sheet
    navigator!.pop(context);
    //start upload process
    final bloc = context.read<ProfileBloc>();
    bloc.add(UpdateProfilePhotRequested(pickedFile!.path));
    }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Change Profile Picture",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Choose from Gallery",
            ),
            onTap: () => _picImage(context, ImageSource.gallery),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Take a Photo",
            ),
            onTap: () => _picImage(context, ImageSource.camera),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Remove Photo",
              style: TextStyle(
                color: AppColors.error,
              ),
            ),
            onTap: () {
              //gallery picker
              navigator!.pop(context);
            },
          )
        ],
      ),
    );
  }
}
