import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nutrial/components/progress_bar.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/pdf_items_model.dart';
import 'package:nutrial/screens/calories/calories_components/new_items_row.dart';
import 'package:nutrial/screens/calories/calories_components/saved_items_row.dart';
import 'package:nutrial/screens/calories/calories_components/selected_items_row.dart';
import 'package:nutrial/screens/calories/calories_view_model.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';

class CaloriesScreen extends StatelessWidget {
  const CaloriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CaloriesViewModel>(
        create: (_) => CaloriesViewModel(
              connectionService: context.read<ConnectionService>(),
              firebaseService: context.read<FirebaseService>(),
              messageService: context.read<MessageService>(),
              localization: S.of(context),
            ),
        child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late ScrollController scrollController;

  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;
  late double initViewInsets;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CaloriesViewModel>().getCaloriesFromJson();
      context.read<CaloriesViewModel>().getCardioAsync();
      context.read<CaloriesViewModel>().getCaloriesAsync();
    });

    scrollController = ScrollController();

    window = WidgetsBinding.instance.window;
    initViewInsets = window?.viewInsets.bottom ?? 0;

    window?.onMetricsChanged = () {
      if (!mounted) return;
      setState(() {
        final window = this.window;
        if (window != null) {
          _viewInsets = EdgeInsets.fromWindowPadding(
            window.viewInsets,
            window.devicePixelRatio,
          ).add(EdgeInsets.fromWindowPadding(
            window.padding,
            window.devicePixelRatio,
          )) as EdgeInsets;

          if (initViewInsets == window.viewInsets.bottom) return;

          Future.delayed(const Duration(milliseconds: 90)).then((value) {
            if (!mounted) return;
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var showProteinMenu =
        context.select((CaloriesViewModel vm) => vm.showProteinMenu);
    var vm = context.watch<CaloriesViewModel>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor.withOpacity(0.9),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(bottom: _viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _Header(),
                Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30.h),
                        const _ProteinCategory(),
                        _ProgressIndicator(
                          progressRatio: vm.proteinProgressRatio,
                          condition: vm.isMetProteinGoal,
                        ),
                        const _HeaderCategory(isProtein: true),
                        const _ProteinItem(),
                        if (showProteinMenu) const _Items(isProtein: true),
                        SizedBox(height: 50.h),
                        const _CarbsFatsCategory(),
                        _ProgressIndicator(
                          progressRatio: vm.carbsProgressRatio,
                          condition: vm.isMetCarbsGoal,
                        ),
                        const _HeaderCategory(isProtein: false),
                        const _CarbsItem(),
                        const _CardioHeader(),
                        const _CardioActivityList(),
                        const _WaterHeader(),
                        if (vm.waterBottlesCount != 0) const _WaterBottles(),
                        SizedBox(height: 20.h),
                        const _SaveButton()
                      ],
                    ),
                    vm.isLoading
                        ? Positioned(
                            top: 100.h,
                            left: 150.w,
                            right: 150.w,
                            bottom: 100.h,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CarbsItem extends StatelessWidget {
  const _CarbsItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (vm.showNewCarbsItem) const _NewCarbsItem(),
        if (vm.showSelectedCarbsItem) const _SelectedCarbsItems(),
        if (vm.showCarbsMenu) const _Items(isProtein: false),
        if (!vm.isLoading && vm.carbsSelectedItems.isNotEmpty)
          const _SavedCarbsItems(),
      ],
    );
  }
}

class _SavedCarbsItems extends StatelessWidget {
  const _SavedCarbsItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return _SavedItems(
      itemsList: vm.carbsSelectedItems,
      isProtein: false,
    );
  }
}

class _NewCarbsItem extends StatelessWidget {
  const _NewCarbsItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return NewItemsRow(
      itemName: S.of(context).chooseItem,
      showMenu: vm.showCarbsMenu,
      onMenuTapped: () => context.read<CaloriesViewModel>().setCarbsMenuState(),
      controller: vm.carbsQtyController,
    );
  }
}

class _ProteinItem extends StatelessWidget {
  const _ProteinItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (vm.showNewProteinItem) const _NewProteinItem(),
        if (vm.showSelectedIProteinItem) const _SelectedProteinItem(),
        if (!vm.isLoading && vm.proteinsSelectedItems.isNotEmpty)
          const _SavedProteinItem(),
      ],
    );
  }
}

class _SavedProteinItem extends StatelessWidget {
  const _SavedProteinItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return _SavedItems(
      itemsList: vm.proteinsSelectedItems,
      isProtein: true,
    );
  }
}

class _NewProteinItem extends StatelessWidget {
  const _NewProteinItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return NewItemsRow(
      itemName: S.of(context).chooseItem,
      showMenu: vm.showProteinMenu,
      onMenuTapped: () =>
          context.read<CaloriesViewModel>().setProteinMenuState(),
      controller: vm.proteinQtyController,
    );
  }
}

class _SelectedCarbsItems extends StatelessWidget {
  const _SelectedCarbsItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return SelectedItem(
      itemName: vm.selectedCarbsItem!.itemName!,
      calories: vm.calculatedCarbsCalories,
      controller: vm.carbsQtyController,
      onChanged: (value) =>
          context.read<CaloriesViewModel>().onCarbsQuantityAddedAction(),
      onSubmitted: (value) =>
          context.read<CaloriesViewModel>().onSubmitCarbsButtonAction(),
    );
  }
}

class _SelectedProteinItem extends StatelessWidget {
  const _SelectedProteinItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return SelectedItem(
      itemName: vm.selectedProteinItem!.itemName!,
      calories: vm.calculatedProteinCalories,
      controller: vm.proteinQtyController,
      onChanged: (value) =>
          context.read<CaloriesViewModel>().onProteinQuantityAddedAction(),
      onSubmitted: (value) =>
          context.read<CaloriesViewModel>().onSubmitProteinButtonAction(),
    );
  }
}

class _CarbsFatsCategory extends StatelessWidget {
  const _CarbsFatsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return _Category(
      imgName: 'fats',
      isHasNumbers: true,
      caloriesRate: vm.carbsGoalCalories.roundToDouble().toString(),
      consumedCalories: vm.totalCarbsCalories.toString(),
      controller: vm.carbsGoalController,
      initGoalValue: vm.carbsGoalCalories.toString(),
      isEditGoal: vm.isEditCarbsGoal,
      onTap: () => context.read<CaloriesViewModel>().setEditCarbsGoalState(),
      onSubmitted: (value) =>
          context.read<CaloriesViewModel>().setCarbsGoalValue(value),
    );
  }
}

class _ProteinCategory extends StatelessWidget {
  const _ProteinCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return _Category(
      imgName: 'protiens',
      isHasNumbers: true,
      caloriesRate: vm.proteinGoalCalories.roundToDouble().toString(),
      consumedCalories: vm.totalProteinCalories.toString(),
      controller: vm.proteinGoalController,
      initGoalValue: vm.proteinGoalCalories.toString(),
      isEditGoal: vm.isEditProteinGoal,
      onTap: () => context.read<CaloriesViewModel>().setEditProteinGoalState(),
      onSubmitted: (value) =>
          context.read<CaloriesViewModel>().setProteinGoalValue(value),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    Key? key,
    required this.progressRatio,
    required this.condition,
  }) : super(key: key);

  final double progressRatio;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicatorApp(
      consumedCaloriesPercentage: progressRatio,
      color: condition
          ? const AlwaysStoppedAnimation<Color>(AppColors.floatingButton)
          : AlwaysStoppedAnimation<Color>(Colors.red.shade300),
    );
  }
}

class _CardioActivityList extends StatelessWidget {
  const _CardioActivityList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();
    var cardioList =
        vm.isTodaySelected ? vm.todayActivity : vm.yesterdayActivity;

    return Flexible(
      child: Column(
        children: [
          if (cardioList.isNotEmpty)
            for (int i = 0; i <= cardioList.length - 1; i++)
              Column(
                children: [
                  _CardioActivity(
                    activityName: cardioList[i].activity,
                    caloriesBurned: cardioList[i].calories,
                  ),
                  SizedBox(height: 10.h),
                ],
              )
        ],
      ),
    );
  }
}

class _CardioActivity extends StatelessWidget {
  const _CardioActivity({
    Key? key,
    required this.activityName,
    required this.caloriesBurned,
  }) : super(key: key);

  final String activityName;
  final String caloriesBurned;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.black.withOpacity(0.23)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                activityName,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                '$caloriesBurned CAL',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardioHeader extends StatelessWidget {
  const _CardioHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: _Category(
                imgName: 'cardio',
                isHasNumbers: false,
              ),
            ),
            InkWell(
              onTap: () =>
                  context.read<CaloriesViewModel>().navigateToCardioScreen(),
              child: Image.asset('assets/icons/add.png'),
            )
          ],
        ),
      ),
    );
  }
}

class _WaterBottles extends StatelessWidget {
  const _WaterBottles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();
    var waterBottlesCount =
        context.select((CaloriesViewModel vm) => vm.waterBottlesCount);

    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 8.h),
        child: Container(
          height: waterBottlesCount > 3 ? 300.h : 170.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.primaryLightColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(20.0),
          child: Scrollbar(
            child: GridView.builder(
              controller: vm.scrollController,
              itemCount: waterBottlesCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/water_bottle.png',
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/waterbottleSel.png',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WaterHeader extends StatelessWidget {
  const _WaterHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: _Category(
              imgName: 'water',
              isHasNumbers: false,
            ),
          ),
          InkWell(
            onTap: () =>
                context.read<CaloriesViewModel>().onAddWaterBottleAction(),
            child: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Text(
              vm.waterBottlesCount.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          InkWell(
            onTap: () =>
                context.read<CaloriesViewModel>().onSubtractWaterBottleAction(),
            child: Icon(
              Icons.remove_circle,
              color: Colors.white,
              size: 30.sp,
            ),
          )
        ],
      ),
    );
  }
}

class _SavedItems extends StatelessWidget {
  const _SavedItems({
    Key? key,
    required this.itemsList,
    required this.isProtein,
  }) : super(key: key);

  final List<CaloriesModel> itemsList;
  final bool isProtein;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          for (int i = 0; i <= itemsList.length - 1; i++)
            SavedItemsRow(
              quantity: itemsList[i].itemQuantity,
              itemName: itemsList[i].itemName!,
              calories: itemsList[i].totalCal!.toString(),
              onDelete: isProtein
                  ? () => context
                      .read<CaloriesViewModel>()
                      .onDeleteProteinItemSelectedAction(item: itemsList[i])
                  : () => context
                      .read<CaloriesViewModel>()
                      .onDeleteCarbItemSelectedAction(item: itemsList[i]),
            ),
        ],
      ),
    );
  }
}

class _Items extends StatelessWidget {
  const _Items({Key? key, required this.isProtein}) : super(key: key);

  final bool isProtein;

  @override
  Widget build(BuildContext context) {
    var protein = context.select((CaloriesViewModel vm) => vm.proteinCalories);
    var carbsFats = context.select((CaloriesViewModel vm) => vm.carbsCalories);

    return Padding(
      padding: EdgeInsets.only(left: 80.w, right: 105.w),
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.grey.withOpacity(0.5)),
        child: ListView.separated(
          itemCount: isProtein
              ? protein.isEmpty
                  ? protein.length
                  : protein.length - 1
              : carbsFats.isEmpty
                  ? carbsFats.length
                  : carbsFats.length - 1,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: isProtein
                  ? () => context
                      .read<CaloriesViewModel>()
                      .setSelectedProteinItem(food: protein[index])
                  : () => context
                      .read<CaloriesViewModel>()
                      .setSelectedCarbsItem(food: carbsFats[index]),
              child: Text(
                isProtein
                    ? '${index + 1}. ${protein[index].foodType}'
                    : '${index + 1}. ${carbsFats[index].foodType}',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            );
          },
          separatorBuilder: (_, context) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
              child: const DottedLine(
                dashColor: Colors.white,
                dashRadius: 50.0,
                lineThickness: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.h,
          width: MediaQuery.of(context).size.width,
          color: AppColors.orangeColor,
          child: Padding(
            padding: EdgeInsets.only(top: 24.0.h),
            child: Row(
              children: [
                SizedBox(width: 40.w),
                Text(
                  S.of(context).calories.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 22.sp, letterSpacing: 4.5),
                ),
                SizedBox(width: 100.w),
                Padding(
                  padding: EdgeInsets.only(right: 5.0.w),
                  child: Image.asset(
                    'assets/images/logo_n.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
        ),
        const _Date(),
      ],
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todayDate = context.select((CaloriesViewModel vm) => vm.todayDate);
    var yesterdayDate =
        context.select((CaloriesViewModel vm) => vm.yesterdayDate);
    var isTodaySelected =
        context.select((CaloriesViewModel vm) => vm.isTodaySelected);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: isTodaySelected ? 2 : 3,
          child: InkWell(
            onTap: () =>
                context.read<CaloriesViewModel>().setTodaySelectedState(),
            child: Container(
              height: 45.h,
              color: isTodaySelected
                  ? AppColors.primaryLightColor3
                  : AppColors.primaryDarkColor,
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
                  child: Text(
                    isTodaySelected ? yesterdayDate! : 'Yesterday',
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 1.9),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: isTodaySelected ? 3 : 2,
          child: InkWell(
            onTap: () =>
                context.read<CaloriesViewModel>().setTodaySelectedState(),
            child: Container(
              height: 45.h,
              color: isTodaySelected
                  ? AppColors.primaryDarkColor
                  : AppColors.primaryLightColor3,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  isTodaySelected ? S.of(context).today : todayDate!,
                  style:
                      const TextStyle(color: Colors.white, letterSpacing: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({Key? key, required this.isProtein}) : super(key: key);

  final bool isProtein;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: isProtein
            ? () => context.read<CaloriesViewModel>().onAddProteinButtonAction()
            : () => context.read<CaloriesViewModel>().onAddCarbsButtonAction(),
        child: Image.asset('assets/icons/add.png'));
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<CaloriesViewModel>();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => context.read<CaloriesViewModel>().saveCaloriesActionAsync(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          vm.showSaveProgress
              ? vm.showErrorSaving
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 26.0.h),
                      child: Lottie.asset(
                        width: 70.w,
                        height: 50.h,
                        "assets/lottie/error.json",
                        fit: BoxFit.contain,
                      ))
                  : Padding(
                      padding: EdgeInsets.only(bottom: 26.0.h),
                      child: Lottie.asset(
                        width: 70.w,
                        height: 50.h,
                        "assets/lottie/save.json",
                        fit: BoxFit.contain,
                      ),
                    )
              : Container(
                  width: size.width * 0.23,
                  height: size.height * 0.065,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE59D80),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      S.of(context).save.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    Key? key,
    required this.imgName,
    required this.isHasNumbers,
    this.controller,
    this.caloriesRate,
    this.consumedCalories,
    this.initGoalValue,
    this.onSubmitted,
    this.onTap,
    this.isEditGoal = false,
  }) : super(key: key);

  final String imgName;
  final bool isHasNumbers;
  final String? consumedCalories;
  final String? caloriesRate;
  final TextEditingController? controller;
  final String? initGoalValue;
  final bool isEditGoal;
  final Function(String)? onSubmitted;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    controller?.text = initGoalValue ?? "";
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Image.asset('assets/images/$imgName.png'),
          ),
          Row(
            children: [
              if (isHasNumbers && !isEditGoal)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$consumedCalories / $caloriesRate',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              SizedBox(width: 15.w),
              if (isHasNumbers && isEditGoal)
                _GoalTextField(
                    controller: controller, onSubmitted: onSubmitted!),
              if (isHasNumbers)
                InkWell(
                  onTap: onTap,
                  child: Icon(
                    isEditGoal ? Icons.close : Icons.edit,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalTextField extends StatelessWidget {
  const _GoalTextField({
    Key? key,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 100.w,
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'set goal',
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
    );
  }
}

class _HeaderCategory extends StatelessWidget {
  const _HeaderCategory({Key? key, required this.isProtein}) : super(key: key);

  final bool isProtein;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 25.w),
      child: Container(
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Title(title: S().grams),
            const VerticalDivider(thickness: 1, color: Colors.white),
            _Title(width: 0.5, title: S().items),
            const VerticalDivider(thickness: 1, color: Colors.white),
            _Title(title: S().cal),
            Expanded(child: _AddButton(isProtein: isProtein)),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.title,
    this.width = 0.11,
  }) : super(key: key);

  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * width,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
