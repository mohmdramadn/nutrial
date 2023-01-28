import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        _InfoTextField(controller: nameController, title: S.of(context).name),
        const SizedBox(height: 15),
        _InfoTextField(controller: idController, title: S.of(context).id),
        const SizedBox(height: 15),
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
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: InkWell(
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
                  left: 60,
                  right: 0,
                  bottom: 14,
                  child: SizedBox(
                    width: size.width * 0.2,
                    child: TextFormField(
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
                            width: size.width * 0.12,
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const Text(
                            ConstStrings.dots,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
      ),
    );
  }
}
