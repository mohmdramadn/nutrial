import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/components/logo.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/cardio_exercise/cardio_exercise_view_model.dart';
import 'package:provider/provider.dart';

class CardioExerciseScreen extends StatelessWidget {
  const CardioExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardioExerciseViewModel>(
        create: (_) => CardioExerciseViewModel(), child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isSuccess =
        context.select((CardioExerciseViewModel vm) => vm.isSuccess);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            const _BackgroundImg(),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  const Logo(),
                  SizedBox(height: 70.h),
                  if (isSuccess) const _SuccessWidget(),
                  if (!isSuccess)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [_Minutes(), _BodyWeight()],
                    ),
                  if (!isSuccess) SizedBox(height: size.height * 0.02),
                  if (!isSuccess) _TotalCalories(size: size, total: 'total'),
                  if (!isSuccess) const _SaveButton(),
                  if (!isSuccess) SizedBox(height: size.height * 0.04),
                  if (!isSuccess) _BottomKilosCalories(size: size)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  const _SuccessWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/lift_icon.png',
          height: 200,
          width: 200,
          fit: BoxFit.contain,
        ),
        SizedBox(height: size.height * .1),
        const Center(
          child: Text(
            ConstStrings.yaay,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Center(
          child: Text(
            ConstStrings.champion,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomKilosCalories extends StatelessWidget {
  const _BottomKilosCalories({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      width: size.width,
      decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            S.of(context).textCardioExercise,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const _KiloGrams(),
          const _Calories()
        ],
      ),
    );
  }
}

class _BackgroundImg extends StatelessWidget {
  const _BackgroundImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/cardio_bg.png'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _TotalCalories extends StatelessWidget {
  const _TotalCalories({
    Key? key,
    required this.size,
    required this.total,
  }) : super(key: key);

  final Size size;
  final String total;

  @override
  Widget build(BuildContext context) {
    var totalCalories =
        context.select((CardioExerciseViewModel vm) => vm.totalCalories);
    return Container(
      width: size.width * 0.30,
      height: size.height * 0.06,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Center(
          child: Text(
        '${S.of(context).total}:  ${totalCalories ?? 0} ${S.of(context).cal}',
        style: const TextStyle(fontSize: 18),
      )),
    );
  }
}

class _Calories extends StatelessWidget {
  const _Calories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _CircularBox(title: Calories.twoHundredAndThirtySix),
        _CircularBox(title: Calories.fiveHundredAndNinetyEight),
        _CircularBox(title: Calories.sixHundredAndNinetyFive),
        _CircularBox(title: Calories.sevenHundredAndNinetyOne),
      ],
    );
  }
}

class _KiloGrams extends StatelessWidget {
  const _KiloGrams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _CircularBox(title: Kilograms.sixty),
        _CircularBox(title: Kilograms.seventy),
        _CircularBox(title: Kilograms.eighty),
        _CircularBox(title: Kilograms.ninety),
      ],
    );
  }
}

class _CircularBox extends StatelessWidget {
  const _CircularBox({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    var selectedWeight =
        context.select((CardioExerciseViewModel vm) => vm.selectedWeight);
    return InkWell(
      onTap: () =>
          context.read<CardioExerciseViewModel>().setSelectedWeight(title),
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              selectedWeight == title ? AppColors.floatingButton : Colors.white,
        ),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            color: selectedWeight == title
                ? Colors.white
                : AppColors.primaryDarkColor,
          ),
        )),
      ),
    );
  }
}

class _SaveButton extends StatefulWidget {
  const _SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<_SaveButton> {
  @override
  Widget build(BuildContext context) {
    var isLoading =
        context.select((CardioExerciseViewModel vm) => vm.isLoading);

    return ElevatedButton(
      //TODO add save functionality
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: AppColors.saveButtonColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 8.0.w),
        child: isLoading
            ? const CircularProgressIndicator(
                backgroundColor: AppColors.darkPrimaryColor,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).save.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.sp,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  const Icon(Icons.check, color: Colors.white),
                ],
              ),
      ),
    );
  }
}

class _BodyWeight extends StatelessWidget {
  const _BodyWeight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedWeight =
        context.select((CardioExerciseViewModel vm) => vm.selectedWeight);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 24.0.h),
          child: Text(
            S.of(context).weight,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          width: 90,
          height: 80,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: _CircularBox(title: selectedWeight ?? ''),
        )
      ],
    );
  }
}

class _Minutes extends StatelessWidget {
  const _Minutes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =
        context.select((CardioExerciseViewModel vm) => vm.minutesController);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 24.0.h),
          child: Text(
            S.of(context).min,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          width: 90,
          height: 90,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, right: 20)),
              onChanged: (min) => context
                  .read<CardioExerciseViewModel>()
                  .onMinutesChangedAction(min),
            ),
          ),
        )
      ],
    );
  }
}
