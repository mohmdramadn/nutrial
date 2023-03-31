import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/on_boarding/on_board_view_model.dart';
import 'package:provider/provider.dart';

class BodyPercentageScreen extends StatelessWidget {
  const BodyPercentageScreen({Key? key}) : super(key: key);

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
    var musclesController =
        context.select((OnBoardViewModel vm) => vm.musclesController);
    var waterController =
        context.select((OnBoardViewModel vm) => vm.waterController);
    var fatController =
        context.select((OnBoardViewModel vm) => vm.fatsController);

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.only(bottom: _viewInsets.bottom),
        child: Column(
          children: [
            SizedBox(height: 65.h),
            Text(
              S.of(context).percentage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                height: 1.7.h,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 53.h),
            _BodyComponent(
                controller: musclesController, title: S.of(context).muscles),
            SizedBox(height: 20.h),
            _BodyComponent(controller: waterController, title: S.of(context).water),
            SizedBox(height: 20.h),
            _BodyComponent(controller: fatController, title: S.of(context).fats)
          ],
        ),
      ),
    );
  }
}

class _BodyComponent extends StatelessWidget {
  const _BodyComponent({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              height: 1.7.h,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        _PercentageTextField(controller: controller),
      ],
    );
  }
}

class _PercentageTextField extends StatefulWidget {
  const _PercentageTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<_PercentageTextField> createState() => _PercentageTextFieldState();
}

class _PercentageTextFieldState extends State<_PercentageTextField> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => myFocusNode.requestFocus(),
      child: SizedBox(
        width: 85.w,
        child: TextFormField(
          focusNode: myFocusNode,
          controller: widget.controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
                borderSide: BorderSide.none
              ),
              filled: true,
              fillColor: AppColors.textFieldColor.withOpacity(0.4),
          ),
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2)
          ],
        ),
      ),
    );
  }
}
