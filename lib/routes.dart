import 'package:get/get.dart';
import 'package:teleprac/view/screens/auth/register/otp_verify_screen.dart';
import 'package:teleprac/view/screens/doctors/notify_me_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/accounts/doctor_account_update_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/accounts/doctor_accounts_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_family/family_member_screen.dart';
import 'package:teleprac/core/midleware/midleware.dart';
import 'package:teleprac/view/screens/auth/forgot_password.dart';
import 'package:teleprac/view/screens/auth/login_screen.dart';
import 'package:teleprac/view/screens/auth/register/register_screen.dart';
import 'package:teleprac/view/screens/doctors/appointment_screen.dart';
import 'package:teleprac/view/screens/doctors/doctor_screen.dart';
import 'package:teleprac/view/screens/global/contact_us.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/pay_for_lab_tests/check_out.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/pay_for_lab_tests/pay_for_lab_test.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/pay_for_medicines/check_out.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/pay_for_medicines/pay_for_medicines.dart';
import 'package:teleprac/view/screens/home/home_collection.dart';
import 'package:teleprac/view/screens/home/account_screen/account_screen.dart';
import 'package:teleprac/view/screens/home/account_screen/change_password.dart';
import 'package:teleprac/view/screens/home/account_screen/profile_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/dashboard_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_appointments/call_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_appointments/my_appointments_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_chats/chat_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_chats/my_chats_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_family/my_family_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_favourites_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_invoices_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_lab_appointments_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_orders/my_orders_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_patients/patient_profile/add_prescription_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_patients/my_patients_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_patients/patient_profile/add_test_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_patients/patient_profile/medical_history/add_medical_history_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_patients/patient_profile/medical_history/medical_history_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_patients/patient_profile/patient_profile_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_prescriptions/my_prescriptions_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_products/add_product_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_products/edit_product_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_products/my_products_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_reviews_screen.dart';
import 'package:teleprac/view/screens/home/dashboard_screen/my_schedules_screen.dart';
import 'package:teleprac/view/screens/home/my_cart/billing_screen.dart';
import 'package:teleprac/view/screens/home/my_cart/my_cart_screen.dart';
import 'package:teleprac/view/screens/home/doctors_screen.dart';
import 'package:teleprac/view/screens/global/success_screen.dart';
import 'package:teleprac/view/screens/home/home.dart';
import 'package:teleprac/view/screens/home/notifications_screen.dart';
import 'package:teleprac/view/screens/home/plan_your_surgery.dart';
import 'package:teleprac/view/screens/labs/lab_details_screen.dart';
import 'package:teleprac/view/screens/labs/labs_screen.dart';
import 'package:teleprac/view/screens/labs/tests/tests_of_lab_screen.dart';
import 'package:teleprac/view/screens/labs/tests/tests_screen.dart';
import 'package:teleprac/view/screens/offer_screen.dart';
import 'package:teleprac/view/screens/on_boarding.dart';
import 'package:teleprac/view/screens/pharmacies/pharmacies_products_screen.dart';
import 'package:teleprac/view/screens/pharmacies/pharmacies_screen.dart';
import 'package:teleprac/view/screens/pharmacies/pharmacy_details_screen.dart';
import 'package:teleprac/view/screens/pharmacies/product_details_screen.dart';
import 'package:teleprac/view/screens/specializations_screen.dart';
import 'package:teleprac/view/widgets/home/blogs/blog_screen.dart';

class AppRoutes {
  // Global
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String successScreen = '/successScreen';
  // Auth
  static const String register = '/register';
  static const String verifyOtp = '/verifyOtp';
  static const String login = '/login';
  static const String forgotPass = '/forgotPass';
  // Home
  static const String home = '/home';
  static const String homeCollection = '/homeCollection';
  static const String contactUs = '/contactUs';
  static const String planYourSurgery = '/planYourSurgery';
  static const String cart = '/cart';
  static const String notifications = '/notifications';
  static const String billing = '/billing';
  static const String offerScreen = '/offerScreen';
  static const String blogScreen = '/blogScreen';
  static const String accountScreen = '/accountScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String dashboardScreen = '/dashboardScreen';
  static const String profileScreen = '/profileScreen';
  // Dashboard
  static const String myAppointmentsScreen = '/myAppointmentsScreen';
  static const String callScreen = '/callScreen';
  static const String mySchedulseScreen = '/mySchedulseScreen';
  static const String myPrescriptionsScreen = '/myPrescriptionsScreen';
  static const String payForMedicinesScreen = '/payForMedicinesScreen';
  static const String payForLabTestsScreen = '/payForLabTestsScreen';
  static const String payForMedicinesCheckoutPreview =
      '/payForMedicinesCheckoutPreview';
  static const String payForLabTestsCheckoutPreview =
      '/payForLabTestsCheckoutPreview';
  static const String labAppointmentsScreen = '/labAppointmentsScreen';
  static const String myInvoicesScreen = '/myInvoicesScreen';
  static const String myFavouritesScreen = '/myFavouritesScreen';
  static const String myChatsScreen = '/myChatsScreen';
  static const String privateChatScreen = '/privateChatScreen';
  static const String myOrdersScreen = '/myOrdersScreen';
  static const String myFamilyScreen = '/myFamilyScreen';
  static const String familyMemberScreen = '/familyMemberScreen';
  static const String myPatientsScreen = '/myPatientsScreen';
  static const String patientProfileScreen = '/patientProfileScreen';
  static const String addPrescriptionScreen = '/addPrescriptionScreen';
  static const String addTestScreen = '/addTestScreen';
  static const String medicalHistoryScreen = '/medicalHistoryScreen';
  static const String addMedicalHistoryScreen = '/addMedicalHistoryScreen';
  static const String myReviewsScreen = '/myReviewsScreen';
  static const String myProductsScreen = '/myProductsScreen';
  static const String addProductScreen = '/addProductScreen';
  static const String editProductScreen = '/editProductScreen';
  static const String doctorAccountsScreen = '/doctorAccountsScreen';
  static const String doctorAccountUpdateScreen = '/doctorAccountUpdateScreen';
  // Specializations
  static const String specializations = '/specializationsScreen';
  // Doctors
  static const String allDoctors = '/doctorsWithSearch';
  static const String doctorScreen = '/doctorScreen';
  static const String appointment = '/appointment';
  static const String notifyMe = '/notifyMe';
  // Labs
  static const String allLabs = '/allLabs';
  static const String labProfile = '/labProfile';
  static const String allTests = '/allTests';
  static const String labTests = '/labTests';
  // Pharmacies
  static const String pharmaciesProducts = '/pharmaciesProducts';
  static const String pharmaciesScreen = '/pharmaciesScreen';
  static const String pharmaciesProductScreen = '/ProductDetailsScreen';
  static const String pharmacyDetails = '/pharmacyDetails';
  static const String productDetails = '/productDetails';
}

List<GetPage<dynamic>> routes = [
  // Global
  GetPage(
    name: AppRoutes.onBoardingScreen,
    page: () => const OnBoarding(),
    middlewares: [AppMiddleware()],
  ),
  GetPage(
    name: AppRoutes.successScreen,
    page: () => const SuccessScreen(),
  ),
  // Auth
  GetPage(
    name: AppRoutes.login,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: AppRoutes.register,
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: AppRoutes.verifyOtp,
    page: () => const VerifyOtpScreen(),
  ),
  GetPage(
    name: AppRoutes.forgotPass,
    page: () => const ForgotPassword(),
  ),
  GetPage(
    name: AppRoutes.changePasswordScreen,
    page: () => const ChangePasswordScreen(),
  ),
  // Home
  GetPage(
    name: AppRoutes.home,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: AppRoutes.homeCollection,
    page: () => const HomeCollectionScreen(),
  ),
  GetPage(
    name: AppRoutes.contactUs,
    page: () => const ContactUsScreen(),
  ),
  GetPage(
    name: AppRoutes.planYourSurgery,
    page: () => const PlanYourSurgery(),
  ),
  GetPage(
    name: AppRoutes.cart,
    page: () => const MyCartScreen(),
  ),
  GetPage(
    name: AppRoutes.billing,
    page: () => const BillingScreen(),
  ),
  GetPage(
    name: AppRoutes.notifications,
    page: () => const NotificationsScreen(),
  ),
  GetPage(
    name: AppRoutes.offerScreen,
    page: () => const OfferScreen(),
  ),
  GetPage(
    name: AppRoutes.blogScreen,
    page: () => const BlogScreen(),
  ),
  GetPage(
    name: AppRoutes.accountScreen,
    page: () => const AccountScreen(),
  ),
  GetPage(
    name: AppRoutes.profileScreen,
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.dashboardScreen,
    page: () => const DashboardScreen(),
  ),
  // Dashboard
  GetPage(
    name: AppRoutes.myAppointmentsScreen,
    page: () => const MyAppointmentsScreen(),
  ),
  GetPage(
    name: AppRoutes.callScreen,
    page: () => const CallScreen(),
  ),
  GetPage(
    name: AppRoutes.mySchedulseScreen,
    page: () => const MySchedulesScreen(),
  ),
  GetPage(
    name: AppRoutes.myPrescriptionsScreen,
    page: () => const MyPrescriptionsScreen(),
  ),
  GetPage(
    name: AppRoutes.payForMedicinesScreen,
    page: () => const PayForMedicines(),
  ),
  GetPage(
    name: AppRoutes.payForMedicinesCheckoutPreview,
    page: () => const PayForMedicinesCheckoutPreview(),
  ),
  GetPage(
    name: AppRoutes.payForLabTestsScreen,
    page: () => const PayForLabTests(),
  ),
  GetPage(
    name: AppRoutes.payForLabTestsCheckoutPreview,
    page: () => const PayForLabTestsCheckoutPreview(),
  ),
  GetPage(
    name: AppRoutes.labAppointmentsScreen,
    page: () => const MyLabAppointmentsScreen(),
  ),
  GetPage(
    name: AppRoutes.myInvoicesScreen,
    page: () => const MyInvoicesScreen(),
  ),
  GetPage(
    name: AppRoutes.myFavouritesScreen,
    page: () => const MyFavouritesScreen(),
  ),
  GetPage(
    name: AppRoutes.myChatsScreen,
    page: () => const MyChatsScreen(),
  ),
  GetPage(
    name: AppRoutes.privateChatScreen,
    page: () => const ChatScreen(),
  ),
  GetPage(
    name: AppRoutes.myOrdersScreen,
    page: () => const MyOrdersScreen(),
  ),
  GetPage(
    name: AppRoutes.myFamilyScreen,
    page: () => const MyFamilyScreen(),
  ),
  GetPage(
    name: AppRoutes.familyMemberScreen,
    page: () => const FamilyMemberScreen(),
  ),
  GetPage(
    name: AppRoutes.myPatientsScreen,
    page: () => const MyPatientsScreen(),
  ),
  GetPage(
    name: AppRoutes.patientProfileScreen,
    page: () => const PatientProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.addPrescriptionScreen,
    page: () => const AddPrescriptionScreen(),
  ),
  GetPage(
    name: AppRoutes.addTestScreen,
    page: () => const AddTestScreen(),
  ),
  GetPage(
    name: AppRoutes.medicalHistoryScreen,
    page: () => const MedicalHistoryScreen(),
  ),
  GetPage(
    name: AppRoutes.addMedicalHistoryScreen,
    page: () => const AddMedicalHistoryScreen(),
  ),
  GetPage(
    name: AppRoutes.myReviewsScreen,
    page: () => const MyReviewsScreen(),
  ),
  GetPage(
    name: AppRoutes.myProductsScreen,
    page: () => const MyProductsScreen(),
  ),
  GetPage(
    name: AppRoutes.addProductScreen,
    page: () => const AddProductScreen(),
  ),
  GetPage(
    name: AppRoutes.editProductScreen,
    page: () => const EditProductScreen(),
  ),
  GetPage(
    name: AppRoutes.doctorAccountsScreen,
    page: () => const DoctorAccountsScreen(),
  ),
  GetPage(
    name: AppRoutes.doctorAccountUpdateScreen,
    page: () => const DoctorAccountUpdateScreen(),
  ),
  // Specializations
  GetPage(
    name: AppRoutes.specializations,
    page: () => const SpecialzationsScreen(),
  ),
  // Doctors
  GetPage(
    name: AppRoutes.allDoctors,
    page: () => const DoctorsWithSearch(),
  ),
  GetPage(
    name: AppRoutes.doctorScreen,
    page: () => const DoctorScreen(),
  ),
  GetPage(
    name: AppRoutes.appointment,
    page: () => const AppointmentScreen(),
  ),
  GetPage(
    name: AppRoutes.notifyMe,
    page: () => const NotifyMeScreen(),
  ),
  // Labs
  GetPage(
    name: AppRoutes.allLabs,
    page: () => const LabsScreen(),
  ),
  GetPage(
    name: AppRoutes.labProfile,
    page: () => const LabDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.labTests,
    page: () => const LabTestsScreen(),
  ),
  GetPage(
    name: AppRoutes.allTests,
    page: () => const TestsScreen(),
  ),
  // Pharmacies
  GetPage(
    name: AppRoutes.pharmaciesProducts,
    page: () => const PharmaciesProductsScreen(),
  ),
  GetPage(
    name: AppRoutes.pharmaciesScreen,
    page: () => const PharmaciesScreen(),
  ),
  GetPage(
    name: AppRoutes.pharmacyDetails,
    page: () => const PharmacyDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.productDetails,
    page: () => const ProductDetailsScreen(),
  ),
];
