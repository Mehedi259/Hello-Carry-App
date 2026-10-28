import 'package:flutter/material.dart';

class AppColors {
  // Brand Primary Navy
  static const Color primary = Color(0xFF0A2342); // Deep Maritime Navy
  static const Color primaryLight = Color(0xFF133660);
  static const Color primaryDark = Color(0xFF061426);

  // Accent & Action Colors
  static const Color accent = Color(0xFF0072FF); // Electric Royal Blue
  static const Color accentLight = Color(0xFF389BFF);
  static const Color accentCyan = Color(0xFF00C2FF); // Cyan Highlight
  static const Color accentGlow = Color(0x1F0072FF);

  // Status & National Accents
  static const Color bdGreen = Color(0xFF00875A); // Bangladesh Flag Green
  static const Color omanRed = Color(0xFFE02B36); // Oman Flag Crimson
  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color warning = Color(0xFFF59E0B); // Amber / Processing
  static const Color info = Color(0xFF0284C7); // Sky Blue
  static const Color error = Color(0xFFEF4444); // Error Red

  // Background & Surfaces
  static const Color background = Color(0xFFF8FAFC); // Clean Slate-50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF1F5F9);
  static const Color surfaceAlt = Color(0xFFE2E8F0);

  // Drawer & Dark Backgrounds
  static const Color drawerBg = Color(0xFF0A1E38);
  static const Color drawerCard = Color(0xFF122847);
  static const Color drawerBorder = Color(0xFF1D3558);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFEDF2F7);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0B2447), Color(0xFF19376D)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0072FF), Color(0xFF00C2FF)],
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
  );
}
