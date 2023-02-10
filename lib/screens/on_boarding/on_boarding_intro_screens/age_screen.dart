import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.11),
        Text(
          S.of(context).ageTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        const _AgeTextField()
      ],
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
            borderRadius: BorderRadius.all(Radius.circular(12)),
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
