import 'package:equatable/equatable.dart';

abstract class FontEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class updateFontScale extends FontEvent {
  final double scale;

  updateFontScale(this.scale);
  @override
  List<Object> get props => [scale];

}
class updateFontFamily extends FontEvent {
  final String family;

  updateFontFamily(this.family);
  @override
  List<Object> get props => [family];
}