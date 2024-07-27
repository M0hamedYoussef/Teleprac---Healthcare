class ResponseModel {
  String? responseCode;
  String? responseMessage;
  Map<String, dynamic>? userData;
  dynamic data;
  String? baseUrl;
  List? doctorsList;
  List? specializationsList;
  List? labsList;
  List? clinicsList;
  List? offersList;
  List? blogsList;
  List? testsList;
  List? productsList;
  List? requestedList;
  List? appointmentsList;
  List? prescriptionsList;
  List? invoicesList;
  List? chatsList;
  List? chatMessages;
  List? ordersList;
  List? patientsList;
  List? medicalHistoryList;
  List? reviewsList;
  List? myProductsList;
  List? scheduleList;
  List? recommendedTestsList;
  List? accounts;
  String? slotDuration;
  Map<String, dynamic>? labDetails;
  Map<String, dynamic>? patientDetails;
  Map<String, dynamic>? additionalCallData;

  ResponseModel({
    this.responseCode,
    this.responseMessage,
    this.baseUrl,
    this.userData,
    this.data,
    this.doctorsList,
    this.specializationsList,
    this.labsList,
    this.offersList,
    this.clinicsList,
    this.blogsList,
    this.testsList,
    this.labDetails,
    this.patientDetails,
    this.requestedList,
    this.productsList,
    this.appointmentsList,
    this.prescriptionsList,
    this.invoicesList,
    this.chatsList,
    this.chatMessages,
    this.ordersList,
    this.patientsList,
    this.reviewsList,
    this.medicalHistoryList,
    this.myProductsList,
    this.additionalCallData,
    this.scheduleList,
    this.recommendedTestsList,
    this.slotDuration,
    this.accounts,
  });

  ResponseModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> responseData = json['response'];
    data = json['data'] ?? [];
    responseCode = responseData['response_code'].toString();
    responseMessage = responseData['response_message'];
    baseUrl = responseData['base_url'];

    if (data is Map && data != null) {
      Map dataMap = data;
      userData = dataMap.containsKey('user_details')
          ? dataMap['user_details'] is Map<String, dynamic>?
              ? dataMap['user_details']
              : null
          : null;
      if (dataMap.containsKey('data')) {
        if (dataMap['data'] is List) {
          doctorsList = dataMap.containsKey('doctor_list')
              ? dataMap['doctor_list']
              : dataMap['data'];
        } else {
          doctorsList = dataMap.containsKey('doctor_list')
              ? dataMap['doctor_list']
              : null;
        }
      } else {
        doctorsList =
            dataMap.containsKey('doctor_list') ? dataMap['doctor_list'] : null;
      }
      specializationsList = dataMap.containsKey('specialization_list')
          ? dataMap['specialization_list']
          : null;
      recommendedTestsList = dataMap.containsKey('customlabtest_list')
          ? dataMap['customlabtest_list']
          : null;
      labsList = dataMap.containsKey('lab_list') ? dataMap['lab_list'] : null;
      testsList =
          dataMap.containsKey('test_list') ? dataMap['test_list'] : null;
      clinicsList =
          dataMap.containsKey('clinic_list') ? dataMap['clinic_list'] : null;
      offersList =
          dataMap.containsKey('offer_list') ? dataMap['offer_list'] : null;
      blogsList =
          dataMap.containsKey('blogs_lists') ? dataMap['blogs_lists'] : null;
      labDetails =
          dataMap.containsKey('lab_details') ? dataMap['lab_details'][0] : null;
      patientDetails = dataMap.containsKey('patient_details')
          ? dataMap['patient_details']
          : null;
      requestedList = dataMap.containsKey('list') ? dataMap['list'] : null;
      productsList = dataMap.containsKey('p_list') ? dataMap['p_list'] : null;
      appointmentsList = dataMap.containsKey('appointments_list')
          ? dataMap['appointments_list']
          : null;
      prescriptionsList = dataMap.containsKey('prescription_list')
          ? dataMap['prescription_list']
          : null;
      invoicesList =
          dataMap.containsKey('inv_list') ? dataMap['inv_list'] : null;
      chatsList =
          dataMap.containsKey('chat_list') ? dataMap['chat_list'] : null;
      chatMessages =
          dataMap.containsKey('chat_details') ? dataMap['chat_details'] : null;
      ordersList =
          dataMap.containsKey('order_list') ? dataMap['order_list'] : null;
      patientsList =
          dataMap.containsKey('patient_list') ? dataMap['patient_list'] : null;
      medicalHistoryList = dataMap.containsKey('medical_records_list')
          ? dataMap['medical_records_list']
          : null;
      reviewsList =
          dataMap.containsKey('reviews_list') ? dataMap['reviews_list'] : null;
      myProductsList =
          dataMap.containsKey('doc_list') ? dataMap['doc_list'] : null;
      additionalCallData = dataMap.containsKey('additional_key')
          ? dataMap['additional_key']
          : null;
      scheduleList = dataMap.containsKey('schedule_list')
          ? dataMap['schedule_list']
          : null;
      slotDuration = dataMap.containsKey('slot') ? dataMap['slot'] : null;
      accounts = dataMap.containsKey('accounts') ? dataMap['accounts'] : null;
    }
  }
}
