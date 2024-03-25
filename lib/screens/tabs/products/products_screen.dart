import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture_project/screens/tabs/products/about_product/about_product_screen.dart';
import 'package:my_furniture_project/screens/tabs/products/add_product/add_product_screen.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/model/product_model.dart';
import '../../../view_models/products_view_model.dart';
import '../../routes.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String searchText='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context,RouteNames.tabRoute);
        },icon: const Icon(Icons.arrow_back,color: AppColors.black,),),
        title:  Text("Products",style: AppTextStyle.interRegular.copyWith(
          color: AppColors.black,fontSize: 24
        ),),

      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> list = (snapshot.data as List<ProductModel>).where((element) =>element.categoryId==widget.categoryId && element.productName.toLowerCase().contains(searchText.toLowerCase())).toList();
            return Column(
              children: [
                const SizedBox(height: 30,),
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
                        hintText: 'Search Product',
                        prefixIcon: const Icon(Icons.search,color: AppColors.black,),
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                ),
                SizedBox(height: 24.h,),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.86,
                    mainAxisSpacing: 16.h,
                    children: [
                      ...List.generate(list.length, (index){
                        ProductModel product=list[index];
                        return ZoomTapAnimation(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context){
                              return AboutProductScreen(product: product,);
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
                                        .read<ProductsViewModel>()
                                        .deleteProduct(product.docId, context);
                                    Navigator.pop(context);
                                  }, child:const Text('ok')),
                                ],
                              );
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: (index.isEven)?24.w:0,right: (index.isOdd)?24.w:0),
                            padding: EdgeInsets.symmetric(horizontal:10.w,vertical: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color:Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.network(product.imageUrl,width: 130.w,height: 130.h,fit: BoxFit.cover,)),
                                const Spacer(),
                                Text(product.productName,style: AppTextStyle.interMedium.copyWith(
                                    color: AppColors.black,fontSize: 16.w
                                ),),
                                const SizedBox(height: 7,),
                                Text('Price: \$${product.price}',style: AppTextStyle.interRegular.copyWith(
                                  color: AppColors.c_F2A666
                                ),),
                                // const SizedBox(height: 10,),
                              ],),
                          ),
                        );
                      })
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
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return AddProduct(categoryId:widget.categoryId);
                        }));
                      }, child:Text('Add Product',style: AppTextStyle.interRegular.copyWith(
                      color: AppColors.white,fontSize: 20.w
                  ),)),
                ),
                SizedBox(height: 10.h,)
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
