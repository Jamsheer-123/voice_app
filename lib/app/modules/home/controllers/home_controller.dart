import '''
package:get/get.dart''';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeController extends GetxController {
  var isLIstening = false.obs;
  var speechText = "".obs;
  var speechTextDuply = "".obs;
  var answes = 0.obs;
  var addData = false.obs;

  stt.SpeechToText speech = stt.SpeechToText();
  @override
  void onInit() {
    super.onInit();
  }

  void listen() async {
    if (!isLIstening.value) {
      bool available = await speech.initialize(
        onStatus: (val) {},
        onError: (val) {},
      );
      if (available) {
        isLIstening.value = true;
        speech.listen(onResult: (val) {
          speechText.value = val.recognizedWords.numericOnly();
          speechTextDuply.value = speechText.value;
          addData.value = true;
        });
      }
    } else {
      isLIstening.value = false;
      speech.stop();
      speechText.value = "";
      addData.value = false;
    }
  }

  var value = 0.obs;
  void add() {
    if (value < 7) {
      value.value++;
      isLIstening.value = false;
      speechText.value = "0";
      addData.value = false;
    }
  }

  void subtract() {
    value.value--;
  }
}
