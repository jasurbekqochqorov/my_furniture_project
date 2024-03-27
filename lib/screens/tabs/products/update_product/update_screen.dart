import 'package:flutter/material.dart';
import 'package:my_furniture_project/data/model/product_model.dart';
import 'package:my_furniture_project/screens/tabs/products/about_product/about_product_screen.dart';
import 'package:my_furniture_project/servise/local_notification_service.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';
import 'package:my_furniture_project/view_models/products_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/notification_model.dart';
import '../../../../view_models/local_notification_view_model.dart';
class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product});
  final ProductModel product;
  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
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
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
            return AboutProductScreen(product: widget.product);
          }));
        },icon:const Icon(Icons.arrow_back,color: AppColors.black,),),
        centerTitle: true,
        title:  Text('Update Product',style: AppTextStyle.interRegular.copyWith(
            color: AppColors.c_0C8A7B,fontSize: 24
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:24.w,vertical:40),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Enter new product name',
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
                hintText: 'Enter new image url',
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
                hintText: 'Enter new description',
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
                hintText: 'Enter new price',
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
            ProductModel newProduct=ProductModel(
              price: (priceController.text.isNotEmpty)?double.parse(priceController.text):widget.product.price,
              imageUrl:(imageController.text.isNotEmpty)?imageController.text:widget.product.imageUrl,
              productName:(nameController.text.isNotEmpty)?nameController.text:widget.product.productName,
              docId:widget.product.docId,
              productDescription: (productDescriptionController.text.isNotEmpty)?productDescriptionController.text:widget.product.productDescription,
              categoryId:widget.product.categoryId,);

            context.read<ProductsViewModel>().updateProduct(newProduct,context);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
              return AboutProductScreen(product: newProduct,);
            }));
            NotificationModel notification=NotificationModel(name: "${nameController.text} yangilandi", id:DateTime.now().millisecond);
            context.read<NotificationViewModel>().addNotification(notification);
              LocalNotificationService().showNotification(
                  title:"${nameController.text} yangilandi",
                  body: "Mahsulotni ko'rish",
                  id: notification.id);

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
