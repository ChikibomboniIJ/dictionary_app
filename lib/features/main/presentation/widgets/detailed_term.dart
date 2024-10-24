import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

class DetailedTerm extends StatefulWidget {
  final String russian;
  final String english;
  final String china;
  final String transcription;
  const DetailedTerm(
      {super.key,
      required this.russian,
      required this.english,
      required this.china,
      required this.transcription});

  @override
  State<DetailedTerm> createState() => _DetailedTermState();
}

class _DetailedTermState extends State<DetailedTerm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Термин"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flag.fromCode(
                FlagsCode.RU,
                height: 80,
                width: 40,
              ),
              Expanded(
                child: Text(
                  widget.russian,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flag.fromCode(
                FlagsCode.GB,
                height: 80,
                width: 40,
              ),
              Expanded(
                child: Text(
                  widget.english,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flag.fromCode(
                FlagsCode.CN,
                height: 80,
                width: 40,
              ),
              Expanded(
                child: Text(
                  widget.china,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flag.fromCode(
                FlagsCode.CN,
                height: 80,
                width: 40,
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  widget.transcription,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
