import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_service.dart';

class LoginService extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final _isObscure = true.obs;
  @override
  void onInit() {
    print('>>> LoginController started');
    super.onInit();
  }

  AuthService get authService => Get.find<AuthService>();
  bool get isObscure => _isObscure.value;
  set isObscure(bool value) => _isObscure.value = value;
}
