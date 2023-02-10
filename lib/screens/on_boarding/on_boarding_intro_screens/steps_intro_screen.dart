import 'package:flutter/material.dart';
import 'package:nutrial/generated/l10n.dart';

class StepsScreen extends StatelessWidget {
  const StepsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Text(
              S.of(context).boardOneTitle,
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
                height: size.height * 0.175,
                child: Image.asset('assets/images/board1.png')),
            Text(
              S.of(context).boardOneDesc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                wordSpacing: 1.5,
                height: 1.8,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ));
  }
}
