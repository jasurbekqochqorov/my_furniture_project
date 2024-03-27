import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/servise/local_notification_service.dart';
import 'package:my_furniture_project/view_models/auth_view_model.dart';
import 'package:my_furniture_project/view_models/category_view_model.dart';
import 'package:my_furniture_project/view_models/local_notification_view_model.dart';
import 'package:my_furniture_project/view_models/products_view_model.dart';
import 'package:my_furniture_project/view_models/tab_view_model.dart';
import 'package:provider/provider.dart';
import 'servise/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // LocalNotificationService().init();
  await configureLocalTimeZone();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriesViewModel()),
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
