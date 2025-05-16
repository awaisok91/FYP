import 'package:e_learning/bloc/font/font_bloc.dart';
import 'package:e_learning/bloc/font/font_event.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/services/font_services.dart';
import 'package:e_learning/view/settings/widgets/setting_section.dart';
import 'package:e_learning/view/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingSection(
                title: "App Preferences",
                children: [
                  SettingTile(
                    title: "Download over Wi-Fi only ",
                    icon: Icons.wifi_outlined,
                    traling: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingSection(
                title: "Content",
                children: [
                  SettingTile(
                    title: "Download Quality",
                    icon: Icons.high_quality_outlined,
                    traling: DropdownButton<String>(
                      onChanged: (value) {},
                      underline: const SizedBox(),
                      value: "High",
                      items: ["Low", "Medium", "High"]
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                  SettingTile(
                    title: "Auto-Play Video ",
                    icon: Icons.play_circle_outline,
                    traling: Switch(
                      value: false,
                      onChanged: (value) {},
                      activeColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingSection(
                title: "Privacy",
                children: [
                  SettingTile(
                    title: "Privacy Policy",
                    icon: Icons.privacy_tip_outlined,
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  ),
                  SettingTile(
                    title: "Terms of Services",
                    icon: Icons.description_outlined,
                    onTap: () => Get.toNamed(AppRoutes.termCondition),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingSection(
                title: "Text Settings",
                children: [
                  SettingTile(
                    title: "Font Size",
                    icon: Icons.format_size,
                    traling: DropdownButton<String>(
                      value: FontServices.fontSizesScale.keys.firstWhere(
                        (key) =>
                            FontServices.fontSizesScale[key] ==
                            FontServices.currentFontScale,
                        orElse: () => "Normal", // Default value
                      ),
                      items: FontServices.fontSizesScale.keys
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) async {
                        // Handle font size change
                        if (value != null) {
                          context.read<FontBloc>().add(
                                updateFontScale(
                                    FontServices.fontSizesScale[value]!),
                              );
                        }
                      },
                      underline: const SizedBox(),
                    ),
                  ),
                  SettingTile(
                    title: "Font Family",
                    icon: Icons.font_download,
                    traling: DropdownButton<String>(
                      value: FontServices.availableFonts.entries
                          .firstWhere(
                            (e) => e.value == FontServices.currentFontFamily,
                            orElse: () => FontServices
                                .availableFonts.entries.first, // Default value
                          )
                          .key,
                      items: FontServices.availableFonts.keys
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        // Handle font family change
                        if (value != null) {
                          context.read<FontBloc>().add(
                                updateFontFamily(
                                  FontServices.availableFonts[value]!,
                                ),
                              );
                        }
                      },
                      underline: const SizedBox(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SettingSection(title: "App Info", children: [
                SettingTile(
                  title: "Version",
                  icon: Icons.info_outline,
                  traling: Text(
                    "1.0.0",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
