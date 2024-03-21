import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/images/app_images.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }
  @override
  void initState() {
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF0C8A7B),
      body: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SvgPicture.asset(AppImages.splash),
          SizedBox(height: 15.h,),
         Text('Crafty Furniture',style:AppTextStyle.interMedium.copyWith(
           color: AppColors.white,fontSize: 24.w
         ),),
      ],),),
    );
  }
}
