import 'package:bloc/bloc.dart';
import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/course/course_event.dart';
import 'package:e_learning/bloc/course/course_state.dart';
import 'package:e_learning/repositories/courses_repository.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CoursesRepository _coursesRepository;
  final AuthBloc _authBloc;

  CourseBloc({
    required CoursesRepository coursesRepository,
    required AuthBloc authBloc,
  })  : _coursesRepository = coursesRepository,
        _authBloc = authBloc,
        super(courseInitial()) {
    on<LoadCourse>(_onLoadCourses);
    on<LoadCourseDetail>(_onLoadCourseDetail);
    on<EnrollCourse>(_onEnrolleCourse);
    on<LoadEnrolledCourses>(_onLoadEnrolledCourse);
    on<LoadOfflineCourses>(_onLoadOfflineCourses);
    on<UpdateCourse>(_onUpdateCourse);
    on<DeleteCourse>(_onDeleteCourse);
  }
  Future<void> _onLoadCourses(
    LoadCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses = await _coursesRepository.getCourses(
        categoryId: event.categoryId,
      );
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onLoadCourseDetail(
    LoadCourseDetail event,
    Emitter<CourseState> emit,
  ) async {}
  Future<void> _onEnrolleCourse(
    EnrollCourse event,
    Emitter<CourseState> emit,
  ) async {}
  Future<void> _onLoadEnrolledCourse(
    LoadEnrolledCourses event,
    Emitter<CourseState> emit,
  ) async {}
  Future<void> _onLoadOfflineCourses(
    LoadOfflineCourses event,
    Emitter<CourseState> emit,
  ) async {}
  Future<void> _onUpdateCourse(
    UpdateCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses =
          await _coursesRepository.getinstructorCourses(event.instructorId);
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onDeleteCourse(
    DeleteCourse event,
    Emitter<CourseState> emit,
  ) async {
    try {
      await _coursesRepository.deleteCourse(event.courseId);
      final userId = _authBloc.state.userModel?.uid;
      if (userId != null) {
        final courses = await _coursesRepository.getinstructorCourses(userId);
        //succes message show afther first emit
        emit(CourseDeleted("Course deleted successfully"));
        //then emit the updated course list
        emit(CourseLoaded(courses));
      }
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
