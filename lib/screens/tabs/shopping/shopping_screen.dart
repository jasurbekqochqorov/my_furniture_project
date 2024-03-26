import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/product_model.dart';
import '../../../servise/local_notification_service.dart';
import '../../../view_models/products_view_model.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shoppig"),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       context.read<ProductsViewModel>().insertProducts(
          //         ProductModel(
          //           price: 12.5,
          //           imageUrl:
          //           "https://i.ebayimg.com/images/g/IUMAAOSwZGBkTR-K/s-l400.png",
          //           productName: "Nokia 12 80",
          //           docId: "",
          //           productDescription: "productDescription",
          //           categoryId: "kcggCJzOEz7gH1LQy44x",
          //         ),
          //         context,
          //       );
          //     },
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
        ),
        // body: Column(
        //   children: [
        //     TextButton(
        //       child: const Text("Show Notification"),
        //       onPressed: () {
        //         LocalNotificationService().showNotification(
        //           title: "Galaxy 12 nomli maxsulot qo'shildi!",
        //           body: "Maxsulot haqida ma'lumot olishingiz mumkin.",
        //           id: 1,
        //         );
        //         // id++;
        //       },
        //     ),
        //     TextButton(
        //       child: const Text("Cancel Notification"),
        //       onPressed: () {
        //         LocalNotificationService().cancelNotification(3);
        //       },
        //     ),
        //     TextButton(
        //       child: const Text("Show Periodic Notification"),
        //       onPressed: () {
        //         LocalNotificationService().scheduleNotification(
        //           title: "Galaxy 12 nomli maxsulot qo'shildi!",
        //           body: "Maxsulot haqida ma'lumot olishingiz mumkin.",
        //           delayedTime: 5,
        //         );
        //       },
        //     ),
        //   ],
        // ));
    );
  }
}
