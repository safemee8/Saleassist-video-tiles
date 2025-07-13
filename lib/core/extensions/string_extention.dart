import 'dart:ui';

extension HexColor on String {
  Color toColor() {
    var hex = replaceAll('#', '');
    if (hex.length == 6) hex = 'ff$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
