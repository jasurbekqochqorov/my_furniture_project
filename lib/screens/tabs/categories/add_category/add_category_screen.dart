import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/category_model.dart';
import '../../../../view_models/category_view_model.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController=TextEditingController();
  TextEditingController imageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title:  Text('Add Category',style: AppTextStyle.interRegular.copyWith(
          color: AppColors.c_0C8A7B,fontSize: 24
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:24.w,vertical:40),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter category name',
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  width: 1,color: AppColors.black.withOpacity(0.7),
                )
              )
            ),
          ),
          SizedBox(height: 20.h,),
          TextField(
            controller: imageController,
            decoration: InputDecoration(
              hintText: 'Enter image url',
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      width: 1,color: AppColors.black.withOpacity(0.7),
                    )
                )
            ),
          ),
          const Spacer(),
          TextButton(onPressed: (){
            context.read<CategoriesViewModel>().insertCategory(
                    CategoryModel(
                      imageUrl:imageController.text,
                      categoryName:nameController.text,
                      docId: "",
                    ),
                    context,
                  );
            Navigator.pushReplacementNamed(context,RouteNames.tabRoute);
            },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.c_0C8A7B
              ),
              child:Text('Save',style: AppTextStyle.interRegular.copyWith(
                fontSize: 14.w,color: AppColors.white
              ),))
        ],),
      ),
    );
  }
}
