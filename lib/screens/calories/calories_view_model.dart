import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutrial/extensions/date_time_extension.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/calories_model.dart';
import 'package:nutrial/models/pdf_items_model.dart';
import 'package:nutrial/models/cardio.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class CaloriesViewModel extends ChangeNotifier{
  final ConnectionService connectionService;
  final FirebaseService firebaseService;
  final MessageService messageService;
  final S localization;

  CaloriesViewModel({
    required this.connectionService,
    required this.firebaseService,
    required this.messageService,
    required this.localization,
  });

  var items = CaloriesDB().calories;
  List<Calories> itemsList = [];

  void createTableRowsInit() {
    for (int index = 0; index < items.length; index++) {
      itemsList.add(
        Calories(
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
  TextEditingController proteinGoalController = TextEditingController();
  TextEditingController carbsGoalController = TextEditingController();

  List<Calories> _proteinsSelectedItems = [];
  List<Calories> get proteinsSelectedItems => _proteinsSelectedItems;

  List<Calories> _carbsSelectedItems = [];
  List<Calories> get carbsSelectedItems => _carbsSelectedItems;

  Calories? _selectedProteinItem;
  Calories? get selectedProteinItem => _selectedProteinItem;

  Calories? _selectedCarbsItem;
  Calories? get selectedCarbsItem => _selectedCarbsItem;

  double totalProteinCalories = 0;
  double proteinGoalCalories = 100;
  double proteinProgressRatio = 0.0;

  void setProteinGoalValue(value){
    var newValue = double.tryParse(value);
    proteinGoalCalories = newValue ?? proteinGoalCalories;
    calculateProteinProgress();
    notifyListeners();
  }

  void setCarbsGoalValue(value){
    var newValue = double.tryParse(value);
    carbsGoalCalories = newValue ?? carbsGoalCalories;
    calculateCarbsProgress();
    notifyListeners();
  }

  double totalCarbsCalories = 0;
  double carbsGoalCalories = 1000;
  double carbsProgressRatio = 0.0;

  bool _isMetProteinGoal = false;
  bool get isMetProteinGoal => _isMetProteinGoal;

  bool _isMetCarbsGoal = false;
  bool get isMetCarbsGoal => _isMetCarbsGoal;

  int _waterBottlesCount = 0;
  int get waterBottlesCount => _waterBottlesCount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  final DateTime _todayDate = DateTime.now();
  String? get todayDate => _todayDate.dateOnly();

  final DateTime _yesterdayDate =
      DateTime.now().subtract(const Duration(days: 1));
  String? get yesterdayDate => _yesterdayDate.dateOnly();

  Map<DateTime, List<QuerySnapshot>>? _cardioResponse = {};

  List<CardioActivity>? _cardio = [];
  List<CardioActivity>? get cardio => _cardio;

  List<CardioActivity> todayActivity = [];
  List<CardioActivity> yesterdayActivity = [];

  bool _isTodaySelected = true;
  bool get isTodaySelected => _isTodaySelected;
  void setTodaySelectedState(){
    _isTodaySelected = !_isTodaySelected;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  bool _isEditProteinGoal = false;
  bool get isEditProteinGoal => _isEditProteinGoal;
  void setEditProteinGoalState(){
    _isEditProteinGoal = !_isEditProteinGoal;
    if (!isEditProteinGoal && _calculatedProteinCalories != null) {
      setProteinGoalValue(proteinGoalController.text);
    }
    notifyListeners();
  }

  bool _isEditCarbsGoal = false;
  bool get isEditCarbsGoal => _isEditCarbsGoal;
  void setEditCarbsGoalState(){
    _isEditCarbsGoal = !_isEditCarbsGoal;
    if (_isEditCarbsGoal) setCarbsGoalValue(carbsGoalController.text);
    notifyListeners();
  }

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

  void onSubmitProteinButtonAction(){
    if(_selectedProteinItem == null || proteinQtyController.text == ''){
      return;
    }
    _addProteinItemAction(_selectedProteinItem);
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

  void onSubmitCarbsButtonAction(){
    if(_selectedCarbsItem == null || carbsQtyController.text == ''){
      return;
    }
    _addCarbsItemAction(_selectedCarbsItem);
    setSelectedCarbsItemState();
    _resetCarbsValues();
    notifyListeners();
  }

  void _resetProteinValues() {
    _selectedProteinItem = null;
    _calculatedProteinCalories = '0';
    proteinQtyController.text = '';
    notifyListeners();
  }

  void _resetCarbsValues() {
    _selectedCarbsItem = null;
    _calculatedCarbsCalories = '0';
    carbsQtyController.text = '';
  }

  void setSelectedProteinItem({required Calories item}) {
    _selectedProteinItem = item;
    setSelectedProteinItemState();
    setNewProteinItemState();
    setProteinMenuState();
    notifyListeners();
  }

  void setSelectedCarbsItem({required Calories item}) {
    _selectedCarbsItem = item;
    setSelectedCarbsItemState();
    setNewCarbsItemState();
    setCarbsMenuState();
    notifyListeners();
  }

  void _addProteinItemAction(Calories? item) {
    item!.itemQuantity = proteinQtyController.text;
    item.totalCal = double.tryParse(_calculatedProteinCalories!);
    _proteinsSelectedItems.add(item);
    calculateProteinProgress();
    notifyListeners();
  }

  void _addCarbsItemAction(Calories? item) {
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
    if (_proteinsSelectedItems.length == 0) {
      totalProteinCalories = 0;
      proteinProgressRatio = ((totalProteinCalories * 1.0) / proteinGoalCalories);
      _isMetProteinGoal = (proteinGoalCalories - 50) <= totalProteinCalories &&
          totalProteinCalories <= (proteinGoalCalories + 50);
      notifyListeners();
      return;
    }
    totalProteinCalories += num.tryParse(_calculatedProteinCalories!)!;
    proteinProgressRatio = ((totalProteinCalories * 1.0) / proteinGoalCalories);
    _isMetProteinGoal = (proteinGoalCalories - 50) <= totalProteinCalories &&
        totalProteinCalories <= (proteinGoalCalories + 50);
    totalProteinCalories = totalProteinCalories.roundToDouble();
    notifyListeners();
  }

  void calculateCarbsProgress() {
    if (_carbsSelectedItems.length == 0) {
      totalCarbsCalories = 0;
      carbsProgressRatio = ((totalCarbsCalories * 1.0) / carbsGoalCalories);
      _isMetCarbsGoal = (carbsGoalCalories - 50) <= totalCarbsCalories &&
          totalCarbsCalories <= (carbsGoalCalories + 50);
      notifyListeners();
      return;
    }
    totalCarbsCalories += num.tryParse(_calculatedCarbsCalories!)!;
    carbsProgressRatio = ((totalCarbsCalories * 1.0) / carbsGoalCalories);
    _isMetCarbsGoal = (carbsGoalCalories - 50) <= totalCarbsCalories &&
        totalCarbsCalories <= (carbsGoalCalories + 50);
    totalCarbsCalories = totalCarbsCalories.roundToDouble();
    notifyListeners();
  }

  void onDeleteProteinItemSelectedAction({required Calories item}){
    _proteinsSelectedItems.remove(item);
    calculateProteinProgress();
    notifyListeners();
  }

  void onDeleteCarbItemSelectedAction({required Calories item}){
    _carbsSelectedItems.remove(item);
    calculateCarbsProgress();
    notifyListeners();
  }

  Future<void> getCardioAsync()async{
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      setLoadingState(false);
      notifyListeners();
    }
    var response = await firebaseService.getUserCardio();

    if (response.isError) {
      messageService.showErrorSnackBar('', localization.error);
      setLoadingState(false);
      notifyListeners();
      return;
    }

    _cardioResponse = response.asValue!.value;
    todayCardio();
    yesterdayCardio();
    setLoadingState(false);
  }


  bool _isCardioLoading = false;
  bool get isCardioLoading => _isCardioLoading;
  void setCardioLoadingState(value){
    _isCardioLoading = value;
    notifyListeners();
  }

  void yesterdayCardio() {
    var yesterdayCardio = _cardioResponse!.entries
        .firstWhereOrNull((element) => element.key.day == _yesterdayDate.day);
    if(yesterdayCardio == null) return;
    for (var element in yesterdayCardio.value) {
      for (var activity in element.docs) {
        var cardio =
        CardioActivity.fromJson(activity.data() as Map<String, dynamic>);
        yesterdayActivity.add(cardio);
      }
    }
  }

  void todayCardio() {
    var todayCardio = _cardioResponse!.entries
        .firstWhereOrNull((element) => element.key.day == _todayDate.day);
    if(todayCardio == null) return;
    for (var element in todayCardio.value) {
      for (var activity in element.docs) {
        var cardio =
            CardioActivity.fromJson(activity.data() as Map<String, dynamic>);
        todayActivity.add(cardio);
      }
    }
  }

  Future<void> saveCaloriesActionAsync()async{
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      setLoadingState(false);
      notifyListeners();
    }
    if (_proteinsSelectedItems.isEmpty && _carbsSelectedItems.isEmpty) {
      Fluttertoast.showToast(
          msg: "No calories added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      setLoadingState(false);
      return;
    }
    var response = await firebaseService.saveCaloriesAsync(
      proteinItems: _proteinsSelectedItems,
      carbsItems: _carbsSelectedItems,
    );

    if (response.isError) {
      messageService.showErrorSnackBar('', localization.error);
      setLoadingState(false);
      notifyListeners();
      return;
    }

    Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    setLoadingState(false);
  }
}