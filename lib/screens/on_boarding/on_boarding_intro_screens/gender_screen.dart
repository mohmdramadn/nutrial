import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/on_boarding/on_board_view_model.dart';
import 'package:provider/provider.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 65.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            _Male(),
            SizedBox.square(),
            _Female(),
          ],
        ),
      ],
    );
  }
}

class _Male extends StatelessWidget {
  const _Male({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGender = context.select((OnBoardViewModel vm) => vm.gender);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.11),
        Text(
          S.of(context).male,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            height: 1.7.h,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        selectedGender == 1
            ? const _SelectedContainer()
            : const _UnselectedContainer(isMale: true),
      ],
    );
  }
}

class _Female extends StatelessWidget {
  const _Female({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGender = context.select((OnBoardViewModel vm) => vm.gender);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.11),
        Text(
          S.of(context).female,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            height: 1.7.h,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        selectedGender == 0
            ? const _SelectedContainer()
            : const _UnselectedContainer(isMale: false),
      ],
    );
  }
}

class _SelectedContainer extends StatelessWidget {
  const _SelectedContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: 65.w,
      decoration: BoxDecoration(
        color: AppColors.floatingButton,
        borderRadius: BorderRadius.circular(70),
      ),
    );
  }
}

class _UnselectedContainer extends StatelessWidget {
  const _UnselectedContainer({
    Key? key,
    required this.isMale,
  }) : super(key: key);
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isMale) {
          context.read<OnBoardViewModel>().setGender(1);
          return;
        }
        context.read<OnBoardViewModel>().setGender(0);
      },
      child: Container(
        height: 65.h,
        width: 65.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(70),
        ),
      ),
    );
  }
}
