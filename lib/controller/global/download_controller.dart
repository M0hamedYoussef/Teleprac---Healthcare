import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DownloadController extends GetxController {
  downloadFile({required String url}) async {
    if (GetPlatform.isAndroid) {
      PermissionStatus downloadPermission;
      AndroidDeviceInfo devInfo = await DeviceInfoPlugin().androidInfo;
      int androidVersion = int.parse(devInfo.version.release.split('.')[0]);

      if (androidVersion > 12) {
        downloadPermission = await Permission.manageExternalStorage.request();
      } else {
        downloadPermission = await Permission.storage.request();
      }

      if (downloadPermission.isGranted) {
        Fluttertoast.showToast(
          msg: 'Connecting',
          backgroundColor: AppColors.secondaryColor,
          textColor: AppColors.black,
        );
        var response = await get(
          Uri.parse(
            url,
          ),
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: 'Download Started',
            backgroundColor: AppColors.secondaryColor,
            textColor: AppColors.black,
          );

          String filename = url.split('/').last;

          final file = File('/storage/emulated/0/Download/$filename');
          await file.writeAsBytes(response.bodyBytes);
          await MediaScanner.loadMedia(path: file.path);

          Fluttertoast.showToast(
            msg: 'Downloaded',
            backgroundColor: AppColors.secondaryColor,
            textColor: AppColors.black,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Error : ${response.statusCode}',
            backgroundColor: AppColors.secondaryColor,
            textColor: AppColors.black,
          );
        }
      }
    } else {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
