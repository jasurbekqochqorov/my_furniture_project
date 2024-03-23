import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/view_models/auth_view_model.dart';
import 'package:my_furniture_project/view_models/category_view_model.dart';
import 'package:my_furniture_project/view_models/products_view_model.dart';
import 'package:my_furniture_project/view_models/tab_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
