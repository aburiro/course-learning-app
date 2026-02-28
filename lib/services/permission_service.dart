import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();
  static final PermissionService instance = PermissionService._();

  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    }
    final photosStatus = await Permission.photos.request();
    return photosStatus.isGranted;
  }

  Future<void> openSettingsIfDenied() async {
    await openAppSettings();
  }
}
