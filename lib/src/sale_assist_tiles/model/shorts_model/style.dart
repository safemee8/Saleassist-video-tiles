import 'package:equatable/equatable.dart';

class Style extends Equatable {
  final String? verticalPosition;
  final String? horizontalPosition;

  const Style({this.verticalPosition, this.horizontalPosition});

  factory Style.fromMap(Map<String, dynamic> json) => Style(
        verticalPosition: json['vertical_position'] as String?,
        horizontalPosition: json['horizontal_position'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'vertical_position': verticalPosition,
        'horizontal_position': horizontalPosition,
      };

  Style copyWith({
    String? verticalPosition,
    String? horizontalPosition,
  }) {
    return Style(
      verticalPosition: verticalPosition ?? this.verticalPosition,
      horizontalPosition: horizontalPosition ?? this.horizontalPosition,
    );
  }

  @override
  List<Object?> get props => [verticalPosition, horizontalPosition];
}
