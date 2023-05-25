import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/styles.dart';
import 'data/helper/preferences_helper.dart';
import 'global.dart';
import 'routes.dart';
import 'view_model/helper_vm.dart';
import 'view_model/course_vm.dart';
import 'view_model/materials_vm.dart';
import 'view_model/order_vm.dart';
import 'view_model/preferences_vm.dart';
import 'view_model/project_vm.dart';
import 'view_model/promo_vm.dart';
import 'view_model/user_vm.dart';

void main() {
  initializeDateFormatting('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HelperVM()),
        ChangeNotifierProvider(create: (_) => UserVM()),
        ChangeNotifierProvider(create: (_) => CourseVM()),
        ChangeNotifierProvider(create: (_) => MaterialsVM()),
        ChangeNotifierProvider(create: (_) => PromoVM()),
        ChangeNotifierProvider(create: (_) => UserVM()),
        ChangeNotifierProvider(create: (_) => OrderVM()),
        ChangeNotifierProvider(create: (_) => ProjectVM()),
        ChangeNotifierProvider(
          create: (_) => PreferencesVM(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: snackbarKey,
        title: 'Media Belajarku',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme().apply(
            bodyColor: primaryTextColor,
            displayColor: primaryTextColor,
          ),
          colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryTextColor,
          ),
        ),
      ),
    );
  }
}
