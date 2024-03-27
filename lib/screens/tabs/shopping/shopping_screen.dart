
import 'package:flutter/material.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/view_models/local_notification_view_model.dart';
import 'package:provider/provider.dart';


class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    final notificationViewModel=Provider.of<NotificationViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Shoppig"),
        ),
        body: (notificationViewModel.getNotifications().isNotEmpty)?Column(children: [
          SizedBox(height: 40,),
          for(var notification in notificationViewModel.getNotifications())
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 24.w),
            child: ListTile(
                title:Text(notification.name),
              ),
          )
        ],):const Center(child: Text("Empty"),)

    );
  }
}
