import 'package:flutter/widgets.dart';
import 'package:flag/flag.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
            width: 40,
            child: Text(
              "#",
              style: TextStyle(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            )),
        Container(
          width: screenWidth / 4 - 10,
          child: Column(
            children: [
              const Text(
                "Русский",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Flag.fromCode(
                FlagsCode.RU,
                height: 80,
                width: 40,
              )
            ],
          ),
        ),
        Container(
          width: screenWidth / 4 - 10,
          child: Column(
            children: [
              const Text(
                "English",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Flag.fromCode(
                FlagsCode.GB,
                height: 80,
                width: 40,
              )
            ],
          ),
        ),
        Container(
          width: screenWidth / 4 - 10,
          child: Column(
            children: [
              const Text(
                "Chinese",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Flag.fromCode(
                FlagsCode.CN,
                height: 80,
                width: 40,
              )
            ],
          ),
        ),
        Container(
          width: screenWidth / 4 - 10,
          child: Column(
            children: [
              const Text(
                "Trans-tion",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Flag.fromCode(
                FlagsCode.CN,
                height: 80,
                width: 40,
              )
            ],
          ),
        ),
      ],
    );
  }
}
