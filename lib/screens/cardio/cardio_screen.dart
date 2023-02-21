import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/cardio/cardio_view_model.dart';
import 'package:nutrial/screens/cardio_exercise/cardio_exercise_screen.dart';
import 'package:provider/provider.dart';

class CardioScreen extends StatelessWidget {
  const CardioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardioViewModel>(
        create: (_) => CardioViewModel(), child: const _Body());
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
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Header(),
            _SearchBox(size: size),
            _CardioActivities(size: size)
          ],
        ),
      ),
    );
  }
}

class _CardioActivities extends StatelessWidget {
  const _CardioActivities({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var cardioList = context.select((CardioViewModel vm) => vm.cardioList);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 8.0.h),
      child: Container(
        width: size.width * 0.9,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColors.darkPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cardioList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: ()=> Get.to(const CardioExerciseScreen()),
                child: _CardioItem(itemName: cardioList[index]));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: const Divider(
                  color: AppColors.yellowTextColor, thickness: 0.5),
            );
          },
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var controller =
        context.select((CardioViewModel vm) => vm.searchController);

    return Padding(
      padding:
          EdgeInsets.only(bottom: 20.0.h, top: 50.0.h, left: 32.w, right: 32.w),
      child: Container(
        width: size.width * 0.9,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, size: 35),
              hintText: S.of(context).searchWorkout,
              border: InputBorder.none,
            ),
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}

class _CardioItem extends StatelessWidget {
  const _CardioItem({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: const TextStyle(color: Colors.white),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset('assets/icons/arrow_forward.png'),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.h,
          width: MediaQuery.of(context).size.width,
          color: AppColors.cardioHeaderColor,
          child: Padding(
            padding: EdgeInsets.only(top: 24.0.h),
            child: Row(
              children: [
                SizedBox(width: 50.w),
                Text(
                  S.of(context).cardio.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 22.sp, letterSpacing: 4.5),
                ),
                SizedBox(width: 120.w),
                Padding(
                  padding: EdgeInsets.only(right: 5.0.w),
                  child: Image.asset(
                    'assets/images/logo_n.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
        ),
        const _Date(),
      ],
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 45.h,
            color: AppColors.primaryLightColor3,
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
                child: const Text(
                  'Yesterday',
                  style: TextStyle(color: Colors.white, letterSpacing: 1.9),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 45.h,
            color: AppColors.primaryDarkColor,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '11/10/2023',
                style: TextStyle(color: Colors.white, letterSpacing: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
