import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/splash/splash_screen.dart';
import 'package:my_furniture_project/screens/tabs/categories/add_category/add_category_screen.dart';
import 'package:my_furniture_project/screens/tabs/products/products_screen.dart';
import 'package:my_furniture_project/screens/tabs/tab_screen.dart';

import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.loginRoute:
        return navigate(const LoginScreen());

      case RouteNames.registerRoute:
        return navigate(const RegisterScreen());

      case RouteNames.addCategory:
        return navigate(const AddCategory());
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String product = "/product_route";
  static const String loginRoute = "/login_route";
  static const String registerRoute = "/register_route";
  static const String addCategory = "/add_category_route";
}
