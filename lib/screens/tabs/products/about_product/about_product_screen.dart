import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture_project/data/model/product_model.dart';
import 'package:my_furniture_project/screens/tabs/products/products_screen.dart';
import 'package:my_furniture_project/screens/tabs/products/update_product/update_screen.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';

import '../../../../utils/colors/app_colors.dart';


class AboutProductScreen extends StatefulWidget {
  const AboutProductScreen({super.key, required this.product});
  final ProductModel product;
  @override
  State<AboutProductScreen> createState() => _AboutProductScreenState();
}

class _AboutProductScreenState extends State<AboutProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('About Product',style: AppTextStyle.interMedium.copyWith(
          color: AppColors.black,fontSize: 24,
        ),),centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
              return UpdateProduct(product: widget.product,);
            }));
          }, icon:const Icon(Icons.edit,color: AppColors.c_0C8A7B,))
        ],
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
            return ProductsScreen(categoryId: widget.product.categoryId);
          }));
        },icon: const Icon(Icons.arrow_back,color: AppColors.black,),),
      ),
      body:SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height:20,),
          ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(widget.product.imageUrl,width: 250,height: 250,fit: BoxFit.cover,)),
          const SizedBox(height: 30,),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(widget.product.productName,style: AppTextStyle.interMedium.copyWith(
                    color: AppColors.black,fontSize: 24.w
                  ),),
                  const Spacer(),
                  Text("\$${widget.product.price.toString()}",style: AppTextStyle.interMedium.copyWith(
                      color: AppColors.c_F2A666,fontSize: 24.w))
                ],),
                const SizedBox(height: 40,),
                Text('Description:',style: AppTextStyle.interBold.copyWith(
                  color: AppColors.black,fontSize: 30.w
                ),),
                const SizedBox(height: 40,),
                Text(widget.product.productDescription,style: AppTextStyle.interRegular.copyWith(
                  color: AppColors.black,fontSize: 18.w
                ),),
                const SizedBox(height: 60,),
              ],
            ),
          )
        ],),
      )
    );
  }
}
