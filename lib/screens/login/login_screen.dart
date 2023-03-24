import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/login/login_view_model.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (_) => LoginViewModel(
            firebaseService: context.read<FirebaseService>(),
            messageService: context.read<MessageService>(),
            localization: context.read<S>(),
            connectionService: context.read<ConnectionService>(),
        ),
        child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
            color: Colors.grey[800]),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _HeaderLogo(size: size),
                SizedBox(height: 5.h),
                const _UserName(),
                SizedBox(height: 10.h),
                const _Password(),
                SizedBox(height: 10.h),
                const _LoginButton(),
                SizedBox(height: 10.h),
                const _SocialMediaDivider(),
                SizedBox(height: 20.h),
                const _SocialMedia(),
                SizedBox(height: 30.h),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: _PoweredByLogo(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialMedia extends StatelessWidget {
  const _SocialMedia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _SocialMediaButton(logo: 'apple_logo', size: 45),
        SizedBox(width: 10.w),
        const _SocialMediaButton(
            logo: 'google_logo', iconColor: Colors.yellow, size: 40),
        SizedBox(width: 10.w),
        const _SocialMediaButton(logo: 'facebook_logo'),
      ],
    );
  }
}

class _SocialMediaDivider extends StatelessWidget {
  const _SocialMediaDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.h,
          width: 120.w,
          child: const Divider(
              color: Colors.white, thickness: 1, indent: 20, endIndent: 20),
        ),
        const Text(
          ConstStrings.orComWith,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
          width: 120,
          child: Divider(
              color: Colors.white, thickness: 1, indent: 20, endIndent: 20),
        ),
      ],
    );
  }
}

class _SocialMediaButton extends StatelessWidget {
  const _SocialMediaButton({
    Key? key,
    required this.logo,
    this.size,
    this.iconColor,
  }) : super(key: key);

  final String logo;
  final Color? iconColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO integrate with social media
      },
      child: SizedBox(
        height: size?.h ?? 60.h,
        width: size?.w ?? 60.w,
        child: Image.asset(
          'assets/images/$logo.png',
          fit: BoxFit.contain,
          color: iconColor,
        ),
      ),
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =
        context.select((LoginViewModel vm) => vm.passwordController);
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.24,
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(19)),
          child: Center(
            child: Text(
              S.of(context).password,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 200.w,
          child: TextFormField(
            controller: controller,
            cursorColor: AppColors.primaryDarkColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding: EdgeInsets.only(left: 12.0.w, right: 12.0.w),
            ),
          ),
        ),
      ],
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.select((LoginViewModel vm) => vm.nameController);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90.w,
          height: 35.h,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Center(
              child: Text(
            S.of(context).username,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          )),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 200.w,
          child: TextFormField(
            controller: controller,
            cursorColor: AppColors.primaryDarkColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 200.h,
      child: Image.asset('assets/images/logo.png', scale: 1.5),
    );
  }
}

class _PoweredByLogo extends StatelessWidget {
  const _PoweredByLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/powerBy.png'),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () => context.read<LoginViewModel>().skipAction(),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.darkPrimaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                        child: Text(
                          S.of(context).skip,
                          style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LoginButton extends StatefulWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: ElevatedButton(
        onPressed: ()=> context.read<LoginViewModel>().loginAsync(),
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryLightColor4),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: AppColors.primaryLightColor4),
            ),
          ),
        ),
        child: Text(
          S.of(context).login,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void showInSnackBarError(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(width: 10),
          Text(value)
        ],
      ),
      backgroundColor: Colors.red,
    ));
  }
}
