import 'package:flutter/material.dart';

class ColorConstants {
  // Primary Color
  static const Color primaryColor = Color(0xffffcc99);
  static const Color primaryShade1 = Color(0xffffc388);
  static const Color primaryShade2 = Color(0xffffbb78);
  static const Color primaryShade3 = Color(0xffffa347);
  static const Color primaryShade4 = Color(0xffff8a16);
  static const Color primaryShade5 = Color(0xffe47200);
  static const Color primaryShade6 = Color(0xffb35900);
  static const Color primaryShade7 = Color(0xff9b4d00);
  static const Color primaryShade8 = Color(0xff924900);
  static const Color primaryShade9 = Color(0xfffee4c9);
  static const Color primaryShade10 = Color(0xfffff4ea);

  // Gradients
  static const gradient1 = LinearGradient(
    colors: [
      primaryShade1,
      primaryShade2,
      primaryShade3,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const gradient2 = LinearGradient(
    colors: [
      primaryShade3,
      primaryShade4,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const gradient3 = LinearGradient(
    colors: [
      primaryShade4,
      primaryShade5,
      primaryShade6,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const gradient4 = LinearGradient(
    colors: [
      primaryShade6,
      primaryShade7,
      primaryShade8,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
