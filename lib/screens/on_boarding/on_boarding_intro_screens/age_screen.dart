import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/on_boarding/on_board_view_model.dart';
import 'package:provider/provider.dart';

class AgeScreen extends StatelessWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Body();
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late ScrollController scrollController;

  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;
  late double initViewInsets;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    window = WidgetsBinding.instance.window;
    initViewInsets = window?.viewInsets.bottom ?? 0;

    window?.onMetricsChanged = () {
      if (!mounted) return;
      setState(() {
        final window = this.window;
        if (window != null) {
          _viewInsets = EdgeInsets.fromWindowPadding(
            window.viewInsets,
            window.devicePixelRatio,
          ).add(EdgeInsets.fromWindowPadding(
            window.padding,
            window.devicePixelRatio,
          )) as EdgeInsets;

          if (initViewInsets == window.viewInsets.bottom) return;

          Future.delayed(const Duration(milliseconds: 90)).then((value) {
            if (!mounted) return;
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.only(bottom: _viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90.h),
            Text(
              S.of(context).ageTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                height: 1.7.h,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            const _AgeTextField()
          ],
        ),
      ),
    );
  }
}

class _AgeTextField extends StatelessWidget {
  const _AgeTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.select((OnBoardViewModel vm) => vm.ageController);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.6,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(19)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.textFieldColor.withOpacity(0.4),
        ),
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2)
        ],
      ),
    );
  }
}
