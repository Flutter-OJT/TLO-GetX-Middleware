import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user/user_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegistrationScreen extends GetView<LoginService> {
  RegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  //String _selectedRole = 'User';
  //final List<String> _roleOptions = ['User', 'Admin'];
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(
                labelText: 'Role(User or Admin)',
              ),
            ),
            // DropdownButtonFormField<String>(
            //   value: _selectedRole,
            //   onChanged: (newValue) {
            //     _selectedRole = newValue!;
            //   },
            //   items: _roleOptions.map((role) {
            //     return DropdownMenuItem<String>(
            //       value: role,
            //       child: Text(role),
            //     );
            //   }).toList(),
            //   decoration: const InputDecoration(
            //     labelText: 'Role',
            //   ),
            // ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                UserModel newUser = UserModel(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    role: _roleController.text);

                userService.createUser(newUser);
                _nameController.text = '';
                _emailController.text = '';
                _passwordController.text = '';
                _roleController.text = '';
                // ignore: prefer_const_constructors
                final snackBar = SnackBar(
                  content: const Text('Registratin Complete!'),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ),
    );
  }
}
