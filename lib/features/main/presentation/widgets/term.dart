import 'package:dictionary_app/features/main/presentation/widgets/detailed_term.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Term extends StatelessWidget {
  final String russian;
  final String english;
  final String china;
  final String transcription;
  final Color backgroudColor;
  final int id;
  const Term(
      {super.key,
      required this.russian,
      required this.english,
      required this.china,
      required this.transcription,
      required this.backgroudColor,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        showDialog(
          context: context, // Provide the context of your widget
          builder: (_) {
            return DetailedTerm(
                russian: russian,
                english: english,
                china: china,
                transcription: transcription);
          },
        );
      },
      child: Container(
        color: backgroudColor,
        height: 60,
        child: Row(
          children: [
            SizedBox(
                width: 40,
                child: Text(
                  "${id.toString()}.",
                  style: TextStyle(fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                )),
            Container(
              width: screenWidth / 4 - 10,
              height: 20,
              child: Text(
                locale: Locale('ru', 'RU'),
                russian,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                width: screenWidth / 4 - 10,
                height: 20,
                child: Text(
                  english,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )),
            Container(
              width: screenWidth / 4 - 10,
              height: 20,
              child: Text(
                china,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: screenWidth / 4 - 10,
              height: 20,
              child: Text(
                transcription,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
