import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController statusC;

  @override
  void onInit() {
    emailC = TextEditingController(text: "your.name@gmail.com");
    nameC = TextEditingController(text: "I am Android");
    statusC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    statusC.dispose();
    super.onClose();
  }
}
