import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teleprac/controller/main_controller.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/pharmacies/pharmacy_model.dart';
import 'package:teleprac/model/profile/patient_profile_model.dart';
import 'package:teleprac/routes.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProfileController extends GetxController {
  late PatientProfileModel patientProfileModel;
  late AdvancedDoctorModel advancedDoctorModel;
  late PharmacyModel pharmacyModel;
  late String userID;
  late String userName;
  late String firstName;
  late String lastName;
  late String fullName;
  late String userEmail;
  late String userPFP;
  late String userPhone;
  late String userToken;
  late String userRole;
  //
  File? pfp;
  late String gender;
  late String dob;
  late String bloodGroup;
  late String city;
  late String state;
  late String priceType;
  late String specialization;
  late List awards;
  late List memberships;
  late List educations;
  late List registrations;
  late List experiences;
  late List services;
  late String servicesString;
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController firstAddressCon = TextEditingController();
  TextEditingController secondAddressCon = TextEditingController();
  TextEditingController postalCodeCon = TextEditingController();
  TextEditingController biographyCon = TextEditingController();
  TextEditingController clinicNameCon = TextEditingController();
  TextEditingController clinicAddressCon = TextEditingController();
  TextEditingController registerNoCon = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  TextEditingController servicesCon = TextEditingController();
  //
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode firstAddressFocus = FocusNode();
  FocusNode secondAddressFocus = FocusNode();
  FocusNode postalCodeFocus = FocusNode();
  FocusNode clinicNameFocus = FocusNode();
  FocusNode clinicAddressFocus = FocusNode();
  FocusNode servicesFocus = FocusNode();
  //
  String firstNameValidationText = '';
  String lastNameValidationText = '';
  String dobValidationText = '';
  String genderValidationText = '';
  String bloodGroupValidationText = '';
  String firstAddressValidationText = '';
  String secondAddressValidationText = '';
  String stateValidationText = '';
  String cityValidationText = '';
  String postalCodeValidationText = '';
  String pforilePictureValidationText = '';
  String specializationValidationText = '';
  String regNumValidationText = '';
  //
  late List states;
  List priceTypes = [
    {
      'value': 'Free',
    },
    {
      'value': 'Custom Price',
    },
  ];
  List bloodGroups = [
    {
      'value': '1',
      'label': 'A+',
    },
    {
      'value': '2',
      'label': 'A-',
    },
    {
      'value': '3',
      'label': 'B+',
    },
    {
      'value': '4',
      'label': 'B-',
    },
    {
      'value': '5',
      'label': 'AB+',
    },
    {
      'value': '6',
      'label': 'AB-',
    },
    {
      'value': '7',
      'label': 'O+',
    },
    {
      'value': '8',
      'label': 'O-',
    },
  ];
  List genders = [
    {
      'value': '1',
      'label': 'Male',
    },
    {
      'value': '2',
      'label': 'Female',
    }
  ];
  List cities = [];
  late List specializationsList;
  MyServices myServices = Get.find();
  MainController mainController = Get.find();
  Crud crud = Crud();

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    initUserData();
    super.onInit();
  }

  initUserData() {
    userID = myServices.sharedPreferences.getString('id')!;
    userName = myServices.sharedPreferences.getString('username')!;
    userRole = myServices.sharedPreferences.getString('role')!;
    firstName = myServices.sharedPreferences.getString('first_name')!;
    lastName = myServices.sharedPreferences.getString('last_name')!;
    fullName = '$firstName $lastName';
    userPFP = myServices.sharedPreferences.getString('pfp')!;
    userEmail = myServices.sharedPreferences.getString('email')!;
    userToken = myServices.sharedPreferences.getString('token')!;
    userPhone = myServices.sharedPreferences.getString('mobileNumber')!;
    if (Get.arguments['patientModel'] != null) {
      patientProfileModel = Get.arguments['patientModel'];
      states = Get.arguments['states'];
      firstNameCon.text = patientProfileModel.firstName!;
      lastNameCon.text = patientProfileModel.lastName!;
      dob = patientProfileModel.dob!;
      firstAddressCon.text = patientProfileModel.address1!;
      secondAddressCon.text = patientProfileModel.address2!;
      if (patientProfileModel.gender != null &&
          patientProfileModel.gender!.removeAllWhitespace.isNotEmpty &&
          patientProfileModel.gender != '0') {
        gender = genders
            .where((element) =>
                element['label'].toString().toLowerCase() ==
                patientProfileModel.gender.toString().toLowerCase())
            .toList()[0]['value'];
      } else {
        gender = '';
      }
      if (patientProfileModel.bloodGroup != null &&
          patientProfileModel.bloodGroup!.removeAllWhitespace.isNotEmpty &&
          patientProfileModel.bloodGroup != '0') {
        bloodGroup = bloodGroups
            .where((element) =>
                element['label'].toString().toLowerCase() ==
                patientProfileModel.bloodGroup.toString().toLowerCase())
            .toList()[0]['value'];
      } else {
        bloodGroup = '';
      }
      if (patientProfileModel.state != null &&
          patientProfileModel.state!.removeAllWhitespace.isNotEmpty &&
          patientProfileModel.state != '0') {
        state = states
            .where((element) => element['value'] == patientProfileModel.state)
            .toList()[0]['value'];
      } else {
        state = '';
      }
      if (patientProfileModel.cityname != null &&
          patientProfileModel.cityname!.isNotEmpty &&
          patientProfileModel.cityname != '0') {
        cities = [
          {
            'value': patientProfileModel.city,
            'label': patientProfileModel.cityname,
          }
        ];
        city = patientProfileModel.city!;
      } else {
        city = '';
      }
      postalCodeCon.text = patientProfileModel.postalCode!;
    } else if (Get.arguments['doctorModel'] != null) {
      advancedDoctorModel = Get.arguments['doctorModel'];
      specializationsList = Get.arguments['specializationsList'];
      states = Get.arguments['states'];
      firstNameCon.text = advancedDoctorModel.doctorDetails!.firstName!;
      lastNameCon.text = advancedDoctorModel.doctorDetails!.lastName!;
      dob = advancedDoctorModel.doctorDetails!.dob!;
      firstAddressCon.text = advancedDoctorModel.doctorDetails!.address1!;
      secondAddressCon.text = advancedDoctorModel.doctorDetails!.address2!;
      if (advancedDoctorModel.doctorDetails!.gender != null &&
          advancedDoctorModel
              .doctorDetails!.gender!.removeAllWhitespace.isNotEmpty &&
          advancedDoctorModel.doctorDetails!.gender != '0') {
        gender = genders
            .where((element) =>
                element['label'].toString().toLowerCase() ==
                advancedDoctorModel.doctorDetails!.gender
                    .toString()
                    .toLowerCase())
            .toList()[0]['value'];
      } else {
        gender = '';
      }
      if (advancedDoctorModel.doctorDetails!.bloodGroup != null &&
          advancedDoctorModel
              .doctorDetails!.bloodGroup!.removeAllWhitespace.isNotEmpty &&
          advancedDoctorModel.doctorDetails!.bloodGroup != '0') {
        bloodGroup = bloodGroups
            .where((element) =>
                element['label'].toString().toLowerCase() ==
                advancedDoctorModel.doctorDetails!.bloodGroup
                    .toString()
                    .toLowerCase())
            .toList()[0]['value'];
      } else {
        bloodGroup = '';
      }
      if (advancedDoctorModel.doctorDetails!.state != null &&
          advancedDoctorModel
              .doctorDetails!.state!.removeAllWhitespace.isNotEmpty &&
          advancedDoctorModel.doctorDetails!.state != '0') {
        state = states
            .where((element) =>
                element['value'] == advancedDoctorModel.doctorDetails!.state)
            .toList()[0]['value'];
      } else {
        state = '';
      }
      if (advancedDoctorModel.doctorDetails!.cityname != null &&
          advancedDoctorModel.doctorDetails!.cityname!.isNotEmpty &&
          advancedDoctorModel.doctorDetails!.cityname != '0') {
        cities = [
          {
            'value': advancedDoctorModel.doctorDetails!.city,
            'label': advancedDoctorModel.doctorDetails!.cityname,
          }
        ];
        city = advancedDoctorModel.doctorDetails!.city!;
      } else {
        city = '';
      }
      postalCodeCon.text = advancedDoctorModel.doctorDetails!.postalCode!;
      priceType = advancedDoctorModel.doctorDetails!.priceType!;
      amountCon.text = advancedDoctorModel.doctorDetails!.amount!;
      clinicAddressCon.text = advancedDoctorModel.doctorDetails!.clinicAddress!;
      clinicNameCon.text = advancedDoctorModel.doctorDetails!.clinicName!;
      services = advancedDoctorModel.doctorDetails!.services!.isNotEmpty
          ? advancedDoctorModel.doctorDetails!.services!.split(',')
          : [];
      servicesString = advancedDoctorModel.doctorDetails!.services!;
      awards = advancedDoctorModel.toJson()['awards'] ?? [];
      memberships = advancedDoctorModel.toJson()['memberships'] ?? [];
      educations = advancedDoctorModel.toJson()['education'] ?? [];
      experiences = advancedDoctorModel.toJson()['experience'] ?? [];
      registrations = advancedDoctorModel.toJson()['registrations'] ?? [];
      registerNoCon.text =
          registrations.isNotEmpty ? registrations[0]['registrations'] : '';
      biographyCon.text =
          advancedDoctorModel.doctorDetails!.biography != null &&
                  advancedDoctorModel.doctorDetails!.biography
                      .toString()
                      .replaceAll('null', '')
                      .isNotEmpty
              ? parse(advancedDoctorModel.doctorDetails!.biography).body!.text
              : '';
      if (advancedDoctorModel.doctorDetails!.specialization != null &&
          advancedDoctorModel.doctorDetails!.specialization!.isNotEmpty &&
          advancedDoctorModel.doctorDetails!.specialization != '0') {
        specialization = advancedDoctorModel.doctorDetails!.specialization!;
      } else {
        specialization = '';
      }
    } else if (Get.arguments['pharmacyModel'] != null) {
      pharmacyModel = Get.arguments['pharmacyModel'];
      states = Get.arguments['states'];
      firstNameCon.text = pharmacyModel.pharmacyName.toString().split(' ')[0];
      lastNameCon.text = pharmacyModel.pharmacyName.toString().split(' ')[1];
      firstAddressCon.text = pharmacyModel.address1!;
      secondAddressCon.text = pharmacyModel.address2!;
      if (pharmacyModel.statename != null &&
          pharmacyModel.statename!.removeAllWhitespace.isNotEmpty &&
          pharmacyModel.statename != '0') {
        state = states
            .where((element) => element['label'] == pharmacyModel.statename)
            .toList()[0]['value'];
      } else {
        state = '';
      }
    }
  }

  updatePatientProfile() async {
    if (mainValidate()) {
      loading();
      var res = await updatePatientProfileRequest();
      Get.back();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseMessage.toString().trim() ==
                'Profile successfully updated' &&
            responseModel.responseCode == '200') {
          await myServices.sharedPreferences.setString(
            'pfp',
            AppLinks.baseUrl + res['data']['patient_details']['profileimage'],
          );
          await myServices.sharedPreferences.setString(
              'first_name', res['data']['patient_details']['first_name']);
          await myServices.sharedPreferences.setString(
              'last_name', res['data']['patient_details']['last_name']);
          await myServices.sharedPreferences.setString(
            'currentLocation',
            res['data']['patient_details']['cityname'],
          );
          mainController.currentLocation =
              res['data']['patient_details']['cityname'];

          mainController.lastName = res['data']['patient_details']['last_name'];
          mainController.firstName =
              res['data']['patient_details']['first_name'];
          mainController.lastName = res['data']['patient_details']['last_name'];
          mainController.fullName =
              '${mainController.firstName} ${mainController.lastName}';
          Get.offAllNamed(
            AppRoutes.successScreen,
            arguments: {
              'function': () {
                Get.offAllNamed(AppRoutes.home);
              },
              'buttonText': 'Home',
            },
          );
        } else {
          Get.defaultDialog(
            middleText: 'Something Went Wrong',
          );
        }
      }
    }
  }

  updatePatientProfileRequest() async {
    var res = await crud.connect(
      link: AppLinks.updatePatientProfile,
      file: pfp,
      fileRequestName: 'profile_image',
      data: {
        'first_name': firstNameCon.text.trim(),
        'last_name': lastNameCon.text.trim(),
        'address1': firstAddressCon.text.trim(),
        'address2': secondAddressCon.text.trim(),
        'postal_code': postalCodeCon.text.trim(),
        'dob': dob,
        'gender': gender == '1' ? 'Male' : 'Female',
        'blood_group': bloodGroups
            .where((element) => element['value'] == bloodGroup)
            .toList()[0]['label'],
        'state': state,
        'city': city,
        'country': '101',
      },
      headers: {
        'token': userToken,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  updateDoctorProfile() async {
    if (mainValidate() && doctorValidate()) {
      loading();
      var res = await updateDoctorProfileRequest();
      Get.back();
      if (res is RequsetStatus == false) {
        ResponseModel responseModel = ResponseModel.fromJson(res);
        if (responseModel.responseMessage.toString().trim() ==
                'Profile successfully updated' &&
            responseModel.responseCode == '200') {
          await myServices.sharedPreferences.setString(
            'pfp',
            AppLinks.baseUrl + res['data']['doctor_details']['profileimage'],
          );
          await myServices.sharedPreferences.setString(
              'first_name', res['data']['doctor_details']['first_name']);
          await myServices.sharedPreferences.setString(
              'last_name', res['data']['doctor_details']['last_name']);
          await myServices.sharedPreferences.setString(
            'currentLocation',
            res['data']['doctor_details']['cityname'],
          );
          mainController.currentLocation =
              res['data']['doctor_details']['cityname'];

          mainController.firstName =
              res['data']['doctor_details']['first_name'];
          mainController.lastName = res['data']['doctor_details']['last_name'];

          mainController.fullName =
              '${mainController.firstName} ${mainController.lastName}';
          Get.offAllNamed(
            AppRoutes.successScreen,
            arguments: {
              'function': () {
                Get.offAllNamed(AppRoutes.home);
              },
              'buttonText': 'Home',
            },
          );
        } else {
          Get.defaultDialog(
            middleText: 'Something Went Wrong',
          );
        }
      }
    }
  }

  updateDoctorProfileRequest() async {
    List filteredEducations = [];
    List filteredExperiences = [];
    for (Map educationMap in educations) {
      if (educationMap['degree'].toString().isNotEmpty) {
        filteredEducations.add(educationMap);
      }
    }
    for (Map expMap in experiences) {
      if (expMap['hospital_name'].toString().isNotEmpty) {
        filteredExperiences.add(expMap);
      }
    }

    var res = await crud.connect(
      link: AppLinks.updateDoctorProfile,
      file: pfp,
      fileRequestName: 'profile_image',
      data: {
        'first_name': firstNameCon.text.trim(),
        'last_name': lastNameCon.text.trim(),
        'address1': firstAddressCon.text.trim(),
        'address2': secondAddressCon.text.trim(),
        'postal_code': postalCodeCon.text.trim(),
        'dob': dob,
        'gender': gender == '1' ? 'Male' : 'Female',
        'blood_group': bloodGroups
            .where((element) => element['value'] == bloodGroup)
            .toList()[0]['label'],
        'state': state,
        'city': city,
        'country': '101',
        'biography': biographyCon.text.trim(),
        'clinic_name': clinicNameCon.text.trim(),
        'clinic_address': clinicAddressCon.text.trim(),
        'register_no': registerNoCon.text.trim(),
        'services': servicesString,
        'specialization': specialization,
        'price_type': priceType,
        'amount': amountCon.text,
        'educations': jsonEncode(filteredEducations),
        'experiences': jsonEncode(filteredExperiences),
        'awards': jsonEncode(awards),
        'memberships': jsonEncode(memberships),
        'registrations': jsonEncode([
          {
            'registrations': registerNoCon.text.trim(),
            'registrations_year': '',
            'registrations_ts': ''
          }
        ]),
      },
      headers: {
        'token': userToken,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  updatePharmacyProfile() async {
    // loading();
    // var res = await updatePharmacyProfileRequest();
    // // Get.back();
    // if (res is RequsetStatus == false) {
    //   ResponseModel responseModel = ResponseModel.fromJson(res);
    //   if (responseModel.responseMessage.toString().trim() ==
    //           'Profile successfully updated' &&
    //       responseModel.responseCode == '200') {
    //     Get.toNamed(
    //       AppRoutes.successScreen,
    //       arguments: {
    //         'function': () {
    //           Get.offAllNamed(AppRoutes.home);
    //         },
    //         'buttonText': 'Home',
    //       },
    //     );
    //   } else {
    //     Get.defaultDialog(
    //       middleText: 'Something Went Wrong',
    //     );
    //   }
    // }
  }

  updatePharmacyProfileRequest() async {
    var res = await crud.connect(
      link: AppLinks.updatePharmacyProfile,
      file: pfp,
      fileRequestName: 'profile_image',
      data: {
        'pharmacy_name': 'sssssssss',
        "mobile_number": "9573359954",
        "dob": "1970-01-01",
        "gender": 'pharmacy',
        'postal_code': '55555',
        "blood_group": 'pharmacy',
        'first_name': firstNameCon.text.trim(),
        'last_name': lastNameCon.text.trim(),
        'address1': firstAddressCon.text.trim(),
        'address2': secondAddressCon.text.trim(),
        'home_delivery': '1',
        '24hrsopen': '0',
        'pharamcy_opens_at': '9:00 AM',
        'country': '101',
        'state': '8',
        'city': '703',
      },
      headers: {
        'token': userToken,
      },
    );

    return res.fold((l) => l, (r) => r);
  }

  firstNameEditingCompleted() {
    if (firstNameCon.text.isNotEmpty) {
      firstNameValidationText = '';
      update();
      lastNameFocus.requestFocus();
    } else {
      firstNameValidationText = 'Please type your first name';
      update();
    }
  }

  lastNameEditingCompleted() {
    if (lastNameCon.text.isNotEmpty) {
      lastNameValidationText = '';
      update();
      firstAddressFocus.requestFocus();
    } else {
      lastNameValidationText = 'Please type your last name';
      update();
    }
  }

  firstAddressEditingCompleted() {
    if (firstAddressCon.text.isNotEmpty) {
      firstAddressValidationText = '';
      update();
      secondAddressFocus.requestFocus();
    } else {
      firstAddressValidationText = 'Please type your first address';
      update();
    }
  }

  secondAddressEditingCompleted() {
    if (secondAddressCon.text.isNotEmpty) {
      secondAddressValidationText = '';
      update();
      postalCodeFocus.requestFocus();
    } else {
      secondAddressValidationText = 'Please type your second address';
      update();
    }
  }

  postalCodeEditingCompleted() {
    if (postalCodeCon.text.isNotEmpty) {
      postalCodeValidationText = '';
      update();
    } else {
      postalCodeValidationText = 'Please type your postal code';
      update();
    }
  }

  stateSelected({required String id}) async {
    state = id;
    loading();
    var res = await citiesRequest(id: id);
    Get.back();
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      if (responseModel.responseCode.toString().trim() == '200') {
        cities = responseModel.requestedList!;
        update();
      }
    }
  }

  citiesRequest({required String id}) async {
    var res = await crud.connect(
      link: AppLinks.locationsApi,
      data: {
        'type': '3',
        'id': id,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }

  selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          dob.isEmpty ? DateTime.parse('2000-01-01') : DateTime.parse(dob),
      firstDate: DateTime.parse('1900-01-01'),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dob = picked.toString().substring(0, 10);
      update();
    }
  }

  bool mainValidate() {
    bool bloodGroupV = false;
    bool dobV = false;
    bool firstNameV = false;
    bool lastNameV = false;
    bool firstAddressV = false;
    bool secondAddressV = false;
    bool postalCodeV = false;
    bool stateV = false;
    bool cityV = false;

    if (DateTime.parse(dob)
        .isBefore(DateTime.now().add(const Duration(days: 1)))) {
      dobV = true;
    } else {
      dobV = false;
    }

    if (firstNameCon.text.isNotEmpty) {
      firstNameValidationText = '';
      firstNameV = true;
    } else {
      firstNameValidationText = 'Please type your first name';
      firstNameV = false;
    }

    if (lastNameCon.text.isNotEmpty) {
      lastNameValidationText = '';
      lastNameV = true;
    } else {
      lastNameValidationText = 'Please type your last name';
      lastNameV = false;
    }

    if (firstAddressCon.text.isNotEmpty) {
      firstAddressValidationText = '';
      firstAddressV = true;
    } else {
      firstAddressValidationText = 'Please type your first address';
      firstAddressV = false;
    }

    if (secondAddressCon.text.isNotEmpty) {
      secondAddressValidationText = '';
      secondAddressV = true;
    } else {
      secondAddressValidationText = 'Please type your second address';
      secondAddressV = false;
    }

    if (postalCodeCon.text.isNotEmpty) {
      postalCodeValidationText = '';
      postalCodeV = true;
    } else {
      postalCodeValidationText = 'Please type your postal code';
      postalCodeV = false;
    }

    if (state.isEmpty || state == '0') {
      stateV = false;
      stateValidationText = 'State shouldn\'t be empty';
    } else {
      stateV = true;
      stateValidationText = '';
    }
    if (city.isEmpty || city == '0') {
      cityV = false;
      cityValidationText = 'City shouldn\'t be empty';
    } else {
      cityV = true;
      cityValidationText = '';
    }
    if (bloodGroup.isEmpty) {
      bloodGroupV = false;
      bloodGroupValidationText = 'Can\'t be empty';
    } else {
      bloodGroupV = true;
      bloodGroupValidationText = '';
    }
    update();
    if (dobV &&
        firstNameV &&
        lastNameV &&
        firstAddressV &&
        secondAddressV &&
        postalCodeV &&
        stateV &&
        cityV &&
        bloodGroupV) {
      return true;
    } else {
      return false;
    }
  }

  bool doctorValidate() {
    bool specialityV = false;
    bool regNumV = false;
    if (specialization.isEmpty) {
      specialityV = false;
      specializationValidationText = 'Can\'t be empty';
    } else {
      specialityV = true;
      specializationValidationText = '';
    }
    if (registerNoCon.text.isEmpty) {
      regNumV = false;
      regNumValidationText = 'Can\'t be empty';
    } else {
      regNumV = true;
      regNumValidationText = '';
    }

    update();

    return specialityV && regNumV;
  }

  choosePicture() async {
    XFile? pickedPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    int random = Random().nextInt(99999999);

    if (pickedPhoto != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedPhoto.path,
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
        Directory temp = await getTemporaryDirectory();
        XFile? compressedPfp = await FlutterImageCompress.compressAndGetFile(
          croppedFile.path,
          '${temp.path}/compressed$random.${croppedFile.path.split('.').last}',
          quality: 80,
        );
        if (compressedPfp != null) {
          pfp = File(compressedPfp.path);
        } else {
          pfp = File(croppedFile.path);
        }
        update();
      }
    }
  }

  Future<bool> willPop() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    Get.back();
    return Future.value(false);
  }
}
