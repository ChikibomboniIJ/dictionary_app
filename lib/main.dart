import 'package:dictionary_app/features/main/presentation/widgets/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env"); //path to your .env file);
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}
