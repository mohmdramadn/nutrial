import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/calculator/categories_view_model.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoriesViewModel>(
        create: (_) => CategoriesViewModel(), child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.2),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
            color: Colors.grey[800],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 120.0.w, right: 90.0.w, top: 50.h),
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(height: size.height * 0.05),
              _CategoryCard(
                size: size,
                image: 'assets/images/calories_background.jpeg',
                title: S.of(context).calories,
              ),
              SizedBox(height: size.height * 0.015),
              _CategoryCard(
                size: size,
                image: 'assets/images/cardio_bg.png',
                title: S.of(context).cardio,
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    Key? key,
    required this.size,
    required this.title,
    required this.image,
  }) : super(key: key);

  final Size size;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<CategoriesViewModel>().navigateToExercise(screen: title),
      child: Container(
        height: size.height * 0.20,
        width: size.width * 0.799,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
