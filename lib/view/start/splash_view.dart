import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:size_config/size_config.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/view_model/preferences_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:size_config/util/size_extention.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    final preferencesP = Provider.of<PreferencesVM>(context, listen: false);
    final userP = Provider.of<UserVM>(context, listen: false);

    Timer(const Duration(seconds: 4), () {
      if (preferencesP.isFirstTime) {
        Navigation.off('/boarding');
        preferencesP.changeFirstTime(false);
      } else {
        if (preferencesP.isLogged.isEmpty) {
          Navigation.off('/login');
        } else {
          userP.changeUser(preferencesP.isLogged);
          Navigation.off('/main');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      SizeConfig().init(
        context: context,
        safeAreaBox: constraint,
        referenceHeight: 752,
        referenceWidth: 360,
      );

      return Center(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: Image.asset(
              'assets/img/logo.png',
              height: 84.h,
            ),
          ),
        ),
      );
    });
  }
}
