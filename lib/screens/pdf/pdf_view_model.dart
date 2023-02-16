import 'package:flutter/cupertino.dart';
import 'package:nutrial/models/calories_model.dart';
import 'package:nutrial/models/pdf_items_model.dart';

class PdfViewModel extends ChangeNotifier {
  var items = CaloriesDB().calories;
  List<ItemModel> itemsList = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  void createTableRowsInitAsync() {
    for (int index = 0; index < items.length; index++) {
      itemsList.add(
        ItemModel(
          itemName: items[index].itemName,
          itemCalories: items[index].itemCalories,
          itemQuantity: items[index].itemQuantity,
          totalCal: 0,
        ),
      );
    }
    setLoadingState(false);
    notifyListeners();
  }
}
