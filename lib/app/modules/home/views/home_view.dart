import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  int num1 = 2;
  List ab = [2, 4, 5, 6, 7, 8, 9, 10];
  var index = 0.obs;
  FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-us");
    await flutterTts.setPitch(0.5);
    await flutterTts.speak(text);
  }

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: double.infinity,
          // margin: EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Text(
                  "Please Answer the Qustion",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              Obx(
                () => Container(
                  padding: EdgeInsets.only(top: size.height * 0.09),
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$num1" " * " "${ab[controller.value.toInt()]}" " = ",
                        style: const TextStyle(fontSize: 25),
                      ),
                      SizedBox(width: size.width * 0.1),
                      IconButton(
                          onPressed: () {
                            speak("$num1"
                                " multiple"
                                "${ab[controller.value.toInt()]}"
                                " = ");
                          },
                          icon: Icon(Icons.volume_up))
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: size.height * 0.1),
                child: Obx(
                  () => Text(
                    controller.speechTextDuply.value,
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: size.height * 0.48),
                child: Obx(() {
                  return controller.addData.value == true
                      ? num1 * ab[controller.value.toInt()] ==
                              int.tryParse(controller.speechText.value)
                          ? const Text(
                              "Correct Answer",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 30),
                            )
                          : const Text(
                              "Wrong Answer ",
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            )
                      : Container();
                }),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    controller.add();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: Colors.green),
                    width: 130,
                    child: Center(child: Text("Next Qustion")),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Obx(() => AvatarGlow(
              animate: controller.isLIstening.value,
              glowColor: Color.fromARGB(255, 3, 148, 37),
              endRadius: 190.0,
              duration: const Duration(microseconds: 2000),
              repeat: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: FloatingActionButton(
                child: Icon(
                  controller.isLIstening.value ? Icons.mic : Icons.mic_none,
                  size: 34,
                ),
                onPressed: () {
                  controller.listen();
                },
              ),
            )),
      ),
    );
  }
}
