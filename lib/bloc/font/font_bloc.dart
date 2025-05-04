import 'package:e_learning/bloc/font/font_event.dart';
import 'package:e_learning/bloc/font/font_state.dart';
import 'package:e_learning/services/font_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class FontBloc extends Bloc<FontEvent, FontState> {
  final GetStorage _storage = GetStorage();
  FontBloc()
      : super(FontState(
          fontScale: FontServices.currentFontScale,
          fontFamily: FontServices.currentFontFamily,
        )){
          on<updateFontScale>(_onUpdateFontScale);
          on<updateFontFamily>(_onUpdateFontFamily);
        }
  void _onUpdateFontScale(
    updateFontScale event,
    Emitter<FontState> emit,
  ) async {
    await FontServices.setFontScale(event.scale);
    emit(state.copyWith(fontScale: event.scale));
  }
  void _onUpdateFontFamily(
    updateFontFamily event,
    Emitter<FontState> emit,
  ) async {
    await FontServices.setFontFamily(event.family);
    emit(state.copyWith(fontFamily: event.family));
  }
}
