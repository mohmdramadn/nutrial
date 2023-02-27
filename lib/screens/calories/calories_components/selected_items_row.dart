import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedItemRow extends StatelessWidget {
  const SelectedItemRow({
    Key? key,
    required this.itemName,
    required this.calories,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
  }) : super(key: key);

  final String itemName;
  final String? calories;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          _Quantity(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
          _ItemsButton(itemName: itemName),
          _EstimatedCalories(calories: calories),
        ],
      ),
    );
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onSubmitted;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w, top: 5.h, bottom: 5.h),
      child: SizedBox(
        width: 50.w,
        height: 50.h,
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: onSubmitted,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3)
          ],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: '0',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _ItemsButton extends StatelessWidget {
  const _ItemsButton({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50.h,
        width: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Text(
              itemName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _EstimatedCalories extends StatelessWidget {
  const _EstimatedCalories({
    Key? key,
    required this.calories,
  }) : super(key: key);

  final String? calories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0.w),
      child: Container(
        height: 50.h,
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.3),
        ),
        child: Center(
          child: Text(
            calories ?? '0',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
