import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_furniture_project/data/model/notification_model.dart';
import 'package:my_furniture_project/screens/routes.dart';
import 'package:my_furniture_project/servise/local_notification_service.dart';
import 'package:my_furniture_project/utils/colors/app_colors.dart';
import 'package:my_furniture_project/utils/size/size_utils.dart';
import 'package:my_furniture_project/utils/styles/app_text_style.dart';
import 'package:my_furniture_project/view_models/local_notification_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../data/api_provider/api_provider.dart';
import '../../../../data/model/category_model.dart';
import '../../../../view_models/category_view_model.dart';
import '../../../../view_models/image_view_model.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController=TextEditingController();
  // TextEditingController imageController=TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";
  String fcmToken='';
  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().second.toInt(),
          );
          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }
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
        title:  Text('Add Category',style: AppTextStyle.interRegular.copyWith(
          color: AppColors.c_0C8A7B,fontSize: 24
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                takeAnImage();
              },
              child: Text(
                "TAKE AN IMAGE",
                style: AppTextStyle.interSemiBold.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            if (context.watch<ImageViewModel>().getLoader)
            const CircularProgressIndicator(),
            if (imageUrl.isNotEmpty) Image.network(imageUrl),
            // TextField(
            //   controller: imageController,
            //   decoration: InputDecoration(
            //     hintText: 'Enter image url',
            //       border:OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(16),
            //           borderSide: BorderSide(
            //             width: 1,color: AppColors.black.withOpacity(0.7),
            //           )
            //       )
            //   ),
            // ),
            TextButton(
                onPressed: ()async{
              if (imageUrl.isNotEmpty &&
                  nameController.text.isNotEmpty) {
                await context.read<CategoriesViewModel>().insertCategory(
                  CategoryModel(
                    storagePath: storagePath,
                    imageUrl: imageUrl,
                    categoryName: nameController.text,
                    docId: "",
                  ),
                  context,
                );
                Navigator.pushReplacementNamed(context,RouteNames.tabRoute);
              }
              NotificationModel notification=NotificationModel(name: "${nameController.text} category qoshildi", id:DateTime.now().millisecond);
              context.read<NotificationViewModel>().addNotification(notification);
              String messageId = await ApiProvider().sendNotificationToUsers(
                topicName: 'news',
                title: "${nameController.text} category qoshildi",
                body: "Mahsulotni korish",
              );
              debugPrint("MESSAGE ID:$messageId");
              },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.c_0C8A7B,
                ),
                child:Text('Save',style: AppTextStyle.interRegular.copyWith(
                  fontSize: 14.w,color: AppColors.white
                ),))
          ],),
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
  }
}
