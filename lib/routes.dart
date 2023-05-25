import 'package:flutter/material.dart';
import 'view/profile/change_password_view.dart';
import 'view/auth/forget_password_view.dart';
import 'view/learn/certificate_view.dart';
import 'view/learn/project_view.dart';
import 'view/learn/learn_view.dart';
import 'view/learn/material_view.dart';
import 'view/learn/course_detail_view.dart';
import 'view/profile/order_history_view.dart';
import 'view/transaction/detail_view.dart';
import 'view/transaction/order_view.dart';
import 'view/transaction/promo_view.dart';
import 'view/transaction/status_order_view.dart';
import 'view/transaction/transaction_view.dart';
import 'view/main_view.dart';
import 'view/auth/register_view.dart';
import 'view/start/splash_view.dart';
import 'view/start/boarding_view.dart';
import 'view/auth/login_view.dart';

class AppRoute {
  static Route<dynamic> generateRoute(settings) {
    // jika ingin mengirim argument
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/boarding':
        return MaterialPageRoute(builder: (_) => BoardingView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case '/main':
        return MaterialPageRoute(builder: (_) => MainView());
      case '/detail':
        return MaterialPageRoute(builder: (_) => DetailView(args));
      case '/transaction':
        return MaterialPageRoute(builder: (_) => TransactionView(args));
      case '/promo':
        return MaterialPageRoute(builder: (_) => PromoView());
      case '/course_detail':
        return MaterialPageRoute(builder: (_) => CourseDetailView(args));
      case '/material':
        return MaterialPageRoute(builder: (_) => MaterialView(args));
      case '/learn':
        return MaterialPageRoute(builder: (_) => LearnView(args));
      case '/project':
        return MaterialPageRoute(builder: (_) => ProjectView(args));
      case '/certificate':
        return MaterialPageRoute(builder: (_) => CertificateView(args));
      case '/change_password':
        return MaterialPageRoute(builder: (_) => ChangePasswordView());
      case '/forget_password':
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case '/order':
        return MaterialPageRoute(builder: (_) => OrderView(args));
      case '/status_order':
        return MaterialPageRoute(builder: (_) => StatusOrderView(args));
      case '/order_history':
        return MaterialPageRoute(builder: (_) => OrderHistoryView());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Error page',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
      );
    });
  }
}
