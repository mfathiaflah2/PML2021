import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Berinteraksi dengan mudah",
            body:
                "Kamu hanya perlu di rumah saja untuk mendapatkan teman baru.",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/play.json"),
              ),
            ),
          ),
          PageViewModel(
            title: "Temukan Sahabat Baru",
            body:
                "Jika kamu memang jodoh karena aplikasi ini , kami sangat bahagia.",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/add-friends.json"),
              ),
            ),
          ),
          PageViewModel(
            title: "Aplikasi Bebas Biaya",
            body: "Kamu tidak perlu khawatir, aplikasi ini bebas biaya apapun.",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/payment.json"),
              ),
            ),
          ),
          PageViewModel(
            title: "Gabung Sekarang Juga",
            body:
                "Daftar diri kamu untuk menjadi bagian dari kami. kami akan menghubungkan dengan 1000 teman lainnya.",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                child: Lottie.asset("assets/lottie/register.json"),
              ),
            ),
          ),
        ],
        onDone: () => Get.offAllNamed(Routes.LOGIN),
        showSkipButton: true,
        skip: Text("Skip"),
        next: Text(
          "Next",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        done: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
