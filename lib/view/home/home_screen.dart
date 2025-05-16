import 'package:e_learning/models/category.dart';
import 'package:e_learning/view/home/widgets/category_section.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:e_learning/view/home/widgets/home_app_bar.dart';
import 'package:e_learning/view/home/widgets/in_progress_section.dart';
import 'package:e_learning/view/home/widgets/recommended_section.dart';
import 'package:e_learning/view/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Category> categories = [
    Category(
      id: '1',
      name: 'Programmer',
      icon: Icons.code,
      courseCount: DummyDataService.getCoursesByCateogory("1").length,
    ),
    Category(
      id: '2',
      name: 'Design',
      icon: Icons.brush,
      courseCount: DummyDataService.getCoursesByCateogory("2").length,
    ),
    Category(
      id: '3',
      name: 'Business',
      icon: Icons.business,
      courseCount: DummyDataService.getCoursesByCateogory("3").length,
    ),
    Category(
      id: '4',
      name: 'Music',
      icon: Icons.music_note,
      courseCount: DummyDataService.getCoursesByCateogory("4").length,
    ),
    Category(
      id: '5',
      name: 'Photograpy',
      icon: Icons.camera_alt,
      courseCount: DummyDataService.getCoursesByCateogory("5").length,
    ),
    Category(
      id: '6',
      name: 'Language',
      icon: Icons.language,
      courseCount: DummyDataService.getCoursesByCateogory("6").length,
    ),
    Category(
      id: '7',
      name: 'Heatl & fitness',
      icon: Icons.fitness_center,
      courseCount: DummyDataService.getCoursesByCateogory("7").length,
    ),
    Category(
      id: '8',
      name: 'Personal Development',
      icon: Icons.psychology,
      courseCount: DummyDataService.getCoursesByCateogory("8").length,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const HomeAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                const SearchBarWidget(),
                const SizedBox(height: 32),
                CategorySection(categories: categories),
                const SizedBox(height: 32),
                const InProgressSection(),
                const RecommendedSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
