import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/on_boarding/on_board_view_model.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key}) : super(key: key);

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
    var passwordController =
        context.select((OnBoardViewModel vm) => vm.passwordController);
    var confirmPassController =
        context.select((OnBoardViewModel vm) => vm.confirmPassController);

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.only(bottom: _viewInsets.bottom),
        child: Column(
          children: [
            SizedBox(height: 65.h),
            Text(
              S.of(context).setPasswordTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 65.h),
            _PasswordTextField(
              controller: passwordController,
              title: S.of(context).password,
            ),
            SizedBox(height: 15.h),
            _PasswordTextField(
              controller: confirmPassController,
              title: S.of(context).reEnter,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
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
    var showPassword = context.select((OnBoardViewModel vm) => vm.showPassword);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.0.w),
      child: InkWell(
        onTap: () => myFocusNode.requestFocus(),
        child: TextFormField(
          obscureText: showPassword ? true : false,
          focusNode: myFocusNode,
          controller: widget.controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: AppColors.textFieldColor.withOpacity(0.4),
            prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
            suffixIcon: InkWell(
              splashColor: Colors.transparent,
              onTap: () => context.read<OnBoardViewModel>().setShowPassState(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(19)
          ],
        ),
      ),
    );
  }
}
