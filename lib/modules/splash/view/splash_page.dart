import 'package:arretadas/core/app_colors.dart';
import 'package:arretadas/modules/auth/view/home_page.dart';
import 'package:arretadas/modules/menu/view/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:arretadas/modules/splash/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  static const router = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => SplashController()..checkLogin(),
        child: SplashContent(),
      ),
    );
  }
}

class SplashContent extends StatefulWidget {
  @override
  _SplashContentState createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  void initState() {
    super.initState();
    var controller = context.read<SplashController>();
    controller.addListener(() {
      switch (controller.logged) {
        case UserLogged.authenticate:
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MenuPage.router, (route) => false);
          break;
        case UserLogged.unauthenticate:
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.router, (route) => false);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaria,
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: AppColors.primaria),
      ),
      body: Container(
        color: AppColors.primaria,
      ),
    );
  }
}
