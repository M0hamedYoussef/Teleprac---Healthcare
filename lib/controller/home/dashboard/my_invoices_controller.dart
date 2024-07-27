import 'package:get/get.dart';
import 'package:teleprac/core/class/crud.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/model/global/response_model.dart';
import 'package:teleprac/model/home/dashboard/invoice/advanced_invoice_model.dart';
import 'package:teleprac/model/home/dashboard/invoice/invoice_model.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_invoices/invoice_details/invoice_details.dart';

class MyInvoicesController extends GetxController {
  late List myInvoices;
  Crud crud = Crud();

  @override
  void onInit() {
    myInvoices = Get.arguments['invoicesList'];
    super.onInit();
  }

  invoiceDetails({required InvoiceModel invoiceModel}) async {
    loading();
    var res = await invoiceDetailsRequest(invoiceModel: invoiceModel);
    if (res is RequsetStatus == false) {
      ResponseModel responseModel = ResponseModel.fromJson(res);
      AdvancedInvoiceModel advancedInvoiceModel =
          AdvancedInvoiceModel.fromJson(responseModel.data);
      advancedInvoiceModel.createdDate = invoiceModel.date;
      if (responseModel.responseCode == '200') {
        Get.off(
          () => InvoiceDetailsScreen(
            advancedInvoiceModel: advancedInvoiceModel,
          ),
        );
      }
    }
  }

  invoiceDetailsRequest({required InvoiceModel invoiceModel}) async {
    var res = await crud.connect(
      link: AppLinks.invoiceDetails,
      data: {
        'id': invoiceModel.id,
      },
      headers: {
        'token': AppLinks.token,
      },
    );
    return res.fold((l) => l, (r) => r);
  }
}
