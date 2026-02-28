import 'package:flutter/material.dart';

class AppColors {
  // ⚪️ Basic Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // 🟢 Success & 🛑 Error
  static const Color success = Color(0xFF4CAF50); // green
  static const Color danger = Color(0xFFF44336); // red
  static const Color warning = Color(0xFFFFC107); // amber / yellow

  // 🔵 Primary / Secondary
  static const Color primary = Color(0xFF1976D2); // blue
  static const Color primaryLight = Color(0xFF63A4FF);
  static const Color primaryDark = Color(0xFF004BA0);

  static const Color secondary = Color(0xFFFF5722); // deep orange
  static const Color secondaryLight = Color(0xFFFF8A50);
  static const Color secondaryDark = Color(0xFFBF360C);

  // ⚪️ Grayscale
  static const Color gray = Color(0xFF6B6B6B);
  static const Color lightGray = Color(0xFFBDBDBD);
  static const Color extraLightGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF424242);

  // 🟠 Others
  static const Color orange = Color(0xFFFF6200);
  static const Color pink = Color(0xFFE91E63);
  static const Color purple = Color(0xFF7953FF);
  static const Color teal = Color(0xFF009688);
  static const Color blueGray = Color(0xFF607D8B);

  // 🌟 Background / Surface Colors
  // static const Color scaffoldBackground = Color(0xFF003485);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color shadowColor = Color(0x33000000); // 20% black for shadow

  // 📝 Text Colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF636F85);

  static const Color blackText = Color(0xFF2D2D2D);
  static const Color disabledText = Color(0xFFBDBDBD);

  // 🔔 Notification / Accent
  static const Color info = Color(0xFF2196F3); // blue
  static const Color accent = Color(0xFFFF4081);

  // static const Color bgColor = Color(0xFF003485);
  static const Color mainColor = Color(0xFF0F6259);
  static const Color card1 = Color(0xFFE2DAFF);
  static const Color card2 = Color(0xFFFFF2C1);
  static const Color card3 = Color(0xFFD1F0DC);

  static const Color textGrey = Color(0xFF828282);
  static const Color iconGrey = Color(0xFFCECECE);
  static const Color secondaryColor = Color(0xFFE0F7FA);
  static Color shimmerColor = Colors.grey.shade300;
  static Color offBgColor = Color(0xffBEEFFD).withValues(alpha: 0.1);
  static const Color green = Color(0xff00A373);
  static const Color dotsGrey = Color(0xffD3D3D3);
  static const Color red = Color(0xffF42A41);

  static const Color blue = Color(0xff007EFF);
}
