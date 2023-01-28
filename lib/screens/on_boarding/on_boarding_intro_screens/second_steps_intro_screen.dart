import 'package:flutter/material.dart';
import 'package:nutrial/generated/l10n.dart';

class SecondStepsIntroScreen extends StatelessWidget {
  const SecondStepsIntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.11),
        Text(
          S.of(context).boardTwoTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height * 0.05),
        SizedBox(
          height: size.height * 0.29,
          child: Image.asset('assets/images/board2.png'),
        ),
      ],
    );
  }
}