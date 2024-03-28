import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    debugPrint("STORAGE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      debugPrint("STORAGE STATUS AFTER ASK:$status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.phone.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.microphone.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getCalendarFullAccessPermission() async {
    PermissionStatus status = await Permission.calendarFullAccess.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.calendarFullAccess.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getPhotosPermission() async {
    PermissionStatus status = await Permission.photos.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.photos.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getVideosPermission() async {
    PermissionStatus status = await Permission.videos.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.videos.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }


  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.sms,
      Permission.speech,
      Permission.audio,
      Permission.nearbyWifiDevices,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
        await permissions.request();

    debugPrint(
        "NOTIFICATION STATUS AFTER ASK:${somePermissionsResults[Permission.notification]}");
    debugPrint(
        "SMS STATUS AFTER ASK:${somePermissionsResults[Permission.sms]}");
    debugPrint(
        " SPEECH AFTER ASK:${somePermissionsResults[Permission.speech]}");
  }
}
