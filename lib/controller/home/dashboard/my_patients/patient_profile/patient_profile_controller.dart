import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:easy_signature_pad/easy_signature_pad.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/doctors/session_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/patient_model.dart';
import 'package:teleprac/model/labs/tests/test_model.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/routes.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class PatientProfileController extends GetxController {
  late PatientModel patientModel;
  late tz.Location indianTimeZone;
  late String myId;
  Crud crud = Crud();
  MyServices myServices = Get.find();
  late Directory appDocs;
  // Global
  TextEditingController chiefComplaintsCon = TextEditingController();
  TextEditingController ageCon = TextEditingController();
  FocusNode chiefComplaintsFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  File? signature;
  // Add Prescription
  TextEditingController heightCon = TextEditingController();
  TextEditingController weightCon = TextEditingController();
  TextEditingController lmpCon = TextEditingController();
  FocusNode heightFocus = FocusNode();
  FocusNode weightFocus = FocusNode();
  FocusNode lmpFocus = FocusNode();
  List medicines = [];
  List allMedicines = [];
  List medicineTypes = [
    {
      'value': 'Before Food',
      'label': 'Before Food',
    },
    {
      'value': 'After Food',
      'label': 'After Food',
    },
  ];
  // Add Test
  List tests = [];
  List allTests = [];
  //
  List sessions = [];
  @override
  onInit() async {
    patientModel = Get.arguments['patient_model'];
    appDocs = await getApplicationDocumentsDirectory();
    tz.initializeTimeZones();
    indianTimeZone = tz.getLocation('Asia/Kolkata');
    myId = myServices.sharedPreferences.getString('id')!;
    super.onInit();
  }

  goToAddPrescription() async {
    loading();
    await getAllMedicines();
    Get.offNamed(AppRoutes.addPrescriptionScreen);
  }

  goToAddTest() async {
    loading();
    await getAllTests();
    Get.offNamed(AppRoutes.addTestScreen);
  }

  goToMedicalHistory() {
    getMedicalHistory();
  }

  goToLabReports() {
    getLabReports();
  }

  addPrescription() async {
    List filteredMedicines = [];
    for (Map medicine in medicines) {
      if (medicine['drug_name'].toString().isNotEmpty) {
        filteredMedicines.add(medicine);
      }
    }
    if (filteredMedicines.isEmpty) {
      Get.defaultDialog(middleText: 'Please Add Medicine');
    } else {
      Get.defaultDialog(
        title: 'Please Sign Here',
        content: EasySignaturePad(
          borderColor: AppColors.black,
          onChanged: (value) {
            if (value.isNotEmpty) {
              Uint8List decodedSignature = base64Decode(value);
              int random = Random().nextInt(999999999);
              signature = File('${appDocs.path}/signature_$random.png');
              signature!.writeAsBytesSync(decodedSignature);
            } else {
              signature = null;
            }
          },
        ),
        actions: [
          CustomButton(
            function: () async {
              if (signature == null) {
                Get.defaultDialog(middleText: 'Please Sign First');
              } else {
                Get.back();
                loading();
                var res = await addPrescriptionRequest();
                if (res is RequsetStatus == false) {
                  ResponseModel responseModel = ResponseModel.fromJson(res);
                  if (responseModel.responseCode == '200') {
                    Fluttertoast.showToast(
                      msg: 'Added Successfully',
                      backgroundColor: AppColors.secondaryColor,
                      textColor: AppColors.black,
                    );
                    Get.back();
                    addPrescriptionScreenWillPop();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Something Went Wrong',
                      backgroundColor: AppColors.secondaryColor,
                      textColor: AppColors.black,
                    );
                    Get.back();
                  }
                }
              }
            },
            text: 'Confirm',
            buttonColor: AppColors.primaryColor,
            circularRadius: 10,
          )
        ],
      );
    }
  }

  addTest() async {
    List filteredTests = [];
    for (Map test in tests) {
      if (test['test_name'].toString().isNotEmpty) {
        filteredTests.add(test);
      }
    }
    if (filteredTests.isEmpty) {
      Get.defaultDialog(middleText: 'Please Add Test');
    } else {
      Get.defaultDialog(
        title: 'Please Sign Here',
        content: EasySignaturePad(
          borderColor: AppColors.black,
          onChanged: (value) {
            if (value.isNotEmpty) {
              Uint8List decodedSignature = base64Decode(value);
              int random = Random().nextInt(999999999);
              signature = File('${appDocs.path}/signature_$random.png');
              signature!.writeAsBytesSync(decodedSignature);
            } else {
              signature = null;
            }
          },
        ),
        actions: [
          CustomButton(
            function: () async {
              if (signature == null) {
                Get.defaultDialog(middleText: 'Please Sign First');
              } else {
                Get.back();
                loading();
                var res = await addTestRequest();
                if (res is RequsetStatus == false) {
                  ResponseModel responseModel = ResponseModel.fromJson(res);
                  if (responseModel.responseCode == '200') {
                    Fluttertoast.showToast(
                      msg: 'Added Successfully',
                      backgroundColor: AppColors.secondaryColor,
                      textColor: AppColors.black,
                    );
                    Get.back();
                    addTestScreenWillPop();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Something Went Wrong',
                      backgroundColor: AppColors.secondaryColor,
                      textColor: AppColors.black,
                    );
                    Get.back();
                  }
                }
              }
            },
            text: 'Confirm',
            buttonColor: AppColors.primaryColor,
            circularRadius: 10,
          )
        ],
      );
    }
  }

  getMedicalHistory() async {
    loading();
    var res = await getMedicalHistoryRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.medicalHistoryScreen,
          arguments: {
            'medical_history': responseModel.medicalHistoryList,
            'patient_id': patientModel.patientId,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  getLabReports() async {
    loading();
    var res = await getLabReportsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        Get.offNamed(
          AppRoutes.labAppointmentsScreen,
          arguments: {
            'labAppointmentsList': responseModel.appointmentsList,
          },
        );
      } else if (responseModel.responseCode == '201') {
        Get.back();
        Get.defaultDialog(middleText: 'List Is Empty');
      }
    }
  }

  getAllTests() async {
    var res = await getAllTestsRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        allTests = [];
        for (var test in responseModel.testsList!) {
          TestModel testModel = TestModel.fromJson(test);
          allTests.add(
            {
              'value': testModel.labTestName,
            },
          );
        }
      }
    }
  }

  getAllMedicines() async {
    var res = await getAllMedicinesRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        allMedicines = [];
        for (var product in responseModel.productsList!) {
          ProductModel productModel = ProductModel.fromJson(product);
          allMedicines.add(
            {
              'value': productModel.name,
            },
          );
        }
      }
    }
  }

  bookFollowUp() async {
    await checkAvailableTimes();
    String? nextAvailable = await nextAvailableAppointment();
    List<SessionModel> savedSessions = [];
    for (var element in sessions) {
      SessionModel sessionModel = SessionModel.fromJson(element);
      savedSessions.add(sessionModel);
    }
    sessions = [];

    Get.offNamed(
      AppRoutes.appointment,
      arguments: {
        'patient_id': patientModel.patientId,
        'doctor_id': myId,
        'today_sessions': savedSessions,
        'nextAvailable': nextAvailable,
        'previousRoute': Get.currentRoute,
        'amount': '0',
      },
    );
  }

  checkAvailableTimes() async {
    loading();
    var res = await checkAvailableTimesRequest();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode == '200') {
        if (responseModel.data is List) {
          for (var element in responseModel.data) {
            sessions.add(element);
          }
        }
      }
    }
  }

  nextAvailableAppointment() async {
    String? nextAvailable;
    var res = await nextAvailableAppointmentRequest();
    ResponseModel responseModel = ResponseModel.fromJson(res);
    if (responseModel.responseCode == '200') {
      nextAvailable =
          responseModel.data['next_availability'].toString() == 'null'
              ? null
              : responseModel.data['next_availability'].toString();
    }
    return nextAvailable;
  }

  // Api Requests
  addPrescriptionRequest() async {
    List filteredMedicines = [];
    for (Map medicine in medicines) {
      if (medicine['drug_name'].toString().isNotEmpty) {
        filteredMedicines.add(medicine);
      }
    }
    var res = await crud.connect(
      file: signature,
      fileRequestName: 'signature_image',
      link: AppLinks.addPrescription,
      data: {
        'patient_id': patientModel.patientId,
        'drug_details': jsonEncode(filteredMedicines),
        'chief_complaints': chiefComplaintsCon.text.trim(),
        'height': heightCon.text.trim(),
        'weight': weightCon.text.trim(),
        'lmp': lmpCon.text.trim(),
        'age': ageCon.text.trim(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  addTestRequest() async {
    List filteredTests = [];
    for (Map test in tests) {
      if (test['test_name'].toString().isNotEmpty) {
        filteredTests.add(test);
      }
    }
    var res = await crud.connect(
      file: signature,
      fileRequestName: 'signature_image',
      link: AppLinks.addTest,
      data: {
        'patient_id': patientModel.patientId,
        'chief_complaints': chiefComplaintsCon.text.trim(),
        'test_details': jsonEncode(filteredTests),
        'age': ageCon.text.trim(),
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getMedicalHistoryRequest() async {
    var res = await crud.connect(
      link: AppLinks.medicalHistory,
      data: {
        'patient_id': patientModel.patientId,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getLabReportsRequest() async {
    var res = await crud.connect(
      link: AppLinks.labReports,
      data: {
        'patient_id': patientModel.patientId,
      },
      headers: {
        'token': myServices.sharedPreferences.getString('token')!,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getAllTestsRequest() async {
    var res = await crud.connect(
      link: AppLinks.testsList,
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  getAllMedicinesRequest() async {
    var res = await crud.connect(
      link: AppLinks.pharmacyProducts,
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  checkAvailableTimesRequest() async {
    String todayDate =
        tz.TZDateTime.now(indianTimeZone).toString().substring(0, 10);
    var res = await crud.connect(
      link: AppLinks.availableSlots,
      data: {
        'schedule_date': todayDate,
        'doctor_id': myId,
      },
      headers: {
        'token': AppLinks.token,
        'timezone': 'Asia/Kolkata',
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  nextAvailableAppointmentRequest() async {
    var res = await crud.connect(
      link: AppLinks.nextAvailableAppointment,
      data: {
        'doctor_id': myId,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  Future<bool> addPrescriptionScreenWillPop() {
    Get.back();
    chiefComplaintsCon.clear();
    heightCon.clear();
    weightCon.clear();
    lmpCon.clear();
    ageCon.clear();
    medicines = [];
    signature = null;
    return Future.value(false);
  }

  Future<bool> addTestScreenWillPop() {
    Get.back();
    chiefComplaintsCon.clear();
    ageCon.clear();
    tests = [];
    signature = null;
    return Future.value(false);
  }
}
