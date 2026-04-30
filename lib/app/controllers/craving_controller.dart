import 'package:get/get.dart';

class CravingController extends GetxController {
  static CravingController get to => Get.find();

  final duration = 60.obs;
  final timeLeft = 60.obs;
  final running = false.obs;
  final finished = false.obs;
  final breathPhaseIdx = 0.obs;
  final msgIdx = 0.obs;

  final List<Map<String, dynamic>> breathingPhases = [
    {'key': 'breatheIn', 'duration': 4},
    {'key': 'hold', 'duration': 4},
    {'key': 'breatheOut', 'duration': 6},
    {'key': 'hold', 'duration': 2},
  ];

  final List<String> motivationalKeys = [
    'mot1', 'mot2', 'mot3', 'mot4', 'mot5', 'mot6', 'mot7',
  ];

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }

  void reset() {
    _stopTimer();
    timeLeft.value = duration.value;
    running.value = false;
    finished.value = false;
    breathPhaseIdx.value = 0;
    msgIdx.value = 0;
  }

  void setDuration(int secs) {
    duration.value = secs;
    if (!running.value) timeLeft.value = secs;
  }

  void start() {
    timeLeft.value = duration.value;
    running.value = true;
    finished.value = false;
    breathPhaseIdx.value = 0;
    msgIdx.value = 0;
    _runTimer();
  }

  void _runTimer() async {
    while (running.value && timeLeft.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!running.value) break;
      timeLeft.value--;
      if (timeLeft.value % 5 == 0) {
        msgIdx.value = (msgIdx.value + 1) % motivationalKeys.length;
      }
    }
    if (timeLeft.value <= 0 && running.value) {
      running.value = false;
      finished.value = true;
    }
  }

  void _stopTimer() {
    running.value = false;
  }
}

