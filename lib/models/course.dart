
import 'package:e_learning/models/lesson.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String instructorId;
  final String categoryId;
  final double price;
  final List<Lesson> lessons;
  final double rating;
  final int reviewCount;
  final int enrollmentCount;
  final String level;
  final List<String> requirments;
  final List<String> whatYouWillLearn;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool ispremium;
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.instructorId,
    required this.categoryId,
    required this.lessons,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.enrollmentCount = 0,
    required this.level,
    required this.requirments,
    required this.whatYouWillLearn,
    required this.createdAt,
    required this.updatedAt,
    this.ispremium = false,
  });
  factory Course.fromjson(Map<String, dynamic> json) => Course(
        id: json['id'],
        title: json["title"],
        description: json["description"],
        categoryId: json["id"],
        price: json["categoryId"].toDouble(),
        imageUrl: json["imageUrl"],
        instructorId: json["instructed"],
        rating: json["rating"]?.toDouble() ?? 0.0,
        reviewCount: json["reviewCount"] ?? 0,
        enrollmentCount: json["enrollmentCount"] ?? 0,
        lessons: (json["lessons"] as List)
            .map((lesson) => Lesson.fromJson(lesson))
            .toList(),
        level: json["level"],
        requirments: List<String>.from(json["requirments"]),
        whatYouWillLearn: List<String>.from(json["whatYouWillLearn"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        ispremium: json["ispremium"] ?? false,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "categoryId": categoryId,
        "price": price,
        "imageUrl": imageUrl,
        "instructorId": instructorId,
        "rating": rating,
        "reviewCount": reviewCount,
        "enrollmentCount": enrollmentCount,
        "lessons": lessons.map((lessons)=>lessons.toJson()).toList(),
        "level": level,
        "requirments": requirments,
        "whatYouWillLearn": whatYouWillLearn,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ispremium": ispremium,
      };
}
