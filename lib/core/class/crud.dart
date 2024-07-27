import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:teleprac/core/class/request_status.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/core/functions/check_connection.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:teleprac/core/functions/loading_dialog.dart';
import 'package:teleprac/core/services/my_services.dart';
import 'package:teleprac/model/global/response_model.dart';

class Crud {
  Future<Either<RequsetStatus, Map>> connect({
    required String link,
    Map data = const {},
    Map<String, String> headers = const {'token': AppLinks.token},
    String method = 'post',
    String? fileRequestName,
    File? file,
  }) async {
    try {
      if (await checkInternet()) {
        http.Response response;
        if (file != null && fileRequestName != null) {
          var uri = Uri.parse(link);
          var request = http.MultipartRequest("POST", uri);
          var length = await file.length();
          var stream = http.ByteStream(file.openRead());
          stream.cast();
          var multipartFile = http.MultipartFile(
            fileRequestName,
            stream,
            length,
            filename: basename(file.path),
          );
          request.files.add(multipartFile);
          request.headers.addAll(headers);
          data.forEach(
            (key, value) {
              request.fields[key] = value;
            },
          );
          var myrequest = await request.send();
          response = await http.Response.fromStream(myrequest);
        } else {
          if (method.toLowerCase() == 'post') {
            response = await http.post(
              Uri.parse(link),
              body: data,
              headers: headers,
            );
          } else {
            response = await http.get(
              Uri.parse(link),
              headers: headers,
            );
          }
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          var decodedBody = jsonDecode(response.body);
          ResponseModel responseModel = ResponseModel.fromJson(decodedBody);
          if (responseModel.responseMessage ==
              'Invalid token or token missing') {
            Get.back();
            Get.defaultDialog(
              middleText:
                  'Your account is currently logged in on a different device.\n Would you like to login again?',
              actions: [
                MaterialButton(
                  onPressed: () async {
                    MyServices myServices = Get.find();
                    Get.back();
                    loading();
                    if (await myServices.login()) {
                      Get.back();
                      Fluttertoast.showToast(
                        msg: 'Logged In Successfully',
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.black,
                      );
                    } else {
                      Get.back();
                      Fluttertoast.showToast(
                        msg: 'Something Went Wrong',
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.black,
                      );
                    }
                  },
                  color: AppColors.primaryColor,
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: AppDecoration().screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppDecoration.cairo,
                    ),
                  ),
                ),
              ],
            );
          }
          return Right(decodedBody);
        } else {
          return const Left(RequsetStatus.serverError);
        }
      } else {
        return const Left(RequsetStatus.offline);
      }
    } catch (e) {
      return const Left(RequsetStatus.codeError);
    }
  }
}
