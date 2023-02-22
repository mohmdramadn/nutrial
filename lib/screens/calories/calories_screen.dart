import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/components/progress_bar.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/pdf_items_model.dart';
import 'package:nutrial/screens/calories/calories_components/new_items_row.dart';
import 'package:nutrial/screens/calories/calories_components/saved_items_row.dart';
import 'package:nutrial/screens/calories/calories_components/selected_items_row.dart';
import 'package:nutrial/screens/calories/calories_view_model.dart';
import 'package:provider/provider.dart';

class CaloriesScreen extends StatelessWidget {
  const CaloriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CaloriesViewModel>(
        create: (_) => CaloriesViewModel(), child: const _Body());
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CaloriesViewModel>().createTableRowsInit();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var showProteinMenu =
        context.select((CaloriesViewModel vm) => vm.showProteinMenu);
    var showCarbsMenu =
        context.select((CaloriesViewModel vm) => vm.showCarbsMenu);
    var vm = context.watch<CaloriesViewModel>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const _Header(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30.h),
                  const _WaterHeader(),
                  if (vm.waterBottlesCount != 0) const _WaterBottles(),
                  SizedBox(height: 50.h),
                  _CategoryImage(
                    imgName: 'protiens',
                    isHasNumbers: true,
                    caloriesRate:
                        vm.proteinGoalCalories.roundToDouble().toString(),
                    consumedCalories: vm.totalProteinCalories.toString(),
                  ),
                  LinearProgressIndicatorApp(
                    consumedCaloriesPercentage: vm.proteinProgressRatio,
                    color: vm.isMetProteinGoal
                        ? const AlwaysStoppedAnimation<Color>(
                            AppColors.floatingButton)
                        : AlwaysStoppedAnimation<Color>(Colors.red.shade300),
                  ),
                  const _HeaderCategory(isProtein: true),
                  if (vm.showNewProteinItem)
                    NewItemsRow(
                      itemName: S.of(context).chooseItem,
                      showMenu: showProteinMenu,
                      onMenuTapped: () => context
                          .read<CaloriesViewModel>()
                          .setProteinMenuState(),
                      controller: vm.proteinQtyController,
                    ),
                  if (vm.showSelectedIProteinItem)
                    SelectedItemRow(
                        itemName: vm.selectedProteinItem!.itemName!,
                        calories: vm.calculatedProteinCalories,
                        controller: vm.proteinQtyController,
                        onChanged: (value) => context
                            .read<CaloriesViewModel>()
                            .onProteinQuantityAddedAction()),
                  if (vm.proteinsSelectedItems.length != 0)
                    _SavedItems(itemsList: vm.proteinsSelectedItems),
                  if (showProteinMenu) const _Items(isProtein: true),
                  SizedBox(height: 50.h),
                  _CategoryImage(
                    imgName: 'fats',
                    isHasNumbers: true,
                    caloriesRate: vm.carbsGoalCalories.roundToDouble().toString(),
                    consumedCalories: vm.totalCarbsCalories.toString(),
                  ),
                  LinearProgressIndicatorApp(
                    consumedCaloriesPercentage: vm.carbsProgressRatio,
                    color: vm.isMetCarbsGoal
                        ? const AlwaysStoppedAnimation<Color>(
                        AppColors.floatingButton)
                        : AlwaysStoppedAnimation<Color>(Colors.red.shade300),
                  ),
                  const _HeaderCategory(isProtein: false),
                  if (vm.showNewCarbsItem)
                    NewItemsRow(
                      itemName: 'Choose Item',
                      showMenu: showCarbsMenu,
                      onMenuTapped: () =>
                          context.read<CaloriesViewModel>().setCarbsMenuState(),
                      controller: vm.carbsQtyController,
                    ),
                  if (vm.showSelectedCarbsItem)
                    SelectedItemRow(
                        itemName: vm.selectedCarbsItem!.itemName!,
                        calories: vm.calculatedCarbsCalories,
                        controller: vm.carbsQtyController,
                        onChanged: (value) => context
                            .read<CaloriesViewModel>()
                            .onCarbsQuantityAddedAction()),
                  if (vm.carbsSelectedItems.length != 0)
                    _SavedItems(itemsList: vm.carbsSelectedItems),
                  if (showCarbsMenu) const _Items(isProtein: false),
                  const _SaveButton(),
                ],
              ),
            ],
          ),
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
      child: Container(
        height: 300.h,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
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
    );
  }
}

class _WaterHeader extends StatelessWidget {
  const _WaterHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: _CategoryImage(
              imgName: 'water',
              isHasNumbers: false,
            ),
          ),
          InkWell(
            onTap: () =>
                context.read<CaloriesViewModel>().addWaterBottleAction(),
            child: Image.asset('assets/icons/add.png'),
          )
        ],
      ),
    );
  }
}

class _SavedItems extends StatelessWidget {
  const _SavedItems({Key? key, required this.itemsList}) : super(key: key);

  final List<ItemModel> itemsList;

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
    var items = context.select((CaloriesViewModel vm) => vm.itemsList);

    return Padding(
      padding: EdgeInsets.only(left: 80.w, right: 105.w),
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.grey.withOpacity(0.5)),
        child: ListView.separated(
          itemCount: items.length - 1,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: isProtein
                  ? () => context
                      .read<CaloriesViewModel>()
                      .setSelectedProteinItem(item: items[index])
                  : () => context
                      .read<CaloriesViewModel>()
                      .setSelectedCarbsItem(item: items[index]),
              child: Text(
                '${index + 1}. ${items[index].itemName!}',
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
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 45.h,
            color: AppColors.primaryLightColor3,
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
                child: const Text(
                  'Yesterday',
                  style: TextStyle(color: Colors.white, letterSpacing: 1.9),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 45.h,
            color: AppColors.primaryDarkColor,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '11/10/2023',
                style: TextStyle(color: Colors.white, letterSpacing: 1.5),
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
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.23,
            height: size.height * 0.065,
            margin: const EdgeInsets.only(top: 20, bottom: 50),
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
          const Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Icon(Icons.check, size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  const _CategoryImage({
    Key? key,
    required this.imgName,
    required this.isHasNumbers,
    this.caloriesRate,
    this.consumedCalories,
  }) : super(key: key);

  final String imgName;
  final bool isHasNumbers;
  final String? consumedCalories;
  final String? caloriesRate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Image.asset('assets/images/$imgName.png'),
          ),
          if (isHasNumbers)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$consumedCalories / $caloriesRate',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
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
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _Title(title: 'qty.'),
          const VerticalDivider(thickness: 1, color: Colors.white),
          const _Title(width: 0.5, title: 'Items'),
          const VerticalDivider(thickness: 1, color: Colors.white),
          const _Title(title: 'Cal.'),
          _AddButton(isProtein: isProtein),
        ],
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
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
