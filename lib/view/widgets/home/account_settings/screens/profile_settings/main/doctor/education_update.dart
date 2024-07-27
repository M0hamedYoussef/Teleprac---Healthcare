import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class EducationUpdate extends StatelessWidget {
  const EducationUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppDecoration.education,
                      width: AppDecoration().screenWidth * 0.07,
                    ),
                    SizedBox(width: AppDecoration().screenWidth * 0.01),
                    const IntrinsicWidth(
                      child: Text(
                        "Education",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    controller.educations.add({
                      'degree': '',
                      'institute': '',
                      'year_of_completion': '',
                    });
                    controller.update();
                  },
                  child: const Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            controller.educations.length,
            (index) {
              Education education =
                  Education.fromJson(controller.educations[index]);
              TextEditingController degreeCon = TextEditingController();
              degreeCon.text = education.degree!;
              FocusNode degreeFocus = FocusNode();
              TextEditingController collegeCon = TextEditingController();
              collegeCon.text = education.institute!;
              FocusNode collegeFocus = FocusNode();
              TextEditingController yearCon = TextEditingController();
              yearCon.text = education.yearOfCompletion!;
              FocusNode yearFocus = FocusNode();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.educations
                          .remove(controller.educations[index]);
                      controller.update();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    textEditingController: degreeCon,
                    focusNode: degreeFocus,
                    nextFocusNode: collegeFocus,
                    label: 'Degree',
                    onChanged: (val) {
                      controller.educations[index]['degree'] = degreeCon.text;
                    },
                  ),
                  CustomTextFormField(
                    textEditingController: collegeCon,
                    focusNode: collegeFocus,
                    nextFocusNode: yearFocus,
                    label: 'College/Institute',
                    onChanged: (val) {
                      controller.educations[index]['institute'] =
                          collegeCon.text;
                    },
                  ),
                  CustomTextFormField(
                    textEditingController: yearCon,
                    focusNode: yearFocus,
                    label: 'Year of Completion',
                    keyboardType: TextInputType.datetime,
                    maxLength: 4,
                    onChanged: (val) {
                      controller.educations[index]['year_of_completion'] =
                          yearCon.text;
                    },
                  ),
                  SizedBox(height: AppDecoration().screenHeight * .02),
                  const Divider(thickness: 1.2),
                  SizedBox(height: AppDecoration().screenHeight * .02),
                ],
              );
            },
          ),
        ],
      );
    });
  }
}
