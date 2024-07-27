import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/routes.dart';
import 'package:file_picker/file_picker.dart';

class MedicalHistoryController extends GetxController {
  late List medicalHistory;
  late String patientId;
  late String myRole;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  TextEditingController descriptionCon = TextEditingController();
  File? medicalHistoryFile;

  @override
  void onInit() {
    myRole = myServices.sharedPreferences.getString('role')!;
    medicalHistory = Get.arguments['medical_history'];
    if (myRole == '2') {
      patientId = myServices.sharedPreferences.getString('id')!;
    } else {
      patientId = Get.arguments['patient_id'];
    }
    super.onInit();
  }

  goToAddMedicalHistory() {
    Get.toNamed(AppRoutes.addMedicalHistoryScreen);
  }

  chooseMedicalHistoryFile() async {
    FilePickerResult? selectedFile = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['webp', 'jpeg', 'png', 'jpg', 'pdf'],
    );
    Directory temp = await getTemporaryDirectory();
    int random = Random().nextInt(99999999);
    if (selectedFile != null) {
      if (GetUtils.isImage(selectedFile.paths[0]!)) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: selectedFile.paths[0]!,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Edit Image',
              toolbarColor: AppColors.primaryColor,
              toolbarWidgetColor: AppColors.secondaryColor,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              activeControlsWidgetColor: AppColors.primaryColor,
            ),
            IOSUiSettings(title: 'Edit Image'),
          ],
        );
        if (croppedFile != null) {
          XFile? compressedPfp = await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            '${temp.path}/compressed$random.${croppedFile.path.split('.').last}',
            quality: 80,
          );
          if (compressedPfp != null) {
            medicalHistoryFile = File(compressedPfp.path);
          } else {
            medicalHistoryFile = File(croppedFile.path);
          }
        }
      } else if (GetUtils.isPDF(selectedFile.paths[0]!)) {
        String compressedPdf = '${temp.path}/compressed$random.pdf';
        await PdfCompressor.compressPdfFile(
          selectedFile.paths[0]!,
          compressedPdf,
          CompressQuality.MEDIUM,
        );
        medicalHistoryFile = File(compressedPdf);
      }
    }

    update();
  }

  uploadMedicalHistory() async {
    if (descriptionCon.text.isNotEmpty) {
      loading();
      var res = await uploadMedicalHistoryRequset();

      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        await getMedicalHistory();
        Get.back();
        addScreenWillPop();
        Fluttertoast.showToast(
          msg: 'Added Successfully',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      } else {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Something went wrong',
          textColor: AppColors.black,
          backgroundColor: AppColors.secondaryColor,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Description Can\'t Be Empty',
        textColor: AppColors.black,
        backgroundColor: AppColors.secondaryColor,
      );
    }
  }

  uploadMedicalHistoryRequset() async {
    var res = await crud.connect(
      link: AppLinks.uploadMedicalHistory,
      file: medicalHistoryFile,
      fileRequestName: 'user_file',
      data: {
        'patient_id': patientId,
        'description': descriptionCon.text.trim(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getMedicalHistory() async {
    var res = await getMedicalHistoryRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        medicalHistory = responseModel.medicalHistoryList!;
        update();
      }
    }
  }

  getMedicalHistoryRequest() async {
    var res = await crud.connect(
      link: AppLinks.medicalHistory,
      data: {
        'patient_id': patientId,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> addScreenWillPop() {
    descriptionCon.clear();
    medicalHistoryFile = null;
    Get.back();
    return Future.value(false);
  }
}
