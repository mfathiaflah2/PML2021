import 'package:chat_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  get firestore => null;

  Future<void> firstInitialized() async {
    await autologin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });

    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    // Kita akan mengubah isSkipIntro => true
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }

  Future<bool> autologin() async {
    // Kita akan mengubah isAuth => true => autologin
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> login() async {
    try {
      // Ini untuk hoodle kebocoran data user sebelum login
      await _googleSignIn.signOut();

      // Ini digunakan untuk mendapatkan google account
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      // Ini untuk mengecek kondisi login user
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        // kondisi login berhasil
        print("SUDAH BERHASIL LOGIN DENGAN AKUN : ");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final userCredential =
            FirebaseAuth.instance.signInWithCredential(credential);

        print("USER CREDENTIAL");
        print(userCredential);

        // simpan status user bahwa sudah pernah login & tidak akan menapilkan introductions kembali
        final box = GetStorage();
        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);

        // masukkan data ke firebase...
        // CollectionReference users = firestore.collection('users');

        // final checkuser = await users.doc();

        // users.doc(_currentUser!.email).set({
        //   "uid": userCredential!.user!.uid,
        //   "name": _currentUser!.displayName,
        //   "email": _currentUser!.email,
        //   "photoUrl": _currentUser!.photoUrl,
        //   "status": "",
        //   "creationTime":
        //       userCredential!.users!.metadata.creationTime!.toString(),
        //   "lastSignInTime": userCredential!.metadata.lastSignInTime!.toString(),
        //   "updatadTime": DateTime.now().toString(),
        // });

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        print("TIDAK BERHASIL LOGIN");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
