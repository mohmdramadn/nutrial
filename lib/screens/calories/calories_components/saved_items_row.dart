import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedItemsRow extends StatelessWidget {
  const SavedItemsRow({
    Key? key,
    required this.itemName,
    required this.calories,
    required this.quantity,
    required this.onDelete,
  }) : super(key: key);

  final String itemName;
  final String? calories;
  final String? quantity;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          _Quantity(quantity: quantity ?? '0'),
          _ItemsButton(itemName: itemName),
          _EstimatedCalories(calories: calories),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
    );
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({
    Key? key,
    required this.quantity,
  }) : super(key: key);

  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w, top: 5.h, bottom: 5.h),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.3),
        ),
        child: Center(
          child: Text(
            quantity,
            style: const TextStyle(color: Colors.white),
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
