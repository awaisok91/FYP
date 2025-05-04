import 'package:e_learning/models/course.dart';
import 'package:e_learning/models/lesson.dart';
import 'package:e_learning/models/question.dart';
import 'package:e_learning/models/quiz.dart';
import 'package:e_learning/models/quiz_attempt.dart';

class DummyDataService {
  static final List<Course> courses = [
    Course(
      id: "1",
      title: "Flutter Development Bootcamp",
      description:
          "Master flutter and dart from scratch. Build real-world cross-platform apps.",
      price: 99.99,
      imageUrl: "https://i.ytimg.com/vi/z9kOcyKst8s/maxresdefault.jpg",
      instructorId: "inst_1",
      categoryId: '1',
      lessons: _createdFlutterLesson(),
      level: "Intermediate",
      requirments: [
        "Basic Programming language",
        "Dedication to learn",
      ],
      whatYouWillLearn: [
        "Build native apps",
        'Master Dart programming',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      rating: 4.8,
      reviewCount: 245,
      enrollmentCount: 1200,
    ),
    Course(
      id: "2",
      title: "Web Development Bootcamp",
      description:
          "Learn web development from scratch. Build responsive websites using HTML, CSS, and JavaScript.",
      price: 79.99,
      imageUrl: "https://i.ytimg.com/vi/z9kOcyKst8s/maxresdefault.jpg",
      instructorId: "inst_2",
      categoryId: '2',
      lessons: _createdWebDevelopmentLesson(),
      level: "Beginner",
      requirments: [
        "Basic Computer Skills",
        "Willingness to learn",
      ],
      whatYouWillLearn: [
        "Build responsive websites",
        "Understand HTML, CSS, and JavaScript",
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      updatedAt: DateTime.now(),
      rating: 4.5,
      reviewCount: 150,
      enrollmentCount: 800,
      ispremium: true,
    ),
    Course(
      id: "3",
      title: "Data Science with Python",
      description:
          "Learn data science and machine learning using Python. Build real-world projects.",
      price: 89.99,
      imageUrl: "https://i.ytimg.com/vi/z9kOcyKst8s/maxresdefault.jpg",
      instructorId: "inst_3",
      categoryId: '3',
      lessons: _createdDataScienceLesson(),
      level: "Advanced",
      requirments: [
        "Basic Python knowledge",
        "Interest in data science",
      ],
      whatYouWillLearn: [
        "Data analysis and visualization",
        "Machine learning algorithms",
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now(),
      rating: 4.7,
      reviewCount: 300,
      enrollmentCount: 1500,
    ),
    Course(
      id: "4",
      title: "Digital Marketing Masterclass",
      description:
          "Learn digital marketing strategies to grow your business online.",
      price: 49.99,
      imageUrl: "https://i.ytimg.com/vi/z9kOcyKst8s/maxresdefault.jpg",
      instructorId: "inst_4",
      categoryId: '4',
      lessons: _createdDigitalMarketingLesson(),
      level: "Intermediate",
      requirments: [
        "Basic understanding of marketing",
        "Willingness to learn",
      ],
      whatYouWillLearn: [
        "SEO and SEM strategies",
        "Social media marketing techniques",
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
      rating: 4.6,
      reviewCount: 200,
      enrollmentCount: 900,
    ),
    Course(
      id: "5",
      title: "Graphic Design Bootcamp",
      description:
          "Learn graphic design principles and software to create stunning visuals.",
      price: 59.99,
      imageUrl: "https://i.ytimg.com/vi/z9kOcyKst8s/maxresdefault.jpg",
      instructorId: "inst_5",
      categoryId: '5',
      lessons: _createdGraphicDesignLesson(),
      level: "Beginner",
      requirments: [
        "Basic computer skills",
        "Interest in design",
      ],
      whatYouWillLearn: [
        "Design principles and color theory",
        "Using design software like Photoshop and Illustrator",
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
      rating: 4.4,
      reviewCount: 180,
      enrollmentCount: 700,
      ispremium: true,
    ),
    Course(
      id: "6",
      title: "Photography Masterclass",
      description:
          "Learn photography techniques and editing skills to capture stunning images.",
      price: 69.99,
      imageUrl: "https://i.ytimg.com/vi/z9kOcyKst8s/maxresdefault.jpg",
      instructorId: "inst_6",
      categoryId: '6',
      lessons: _createdPhotographyLesson(),
      level: "Intermediate",
      requirments: [
        "Basic understanding of photography",
        "Willingness to learn",
      ],
      whatYouWillLearn: [
        "Camera settings and composition",
        "Photo editing techniques",
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
      rating: 4.9,
      reviewCount: 250,
      enrollmentCount: 1100,
    ),
  ];

  static final List<Quiz> quizzes = [
    Quiz(
      id: "1",
      title: "Flutter",
      description: "Test your knowledge of flutter fundamentals",
      timeLimit: 30,
      questions: _createdFlutterQuizQuestion(),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      isActive: true,
    ),
    Quiz(
      id: "2",
      title: "Dart Basics",
      description: "Test your knowledge of Dart programming language",
      timeLimit: 30,
      questions: _createdDartQuizQuestion(),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isActive: true,
    ),
    Quiz(
      id: "3",
      title: "Web Development",
      description: "Test your knowledge of web development fundamentals",
      timeLimit: 30,
      questions: _createdWebDevelopmentQuizQuestion(),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isActive: true,
    ),
  ];
  static final List<QuizAttempt> quizAttempts = [];

  static List<Lesson> _createdFlutterLesson() {
    return [
      // Lesson(
      //   id: "1",
      //   title: "Introduction to Flutter",
      //   description: "Learn the basics of Flutter and Dart.",
      //   vedioUrl: "https://example.com/flutter_intro.mp4",
      //   duration: 30,
      //   resources: _createDummyResouces(),
      //   isPreview: true,
      //   isLocked: false,
      // ),
      // _createLesson('2', "Dart Programming Basics", false, false),
      // _createLesson('3', "State Management", false, false),

      Lesson(
        id: "1",
        title: "Flutter Development Bootcamp",
        description: "Learn the basics of Flutter and Dart.",
        vedioUrl: "https://example.com/flutter_intro.mp4",
        duration: 30,
        resources: _createDummyResouces(),
        isPreview: true,
        isLocked: false,
        isCompleted: false, // ❌ not completed
      ),
      _createLesson('2', "Dart Programming Basics", false, true), // ✅ completed
      _createLesson('3', 'Building UI with widgets', false, false),
    ];
  }

  static List<Lesson> _createdWebDevelopmentLesson() {
    return [
      // Lesson(
      //   id: "1",
      //   title: "HTML Basics",
      //   description: "Learn the structure of web pages using HTML.",
      //   vedioUrl: "https://example.com/html_basics.mp4",
      //   duration: 45,
      //   resources: _createDummyResouces(),
      //   isPreview: true,
      //   isLocked: false,
      //   isCompleted: false, // ❌ not completed
      // ),
      _createLesson('2', "CSS Fundamentals", false, true), // ✅ completed
      _createLesson('3', 'JavaScript Basics', false, false),
    ];
  }

  static List<Lesson> _createdDataScienceLesson() {
    return [
      // Lesson(
      //   id: "1",
      //   title: "Python for Data Science",
      //   description: "Learn Python programming for data analysis.",
      //   vedioUrl: "https://example.com/python_data_science.mp4",
      //   duration: 60,
      //   resources: _createDummyResouces(),
      //   isPreview: true,
      //   isLocked: false,
      //   isCompleted: false, // ❌ not completed
      // ),
      _createLesson(
          '2', "Data Visualization with Matplotlib", true, true), // ✅ completed
      _createLesson('3', 'Machine Learning Basics', false, false),
    ];
  }

  static List<Lesson> _createdDigitalMarketingLesson() {
    return [
      // Lesson(
      //   id: "1",
      //   title: "SEO Basics",
      //   description: "Learn the fundamentals of SEO.",
      //   vedioUrl: "https://example.com/seo_basics.mp4",
      //   duration: 50,
      //   resources: _createDummyResouces(),
      //   isPreview: true,
      //   isLocked: false,
      //   isCompleted: false, // ❌ not completed
      // ),
      _createLesson('2', "Social Media Marketing", false, true), // ✅ completed
      _createLesson('3', 'Email Marketing Strategies', false, false),
    ];
  }

  static List<Lesson> _createdGraphicDesignLesson() {
    return [
      // Lesson(
      //   id: "1",
      //   title: "Design Principles",
      //   description: "Learn the basics of graphic design.",
      //   vedioUrl: "https://example.com/design_principles.mp4",
      //   duration: 40,
      //   resources: _createDummyResouces(),
      //   isPreview: true,
      //   isLocked: false,
      //   isCompleted: false, // ❌ not completed
      // ),
      _createLesson('2', "Using Photoshop", false, true), // ✅ completed
      _createLesson('3', 'Creating Logos', false, false),
    ];
  }

  static List<Lesson> _createdPhotographyLesson() {
    return [
      // Lesson(
      //   id: "1",
      //   title: "Camera Basics",
      //   description: "Learn the fundamentals of photography.",
      //   vedioUrl: "https://example.com/camera_basics.mp4",
      //   duration: 55,
      //   resources: _createDummyResouces(),
      //   isPreview: true,
      //   isLocked: false,
      //   isCompleted: false, // ❌ not completed
      // ),
      _createLesson('2', "Photo Editing Techniques", true, true), // ✅ completed
      _createLesson('3', 'Composition and Framing', false, false),
    ];
  }

  static Lesson _createLesson(
      String id, String title, bool isPreview, bool isCompleted) {
    return Lesson(
      id: "lesson$id",
      title: title,
      description: "This is a detailed description for $title",
      vedioUrl: "vedioUrl",
      duration: 30,
      resources: _createDummyResouces(),
      isPreview: isPreview,
      isLocked: !isPreview,
      isCompleted: isCompleted,
    );
  }

  static List<Resource> _createDummyResouces() {
    return [
      Resource(
        id: "res_1",
        title: "Lesson Slides",
        type: "Pdf",
        url: "url",
      ),
      Resource(
        id: "res_2",
        title: "Exercise Files",
        type: "zip",
        url: "url",
      ),
    ];
  }

  static Course getCourseById(String id) {
    return courses.firstWhere(
      (course) => course.id == id,
      orElse: () => courses.first,
    );
  }

  static List<Course> getCoursesByCateogory(String categoryId) {
    return courses.where((course) => course.categoryId == categoryId).toList();
  }

  static List<Course> getInstructorCourses(String instructorId) {
    return courses
        .where((course) => course.instructorId == instructorId)
        .toList();
  }

  static bool isCourseCompleted(String courseId) {
    final course = getCourseById(courseId);
    return course.lessons.every((lesson) => lesson.isCompleted);
  }

  static List<Question> _createdFlutterQuizQuestion() {
    return [
      Question(
        id: "1",
        text: "What is Flutter?",
        options: [
          Option(id: "a", text: "A programming language"),
          Option(id: "b", text: "A framework"),
          Option(id: "c", text: "An IDE"),
          Option(id: "d", text: "A database"),
        ],
        correctOptionId: "b",
        points: 1,
      ),
      Question(
        id: "2",
        text: "Which language is used to write Flutter apps?",
        options: [
          Option(id: "a", text: "Java"),
          Option(id: "b", text: "Kotlin"),
          Option(id: "c", text: "Dart"),
          Option(id: "d", text: "Swift"),
        ],
        correctOptionId: "c",
        points: 1,
      ),
    ];
  }

  static List<Question> _createdDartQuizQuestion() {
    return [
      Question(
        id: "1",
        text: "What is Dart?",
        options: [
          Option(id: "a", text: "A programming language"),
          Option(id: "b", text: "A database"),
          Option(id: "c", text: "A framework"),
          Option(id: "d", text: "An operating system"),
        ],
        correctOptionId: "a",
        points: 1,
      ),
      Question(
        id: "2",
        text: "Which company developed Dart?",
        options: [
          Option(id: "a", text: "Microsoft"),
          Option(id: "b", text: "Google"),
          Option(id: "c", text: "Apple"),
          Option(id: "d", text: "Facebook"),
        ],
        correctOptionId: "b",
        points: 1,
      ),
    ];
  }

  static List<Question> _createdWebDevelopmentQuizQuestion() {
    return [
      Question(
        id: "1",
        text: "What is HTML?",
        options: [
          Option(id: "a", text: "A programming language"),
          Option(id: "b", text: "A markup language"),
          Option(id: "c", text: "A database"),
          Option(id: "d", text: "An operating system"),
        ],
        correctOptionId: "b",
        points: 1,
      ),
      Question(
        id: "2",
        text: "What does CSS stand for?",
        options: [
          Option(id: "a", text: "Cascading Style Sheets"),
          Option(id: "b", text: "Computer Style Sheets"),
          Option(id: "c", text: "Creative Style Sheets"),
          Option(id: "d", text: "Colorful Style Sheets"),
        ],
        correctOptionId: "a",
        points: 1,
      ),
    ];
  }

  static Quiz getQuizById(String id) {
    return quizzes.firstWhere(
      (quiz) => quiz.id == id,
      orElse: () => quizzes.first,
    );
  }

  static void saveQuizAttempt(QuizAttempt attempt) {
    quizAttempts.add(attempt);
  }

  static List<QuizAttempt> getQuizAttempts(String userId) {
    return quizAttempts.where((attempt) => attempt.userId == userId).toList();
  }

  static final Set<String> _purchasedCourseIds = {};

  static bool isCourseUlocked(String courseId) {
    final course = getCourseById(courseId);
    return !course.ispremium || _purchasedCourseIds.contains(courseId);
  }

  static void addPurchaesdCourse(String courseId) {
    _purchasedCourseIds.add(courseId);
  }

  // teacher supecific dummy data
  static final Map<String, TeacherStats> teacherState = {
    "inst_1": TeacherStats(
      totalStudents: 1234,
      activeCourses: 8,
      totalRevenue: 1234.53,
      averageRating: 4.6,
      monthlyEnrollments: [123, 43, 543, 53],
      monthlyRevenue: [233, 5434, 645, 2344],
      studentEngagement: StudentEngagement(
        averageCompletionRate: 0.34,
        averageTimePerLesson: 45,
        activeStudentThisWeek: 423,
        courseCompletionRates: {
          "Flutter Development Bootcamp": 0.45,
          "Advance Flutter": 34,
        },
      ),
    ),
  };

  static final Map<String, List<StudentProgress>> studentProgress = {
    "inst_1": [
      StudentProgress(
        studentId: "student_1",
        studentName: "Awais Khan",
        courseId: "1",
        courseName: "Flutter Development Bootcamp",
        progress: 75.0,
        lastActive: DateTime.now().subtract(const Duration(hours: 2)),
        quizScores: [85, 90, 78],
        completedLessons: 5,
        totalLessons: 10,
        averageTimePerLesson: 30,
      ),
      StudentProgress(
        studentId: "student_2",
        studentName: "John Doe",
        courseId: "1",
        courseName: "Flutter Development Bootcamp",
        progress: 50.0,
        lastActive: DateTime.now().subtract(const Duration(days: 1)),
        quizScores: [80, 85, 88],
        completedLessons: 3,
        totalLessons: 10,
        averageTimePerLesson: 25,
      ),
    ]
  };
  static TeacherStats getTeacherStats(String instructorId) {
    final instructorCourses = getInstructorCourses(instructorId);
    final stats = teacherState[instructorId] ?? TeacherStats.empty();
    return TeacherStats(
      totalStudents: instructorCourses.fold(
          0, (sum, course) => sum + course.enrollmentCount),
      activeCourses: instructorCourses.length,
      totalRevenue: instructorCourses.fold(
          0.0, (sum, course) => sum + (course.price * course.enrollmentCount)),
      averageRating: instructorCourses.isEmpty
          ? 0.0
          : instructorCourses.fold(0.0, (sum, course) => sum = course.rating) /
              instructorCourses.length,
      monthlyEnrollments: stats.monthlyEnrollments,
      monthlyRevenue: stats.monthlyRevenue,
      studentEngagement: stats.studentEngagement,
    );
  }

  static List<StudentProgress> getStudentProgress(String instructorId) {
    final instructorCourses = getInstructorCourses(instructorId);
    final courseIds = instructorCourses.map((c) => c.id).toSet();

    return studentProgress[instructorId]
            ?.where((progress) => courseIds.contains(progress.courseId))
            .toList() ??
        [];
  }

  static void updateLessonStatus(String courseId, String lessonId,
      {bool? isCompleated, bool? isLocked}) {
    final courseIndex = courses.indexWhere((c) => c.id == courseId);
    if (courseIndex != -1) {
      final course = courses[courseIndex];
      final lessonIndex =
          course.lessons.indexWhere((lesson) => lesson.id == lessonId);

      if (lessonIndex != -1) {
        final updatedLesson = course.lessons[lessonIndex].copyWith(
          isCompleted: isCompleated ?? course.lessons[lessonIndex].isCompleted,
          isLocked: isLocked ?? course.lessons[lessonIndex].isLocked,
        );
        courses[courseIndex].lessons[lessonIndex] = updatedLesson;
      }
    }
  }

  static bool isLessonCompleated(String courseId, String lessonId) {
    final course = getCourseById(courseId);
    return course.lessons
        .firstWhere(
          (lesson) => lesson.id == lessonId,
          orElse: () => Lesson(
            id: "",
            title: "",
            description: "",
            vedioUrl: "",
            duration: 0,
            resources: [],
          ),
        )
        .isCompleted;
  }
}

//for teacher supecific data
class TeacherStats {
  final int totalStudents;
  final int activeCourses;
  final double totalRevenue;
  final double averageRating;
  final List<int> monthlyEnrollments;
  final List<double> monthlyRevenue;
  final StudentEngagement studentEngagement;

  TeacherStats({
    required this.totalStudents,
    required this.activeCourses,
    required this.totalRevenue,
    required this.averageRating,
    required this.monthlyEnrollments,
    required this.monthlyRevenue,
    required this.studentEngagement,
  });
  factory TeacherStats.empty() => TeacherStats(
      totalStudents: 0,
      activeCourses: 0,
      totalRevenue: 0,
      averageRating: 0,
      monthlyEnrollments: [],
      monthlyRevenue: [],
      studentEngagement: StudentEngagement.empty());
}

class StudentEngagement {
  final double averageCompletionRate;
  final int averageTimePerLesson;
  final int activeStudentThisWeek;
  final Map<String, double> courseCompletionRates;
  StudentEngagement({
    required this.averageCompletionRate,
    required this.averageTimePerLesson,
    required this.activeStudentThisWeek,
    required this.courseCompletionRates,
  });
  factory StudentEngagement.empty() => StudentEngagement(
      averageCompletionRate: 0,
      averageTimePerLesson: 0,
      activeStudentThisWeek: 0,
      courseCompletionRates: {});
}

class StudentProgress {
  final String studentId;
  final String studentName;
  final String courseId;
  final String courseName;
  final double progress;
  final DateTime lastActive;
  final List<int> quizScores;
  final int completedLessons;
  final int totalLessons;
  final int averageTimePerLesson;

  double get averageScore {
    if (quizScores.isEmpty) return 0.0;
    return quizScores.reduce((a, b) => a + b) / quizScores.length / 100;
  }

  StudentProgress({
    required this.studentId,
    required this.studentName,
    required this.courseId,
    required this.courseName,
    required this.progress,
    required this.lastActive,
    required this.quizScores,
    required this.completedLessons,
    required this.totalLessons,
    required this.averageTimePerLesson,
  });
}
