import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/on_boarding/on_board_view_model.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/age_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/gender_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/password_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/percentage_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/second_steps_intro_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/steps_intro_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/third_intro_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/user_info_screen.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnBoardViewModel>(
        create: (_) => OnBoardViewModel(
              firebaseService: context.read<FirebaseService>(),
              messageService: context.read<MessageService>(),
              localization: context.read<S>(),
              connectionService: context.read<ConnectionService>(),
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
  List<Widget> pages = [];
  late PageController controller;

  @override
  void initState() {
    controller = PageController(viewportFraction: 1.0, keepPage: true);
    pages = [
      const StepsScreen(),
      const SecondStepsIntroScreen(),
      const ThirdIntroScreen(),
      const GenderScreen(),
      const AgeScreen(),
      const BodyPercentageScreen(),
      const UserInfoScreen(),
      const PasswordScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentBoard = context.select((OnBoardViewModel vm) => vm.currentBoard);
    var isLoading = context.select((OnBoardViewModel vm) => vm.isLoading);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Logo(size: size),
              _Dots(size: size, pages: pages, currentBoard: currentBoard),
              _PageView(pages: pages, controller: controller),
              Visibility(
                visible: isLoading,
                child: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
              _BottomBar(
                controller: controller,
                pagesLength: pages.length,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 100.w,
      height: 50.h,
      fit: BoxFit.cover,
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    Key? key,
    required this.size,
    required this.pages,
    required this.currentBoard,
  }) : super(key: key);

  final Size size;
  final List<Widget> pages;
  final int currentBoard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: size.width * 0.479,
      child: ListView.separated(
        itemCount: pages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: currentBoard == index
                    ? Colors.white
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(70),
              ));
        },
        separatorBuilder: (_, context) {
          return const SizedBox(width: 9.0);
        },
      ),
    );
  }
}

class _PageView extends StatefulWidget {
  _PageView({
    Key? key,
    required this.pages,
    required this.controller,
  }) : super(key: key);
  final List<Widget> pages;
  late PageController controller;

  @override
  State<_PageView> createState() => _PageViewState();
}

class _PageViewState extends State<_PageView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.5,
      width: size.width,
      child: Center(
        child: PageView.builder(
            controller: widget.controller,
            padEnds: false,
            onPageChanged: (index) {
              context.read<OnBoardViewModel>().setCurrentBoardState(index);
            },
            allowImplicitScrolling: false,
            itemCount: widget.pages.length,
            itemBuilder: (_, index) {
              return widget.pages.elementAt(index);
            }),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  _BottomBar({
    Key? key,
    required this.controller,
    required this.pagesLength,
  }) : super(key: key);
  late PageController controller;
  final int pagesLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/powerBy.png'),
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _PreviousButton(controller: controller),
              const SizedBox(width: 8),
              _NextButton(controller: controller, pagesLength: pagesLength),
            ],
          ),
        )
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  _NextButton({
    Key? key,
    required this.controller,
    required this.pagesLength,
  }) : super(key: key);

  late PageController controller;
  final int pagesLength;

  @override
  Widget build(BuildContext context) {
    var currentBoard = context.select((OnBoardViewModel vm) => vm.currentBoard);
    return GestureDetector(
      onTap: () {
        if (currentBoard != pagesLength - 1) {
          controller.nextPage(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
          );
          return;
        }
        context.read<OnBoardViewModel>().onDoneProfileDataEntryAction();
      },
      child: currentBoard != pagesLength - 1
          ? Get.locale == const Locale('ar')
              ? Image.asset('assets/icons/before.png')
              : Image.asset('assets/icons/next.png')
          : Image.asset('assets/icons/done.png'),
    );
  }
}

class _PreviousButton extends StatelessWidget {
  _PreviousButton({Key? key, required this.controller}) : super(key: key);

  late PageController controller;

  @override
  Widget build(BuildContext context) {
    var currentBoard = context.select((OnBoardViewModel vm) => vm.currentBoard);
    return GestureDetector(
      onTap: () {
        if (currentBoard != 0) {
          controller.previousPage(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
      child: currentBoard != 0
          ? Get.locale == const Locale('ar')
              ? Image.asset('assets/icons/next.png')
              : Image.asset('assets/icons/before.png')
          : Image.asset('assets/icons/skip.png'),
    );
  }
}
