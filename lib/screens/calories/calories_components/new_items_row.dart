import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewItemsRow extends StatelessWidget {
  const NewItemsRow({
    Key? key,
    required this.itemName,
    required this.showMenu,
    required this.onMenuTapped,
    required this.controller,
  }) : super(key: key);

  final String itemName;
  final bool showMenu;
  final Function() onMenuTapped;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          _Quantity(controller: controller),
          _ItemsButton(
            itemName: itemName,
            showMenu: showMenu,
            onMenuTapped: onMenuTapped,
          ),
          const _EstimatedCalories(),
        ],
      ),
    );
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w, top: 5.h, bottom: 5.h),
      child: SizedBox(
        width: 50.w,
        height: 50.h,
        child: TextFormField(
          enabled: false,
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
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemsButton extends StatelessWidget {
  const _ItemsButton({
    Key? key,
    required this.itemName,
    required this.showMenu,
    required this.onMenuTapped,
  }) : super(key: key);

  final String itemName;
  final bool showMenu;
  final Function() onMenuTapped;

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
        child: InkWell(
          onTap: onMenuTapped,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    itemName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 50.w),
                showMenu
                    ? const Icon(
                        Icons.arrow_drop_up_sharp,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.white,
                      ),
              ],
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
  }) : super(key: key);

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
        child: const Center(
          child: Text(
            '0',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
