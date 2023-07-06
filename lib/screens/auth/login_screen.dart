// ignore_for_file: unrelated_type_equality_checks

import 'package:authentications/repository/crud_user_repository.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'registration.dart';

// ignore: must_be_immutable
class LoginScreen extends GetView<LoginService> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();
    LoginService loginService = LoginService();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginService.emailController.value,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => TextField(
                controller: loginService.passwordController.value,
                obscureText: controller.isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(controller.isObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        controller.isObscure = !controller.isObscure;
                      }),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                // Retrieve the entered email and password
                final email = loginService.emailController.value.text;
                final password = loginService.passwordController.value.text;

                try {
                  final CrudUserRepository userrepo = CrudUserRepository();
                  final userList = await userrepo.list();
                  final user = userList!.firstWhere(
                    (user) => user.email == email,
                  );

                  if (user.email == email && user.password == password) {
                    // Perform login logic here
                    // For simplicity, let's assume the login is successful

                    // Set authentication status
                    controller.authService.authenticated = true;

                    // Store user information in storage
                    await storageService.storage
                        .write(key: 'useremail', value: user.email);
                    await storageService.storage
                        .write(key: 'userpassword', value: user.password);
                    controller.authService.useremail = email;
                    controller.authService.userpassword = password;

                    // Navigate to the home screen
                    Get.offNamed('/home');
                  } else {
                    // Login failed
                    // Display an error message or show a snackbar
                    throw Exception('Invalid email or password');
                  }
                } catch (e) {
                  // Handle login error
                  //print('Login Error: $e');
                  // ignore: prefer_const_constructors
                  final snackBar = SnackBar(
                    content: const Text('Invalid Email or Password'),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            const SizedBox(height: 16.0),
            TextButton(
              child: const Text('Register'),
              onPressed: () {
                // Perform registration logic here
                // Navigate to the registration screen
                Get.to(() => RegistrationScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
