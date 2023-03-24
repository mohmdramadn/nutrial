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

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController =
        context.select((OnBoardViewModel vm) => vm.nameController);
    var idController = context.select((OnBoardViewModel vm) => vm.idController);
    var emailController =
        context.select((OnBoardViewModel vm) => vm.emailController);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.1),
        Text(
          S.of(context).enterPersonalDetails,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            height: 1.7.h,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
         SizedBox(height: 30.h),
        _InfoTextField(controller: nameController, title: S.of(context).name),
         SizedBox(height: 15.h),
        _InfoTextField(controller: idController, title: S.of(context).id),
         SizedBox(height: 15.h),
        _InfoTextField(controller: emailController, title: S.of(context).email),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
      child: InkWell(
        onTap: () => myFocusNode.requestFocus(),
        child: TextFormField(
          focusNode: myFocusNode,
          controller: widget.controller,
          style: TextStyle(color: Colors.white,fontSize: 12.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 12.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[500]),
              hintText: widget.title,
              fillColor: AppColors.textFieldColor.withOpacity(0.4),
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
