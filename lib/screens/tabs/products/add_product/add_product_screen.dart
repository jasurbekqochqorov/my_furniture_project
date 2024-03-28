import 'package:flutter/material.dart';
import 'package:my_furniture_project/data/model/product_model.dart';
import 'package:my_furniture_project/servise/local_notification_service.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';
import 'package:my_furniture_project/view_models/products_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/notification_model.dart';
import '../../../../view_models/local_notification_view_model.dart';
class AddProduct extends StatefulWidget {
  const AddProduct({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController=TextEditingController();
  TextEditingController imageController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController productDescriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon:const Icon(Icons.arrow_back,color: AppColors.black,),),
        centerTitle: true,
        title:  Text('Add Product',style: AppTextStyle.interRegular.copyWith(
            color: AppColors.c_0C8A7B,fontSize: 24
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:24.w,vertical:40),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Enter product name',
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
          SizedBox(height: 20.h,),
          TextField(
            controller: productDescriptionController,
            decoration: InputDecoration(
                hintText: 'Enter description',
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
            controller: priceController,
            decoration: InputDecoration(
                hintText: 'Enter price',
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
            context.read<ProductsViewModel>().insertProducts(
                ProductModel(
                  price: double.parse(priceController.text),
                  imageUrl: imageController.text,
                  productName:nameController.text,
                  docId: '',
                  productDescription: productDescriptionController.text,
                  categoryId:widget.categoryId,),
                context);
            Navigator.pop(context);
            NotificationModel notification=NotificationModel(name: "${nameController.text} qoshildi", id:DateTime.now().millisecond);
            context.read<NotificationViewModel>().addNotification(notification);
            LocalNotificationService().showNotification(
                title: "${nameController.text} nomli mahsulot qoshildi", body:"Mahsulot", id:notification.id);
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
