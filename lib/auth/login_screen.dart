import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/images/app_images.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:provider/provider.dart';
import '../utils/constants/app_constants.dart';
import '../utils/styles/app_text_style.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor:Colors.grey.shade200,
        elevation: 0,
      ),
      body: context.watch<AuthViewModel>().loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(24.w),
              child: ListView(
                children: [
                  SizedBox(height:12.h,),
                  Text(
                    "Welcome Back",
                    style: AppTextStyle.interSemiBold.copyWith(
                      fontSize:32.w,
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Text('Welcome Back! Please Enter Your Details.',style:AppTextStyle.interRegular.copyWith(
                    color: AppColors.black.withOpacity(0.4),fontSize: 16.w
                  ),),
                  SizedBox(height: 32.h),
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
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      width: 16.w,height: 16.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border:Border.all(width: 1,color: Colors.black.withOpacity(0.8))
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Text('Remember For 30 Days',style: AppTextStyle.interRegular.copyWith(
                      color: AppColors.black.withOpacity(0.4),fontSize: 14.w
                    ),),
                    const Spacer(),
                    Text('Forgot password',style: AppTextStyle.interRegular.copyWith(
                        color: AppColors.black,fontSize: 14.w
                    ))
                  ],),
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
                        context.read<AuthViewModel>().loginUser(
                              context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      },
                      child: Text(
                        "Sign in",
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
                      onPressed: () {
                        context.read<AuthViewModel>().signInWithGoogle(context,
                            Platform.isAndroid ? null : AppConstants.clientID);
                      },
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
                    Navigator.pushReplacementNamed(context,RouteNames.registerRoute);
                  },
                      child:RichText(text:TextSpan(
                        text: 'Don’t have an account?',
                        style: AppTextStyle.interRegular.copyWith(
                          fontSize: 14.w,color: AppColors.black.withOpacity(0.5)
                        ),
                        children: [
                          TextSpan(
                            text: ' Sing Up For Free',
                            style: AppTextStyle.interRegular.copyWith(
                              color: AppColors.black,fontSize: 14.w
                            )
                          )
                        ]
                      ),))
                ],
              ),
            ),
    );
  }
}
