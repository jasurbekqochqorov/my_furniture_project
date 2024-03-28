
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_furniture_project/utils/permission_utils/app_permissions.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:provider/provider.dart';

import '../screens/routes.dart';
import '../utils/colors/app_colors.dart';
import '../utils/images/app_images.dart';
import '../utils/styles/app_text_style.dart';
import '../view_models/auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.grey.shade200,
      ),
      backgroundColor:Colors.grey.shade200,
      body: context.watch<AuthViewModel>().loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.all(24.w),
        child: ListView(
          children: [
            SizedBox(height:12.h,),
            Text(
              "Create Account",
              style: AppTextStyle.interSemiBold.copyWith(
                fontSize:32.w,
              ),
            ),
            SizedBox(height: 8.h,),
            Text('Let’s create account toghter',style:AppTextStyle.interRegular.copyWith(
                color: AppColors.black.withOpacity(0.4),fontSize: 16.w
            ),),
            SizedBox(height: 32.h),
            Text('Full Name',style: AppTextStyle.interMedium.copyWith(
                color: AppColors.black,fontSize: 14.w
            ),),
            SizedBox(height: 8.h,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,

              ),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Text('Email',style: AppTextStyle.interMedium.copyWith(
                color: AppColors.black,fontSize: 14.w
            ),),
            SizedBox(height: 8.h,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,

              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text('Password',style: AppTextStyle.interMedium.copyWith(
                color: AppColors.black,fontSize: 14.w
            ),),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
              ),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width:width,
              // padding: EdgeInsets.symmetric(vertical:26.h),
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor:AppColors.c_0C8A7B,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  context.read<AuthViewModel>().registerUser(
                    context,
                    email: emailController.text,
                    password: passwordController.text,
                    username: usernameController.text
                  );
                },
                child: Text(
                  "Sign up",
                  style: AppTextStyle.interSemiBold
                      .copyWith(fontSize: 16.w, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            SizedBox(
              width: width,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding:EdgeInsets.symmetric(vertical: 16.h),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.google),
                    SizedBox(width: 6.w,),
                    Text(
                      "Sign in  With Google",
                      style: AppTextStyle.interSemiBold
                          .copyWith(fontSize: 16, color: Colors.black),
                    )
                  ],),
              ),
            ),
            SizedBox(height: 16.h,),
            TextButton(onPressed: (){
              Navigator.pushReplacementNamed(context,RouteNames.loginRoute);
              AppPermissions.getSomePermissions();
            },
                child:RichText(text:TextSpan(
                    text: 'Already Have An Account?',
                    style: AppTextStyle.interRegular.copyWith(
                        fontSize: 14.w,color: AppColors.black.withOpacity(0.5)
                    ),
                    children: [
                      TextSpan(
                          text: ' Sing in',
                          style: AppTextStyle.interRegular.copyWith(
                              color: AppColors.black,fontSize: 14.w
                          )
                      )
                    ]
                ),))
          ],
        ),
      ),
    );;
  }
}
