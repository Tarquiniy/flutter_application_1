import 'package:flutter/material.dart';

final vampireTheme = ThemeData(
  primaryColor: const Color(0xFF1A0A06),
  scaffoldBackgroundColor: const Color(0xFF0D0604),
  hintColor: Colors.grey[600],
  fontFamily:
      'VampireFont', // Устанавливаем шрифт по умолчанию для всего приложения
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(
      fontSize: 28, // Увеличим размер заголовков
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: "VampireFont",
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A0A06)),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFF3A1F14)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFF8B1820)),
    ),
    labelStyle: TextStyle(color: Colors.grey[400]),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF8B1820),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
);
