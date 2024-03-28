import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/screens/tabs/products/products_screen.dart';
import 'package:my_furniture_project/servise/local_notification_service.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/notification_model.dart';
import '../../../view_models/auth_view_model.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/local_notification_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String searchText='';
  @override
  Widget build(BuildContext context) {
  User? user = context.watch<AuthViewModel>().getUser;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Text("Welcome to ${user!.displayName!}",style: AppTextStyle.interMedium.copyWith(
          color: AppColors.black,fontSize: 20,
        ),),
        elevation: 0,
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoriesViewModel>().listenCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<CategoryModel> list = (snapshot.data as List<CategoryModel>).where((element) => element.categoryName.toLowerCase().contains(searchText.toLowerCase())).toList();
            return Column(
              children: [
                SizedBox(height: 24.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.white
                  ),
                  child: TextField(
                    onChanged: (v){
                      setState(() {
                        searchText=v;
                      });
                    },
                    style: AppTextStyle.interMedium.copyWith(
                      color: AppColors.black,fontSize: 16.w
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search Furniture',
                      prefixIcon: const Icon(Icons.search,color: AppColors.black,),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 16.h,
                    children: [
                    ...List.generate(list.length, (index){
                      CategoryModel category=list[index];
                      return ZoomTapAnimation(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context){
                            return ProductsScreen(categoryId: category.docId,);
                          }));
                        },
                        onLongTap: (){
                          showDialog(context: context, builder:(context){
                            return AlertDialog(
                              title: const Text('Do you want to delete'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child:const Text('cancel')),
                                TextButton(onPressed: (){
                                  context
                                    .read<CategoriesViewModel>()
                                    .deleteCategory(category.docId, context);
                                  NotificationModel notification=NotificationModel(name: "${category.categoryName} o'chirildi", id:DateTime.now().millisecond);
                                  context.read<NotificationViewModel>().addNotification(notification);
                                  LocalNotificationService().showNotification(
                                      title:"${category.categoryName} category o'chirildi", body:'Categoryni korisg', id:notification.id);
                                  Navigator.pop(context);
                                  }, child:const Text('ok')),
                              ],
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: (index.isEven)?24.w:0,right: (index.isOdd)?24.w:0),
                          padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:Colors.white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(category.imageUrl,width: 128.w,height: 120.h,fit: BoxFit.cover,)),
                            const Spacer(),
                            Text(category.categoryName,style: AppTextStyle.interMedium.copyWith(
                              color: AppColors.black,fontSize: 16.w
                            ),),
                              const SizedBox(height: 10,),
                          ],),
                        ),
                      );
                    }),
                  ],),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  width: width,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.c_0C8A7B
                      ),
                      onPressed:(){
                        Navigator.pushNamed(context, RouteNames.addCategory);
                      }, child:Text('Add Category',style: AppTextStyle.interRegular.copyWith(
                    color: AppColors.white,fontSize: 18.w
                  ),)),
                ),
                SizedBox(height: 10.h,),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
