import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_appointments/call_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CallController controller = Get.put(CallController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: controller.willPop,
        child: GetBuilder<CallController>(
          builder: (_) {
            return Stack(
              children: [
                Center(
                  child: controller.remoteUid != null
                      ? controller.remoteCameraEnabled
                          ? AgoraVideoView(
                              controller: VideoViewController.remote(
                                rtcEngine: controller.engine,
                                canvas: VideoCanvas(uid: controller.remoteUid),
                                connection: RtcConnection(
                                    channelId: controller.channelId),
                              ),
                            )
                          : Icon(
                              Icons.videocam_off,
                              color: AppColors.primaryColor,
                              size: AppDecoration().screenWidth * 0.2,
                            )
                      : Text(
                          controller.myRole == '1'
                              ? 'Please wait while patient joins the call'
                              : 'Please wait while docto joins the call',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: AppDecoration().screenWidth * 0.12,
                          ),
                        ),
                ),
                if (controller.isCameraEnabled)
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: AppDecoration().screenWidth * 0.3,
                      height: AppDecoration().screenWidth * 0.5,
                      child: Center(
                        child: controller.joined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: controller.engine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: AppDecoration().screenWidth * 0.3,
                      height: AppDecoration().screenWidth * 0.5,
                      child: Center(
                        child: controller.joined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: controller.engine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: AppDecoration().screenWidth * 0.3,
                      height: AppDecoration().screenWidth * 0.5,
                      child: Center(
                        child: controller.joined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: controller.engine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.secondaryColor,
                        boxShadow: const [
                          BoxShadow(blurRadius: 0.2),
                        ],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.red,
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                controller.endCall();
                              },
                              child: Icon(
                                Icons.phone,
                                color: AppColors.secondaryColor,
                                size: AppDecoration().screenWidth * 0.13,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.primaryColor,
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                controller.microphone();
                              },
                              child: Icon(
                                controller.isMicrophoneEnabled
                                    ? Icons.mic
                                    : Icons.mic_off,
                                color: AppColors.secondaryColor,
                                size: AppDecoration().screenWidth * 0.13,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.primaryColor,
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                controller.camera();
                              },
                              child: Icon(
                                controller.isCameraEnabled
                                    ? Icons.videocam
                                    : Icons.videocam_off,
                                color: AppColors.secondaryColor,
                                size: AppDecoration().screenWidth * 0.13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (controller.isCameraEnabled)
                  Positioned(
                    right: 0,
                    bottom: AppDecoration().screenHeight * 0.135,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          controller.cameraSwitch();
                        },
                        child: Icon(
                          Icons.flip_camera_ios_outlined,
                          color: AppColors.secondaryColor,
                          size: AppDecoration().screenWidth * 0.1,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
