import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/on_boarding/on_board_view_model.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

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
    var nameController =
        context.select((OnBoardViewModel vm) => vm.nameController);
    var idController = context.select((OnBoardViewModel vm) => vm.idController);
    var emailController =
        context.select((OnBoardViewModel vm) => vm.emailController);

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(height: 65.h),
          Text(
            S.of(context).enterPersonalDetails,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              height: 1.7.h,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60.h),
         Padding(
           padding: EdgeInsets.only(bottom: _viewInsets.bottom),
           child: Column(
             children: [
               _InfoTextField(
                   controller: nameController, title: S.of(context).name),
               SizedBox(height: 15.h),
               _InfoTextField(controller: idController, title: S.of(context).id),
               SizedBox(height: 15.h),
               _InfoTextField(
                   controller: emailController, title: S.of(context).email),
             ],
           ),
         ),
        ],
      ),
    );
  }
}

class _InfoTextField extends StatefulWidget {
  const _InfoTextField({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;

  @override
  State<_InfoTextField> createState() => _InfoTextFieldState();
}

class _InfoTextFieldState extends State<_InfoTextField> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.0.w),
      child: InkWell(
        onTap: () => myFocusNode.requestFocus(),
        child: TextFormField(
          focusNode: myFocusNode,
          controller: widget.controller,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: AppColors.textFieldColor.withOpacity(0.4),
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            label: Text(widget.title),
          ),
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(19)
          ],
        ),
      ),
    );
  }
}
