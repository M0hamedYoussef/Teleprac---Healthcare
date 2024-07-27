import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/account_settings/profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/model/doctors/advanced_doctor_model.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';

class ExperienceUpdate extends StatelessWidget {
  const ExperienceUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
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
                        AppDecoration.work,
                        width: AppDecoration().screenWidth * 0.07,
                      ),
                      SizedBox(width: AppDecoration().screenWidth * 0.01),
                      const IntrinsicWidth(
                        child: Text(
                          "Experience",
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
                      controller.experiences.add({
                        'hospital_name': '',
                        'from': '',
                        'to': '',
                        'designation': '',
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
              controller.experiences.length,
              (index) {
                Experience experience =
                    Experience.fromJson(controller.experiences[index]);
                TextEditingController hospitalNameCon = TextEditingController();
                hospitalNameCon.text = experience.hospitalName!;
                FocusNode hospitalNameFocus = FocusNode();
                TextEditingController fromCon = TextEditingController();
                FocusNode fromFocus = FocusNode();
                fromCon.text = experience.from!;
                TextEditingController toCon = TextEditingController();
                toCon.text = experience.to!;
                FocusNode toFocus = FocusNode();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.experiences
                            .remove(controller.experiences[index]);
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
                      textEditingController: hospitalNameCon,
                      focusNode: hospitalNameFocus,
                      nextFocusNode: fromFocus,
                      label: 'Hospital Name',
                      onChanged: (val) {
                        controller.experiences[index]['hospital_name'] =
                            hospitalNameCon.text;
                      },
                    ),
                    CustomTextFormField(
                      textEditingController: fromCon,
                      focusNode: fromFocus,
                      nextFocusNode: toFocus,
                      label: 'From (Year)',
                      keyboardType: TextInputType.datetime,
                      maxLength: 4,
                      onChanged: (val) {
                        controller.experiences[index]['from'] = fromCon.text;
                      },
                    ),
                    CustomTextFormField(
                      textEditingController: toCon,
                      focusNode: toFocus,
                      label: 'To (Year)',
                      keyboardType: TextInputType.datetime,
                      maxLength: 4,
                      onChanged: (val) {
                        controller.experiences[index]['to'] = toCon.text;
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
      },
    );
  }
}
