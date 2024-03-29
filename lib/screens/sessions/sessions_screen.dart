import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/components/logo.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/sessions/sessions_view_model.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionsViewModel>(
        create: (_) => SessionsViewModel(
              connectionService: context.read<ConnectionService>(),
              messageService: context.read<MessageService>(),
              firebaseService: context.read<FirebaseService>(),
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SessionsViewModel>().initGetSessionsAsync();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var vm = context.watch<SessionsViewModel>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              const Logo(),
              SizedBox(height: 50.h),
              const _Title(),
              SizedBox(height: 30.h),
              vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : vm.sessions!.isNotEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 380.h,
                          child: ListView.separated(
                            itemCount: vm.sessions!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _SessionItem(
                                  date: vm.sessions![index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 20.h);
                            },
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionItem extends StatelessWidget {
  const _SessionItem({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 35.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primaryLightColor2),
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: EdgeInsets.only(left: 25.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/arrow_forward.png',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.orangeColor),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          S.of(context).mySessions,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
