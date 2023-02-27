import 'package:flutter/cupertino.dart';
import 'package:nutrial/extensions/date_time_extension.dart';
import 'package:nutrial/models/calories_model.dart';
import 'package:nutrial/models/pdf_items_model.dart';

class CaloriesViewModel extends ChangeNotifier{
  var items = CaloriesDB().calories;
  List<ItemModel> itemsList = [];

  void createTableRowsInit() {
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
    notifyListeners();
  }

  bool _showProteinMenu = false;
  bool get showProteinMenu => _showProteinMenu;
  void setProteinMenuState(){
    _showProteinMenu = !_showProteinMenu;
    notifyListeners();
  }

  bool _showCarbsMenu = false;
  bool get showCarbsMenu => _showCarbsMenu;
  void setCarbsMenuState(){
    _showCarbsMenu = !_showCarbsMenu;
    notifyListeners();
  }

  bool _showNewProteinItem = false;
  bool get showNewProteinItem => _showNewProteinItem;
  void setNewProteinItemState(){
    _showNewProteinItem = !_showNewProteinItem;
    notifyListeners();
  }

  bool _showNewCarbsItem = false;
  bool get showNewCarbsItem => _showNewCarbsItem;
  void setNewCarbsItemState(){
    _showNewCarbsItem = !_showNewCarbsItem;
    notifyListeners();
  }

  bool _showSelectedProteinItem = false;
  bool get showSelectedIProteinItem => _showSelectedProteinItem;
  void setSelectedProteinItemState(){
    _showSelectedProteinItem = !_showSelectedProteinItem;
    notifyListeners();
  }

  bool _showSelectedCarbsItem = false;
  bool get showSelectedCarbsItem => _showSelectedCarbsItem;
  void setSelectedCarbsItemState(){
    _showSelectedCarbsItem = !_showSelectedCarbsItem;
    notifyListeners();
  }

  String? _calculatedProteinCalories;
  String? get calculatedProteinCalories => _calculatedProteinCalories;

  String? _calculatedCarbsCalories;
  String? get calculatedCarbsCalories => _calculatedCarbsCalories;

  TextEditingController proteinQtyController = TextEditingController();
  TextEditingController carbsQtyController = TextEditingController();

  List<ItemModel> _proteinsSelectedItems = [];
  List<ItemModel> get proteinsSelectedItems => _proteinsSelectedItems;

  List<ItemModel> _carbsSelectedItems = [];
  List<ItemModel> get carbsSelectedItems => _carbsSelectedItems;

  ItemModel? _selectedProteinItem;
  ItemModel? get selectedProteinItem => _selectedProteinItem;

  ItemModel? _selectedCarbsItem;
  ItemModel? get selectedCarbsItem => _selectedCarbsItem;

  double totalProteinCalories = 0;
  double proteinGoalCalories = 100;
  double proteinProgressRatio = 0.0;

  double totalCarbsCalories = 0;
  double carbsGoalCalories = 1000;
  double carbsProgressRatio = 0.0;

  bool _isMetProteinGoal = false;
  bool get isMetProteinGoal => _isMetProteinGoal;

  bool _isMetCarbsGoal = false;
  bool get isMetCarbsGoal => _isMetCarbsGoal;

  int _waterBottlesCount = 0;
  int get waterBottlesCount => _waterBottlesCount;


  String? get todayDate => DateTime.now().dateOnly();

  String? get yesterdayDate =>
      DateTime.now().subtract(const Duration(days: 1)).dateOnly();

  bool _isTodaySelected = false;
  bool get isTodaySelected => _isTodaySelected;
  void setTodaySelectedState(){
    _isTodaySelected = !_isTodaySelected;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  void onAddProteinButtonAction(){
    if(_selectedProteinItem == null){
      setNewProteinItemState();
      notifyListeners();
      return;
    }
    _addProteinItemAction(_selectedProteinItem);
    setNewProteinItemState();
    setSelectedProteinItemState();
    _resetProteinValues();
    notifyListeners();
  }

  void onAddCarbsButtonAction(){
    if(_selectedCarbsItem == null){
      setNewCarbsItemState();
      notifyListeners();
      return;
    }
    _addCarbsItemAction(_selectedCarbsItem);
    setNewCarbsItemState();
    setSelectedCarbsItemState();
    _resetCarbsValues();
    notifyListeners();
  }

  void _resetProteinValues() {
    _selectedProteinItem = null;
    _calculatedProteinCalories = '0';
    proteinQtyController.text = '';
  }

  void _resetCarbsValues() {
    _selectedCarbsItem = null;
    _calculatedCarbsCalories = '0';
    carbsQtyController.text = '';
  }

  void setSelectedProteinItem({required ItemModel item}) {
    _selectedProteinItem = item;
    setSelectedProteinItemState();
    setNewProteinItemState();
    setProteinMenuState();
    notifyListeners();
  }

  void setSelectedCarbsItem({required ItemModel item}) {
    _selectedCarbsItem = item;
    setSelectedCarbsItemState();
    setNewCarbsItemState();
    setCarbsMenuState();
    notifyListeners();
  }

  void _addProteinItemAction(ItemModel? item) {
    item!.itemQuantity = proteinQtyController.text;
    item.totalCal = double.tryParse(_calculatedProteinCalories!);
    _proteinsSelectedItems.add(item);
    calculateProteinProgress();
    notifyListeners();
  }

  void _addCarbsItemAction(ItemModel? item) {
    item!.itemQuantity = carbsQtyController.text;
    item.totalCal = double.tryParse(_calculatedCarbsCalories!);
    _carbsSelectedItems.add(item);
    calculateCarbsProgress();
    notifyListeners();
  }

  void onProteinQuantityAddedAction() {
    var numberOfPieces = int.tryParse(proteinQtyController.text) ?? 0;
    var weightNumbers = _selectedProteinItem!.itemQuantity!.replaceAll(
        RegExp(r'[^0-9]'), '');
    var itemWeight = int.tryParse(weightNumbers);
    var calories = itemWeight != null
        ? (numberOfPieces * _selectedProteinItem!.itemCalories!) / itemWeight
        : numberOfPieces * _selectedProteinItem!.itemCalories!;
    _calculatedProteinCalories = calories.toString();
    notifyListeners();
  }

  void onCarbsQuantityAddedAction() {
    var numberOfPieces = int.tryParse(carbsQtyController.text) ?? 0;
    var weightNumbers =
        _selectedCarbsItem!.itemQuantity!.replaceAll(RegExp(r'[^0-9]'), '');
    var itemWeight = int.tryParse(weightNumbers);
    var calories = itemWeight != null
        ? (numberOfPieces * _selectedCarbsItem!.itemCalories!) / itemWeight
        : numberOfPieces * _selectedCarbsItem!.itemCalories!;
    _calculatedCarbsCalories = calories.toString();
    notifyListeners();
  }

  void addWaterBottleAction() {
    if(_waterBottlesCount != 0)_scrollToTheEndAction();
    _waterBottlesCount++;
    notifyListeners();
  }

  void _scrollToTheEndAction() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceOut,
    );
  }

  void calculateProteinProgress() {
    totalProteinCalories += num.tryParse(_calculatedProteinCalories!)!;
    proteinProgressRatio = ((totalProteinCalories * 1.0) / proteinGoalCalories);
    _isMetProteinGoal = (proteinGoalCalories - 50) <= totalProteinCalories &&
        totalProteinCalories <= (proteinGoalCalories + 50);
    totalProteinCalories = totalProteinCalories.roundToDouble();
    notifyListeners();
  }

  void calculateCarbsProgress() {
    totalCarbsCalories += num.tryParse(_calculatedCarbsCalories!)!;
    carbsProgressRatio = ((totalCarbsCalories * 1.0) / carbsGoalCalories);
    _isMetCarbsGoal = (carbsGoalCalories - 50) <= totalCarbsCalories &&
        totalCarbsCalories <= (carbsGoalCalories + 50);
    totalCarbsCalories = totalCarbsCalories.roundToDouble();
    notifyListeners();
  }
}