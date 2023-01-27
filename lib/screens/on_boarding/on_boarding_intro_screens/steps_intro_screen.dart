import 'package:flutter/material.dart';

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
            const Text(
              'Here are few steps\nto start your own journey',
              style: TextStyle(
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
            const Text(
              'Do your BMR Test to define\nMuscles percentage\nWater percentage\nFat percentage',
              textAlign: TextAlign.center,
              style: TextStyle(
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
