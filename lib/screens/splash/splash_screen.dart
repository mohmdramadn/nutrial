import 'package:flutter/material.dart';
import 'package:nutrial/screens/splash/splash_view_model.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashViewModel>(
        create: (_) => SplashViewModel(
          firebaseService: context.read<FirebaseService>(),
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().checkIsLoggedInAction();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: [
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                )),
          ),
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        ],
      ),
    );
  }
}
