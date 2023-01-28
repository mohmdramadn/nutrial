import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
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

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var musclesController =
        context.select((OnBoardViewModel vm) => vm.musclesController);
    var waterController =
        context.select((OnBoardViewModel vm) => vm.waterController);
    var fatController =
        context.select((OnBoardViewModel vm) => vm.fatsController);
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.11),
        Text(
          S.of(context).percentage,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        _BodyComponent(controller: musclesController, title: S.of(context).muscles),
        const SizedBox(height: 20),
        _BodyComponent(controller: waterController, title: S.of(context).water),
        const SizedBox(height: 20),
        _BodyComponent(controller: fatController, title: S.of(context).fats)


      ],
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.7,
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
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ()=> myFocusNode.requestFocus(),
      child: Container(
        width: size.width * 0.26,
        decoration: BoxDecoration(
          color: AppColors.textFieldColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: size.width * 0.11,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2)
                  ],
                ),
              ),
            ),
            Positioned(
              top: 21,
              left: 45,
              right: 5,
              bottom: 0,
              child: SizedBox(
                height: size.height * 0.1,
                child: const Text(
                  ConstStrings.percentageSign,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
