import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
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

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController =
    context.select((OnBoardViewModel vm) => vm.passwordController);
    var confirmPassController = context.select((OnBoardViewModel vm) => vm.confirmPassController);
    var showPassword = context.select((OnBoardViewModel vm) => vm.showPassword);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.1),
        Text(
          S.of(context).setPasswordTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.h),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 60.0.w),
              child: _InfoTextField(
                controller: passwordController,
                title: S.of(context).password,
              ),
            ),
            InkWell(
              onTap: ()=> context.read<OnBoardViewModel>().setShowPassState(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 60.0.w),
              child: _InfoTextField(
                controller: confirmPassController,
                title: S.of(context).reEnter,
              ),
            ),
            InkWell(
              onTap: ()=> context.read<OnBoardViewModel>().setShowPassState(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
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
    var showPassword = context.select((OnBoardViewModel vm) => vm.showPassword);
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => myFocusNode.requestFocus(),
      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          color: AppColors.textFieldColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () => myFocusNode.requestFocus(),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 80,
                right: 0,
                bottom: 14,
                child: SizedBox(
                  width: size.width * 0.1,
                  child: TextFormField(
                    obscureText: showPassword ? true : false,
                    focusNode: myFocusNode,
                    controller: widget.controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
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
              ),
              Positioned(
                top: 0,
                left: 10,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: size.height * 0.1,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.18,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const Text(
                          ConstStrings.dots,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
