import 'package:flutter/cupertino.dart';

class ItemModel {
  String? itemName;
  int? itemCalories;
  String? itemQuantity;
  TextEditingController? itemQty;
  bool? isEnableEditing;
  String? itemQtyNum;
  int? totalCal;

  ItemModel({
    this.itemName,
    this.itemCalories,
    this.itemQty,
    this.isEnableEditing,
    this.totalCal,
    this.itemQtyNum,
    this.itemQuantity,
  });
}
