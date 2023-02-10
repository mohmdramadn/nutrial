import 'package:flutter/material.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/screens/sign_up/sign_up_view_model.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(
        firebaseService: context.read<FirebaseService>(),
        messageService: context.read<MessageService>(),
        localization: context.read<S>(),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
              color: Colors.grey[800]),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeaderLogo(size: size),
                  SizedBox(height: size.height * 0.08),
                  const _UserName(),
                  const SizedBox(height: 10),
                  const _Password(),
                  SizedBox(height: size.height * 0.015),
                  const _signUpButton(),
                  const SizedBox(height: 60),
                  const _SocialMediaDivider(),
                  const SizedBox(height: 20),
                  const _SocialMedia(),
                  const SizedBox(height: 10),
                ],
              ),
              const _PoweredByLogo(),
            ],
          ),
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
      children: const [
        _SocialMediaButton(logo: 'apple_logo', size: 45),
        SizedBox(width: 10),
        _SocialMediaButton(
            logo: 'google_logo', iconColor: Colors.yellow, size: 40),
        SizedBox(width: 10),
        _SocialMediaButton(logo: 'facebook_logo'),
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
      children: const [
        SizedBox(
          height: 10,
          width: 120,
          child: Divider(
              color: Colors.white, thickness: 1, indent: 20, endIndent: 20),
        ),
        Text(
          ConstStrings.orComWith,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
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
        height: size ?? 60,
        width: size ?? 60,
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
        context.select((SignUpViewModel vm) => vm.passwordController);
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
              'Password',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(19)),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText:
                    '.....................................................',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                hintStyle: TextStyle(fontSize: 15)),
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
    var controller = context.select((SignUpViewModel vm) => vm.nameController);
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
            'User Name',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          )),
        ),
        const SizedBox(width: 10),
        Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(19)),
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
                hintText:
                    '.....................................................',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                hintStyle: TextStyle(fontSize: 15)),
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
      width: size.width * 0.8,
      height: size.height * 0.4,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}

class _PoweredByLogo extends StatelessWidget {
  const _PoweredByLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/powerBy.png'),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.darkPrimaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 5.0, left: 5.0),
                        child: Text(
                          'SKIP',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                      Icon(
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
    ));
  }
}

class _signUpButton extends StatelessWidget {
  const _signUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: ElevatedButton(
          onPressed: () => context.read<SignUpViewModel>().signUpAsync(),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(15)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: AppColors.primaryColor)))),
          child: Text(
            S.of(context).signup,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ));
  }
}
