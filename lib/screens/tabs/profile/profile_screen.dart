import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/app_text_style.dart';
import '../../../view_models/auth_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;

    return Scaffold(
      backgroundColor:Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor:Colors.grey.shade200,
        elevation: 0,
        title:Text("Profile",style: AppTextStyle.interMedium.copyWith(
          color: AppColors.black,fontSize: 20.w
        ),),
        centerTitle: true,
      ),
      body: user != null
          ? context.watch<AuthViewModel>().loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding:EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (user.photoURL != null)
                            Image.network(
                              user.photoURL!,
                              width: 80,
                              height: 80,
                            ),
                          IconButton(
                            onPressed: () {
                              context.read<AuthViewModel>().updateImageUrl(
                                  "https://www.tenforums.com/attachments/tutorials/146359d1501443008-change-default-account-picture-windows-10-a-user.png");
                            },
                            icon: const Icon(Icons.image),
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            user.displayName.toString(),
                            style: AppTextStyle.interMedium
                                .copyWith(fontSize: 25.w,color: AppColors.c_101817),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            user.email.toString(),
                            style: AppTextStyle.interRegular
                                .copyWith(fontSize: 18,color: AppColors.c_828A89),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    Expanded(
                      child: ListView(children: [
                        ...List.generate(6, (index){
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 19.w),
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                onPressed: (){},
                                child:Row(children: [
                                  Icon(Icons.person,color: AppColors.c_828A89,),
                                  SizedBox(width: 14.w,),
                                  Text('Profile',style: AppTextStyle.interMedium.copyWith(
                                    color: AppColors.c_101817,fontSize: 16.w
                                  ),)
                                ],),
                              ),
                            ),
                          );
                        })
                      ],),
                    ),
                    TextButton(onPressed: (){
                      context.read<AuthViewModel>().logout(context);
                    }, child:Text('Log Out',style: AppTextStyle.interMedium.copyWith(
                      color:const Color(0xFFEA3549),fontSize: 16.w
                    ),))
                  ],
                ),
              )
          : const Center(
              child: Text("USER NOT EXIST"),
            ),
    );
  }
}
