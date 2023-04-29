import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/activites.dart';
import 'package:nutrial/screens/cardio/cardio_view_model.dart';
import 'package:provider/provider.dart';

class CardioScreen extends StatelessWidget {
  const CardioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardioViewModel>(
        create: (_) => CardioViewModel(), child: const _Body());
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CardioViewModel>().initAsync();
    });
  }
  @override
  Widget build(BuildContext context) {
    var isLoading = context.watch<CardioViewModel>().isLoading;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Header(),
          const _SearchTypeAhead(),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : _CardioActivities(size: size)
        ],
      ),
    );
  }
}

class _SearchTypeAhead extends StatelessWidget {
  const _SearchTypeAhead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =
        context.select((CardioViewModel vm) => vm.searchController);
    var activities = context.watch<CardioViewModel>().cardioList;

    return Padding(
      padding:
          EdgeInsets.only(bottom: 10.0.h, top: 10.0.h, left: 32.w, right: 32.w),
      child: TypeAheadField<Activities>(
        keepSuggestionsOnSuggestionSelected: false,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.darkPrimaryColor,
          hasScrollbar: true,
        ),
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          autofocus: false,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: S.of(context).searchWorkout,
              prefixIcon: const Icon(Icons.search, size: 35),
              suffixIcon: InkWell(
                  onTap: () => controller.clear(),
                  child: const Icon(Icons.arrow_drop_down,
                      color: AppColors.primaryColor))),
        ),
        suggestionsCallback: (pattern) async {
          var filteredActivities =
          activities.where((c) => c.activityName.contains(pattern));
          return filteredActivities;
        },
        itemBuilder: (context, suggestion) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              suggestion.activityName,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          );
        },
        onSuggestionSelected: (selectedActivity) {
          context
              .read<CardioViewModel>()
              .navigateAction(selectedActivity);
        },
      ),
    );
  }
}

class _CardioActivities extends StatelessWidget {
  const _CardioActivities({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var cardioList = context.watch<CardioViewModel>().cardioList;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 8.0.h),
      child: Container(
        width: size.width * 0.9,
        height: 425.h,
        decoration: BoxDecoration(
          color: AppColors.darkPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20.w)
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: ListView.separated(
            itemCount: cardioList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () => context
                      .read<CardioViewModel>()
                      .navigateAction(cardioList[index]),
                  child: _CardioItem(itemName: cardioList[index].activityName));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: const Divider(
                    color: AppColors.yellowTextColor, thickness: 0.5),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CardioItem extends StatelessWidget {
  const _CardioItem({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              itemName,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset('assets/icons/arrow_forward.png'),
          )
        ],
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
          color: AppColors.cardioHeaderColor,
          child: Padding(
            padding: EdgeInsets.only(top: 24.0.h),
            child: Row(
              children: [
                SizedBox(width: 50.w),
                Text(
                  S.of(context).cardio.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontSize: 22.sp, letterSpacing: 4.5),
                ),
                SizedBox(width: 120.w),
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
        // const _Date(),
      ],
    );
  }
}
//TODO ask about if this is needed
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
