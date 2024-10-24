import 'package:dictionary_app/features/main/presentation/widgets/main_body.dart';
import 'package:dictionary_app/features/main/presentation/widgets/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: const SafeArea(
        child: Body(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Разделы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Слова',
          ),
        ],
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const SearchScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
    );
  }
}
