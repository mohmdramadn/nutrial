import 'package:flutter/material.dart';
import 'package:nutrial/generated/l10n.dart';

class ThirdIntroScreen extends StatelessWidget {
  const ThirdIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.05),
        Text(
          S.of(context).boardThreeTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        Expanded(child: SizedBox(height: size.height * 0.04)),
        SizedBox(
          height: size.height * 0.2,
          child: Image.asset('assets/images/board3.png'),
        ),
      ],
    );
  }
}
