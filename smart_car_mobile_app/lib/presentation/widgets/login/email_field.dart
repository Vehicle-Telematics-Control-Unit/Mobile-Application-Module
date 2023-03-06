import 'package:flutter/material.dart';

import 'package:smart_car_mobile_app/controllers/login_controller.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.loginController,
  });

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextFormField(
        validator: (value) {
          return loginController.validateEmail(value!);
        },
        onSaved: (value) => loginController.usernameController,
        controller: loginController.usernameController,
        cursorColor: const Color.fromARGB(255, 145, 55, 55),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            filled: true, //<-- SEE HERE
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: "Email/Username",
            errorStyle: const TextStyle(
                fontSize: 15, color: Color.fromARGB(182, 227, 34, 20)),
            prefixIcon: const Icon(Icons.mail, color: Colors.white)),
      ),
    );
  }
}
